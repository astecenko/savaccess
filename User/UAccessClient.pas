unit UAccessClient;

interface
uses Classes, UAccessConstant, DBClient, DB,IniFiles;

type
  TVersionString = string[30];

  TSAVAccessClient = class(TObject)
  private
    FUser: string;
    FDomain: string;
    FSID: string;
    FIniFile:TMemIniFile;
    FWorkstation: string;
    FDataSet: TClientDataSet;
    FConfigDir: string;
    FJournalsDir: string;
    FUsersDir: string;
    FGroupsDir: string;
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
    property IniFile:TMemIniFile read FIniFile write SetIniFile;
    procedure LoadFromFile(const aFileName: string);
    function CheckDomainVersion:Boolean;
    function CheckUserVersion:Boolean;
    function CheckGroupVersion(const aSID:string):Boolean;
    constructor Create(const aConfDirName: string = ''); overload;
    destructor Destroy; override;

  end;

implementation
uses SAVLib, SysUtils, SPGetSid, MsAD;

{ TSAVAccessContainer }

function TSAVAccessClient.CheckDomainVersion: Boolean;

begin

end;

function TSAVAccessClient.CheckGroupVersion(const aSID: string): Boolean;
begin

end;

function TSAVAccessClient.CheckUserVersion: Boolean;
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
    Size := 254;
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
    Size:=32;
  end;
  with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
  begin
    DisplayName := csFieldSID;
    DataType := ftString;
    Size:=50;
  end;
  with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
  begin
    DisplayName := csFieldSource;
    DataType := ftString;
    Size:=1;
  end;
  FDataSet.CreateDataSet;
  if FileExists(FConfigDir+csClientData) then FDataSet.LoadFromFile(FConfigDir+csClientData);
  FDataSet.Open;
  FDataSet.LogChanges:=False;
  FDataSet.FileName:=FConfigDir+csClientData;
  FIniFile:=TMemIniFile.Create(FConfigDir+csContainerCfg);
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
      FIniFile.WriteDateTime('option','LastChange',Now);
      FIniFile.UpdateFile;
      FreeAndNil(Finifile);
    end;   
  inherited;
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
  end
  else
    raise Exception.Create('Нет доступа к файлу ' + aFileName);
end;

procedure TSAVAccessClient.SetDataSet(const Value: TClientDataSet);
begin
  FDataSet := Value;
end;

procedure TSAVAccessClient.SetIniFile(const Value: TMemIniFile);
begin
  FIniFile := Value;
end;

end.

