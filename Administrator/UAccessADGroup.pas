unit UAccessADGroup;

interface
uses Classes, UAccessBase, UAccessContainer;

type
  TSAVAccessADGroup = class(TSAVAccessContainer)
  private
    FPriority: Integer;
    procedure SetPriority(const Value: Integer);

  protected

  public
    property Priority: Integer read FPriority write SetPriority;
    constructor Create; overload;
    constructor Create(aBase: TSAVAccessBase; const aCaption, aSID, aPriority,
      aDescription:
      string);
      overload;
    procedure Save; override;
    function Load(aSID: string = ''): Boolean; override;
    procedure Open(aBase: TSAVAccessBase; const aCaption, aSID: string; const
      aDescription: string = ''; const aParam: string = ''; const aVersion:
      TVersionString = ''); override;
    procedure GetUsersSID(List: TStrings; const aDomain: string; const aSID:
      Boolean = False);
      overload;
    procedure Clear; override;
    procedure UpdateVersion; override;

  end;

implementation
uses SysUtils, VKDBFDataSet, VKDBFNTX, VKDBFIndex, VKDBFSorters,
  UAccessConstant, SAVLib_DBF, IniFiles, MsAD;
{ TSAVAccessGroup }

procedure TSAVAccessADGroup.Clear;
begin
  inherited;
  FPriority := 0;
end;

constructor TSAVAccessADGroup.Create(aBase: TSAVAccessBase; const aCaption,
  aSID, aPriority, aDescription: string);
begin
  Create;
  Open(aBase, aCaption, aSID, aDescription, aPriority);
  Save;
end;

constructor TSAVAccessADGroup.Create;
begin
  inherited Create;
  ContainerType := 'A';
end;

procedure TSAVAccessADGroup.GetUsersSID(List: TStrings; const aDomain: string;
  const aSID: Boolean =
  False);
var
  i: Integer;
  adns: string;
begin
  List.Clear;
  adns := GetDNSDomainName(aDomain);
  GetAllGroupUsers(Caption, GetDomainController(aDomain), List);
  if aSID then
    for i := 0 to List.Count - 1 do
      List[i] := List[i] + '=' + GetSID(List[i], adns);
end;

function TSAVAccessADGroup.Load(aSID: string): Boolean;
var
  table1: TVKDBFNTX;
  s: string;
begin
  if aSID = '' then
    s := SID
  else
    s := aSID;
  table1 := TVKDBFNTX.Create(nil);
  InitOpenDBF(table1, IncludeTrailingPathDelimiter(Bases.JournalsDir)
    + csTableADGroups, 66);
  table1.Open;
  Result := table1.Locate(csFieldSID, s, []);
  if Result then
  begin
    SID := s;
    Caption := table1.fieldByName(csFieldCaption).AsString;
    Description := table1.FieldByName(csFieldDescription).AsString;
    ID := table1.FieldByName(csFieldID).AsInteger;
    Priority := table1.FieldByName(csFieldPrority).AsInteger;
    WorkDir := IncludeTrailingPathDelimiter(Bases.ADGroupsDir) + SID;
    ReadVersion;
  end;
  table1.Close;
  FreeAndNil(table1);
end;

procedure TSAVAccessADGroup.Open(aBase: TSAVAccessBase; const aCaption, aSID,
  aDescription, aParam: string; const aVersion: TVersionString);
begin
  WorkDir := IncludeTrailingPathDelimiter(aBase.ADGroupsDir) + aSID;
  inherited Open(aBase, aCaption, aSID, aDescription, aParam, aVersion);
  FPriority := StrToIntDef(aParam, 0);
end;

procedure TSAVAccessADGroup.Save;
var
  table1: TVKDBFNTX;
  j: Integer;
begin
  inherited;
  table1 := TVKDBFNTX.Create(nil);
  SAVLib_DBF.InitOpenDBF(table1, IncludeTrailingPathDelimiter(Bases.JournalsDir)
    + csTableADGroups, 66);
  table1.Open;
  if not (table1.Locate(csFieldSID, SID, [])) then
  begin
    table1.Append;
    j := table1.GetNextAutoInc(csFieldID);
    if SID = '' then
      SID := IntToStr(j);
    table1.FieldByName(csFieldSID).AsString := SID;
    table1.FieldByName(csFieldID).AsInteger := j;
  end
  else
    table1.Edit;
  table1.FieldByName(csFieldPrority).AsInteger := FPriority;
  table1.FieldByName(csFieldCaption).AsString := Caption;
  table1.FieldByName(csFieldDescription).AsString := Description;
  table1.FieldByName(csFieldVersion).AsString := GetNewVersion;
  Version := table1.FieldByName(csFieldVersion).AsString;
  ID := table1.FieldByName(csFieldID).AsInteger;
  table1.Post;
  table1.Close;
  FreeAndNil(table1);
  WorkDir := IncludeTrailingPathDelimiter(Bases.ADGroupsDir) + SID;
  ForceDirectories(WorkDir);
  WriteVersion;
end;

procedure TSAVAccessADGroup.SetPriority(const Value: Integer);
begin
  FPriority := Value;
end;

procedure TSAVAccessADGroup.UpdateVersion;
var
  table1: TVKDBFNTX;
begin
  inherited;
  table1 := TVKDBFNTX.Create(nil);
  InitOpenDBF(table1, IncludeTrailingPathDelimiter(Bases.JournalsDir)
    + csTableADGroups, 66);
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

