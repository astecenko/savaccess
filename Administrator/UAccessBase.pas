{
Класс хранилища
}
unit UAccessBase;

interface
uses Classes, VKDBFDataSet, VKDBFNTX, VKDBFIndex, VKDBFSorters;

type
  TSAVAccessBase = class(TObject)
  private
    FStoragePath: string;
    FJournalsDir: string;
    FUsersDir: string;
    FGroupsDir: string;
    FADGroupsDir: string;
    FDomainsDir: string;
    FTableUsers: TVKDBFNTX;
    FTableDomains: TVKDBFNTX;
    FTableGroups: TVKDBFNTX;
    FTableADGroups: TVKDBFNTX;
    FCaption: string;
    procedure SetStoragePath(const Value: string);
    function StorageCheck: Boolean;
    function GetFullPath(const aDir: string): string;
    procedure SetJournalsDir(const Value: string);
    procedure SetGroupsDir(const Value: string);
    procedure SetUsersDir(const Value: string);
    function CreateTableUsers: Boolean;
    function CreateTableGroups: Boolean;
    //function CreateTableADGroups: Boolean;
    function CreateTableDomains: Boolean;
    function CreateTableOrgUnits: Boolean;
    function CreateTableLinks: Boolean;
    function CreateTableSupport: Boolean;
    function CreateTableExtension: Boolean;
    function CreateTableActions: Boolean;
    procedure SetDomainsDir(const Value: string);
    procedure GetListByName(List: TStrings; const TableName: string);
    procedure SetCaption(const Value: string);
    procedure SetTableDomains(const Value: TVKDBFNTX);
    procedure SetTableGroups(const Value: TVKDBFNTX);
    procedure SetTableUsers(const Value: TVKDBFNTX);
    procedure SetADGroupsDir(const Value: string);
    procedure SetTableADGroups(const Value: TVKDBFNTX);
  protected

  public
    property StoragePath: string read FStoragePath write SetStoragePath;
    property JournalsDir: string read FJournalsDir write SetJournalsDir;
    property UsersDir: string read FUsersDir write SetUsersDir;
    property GroupsDir: string read FGroupsDir write SetGroupsDir;
    property ADGroupsDir: string read FADGroupsDir write SetADGroupsDir;
    property DomainsDir: string read FDomainsDir write SetDomainsDir;
    property Caption: string read FCaption write SetCaption;
    property TableUsers: TVKDBFNTX read FTableUsers write SetTableUsers;
    property TableDomains: TVKDBFNTX read FTableDomains write SetTableDomains;
    property TableGroups: TVKDBFNTX read FTableGroups write SetTableGroups;
    property TableADGroups: TVKDBFNTX read FTableADGroups write
      SetTableADGroups;
    constructor Create; overload;
    constructor Create(const aPath: string; const bCanCreate: Boolean = False;
      const aJournals: string = ''; const aDomains: string = ''; const aGroups:
      string = ''; const aUsers: string = ''; const aADGroups: string = '');
      overload;
    function CreateTableADGroups: Boolean;
    function CreateStorage: Boolean;
    procedure GetGroups(List: TStrings);
    procedure GetUsers(List: TStrings);
    procedure GetDomains(List: TStrings);
    procedure SaveToFile(const aFileName: string);
    procedure LoadFromFile(const aFileName: string);
    procedure DirectoryInit;

  end;

implementation
uses SAVLib, SAVLib_DBF, KoaUtils, SysUtils, UAccessConstant;

{ TSAVAccessBase }

constructor TSAVAccessBase.Create;
begin
  FJournalsDir := csDefJournalDir;
  FGroupsDir := csDefGroupDir;
  FDomainsDir := csDefDomainDir;
  FUsersDir := csDefUserDir;
  FADGroupsDir := csDefADGroupDir;
  FCaption:='';
end;

constructor TSAVAccessBase.Create(const aPath: string; const bCanCreate: Boolean
  = False; const aJournals: string = ''; const aDomains: string = ''; const
  aGroups: string = ''; const aUsers: string = ''; const aADGroups: string =
  '');
var
  s: string;
begin
  Create;
  FStoragePath := aPath;
  s := IncludeTrailingPathDelimiter(FStoragePath);
  if aJournals <> '' then
    FJournalsDir := ExcludeTrailingPathDelimiter(aJournals)
  else
    FJournalsDir := s + FJournalsDir;
  if aGroups <> '' then
    FGroupsDir := ExcludeTrailingPathDelimiter(aGroups)
  else
    FGroupsDir := s + FGroupsDir;
  if aDomains <> '' then
    FDomainsDir := ExcludeTrailingPathDelimiter(aDomains)
  else
    FDomainsDir := s + FDomainsDir;
  if aUsers <> '' then
    FUsersDir := ExcludeTrailingPathDelimiter(aUsers)
  else
    FUsersDir := s + FUsersDir;
  if aADGroups <> '' then
    FADGroupsDir := ExcludeTrailingPathDelimiter(aADGroups)
  else
    FADGroupsDir := s + FADGroupsDir;
  if bCanCreate then
    if not (CreateStorage) then
      raise Exception.Create('Ошибка при создании хранилища ' + FStoragePath);
end;

procedure TSAVAccessBase.SetStoragePath(const Value: string);
begin
  FStoragePath := Value;
end;

function TSAVAccessBase.GetFullPath(const aDir: string): string;
begin
  if (aDir[2] = ':') or (aDir[2] = '\') or (aDir[2] = '/') then
    Result := aDir
  else
    Result := IncludeTrailingPathDelimiter(FStoragePath) + aDir;
end;

procedure TSAVAccessBase.SetGroupsDir(const Value: string);
begin
  FGroupsDir := GetFullPath(Value);
end;

procedure TSAVAccessBase.SetJournalsDir(const Value: string);
begin
  FJournalsDir := GetFullPath(Value);
end;

procedure TSAVAccessBase.SetUsersDir(const Value: string);
begin
  FUsersDir := GetFullPath(Value);
end;

function TSAVAccessBase.StorageCheck: Boolean;
begin
  Result := (DirectoryExists(FStoragePath)) and (DirectoryExists(FUsersDir)) and
    (DirectoryExists(FGroupsDir)) and (DirectoryExists(FJournalsDir)) and
    (DirectoryExists(FDomainsDir)) and (DirectoryExists(FADGroupsDir)) and
    (FileExists(IncludeTrailingPathDelimiter(FJournalsDir) + csTableDomains));
end;

function TSAVAccessBase.CreateStorage: Boolean;
begin
  Result := StorageCheck;
  if Result = False then
  begin
    Result := (ForceDirectories(ExcludeTrailingPathDelimiter(FStoragePath))) and
      (ForceDirectories(ExcludeTrailingPathDelimiter(FJournalsDir))) and
      (ForceDirectories(ExcludeTrailingPathDelimiter(FUsersDir))) and
      (ForceDirectories(ExcludeTrailingPathDelimiter(FGroupsDir))) and
      (ForceDirectories(ExcludeTrailingPathDelimiter(FDomainsDir))) and
      (ForceDirectories(ExcludeTrailingPathDelimiter(FADGroupsDir)));
    if Result then
    begin
      CreateTableDomains;
      CreateTableUsers;
      CreateTableGroups;
      CreateTableADGroups;
      CreateTableOrgUnits;
      CreateTableLinks;
      CreateTableActions;
      CreateTableExtension;
      CreateTableSupport;
    end;
  end;
  if Result then
  begin
    if Assigned(FTableDomains) then
    begin
      FTableDomains.Close;
      ClearStructDBF(FTableDomains);
      InitOpenDBF(FTableDomains, IncludeTrailingPathDelimiter(FJournalsDir) +
        csTableDomains, 66);
      FTableDomains.Open;
    end;
    if Assigned(FTableUsers) then
    begin
      FTableUsers.Close;
      ClearStructDBF(FTableUsers);
      InitOpenDBF(FTableUsers, IncludeTrailingPathDelimiter(FJournalsDir) +
        csTableUsers, 66);
      FTableUsers.Open;
      {with FTableUsers.Indexes.Add as TVKNTXIndex do
      begin
        NTXFileName := IncludeTrailingPathDelimiter(FJournalsDir) +
          csUsersSIDIndex;
        if FileExists(NTXFileName) = False then
        begin
          ClipperVer := v501;
          KeyExpresion := 'SID';
        //  Unique := True;
          CreateIndex(True);
        end;
      end;
      FTableUsers.SetOrder(1);}
    end;
    if Assigned(FTableGroups) then
    begin
      FTableGroups.Close;
      ClearStructDBF(FTableGroups);
      InitOpenDBF(FTableGroups, IncludeTrailingPathDelimiter(FJournalsDir) +
        csTableGroups, 66);
      FTableGroups.Open;
    end;
    if Assigned(FTableADGroups) then
    begin
      FTableADGroups.Close;
      ClearStructDBF(FTableADGroups);
      InitOpenDBF(FTableADGroups, IncludeTrailingPathDelimiter(FJournalsDir) +
        csTableADGroups, 66);
      FTableADGroups.Open;
    end;
  end;
end;

function TSAVAccessBase.CreateTableDomains: Boolean;
var
  table1: TVKDBFNTX;
begin
  table1 := TVKDBFNTX.Create(nil);
  table1.DBFFileName := IncludeTrailingPathDelimiter(FJournalsDir) +
    csTableDomains;
  table1.OEM := True;
  table1.AccessMode.AccessMode := 66;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldID;
    field_type := 'N';
    len := 6;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldSID;
    field_type := 'C';
    len := 50;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldVersion;
    field_type := 'C';
    len := 30;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldCaption;
    field_type := 'C';
    len := 50;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldIni;
    field_type := 'C';
    len := 250;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldPath;
    field_type := 'C';
    len := 250;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldDescription;
    field_type := 'C';
    len := 250;
  end;
  Result := True;
  try
    table1.CreateTable;
  except
    Result := False;
  end;
  FreeAndNil(table1);
  (*viborka.Open;
  with viborka.Indexes.Add as TVKNTXIndex do
  begin
    NTXFileName := ChangeFileExt(viborka.DBFFileName, csExt_Ntx);
    KeyExpresion := csField_Ki;
    { TODO -oСтеценко А.В. : Нужен ли тут индекс? }
    if arr_cp.Count > 0 then
      KeyExpresion := KeyExpresion + '+' + csField_Cp;
    CreateIndex(True);
  end;

  with qryBases.Indexes.Add as TVKNTXIndex do
          NTXFileName := ChangeFileExt(qryBases.DBFFileName, '.ntx');
  qryBases.Open;
  qryBases.SetOrder(1);

  *)
end;

function TSAVAccessBase.CreateTableGroups: Boolean;
var
  table1: TVKDBFNTX;
begin
  table1 := TVKDBFNTX.Create(nil);
  table1.AccessMode.AccessMode := 66;
  table1.OEM := True;
  table1.DBFFileName := IncludeTrailingPathDelimiter(FJournalsDir) +
    csTableGroups;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldID;
    field_type := 'N';
    len := 6;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldSID;
    field_type := 'C';
    len := 50;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldVersion;
    field_type := 'C';
    len := 30;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldCaption;
    field_type := 'C';
    len := 50;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldDescription;
    field_type := 'C';
    len := 200;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldPrority;
    field_type := 'N';
    len := 6;
  end;
  Result := True;
  try
    table1.CreateTable;
  except
    Result := False;
  end;
  FreeAndNil(table1);
end;

function TSAVAccessBase.CreateTableLinks: Boolean;
var
  table1: TVKDBFNTX;
begin
  table1 := TVKDBFNTX.Create(nil);
  table1.AccessMode.AccessMode := 66;
  table1.OEM := True;
  table1.DBFFileName := IncludeTrailingPathDelimiter(FJournalsDir) +
    csTableOULink;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldParent;
    field_type := 'N';
    len := 6;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldChild;
    field_type := 'N';
    len := 6;
  end;
  Result := True;
  try
    table1.CreateTable;
  except
    Result := False;
  end;
  FreeAndNil(table1);
end;

function TSAVAccessBase.CreateTableOrgUnits: Boolean;
begin
  Result := False;
end;

function TSAVAccessBase.CreateTableUsers: Boolean;
var
  table1: TVKDBFNTX;
begin
  table1 := TVKDBFNTX.Create(nil);
  table1.AccessMode.AccessMode := 66;
  table1.OEM := True;
  table1.DBFFileName := IncludeTrailingPathDelimiter(FJournalsDir) +
    csTableUsers;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldID;
    field_type := 'N';
    len := 6;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldCaption;
    field_type := 'C';
    len := 50;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldSID;
    field_type := 'C';
    len := 50;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldVersion;
    field_type := 'C';
    len := 30;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldDomain;
    field_type := 'C';
    len := 50;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldDescription;
    field_type := 'C';
    len := 200;
  end;
  Result := True;
  try
    table1.CreateTable;
  except
    Result := False;
  end;
  { table1.Open;
   with table1.Indexes.Add as TVKNTXIndex do
   begin
     NTXFileName := IncludeTrailingPathDelimiter(FJournalsDir) + csUsersSIDIndex;
     KeyExpresion := csFieldSID;
     Unique:=True;
     CreateIndex(True);
   end;
   table1.Close;}
  FreeAndNil(table1);
end;

procedure TSAVAccessBase.SetDomainsDir(const Value: string);
begin
  FDomainsDir := GetFullPath(Value);
end;

procedure TSAVAccessBase.GetListByName(List: TStrings;
  const TableName: string);
var
  table1: TVKDBFNTX;
begin
  table1 := TVKDBFNTX.Create(nil);
  table1.AccessMode.AccessMode := 64;
  table1.OEM := True;
  table1.DBFFileName := IncludeTrailingPathDelimiter(FJournalsDir) +
    TableName;
  table1.Open;
  while not (table1.Eof) do
  begin
    List.add(table1.fieldbyname(csFieldCaption).AsString);
    table1.Next;
  end;
  table1.Close;
  FreeAndNil(table1);
end;

procedure TSAVAccessBase.GetGroups(List: TStrings);
begin
  GetListByName(List, csTableGroups);
end;

procedure TSAVAccessBase.GetUsers(List: TStrings);
begin
  GetListByName(List, csTableUsers);
end;

procedure TSAVAccessBase.GetDomains(List: TStrings);
begin
  GetListByName(List, csTableDomains);
end;

procedure TSAVAccessBase.LoadFromFile(const aFileName: string);
var
  list: TStringList;
begin
  if FileExists(aFileName) then
  begin
    list := TStringList.Create;
    list.LoadFromFile(aFileName);
    FCaption := list.Values['caption'];
    if FCaption = '' then
      FCaption := ExtractFileName(aFileName);
    FStoragePath := list.Values['base'];
    FUsersDir := list.Values['users'];
    FJournalsDir := list.Values['journals'];
    FGroupsDir := list.Values['groups'];
    FADGroupsDir := list.Values['adgroups'];
    FDomainsDir := list.Values['domains'];
    FreeAndNil(list);
    CreateStorage;
  end
  else
    raise Exception.Create('Нет доступа к файлу ' + aFileName);
end;

procedure TSAVAccessBase.SaveToFile(const aFileName: string);
var
  list: TStringList;
begin
  list := TStringList.Create;
  list.Add('caption='+FCaption);
  list.Add('base=' + FStoragePath);
  list.Add('journals=' + FJournalsDir);
  list.Add('domains=' + FDomainsDir);
  list.Add('groups=' + FGroupsDir);
  list.Add('adgroups=' + FADGroupsDir);
  list.Add('users=' + FUsersDir);
  try
    list.SaveToFile(aFileName);
  except
    FreeAndNil(list);
    raise Exception.Create('Ошибка при сохранении ' + aFileName + ': ' +
      SysErrorMessage(GetLastError));
  end;
  if Assigned(list) then
    FreeAndNil(list);
end;

procedure TSAVAccessBase.SetCaption(const Value: string);
begin
  FCaption := Value;
end;

procedure TSAVAccessBase.SetTableDomains(const Value: TVKDBFNTX);
begin
  FTableDomains := Value;
end;

procedure TSAVAccessBase.SetTableGroups(const Value: TVKDBFNTX);
begin
  FTableGroups := Value;
end;

procedure TSAVAccessBase.SetTableUsers(const Value: TVKDBFNTX);
begin
  FTableUsers := Value;
end;

function TSAVAccessBase.CreateTableActions: Boolean;
var
  table1: TVKDBFNTX;
begin
  table1 := TVKDBFNTX.Create(nil);
  table1.AccessMode.AccessMode := 66;
  table1.OEM := True;
  table1.DBFFileName := IncludeTrailingPathDelimiter(FJournalsDir) +
    csTableAction;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldFID;
    field_type := 'N';
    len := 6;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldAction;
    field_type := 'N';
    len := 3;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldDescription;
    field_type := 'C';
    len := 150;
  end;
  Result := True;
  try
    table1.CreateTable;
  except
    Result := False;
  end;
  FreeAndNil(table1);
end;

function TSAVAccessBase.CreateTableExtension: Boolean;
var
  table1: TVKDBFNTX;
begin
  table1 := TVKDBFNTX.Create(nil);
  table1.AccessMode.AccessMode := 66;
  table1.OEM := True;
  table1.DBFFileName := IncludeTrailingPathDelimiter(FJournalsDir) +
    csTableExt;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldID;
    field_type := 'N';
    len := 6;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldExt;
    field_type := 'C';
    len := 10;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldType;
    field_type := 'C';
    len := 1;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldDescription;
    field_type := 'C';
    len := 150;
  end;
  Result := True;
  try
    table1.CreateTable;
  except
    Result := False;
  end;
  FreeAndNil(table1);
end;

function TSAVAccessBase.CreateTableSupport: Boolean;
var
  table1: TVKDBFNTX;
begin
  table1 := TVKDBFNTX.Create(nil);
  table1.AccessMode.AccessMode := 66;
  table1.OEM := True;
  table1.DBFFileName := IncludeTrailingPathDelimiter(FJournalsDir) +
    csTableSupport;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldID;
    field_type := 'N';
    len := 8;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldAction;
    field_type := 'C';
    len := 250;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldDescription;
    field_type := 'C';
    len := 100;
  end;
  Result := True;
  try
    table1.CreateTable;
  except
    Result := False;
  end;
  FreeAndNil(table1);
end;

function TSAVAccessBase.CreateTableADGroups: Boolean;
var
  table1: TVKDBFNTX;
begin
  table1 := TVKDBFNTX.Create(nil);
  table1.AccessMode.AccessMode := 66;
  table1.OEM := True;
  table1.DBFFileName := IncludeTrailingPathDelimiter(FJournalsDir) +
    csTableADGroups;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldID;
    field_type := 'N';
    len := 6;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldSID;
    field_type := 'C';
    len := 50;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldVersion;
    field_type := 'C';
    len := 30;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldCaption;
    field_type := 'C';
    len := 50;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldDescription;
    field_type := 'C';
    len := 200;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldPrority;
    field_type := 'N';
    len := 6;
  end;
  Result := True;
  try
    table1.CreateTable;
  except
    Result := False;
  end;
  FreeAndNil(table1);
end;

procedure TSAVAccessBase.SetADGroupsDir(const Value: string);
begin
  FADGroupsDir := GetFullPath(Value);
end;

procedure TSAVAccessBase.SetTableADGroups(const Value: TVKDBFNTX);
begin
  FTableADGroups := Value;
end;

procedure TSAVAccessBase.DirectoryInit;
var
  s: string;
begin
  s := IncludeTrailingPathDelimiter(FStoragePath);
  if FJournalsDir = '' then
    FJournalsDir := s + FJournalsDir;
  if FGroupsDir = '' then
    FGroupsDir := s + FGroupsDir;
  if FADGroupsDir = '' then
    FADGroupsDir := s + FADGroupsDir;
  if FDomainsDir = '' then
    FDomainsDir := s + FDomainsDir;
  if FUsersDir = '' then
    FUsersDir := s + FUsersDir;
end;

end.

