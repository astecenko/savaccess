unit UAccessClient;

interface
uses Classes, UAccessConstant, DBClient, DB, IniFiles, UAccessPattern, UAccessClientFile;

type
  TVersionString = string[30];



  TSAVAccessFileProc = function(const rNew, rOld: TClientFile;
    const aDir, aSID: string; const aPath: string = ''): Boolean;

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
    FIniFile: TIniFile;
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
    procedure SetIniFile(const Value: TIniFile);
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
    property IniFile: TIniFile read FIniFile write SetIniFile;
    procedure LoadFromFile(const aFileName: string);
    procedure SortListVal(Source: TStrings);
    function Record2ClientFile(table1: TDataSet; const aSID, aSource: string):
      TClientFile;
    procedure ClientFile2Record(table1: TDataSet; const ClntFile1: TClientFile);
    function CheckDomainVersion: Boolean; //True = Equal
    function CheckUserVersion: Boolean;
    function GetDirBySource(const aSource: Char): string;
    function CheckGroupVersion(const aSID: string): Boolean;
    function FileProcessing(const aOld, aNew: TClientFile): Boolean;
    function AddedProc(const aOld, aNew: TClientFile; const aDir, aSID, aPath:
      string):
      Boolean;
    procedure UpdateContainerFile(const aDir, aSID, aVersion: string);
    function Update: Boolean;
    function FindPlugin(const AFileType:Char; AExt: string; AID: Integer; const AGUID:
  TGUID; out  Obj): Boolean;
    constructor Create(const aConfDirName: string = ''); overload;
    destructor Destroy; override;

  end;

implementation
uses SAVLib, SysUtils, SPGetSid, MsAD, VKDBFDataSet, SAVLib_DBF, Variants,
  KoaUtils, Windows,PluginManager, PluginAPI;

{ TSAVAccessContainer }

function TSAVAccessClient.AddedProc(const aOld,
  aNew: TClientFile; const aDir, aSID, aPath: string): Boolean;
var
  {i: Integer;
  b: Byte;}
  Plugin: ISAVAccessFileAct;
begin
 // b := 0;
  Result := False;
 // i := 0;
  if FindPlugin(Char(aNew.TypeF),aNew.Ext,aNew.Action, ISAVAccessFileAct, Plugin) then
      begin
        Result:= Plugin.ProcessedFile(aNew,aOld,aDir,aSID,aPath)>0
      end;
  {while (i < FActions.Count) and (b < 1) do
  begin
    if (TSAVAccessFileAction(FActions.Items[i]).FileType = aNew.TypeF) and
      (TSAVAccessFileAction(FActions.Items[i]).FFileExt = aNew.Ext) and
      (TSAVAccessFileAction(FActions.Items[i]).FFileAction = aNew.Action) then
    begin
      Result := TSAVAccessFileAction(FActions.Items[i]).FileProc(aNew, aOld,
        aDir, aSID, aPath);
      b := 1;
    end;
    Inc(i);
  end }
end;

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
  FIniFile := TIniFile.Create(FConfigDir + csContainerCfg);
  FActions := TList.Create;
  SetErrorMode(SetErrorMode(0) or SEM_NOOPENFILEERRORBOX or
    SEM_FAILCRITICALERRORS);
  Plugins.SetVersion(1);
  // Загрузка всех плагинов. Подразумевается, что они лежат в под-папке Plugins
  Plugins.LoadPlugins(ExtractFilePath(ParamStr(0)) + 'Plugins', SPluginExt);
end;

function TSAVAccessClient.FindPlugin(const AFileType:Char; AExt: string; AID: Integer; const AGUID:
  TGUID; out  Obj): Boolean;
var
  X: Integer;
begin
  Result := False;
  for X := 0 to Plugins.Count - 1 do
    if (Plugins[X].ActionID = AID) and (Plugins[X].Extension = AExt) and (Plugins[x].FileType=AFileType) then
    begin
      Result := Supports(Plugins[X], AGUID, Obj);
      if Result then
        Break;
    end;
end;

destructor TSAVAccessClient.Destroy;
var
  I: Integer;
begin
  if Assigned(FDataSet) then
  begin
    FDataSet.ApplyUpdates(-1);
    FDataSet.Close;
    FreeAndNil(FDataset);
  end;
  if Assigned(FTemplate) then
    FreeAndNil(FTemplate);
  if Assigned(FIniFile) then
  begin
    FIniFile.WriteDateTime('option', 'LastChange', Now);
    FreeAndNil(Finifile);
  end;
  if Assigned(FActions) then
  begin
    for i := 0 to FACtions.Count - 1 do
      TObject(FACtions[i]).Free;
    FreeAndNil(FACtions);
  end;
  inherited;
end;

function TSAVAccessClient.FileProcessing(const aOld,
  aNew: TClientFile): Boolean;
var
  hFile: Cardinal;
  sf, ContDir: string;
begin
  Result := True;
  sf := FTemplate.GetPath(aNew.ClntFile);
  ContDir := IncludeTrailingPathDelimiter(GetDirBySource(char(aNew.Source))) + aNew.SID
    + '\f\';
  case aNew.TypeF of
    'F': //Файловая операция
      begin
        if (aNew.Ext = '') or (AddedProc(aOld, aNew, ContDir, aNew.SID, sf) =
          False) then
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
          end
      end;
    'C': //Операция с каталогом
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
              Result := ForceDirectories(ExcludeTrailingPathDelimiter(sf));
            end;
        else
          begin
            ;
          end;
        end
      end;
  else
    begin
      AddedProc(aOld, aNew, ContDir, aNew.SID, sf);
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

    FTemplate := TPathTemplate.Create(IncludeTrailingPathDelimiter(FJournalsDir) + csTemplateMain, False);
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
  Result.TypeF := WideChar(table1.fieldbyname(csFieldType).AsString[1]);
  Result.Action := table1.fieldbyname(csFieldAction).AsInteger;
  Result.MD5 := table1.fieldbyname(csFieldMD5).AsString;
  Result.Source := WideChar(aSource[1]);
  Result.SID := aSID;
end;

procedure TSAVAccessClient.SetActions(const Value: TList);
begin
  FActions := Value;
end;

procedure TSAVAccessClient.SetDataSet(const Value: TClientDataSet);
begin
  FDataSet := Value;
end;

procedure TSAVAccessClient.SetIniFile(const Value: TIniFile);
begin
  FIniFile := Value;
end;

//основная ф-ция обновления

procedure TSAVAccessClient.SortListVal(Source: TStrings);

var
  ListWork, ListRes: TStringList;
  j: Integer;

  function GetMinListNumb(List1: TStrings): Integer;
  var
    vMin: integer;
    i, x: Integer;
  begin
    if List1.Count > 1 then
    begin
      Result := 0;
      vMin := StrToIntDef(List1.ValueFromIndex[Result], Result);
      for i := 1 to pred(List1.Count) do
      begin
        x := StrToIntDef(List1.ValueFromIndex[i], 0);
        if vMin > x then
        begin
          Result := i;
          vMin := x;
        end;
      end;
    end
    else
      Result := 0;
  end;
begin
  if Source.Count > 1 then
  begin
    ListWork := TStringList.Create;
    ListRes := TStringList.Create;
    ListWork.Assign(Source);
    while ListWork.Count > 0 do
    begin
      j := GetMinListNumb(ListWork);
      ListRes.Add(ListWork[j]);
      ListWork.Delete(j);
    end;
    FreeAndNil(ListWork);
    Source.Clear;
    Source.Assign(ListRes);
    FreeAndNil(ListRes);
  end
end;

function TSAVAccessClient.Update: Boolean;
var
  ini: TIniFile;
  list1: TStringList;
  sUserIni: string;
  i: Integer;
begin

  UpdateContainerFile(FDomainsDir, Domain, FIniFile.ReadString('D', Domain,
    ''));
  sUserIni := IncludeTrailingPathDelimiter(FUsersDir) + FSID + '\' +
    csContainerCfg;
  if FileExists(sUserIni) then
  begin
    ini := TIniFile.Create(sUserIni);
    list1 := TStringList.Create;
    ini.ReadSection('groups', list1);
    SortListVal(list1);
    list1.SaveToFile(FConfigDir + 'workgroups.lst');
    for i := 0 to list1.Count - 1 do
    begin //work with groups SID from LOW to HIGH priority
      UpdateContainerFile(FGroupsDir, list1[i], FIniFile.ReadString('G',
        list1[i], ''));
    end;
    FreeAndNil(list1);
    FreeAndNil(ini);
    UpdateContainerFile(FUsersDir, SID, FIniFile.ReadString('U', SID, ''));
  end;
  FDataSet.ApplyUpdates(-1);
end;

//Обновление файлов определенного контейнера хранилища переданного в aDir+aSID

procedure TSAVAccessClient.UpdateContainerFile(const aDir, aSID, aVersion:
  string);
var
  ini: TIniFile;
  c: Char;
  s, vers: string;
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
  vers := Ini.ReadString('main', 'version', '');
  FreeAndNil(ini);
  if (FileExists(sPath + csFilesTable)) and (vers <> aVersion) then
  begin
    table1 := TVKDBFNTX.Create(nil);
    InitOpenDBF(table1, sPath + csFilesTable, 64);
    table1.Open;
    while not (table1.Eof) do
    begin
      if FDataSet.Locate(csFieldSrvrFile + ';' + csFieldExt + ';' + csFieldType
        +
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
        if FileProcessing(Record2ClientFile(table1, aSID, c),
          Record2ClientFile(table1, aSID, c)) then
        begin
          FDataSet.Insert;
          FileInfoMove(table1, FDataSet, True);
          FDataSet.Post;
        end;
      end;
      table1.Next;
    end;
    table1.Close;
    FreeAndNil(table1);
    FIniFile.WriteString(c, aSID, vers);
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

