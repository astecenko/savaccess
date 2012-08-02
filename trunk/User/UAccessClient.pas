unit UAccessClient;

interface
uses Classes, UAccessConstant, DBClient, DB, IniFiles, UAccessPattern;

type
  TVersionString = string[30];

  TClientFile = record
    SrvrFile: string[50];
    Version: string[30];
    ClntFile: string[254];
    Ext: string[10];
    TypeF: Char;
    Action: Integer;
    MD5: string[32];
    Source: Char;
    SID: string[50];
  end;

  TSAVAccessFileProc = function(const rNew, rOld: TClientFile; const aDir, aSID:
    string): Boolean;

  TSAVAccessFileAction = class
  private
    procedure SetFileAction(const Value: Integer);
    procedure SetFileExt(const Value: string);
    procedure SetFileType(const Value: string);
  protected
    FFileType: string;
    FFileAction: Integer;
    FFileExt: string;
    FFileProc: TSAVAccessFileProc;
  public
    property FileType: string read FFileType write SetFileType;
    property FileAction: Integer read FFileAction write SetFileAction;
    property FileExt: string read FFileExt write SetFileExt;
    property FileProc: TSAVAccessFileProc read FFileProc write FFileProc;
    constructor Create(const AFileType, AFileExt: string; const AFileAct:
      Integer; AFunc: TSAVAccessFileProc);
  end;

  TSAVAccessClient = class(TObject)
  private
    FUser: string;
    FDomain: string;
    FSID: string;
    FIniFile: TMemIniFile;
    FWorkstation: string;
    FDataSet: TClientDataSet;
    FConfigDir: string;
    FJournalsDir: string;
    FUsersDir: string;
    FGroupsDir: string;
    FTemplate: TPathTemplate;
    FDomainsDir: string;
    FActions: TList;
    procedure SetDataSet(const Value: TClientDataSet);
    procedure SetIniFile(const Value: TMemIniFile);
    procedure SetActions(const Value: TList);
  public
    property ConfigDir: string read FConfigDir;
    property Domain: string read FDomain;
    property SID: string read FSID;
    property Actions: TList read FActions write SetActions;
    property User: string read FUser;
    property DataSet: TClientDataSet read FDataSet write SetDataSet;
    property JournalsDir: string read FJournalsDir;
    property UsersDir: string read FUsersDir;
    property GroupsDir: string read FGroupsDir;
    property DomainsDir: string read FDomainsDir;
    property Workstation: string read FWorkstation;
    property IniFile: TMemIniFile read FIniFile write SetIniFile;
    procedure LoadFromFile(const aFileName: string);
    function Record2ClientFile(table1: TDataSet; const aSID, aSource: string):
      TClientFile;
    procedure ClientFile2Record(table1: TDataSet; const ClntFile1: TClientFile);
    function CheckDomainVersion: Boolean; //True = Equal
    function CheckUserVersion: Boolean;
    function GetDirBySource(const aSource: Char): string;
    function CheckGroupVersion(const aSID: string): Boolean;
    function FileProcessing(const aOld, aNew: TClientFile): Boolean;
    procedure UpdateContainerFile(const aDir, aSID: string);
    constructor Create(const aConfDirName: string = ''); overload;
    destructor Destroy; override;

  end;

implementation
uses SAVLib, SysUtils, SPGetSid, MsAD, VKDBFDataSet, SAVLib_DBF, Variants,
  KoaUtils, Windows;

{ TSAVAccessContainer }

function TSAVAccessClient.CheckDomainVersion: Boolean;
var
  ini: TIniFile;
  s: string;
begin
  ini := TIniFile.Create(DomainsDir + Domain + '\' + csContainerCfg);
  s := ini.ReadString('main', 'version', '');
  FreeAndNil(ini);
  Result := (s <> '') and (s = FIniFile.ReadString('version', 'domain', ''));
end;

function TSAVAccessClient.CheckGroupVersion(const aSID: string): Boolean;
var
  ini: TIniFile;
  s: string;
begin
  ini := TIniFile.Create(GroupsDir + aSID + '\' + csContainerCfg);
  s := ini.ReadString('main', 'version', '');
  FreeAndNil(ini);
  Result := (s <> '') and (s = FIniFile.ReadString('version', 'gr' + aSID, ''));
end;

function TSAVAccessClient.CheckUserVersion: Boolean;
var
  ini: TIniFile;
  s: string;
begin
  ini := TIniFile.Create(UsersDir + SID + '\' + csContainerCfg);
  s := ini.ReadString('main', 'version', '');
  FreeAndNil(ini);
  Result := (s <> '') and (s = FIniFile.ReadString('version', 'user', ''));
end;

procedure TSAVAccessClient.ClientFile2Record(table1: TDataSet;
  const ClntFile1: TClientFile);
begin

end;

constructor TSAVAccessClient.Create(const aConfDirName: string);
var
  s: string;
begin
  if aConfDirName = '' then
    s := 'SAVAccessClient'
  else
    s := aConfDirName;
  FConfigDir := GetSpecialFolderLocation(CSIDL_APPDATA,
    FOLDERID_RoamingAppData);
  if FConfigDir = '' then
    FConfigDir := GetCurrentDir;
  FConfigDir :=
    IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(FConfigDir) + s);
  FSID := SPGetSid.GetCurrentUserSid;
  FWorkstation := MsAD.GetCurrentComputerName;
  FUser := MsAD.GetCurrentUserName;
  FDomain := MsAD.CurrentDomainName;
  FDataSet := TClientDataSet.Create(nil);
  with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
  begin
    DisplayName := csFieldSrvrFile;
    DataType := ftString;
    Size := 50;
  end;
  with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
  begin
    DisplayName := csFieldVersion;
    DataType := ftString;
    Size := 30;
  end;
  with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
  begin
    DisplayName := csFieldClntFile;
    DataType := ftString;
    Size := 2047;
  end;
  with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
  begin
    DisplayName := csFieldExt;
    DataType := ftString;
    Size := 10;
  end;
  with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
  begin
    DisplayName := csFieldType;
    DataType := ftString;
    Size := 1;
  end;
  with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
  begin
    DisplayName := csFieldAction;
    DataType := ftInteger;
  end;
  with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
  begin
    DisplayName := csFieldMD5;
    DataType := ftString;
    Size := 32;
  end;
  with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
  begin
    DisplayName := csFieldSID;
    DataType := ftString;
    Size := 50;
  end;
  with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
  begin
    DisplayName := csFieldSource;
    DataType := ftString;
    Size := 1;
  end;
  FDataSet.CreateDataSet;
  if FileExists(FConfigDir + csClientData) then
    FDataSet.LoadFromFile(FConfigDir + csClientData);
  FDataSet.Open;
  FDataSet.LogChanges := False;
  FDataSet.FileName := FConfigDir + csClientData;
  FIniFile := TMemIniFile.Create(FConfigDir + csContainerCfg);
  FActions := TList.Create;
end;

destructor TSAVAccessClient.Destroy;
begin
  if Assigned(FDataSet) then
  begin
    FDataSet.ApplyUpdates(-1);
    FDataSet.Close;
    FreeAndNil(FDataset);
  end;
  if Assigned(FIniFile) then
  begin
    FIniFile.WriteDateTime('option', 'LastChange', Now);
    FIniFile.UpdateFile;
    FreeAndNil(Finifile);
  end;
  if Assigned(FActions) then
    FreeAndNil(FACtions);
  inherited;
end;

function TSAVAccessClient.FileProcessing(const aOld,
  aNew: TClientFile): Boolean;
var
  hFile: Cardinal;
  sf,ContDir: string;
begin
  Result := True;
  sf := FTemplate.GetPath(aNew.ClntFile);
  ContDir:=GetDirBySource(aNew.Source) + aNew.SID + '\f\';
  case aNew.TypeF of
    'F': //Файловая операция
      begin
        if aNew.Ext = '' then
          case aNew.Action of
            0: // Удаление
              begin
                if FileExists(sf) then
                  Result := Windows.DeleteFile(PChar(sf));
              end;
            1: // Копирование
              begin
                try
                  fCopyFile(ContDir + aNew.SrvrFile, sf);
                except
                  Result := False;
                end;
              end;
            2: // Создать файл пустой
              begin
                hFile := CreateFile(PChar(sf), GENERIC_WRITE,
                  FILE_SHARE_WRITE or FILE_SHARE_READ, nil,
                  OPEN_ALWAYS, FILE_FLAG_WRITE_THROUGH, 0);
                Result := hFile <> INVALID_HANDLE_VALUE;
                CloseHandle(hFile);
              end;
          else
            begin
              ;
            end;
          end
        else
        begin
          // Для типов файлов по расширению обработчики тут
        end;
      end;
    'D': //Операция с каталогом
      begin
        case aNew.Action of
          0: // Удаление
            begin
              if DirectoryExists(sf) then
                Result := fRemoveDir(sf)
            end;
         { 1: // Копирование - 
            begin
              fCopyDir();
            end;}
          2: // Создать пустую директорию
            begin
              Result:=ForceDirectories(ExcludeTrailingPathDelimiter(sf));
            end;
        else
          begin
            ;
          end;
        end
      end;
  else
    begin
      ;
    end;
  end;
end;

function TSAVAccessClient.GetDirBySource(const aSource: Char): string;
begin
  Result := '';
  case aSource of
    'D': Result := FDomainsDir;
    'G': Result := FGroupsDir;
    'U': Result := FUsersDir;
  end;
end;

procedure TSAVAccessClient.LoadFromFile(const aFileName: string);
var
  list: TStringList;
begin
  if FileExists(aFileName) then
  begin
    list := TStringList.Create;
    list.LoadFromFile(aFileName);
    FUsersDir := list.Values['users'];
    FJournalsDir := list.Values['journals'];
    FGroupsDir := list.Values['groups'];
    FDomainsDir := list.Values['domains'];
    FreeAndNil(list);
    if Assigned(FTemplate) then
      FreeAndNil(FTemplate);
    FTemplate := TPathTemplate.Create(FJournalsDir + csTemplateMain);
  end
  else
    raise Exception.Create('Нет доступа к файлу ' + aFileName);
end;

function TSAVAccessClient.Record2ClientFile(table1: TDataSet; const aSID,
  aSource: string): TClientFile;
begin
  Result.SrvrFile := table1.fieldbyname(csFieldSrvrFile).AsString;
  Result.Ext := table1.fieldbyname(csFieldExt).AsString;
  Result.Version := table1.fieldbyname(csFieldVersion).AsString;
  Result.ClntFile := table1.fieldbyname(csFieldClntFile).AsString;
  Result.TypeF := table1.fieldbyname(csFieldType).AsString[1];
  Result.Action := table1.fieldbyname(csFieldAction).AsInteger;
  Result.MD5 := table1.fieldbyname(csFieldMD5).AsString;
  Result.Source := table1.fieldbyname(csFieldSource).asstring[1];
  Result.SID := table1.fieldbyname(csFieldSID).asstring;
end;

procedure TSAVAccessClient.SetActions(const Value: TList);
begin
  FActions := Value;
end;

procedure TSAVAccessClient.SetDataSet(const Value: TClientDataSet);
begin
  FDataSet := Value;
end;

procedure TSAVAccessClient.SetIniFile(const Value: TMemIniFile);
begin
  FIniFile := Value;
end;

procedure TSAVAccessClient.UpdateContainerFile(const aDir, aSID: string);
var
  ini: TIniFile;
  c: Char;
  s: string;
  sPath: string;
  table1: TVKDBFNTX;

  procedure FileInfoMove(aFrom, aTo: TDataSet; const aFull: Boolean);
  begin
    if aFull then
    begin
      aTo.fieldbyname(csFieldSrvrFile).AsString :=
        aFrom.fieldbyname(csFieldSrvrFile).AsString;
      aTo.fieldbyname(csFieldExt).AsString :=
        aFrom.fieldbyname(csFieldExt).AsString;
      aTo.fieldbyname(csFieldType).AsString :=
        aFrom.fieldbyname(csFieldType).AsString;
      aTo.FieldByName(csFieldSource).AsString := c;
      aTo.FieldByName(csFieldSID).AsString := aSID;
    end;
    aTo.fieldbyname(csFieldClntFile).AsString :=
      aFrom.fieldbyname(csFieldClntFile).AsString;
    aTo.fieldbyname(csFieldVersion).AsString :=
      aFrom.fieldbyname(csFieldVersion).AsString;
    aTo.fieldbyname(csFieldMD5).AsString :=
      aFrom.fieldbyname(csFieldMD5).AsString;
    aTo.fieldbyname(csFieldAction).AsInteger :=
      aFrom.fieldbyname(csFieldAction).AsInteger;
  end;

begin
  s := '';
  sPath := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(aDir) +
    aSID);
  ini := TIniFile.Create(sPath + csContainerCfg);
  c := Ini.ReadString('main', 'type', ' ')[1];
  FreeAndNil(ini);
  table1 := TVKDBFNTX.Create(nil);
  InitOpenDBF(table1, sPath + csFilesTable, 64);
  table1.Open;
  while not (table1.Eof) do
  begin
    if FDataSet.Locate(csFieldSrvrFile + ';' + csFieldExt + ';' + csFieldType +
      ';' + csFieldSource + ';' + csFieldSID,
      varArrayOf([table1.fieldbyname(csFieldSrvrFile).AsString,
      table1.fieldbyname(csFieldExt).AsString,
        table1.fieldbyname(csFieldType).AsString, c, aSID]), []) then
    begin
      if FDataSet.fieldbyname(csFieldVersion).AsString <>
        table1.fieldbyname(csFieldVersion).AsString then
      begin
        if FileProcessing(Record2ClientFile(FDataSet, aSID, c),
          Record2ClientFile(table1, aSID, c)) then
        begin
          FDataSet.Edit;
          FileInfoMove(table1, FDataSet, False);
          FDataSet.Post;
        end;
      end
    end
    else
    begin
      if FileProcessing(Record2ClientFile(FDataSet, aSID, c),
        Record2ClientFile(table1, aSID, c)) then
      begin
        FDataSet.Insert;
        FileInfoMove(table1, FDataSet, True);
        FDataSet.Post;
      end;
    end;
    table1.Next;
  end;
end;

{ TSAVAccessFileAction }

constructor TSAVAccessFileAction.Create(const AFileType, AFileExt: string;
  const AFileAct: Integer; AFunc: TSAVAccessFileProc);
begin
  FFileType := AFileType;
  FFileExt := AFileExt;
  FFileAction := AFileAct;
  FFileProc := AFunc;
end;

procedure TSAVAccessFileAction.SetFileAction(const Value: Integer);
begin
  FFileAction := Value;
end;

procedure TSAVAccessFileAction.SetFileExt(const Value: string);
begin
  FFileExt := Value;
end;

procedure TSAVAccessFileAction.SetFileType(const Value: string);
begin
  FFileType := Value;
end;

end.

