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
    procedure SetDataSet(const Value: TClientDataSet);
    procedure SetIniFile(const Value: TMemIniFile);
  public
    property ConfigDir: string read FConfigDir;
    property Domain: string read FDomain;
    property SID: string read FSID;
    property User: string read FUser;
    property DataSet: TClientDataSet read FDataSet write SetDataSet;
    property JournalsDir: string read FJournalsDir;
    property UsersDir: string read FUsersDir;
    property GroupsDir: string read FGroupsDir;
    property DomainsDir: string read FDomainsDir;
    property Workstation: string read FWorkstation;
    property IniFile: TMemIniFile read FIniFile write SetIniFile;
    procedure LoadFromFile(const aFileName: string);
    function Record2ClientFile(table1: TDataSet): TClientFile;
    procedure ClientFile2Record(table1:TDataSet; const ClntFile1:TClientFile);
    function CheckDomainVersion: Boolean; //True = Equal
    function CheckUserVersion: Boolean;
    function CheckGroupVersion(const aSID: string): Boolean;
    function FileProcessing(const aOld, aNew: TClientFile): Boolean;
    procedure UpdateContainerFile(const aDir: string);
    constructor Create(const aConfDirName: string = ''); overload;
    destructor Destroy; override;

  end;

implementation
uses SAVLib, SysUtils, SPGetSid, MsAD, VKDBFDataSet, SAVLib_DBF, Variants;

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
  inherited;
end;

function TSAVAccessClient.FileProcessing(const aOld,
  aNew: TClientFile): Boolean;
begin
  Result := False;
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

function TSAVAccessClient.Record2ClientFile(table1: TDataSet): TClientFile;
begin
  Result.SrvrFile := table1.fieldbyname(csFieldSrvrFile).AsString;
  Result.Ext := table1.fieldbyname(csFieldExt).AsString;
  Result.Version := table1.fieldbyname(csFieldVersion).AsString;
  Result.ClntFile := table1.fieldbyname(csFieldClntFile).AsString;
  Result.TypeF := table1.fieldbyname(csFieldType).AsString[1];
  Result.Action := table1.fieldbyname(csFieldAction).AsInteger;
  Result.MD5 := table1.fieldbyname(csFieldMD5).AsString;
end;

procedure TSAVAccessClient.SetDataSet(const Value: TClientDataSet);
begin
  FDataSet := Value;
end;

procedure TSAVAccessClient.SetIniFile(const Value: TMemIniFile);
begin
  FIniFile := Value;
end;

procedure TSAVAccessClient.UpdateContainerFile(const aDir: string);
var
  ini: TIniFile;
  c: Char;
  s: string;
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
  ini := TIniFile.Create(aDir + csContainerCfg);
  c := Ini.ReadString('main', 'type', ' ')[1];
  FreeAndNil(ini);
  table1 := TVKDBFNTX.Create(nil);
  InitOpenDBF(table1, aDir + csFilesTable, 64);
  table1.Open;
  while not (table1.Eof) do
  begin
    if FDataSet.Locate(csFieldSrvrFile + ';' + csFieldExt + ';' + csFieldType,
      varArrayOf([table1.fieldbyname(csFieldSrvrFile).AsString,
      table1.fieldbyname(csFieldExt).AsString,
        table1.fieldbyname(csFieldType).AsString]), []) then
    begin
      if FDataSet.fieldbyname(csFieldMD5).AsString <>
        table1.fieldbyname(csFieldMD5).AsString then
      begin
        if FileProcessing(Record2ClientFile(FDataSet),
          Record2ClientFile(table1)) then
        begin
          FDataSet.Edit;
          FileInfoMove(table1,FDataSet,False);
          FDataSet.Post;
        end;
      end
    end
    else
    begin

    end;
    table1.Next;
  end;
  {case c of
    'U': s := FUsersDir+;
    'D': s:=FDomainsDir;
    'G': s:=FGroupsDir;
  end;
  if (c <> '') and (c <> ' ') then
  begin

  end;}
end;

end.

