unit UAccessUser;

interface
uses Classes, UAccessBase, UAccessContainer;

type
  TSAVAccessUser = class(TSAVAccessContainer)
  private
    FDomain: string;
    procedure SetDomain(const Value: string);
  protected

  public
    property Domain: string read FDomain write SetDomain;
    constructor Create; overload;
    constructor Create(aBase: TSAVAccessBase; const aDomain, aCaption, aSID,
      aDescription: string); overload;
    procedure Save; override;
    procedure Open(aBase: TSAVAccessBase; const aCaption, aSID: string; const
      aDescription: string = ''; const aParam: string = ''; const aVersion:
      TVersionString = ''); override;
    function Load(aSID: string = ''): Boolean; override;
    procedure GetGroups(List: TStrings);
    procedure Clear; override;
    function GroupDelete(const aSID:string):Boolean;
    procedure UpdateVersion; override;
  end;

implementation
uses SAVLib, SAVLib_DBF, KoaUtils, SysUtils, VKDBFDataSet, VKDBFNTX, VKDBFIndex,
  VKDBFSorters, UAccessConstant, DB, IniFiles;

{ TSAVAccessUser }

constructor TSAVAccessUser.Create;
begin
  inherited Create;
  ContainerType := 'U';
end;

procedure TSAVAccessUser.Clear;
begin
  inherited;
  FDomain := '';
end;

constructor TSAVAccessUser.Create(aBase: TSAVAccessBase; const aDomain,
  aCaption, aSID, aDescription: string);
begin
  Create;
  Open(aBase, aCaption, aSID, aDescription, aDomain);
  Save;
end;

procedure TSAVAccessUser.GetGroups(List: TStrings);
var
  Ini01: TIniFile;
  list1: TStringList;
  table1: TVKDBFNTX;
  i: Integer;
begin
  List.Clear;
  Ini01 := TIniFile.Create(IncludeTrailingPathDelimiter(WorkDir) +
    csContainerCfg);
  list1 := TStringList.Create;
  ini01.ReadSectionValues(csIniGroups,list1);
  FreeAndNil(Ini01);
  table1 := TVKDBFNTX.Create(nil);
  SAVLib_DBF.InitOpenDBF(table1, IncludeTrailingPathDelimiter(Bases.JournalsDir)
    + csTableGroups, 64);
  table1.Open;
  for i := 0 to list1.Count - 1 do
    if table1.Locate(csFieldSID, list1.Names[i], []) then
      List.Add(table1.fieldByName(csFieldCaption).AsString + '=' +
        list1.Names[i])
    else
      List.Add(csNotFound + '=' + list1.Names[i]);
  table1.Close;
  FreeAndNil(table1);
  FreeAndNil(list1);
end;

function TSAVAccessUser.Load(aSID: string = ''): Boolean;
var
  table1: TVKDBFNTX;
  s: string;
begin
  //  inherited;
  if aSID = '' then
    s := SID
  else
    s := aSID;
  table1 := TVKDBFNTX.Create(nil);
  SAVLib_DBF.InitOpenDBF(table1, IncludeTrailingPathDelimiter(Bases.JournalsDir)
    + csTableUsers, 64);
  table1.Open;
  Result := table1.Locate(csFieldSID, s, []);
  if Result then
  begin
    SID := s;
    Caption := table1.fieldByName(csFieldCaption).AsString;
    Description := table1.FieldByName(csFieldDescription).AsString;
    ID := table1.FieldByName(csFieldID).AsInteger;
    Domain := table1.FieldByName(csFieldDomain).AsString;
    WorkDir := IncludeTrailingPathDelimiter(Bases.UsersDir) + SID;
    ReadVersion;
  end;
  table1.Close;
  FreeAndNil(table1);
end;

procedure TSAVAccessUser.Save;
var
  table1: TVKDBFNTX;
begin
  inherited;
  table1 := TVKDBFNTX.Create(nil);
  SAVLib_DBF.InitOpenDBF(table1, IncludeTrailingPathDelimiter(Bases.JournalsDir)
    + csTableUsers, 66);
  table1.Open;
  if not (table1.Locate(csFieldSID, SID, [])) then
  begin
    table1.Append;
    table1.FieldByName(csFieldSID).AsString := SID;
    table1.FieldByName(csFieldID).AsInteger := table1.GetNextAutoInc(csFieldID);
    table1.FieldByName(csFieldDomain).AsString := Domain;
  end
  else
    table1.Edit;
  table1.FieldByName(csFieldCaption).AsString := Caption;
  table1.FieldByName(csFieldDescription).AsString := Description;
  table1.FieldByName(csFieldVersion).AsString := GetNewVersion;
  Version := table1.FieldByName(csFieldVersion).AsString;
  ID := table1.FieldByName(csFieldID).AsInteger;
  table1.Post;
  table1.Close;
  FreeAndNil(table1);
  WorkDir := IncludeTrailingPathDelimiter(Bases.UsersDir) + SID;
  ForceDirectories(WorkDir);
  WriteVersion;
end;

procedure TSAVAccessUser.SetDomain(const Value: string);
begin
  FDomain := Value;
end;

procedure TSAVAccessUser.Open(aBase: TSAVAccessBase; const aCaption, aSID:
  string; const
  aDescription: string = ''; const aParam: string = ''; const aVersion:
  TVersionString =
  '');
begin
  WorkDir := IncludeTrailingPathDelimiter(aBase.UsersDir) + aSID;
  inherited Open(aBase, aCaption, aSID, aDescription, aParam, aVersion);
  FDomain := aParam;
end;

function TSAVAccessUser.GroupDelete(const aSID: string): Boolean;
var
  Ini01: TIniFile;
begin
  Result := True;
  Ini01 := TIniFile.Create(IncludeTrailingPathDelimiter(WorkDir) +
    csContainerCfg);
  Ini01.DeleteKey(csIniGroups, aSID);
  FreeAndNil(Ini01);
  try
    Ini01 := TIniFile.Create(IncludeTrailingPathDelimiter(Bases.GroupsDir) + aSID
      +
      '\' + csContainerCfg);
    Ini01.DeleteKey(csIniUsers, SID);
  except
    Result := False;
  end;
  if Assigned(Ini01) then
    FreeAndNil(Ini01);
end;

procedure TSAVAccessUser.UpdateVersion;
var
  table1: TVKDBFNTX;
begin
  inherited;
  table1 := TVKDBFNTX.Create(nil);
  InitOpenDBF(table1, IncludeTrailingPathDelimiter(Bases.JournalsDir)
    + csTableUsers, 66);
  table1.Open;
  if table1.Locate(csFieldSID, SID, []) then
  begin
    table1.Edit;
    table1.FieldByName(csFieldVersion).AsString := Version;
    table1.Post;
  end;
  table1.Close;
  FreeAndNil(table1);
end;

end.

