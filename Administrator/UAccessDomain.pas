unit UAccessDomain;

interface
uses Classes, UAccessBase, UAccessContainer;

type
  TSAVAccessDomain = class(TSAVAccessContainer)
  private
    FGroups: TStringList;
    procedure SetGroups(const Value: TStringList);
  protected

  public
    property Groups: TStringList read FGroups write SetGroups;
    constructor Create; overload;
    constructor Create(aBase: TSAVAccessBase; const aCaption, aSID,
      aDescription: string); overload;
    destructor Destroy; override;
    procedure Save; override;
    function Load(aSID: string = ''): Boolean; override;
    procedure GetGroups(List: TStrings; const aWithSID: Boolean = False);
    procedure GetUsers(List: TStrings);
    procedure GetUsersFromAD(List: TStrings);
    procedure Clear; override;
    procedure Open(aBase: TSAVAccessBase; const aCaption, aSID: string; const
      aDescription: string = ''; const aParam: string = ''; const aVersion:
      TVersionString = ''); override;
    procedure UpdateVersion; override;
  end;

implementation
uses SAVLib, SAVLib_DBF, KoaUtils, SysUtils, VKDBFDataSet, VKDBFNTX, VKDBFIndex,
  VKDBFSorters, UAccessConstant, MsAD;

{ TSAVAccessDomain }

constructor TSAVAccessDomain.Create;
begin
  inherited Create;
  ContainerType := 'D';
  FGroups := TStringList.Create;
end;

procedure TSAVAccessDomain.Clear;
begin
  inherited;
  FGroups.Clear;
end;

constructor TSAVAccessDomain.Create(aBase: TSAVAccessBase; const aCaption,
  aSID, aDescription: string);
begin
  Create;
  Open(aBase, aCaption, aSID, aDescription);
  Save;
end;

procedure TSAVAccessDomain.GetGroups(List: TStrings; const aWithSID: Boolean =
  False);
begin
  GetAllGroups(SID, List, aWithSID);
end;

procedure TSAVAccessDomain.GetUsers(List: TStrings);
begin

end;

procedure TSAVAccessDomain.GetUsersFromAD(List: TStrings);
begin

end;

function TSAVAccessDomain.Load(aSID: string): Boolean;
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
    + csTableDomains, 64);
  table1.Open;
  Result := table1.Locate(csFieldSID, s, []);
  if Result then
  begin
    SID := s;
    Caption := table1.fieldByName(csFieldCaption).AsString;
    Description := table1.FieldByName(csFieldDescription).AsString;
    ID := table1.FieldByName(csFieldID).AsInteger;
    WorkDir := IncludeTrailingPathDelimiter(Bases.DomainsDir) + SID;
    ReadVersion;
  end;
  table1.Close;
  FreeAndNil(table1);
end;

procedure TSAVAccessDomain.Open(aBase: TSAVAccessBase; const aCaption,
  aSID, aDescription, aParam: string; const aVersion: TVersionString);
begin
  WorkDir := IncludeTrailingPathDelimiter(aBase.DomainsDir) + aSID;
  inherited Open(aBase, aCaption, aSID, aDescription, aParam, aVersion);
  GetGroups(FGroups, True);
end;

procedure TSAVAccessDomain.Save;
var
  table1: TVKDBFNTX;
begin
  inherited;
  table1 := TVKDBFNTX.Create(nil);
  SAVLib_DBF.InitOpenDBF(table1, Bases.JournalsPath + csTableDomains, 66);
  with table1.Indexes.Add as TVKNTXIndex do
    NTXFileName := Bases.JournalsPath + csIndexDomainName;
  with table1.Indexes.Add as TVKNTXIndex do
    NTXFileName := Bases.JournalsPath + csIndexDomainVersion;
  table1.Open;
  if table1.FLock then
  begin
    if not (table1.Locate(csFieldSID, SID, [])) then
    begin
      table1.Append;
      table1.FieldByName(csFieldSID).AsString := SID;
      table1.FieldByName(csFieldID).AsInteger :=
        table1.GetNextAutoInc(csFieldID);
    end
    else
      table1.Edit;
    table1.FieldByName(csFieldVersion).AsString := GetNewVersion;
    Version := table1.FieldByName(csFieldVersion).AsString;
    table1.FieldByName(csFieldCaption).AsString := Caption;
    table1.FieldByName(csFieldDescription).AsString := Description;
    ID := table1.FieldByName(csFieldID).AsInteger;
    table1.Post;
    table1.UnLock;
  end
  else
    raise Exception.Create(csFLockError + Table1.DBFFileName);
  table1.Close;
  FreeAndNil(table1);
  WorkDir := IncludeTrailingPathDelimiter(Bases.DomainsDir) + SID;
  ForceDirectories(WorkDir);
  WriteVersion;

end;

procedure TSAVAccessDomain.SetGroups(const Value: TStringList);
begin
  FGroups := Value;
end;

destructor TSAVAccessDomain.Destroy;
begin
  FreeAndNil(FGroups);
  inherited;
end;

procedure TSAVAccessDomain.UpdateVersion;
var
  table1: TVKDBFNTX;
begin
  inherited;
  table1 := TVKDBFNTX.Create(nil);
  InitOpenDBF(table1, Bases.JournalsPath + csTableDomains, 66);
  with table1.Indexes.Add as TVKNTXIndex do
    NTXFileName := Bases.JournalsPath + csIndexDomainVersion;
  table1.Open;
  if table1.Locate(csFieldSID, SID, []) then
  begin
    if table1.FLock then
    begin
      table1.Edit;
      table1.FieldByName(csFieldVersion).AsString := Version;
      table1.Post;
      table1.UnLock;
    end
    else
      raise Exception.Create(csFLockError + Table1.DBFFileName);
  end;
  table1.Close;
  FreeAndNil(table1);
end;

end.

