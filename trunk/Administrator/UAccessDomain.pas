unit UAccessDomain;

interface
uses Classes, UAccessBase, UAccessContainer;

type
  TSAVAccessDomain = class(TSAVAccessContainer)
  private

  protected

  public
    constructor Create; overload;
    constructor Create(aBase: TSAVAccessBase; const aCaption, aSID,
      aDescription:
      string);
      overload;
    procedure Save; override;
    function Load(aSID: string = ''): Boolean; override;
    procedure GetGroups(List: TStrings);
    procedure GetUsers(List: TStrings);
    procedure GetUsersFromAD(List: TStrings);
    procedure Open(aBase: TSAVAccessBase; const aCaption, aSID: string; const
      aDescription: string = ''; const aParam: string = ''; const aVersion:
      TVersionString = ''); override;

  end;

implementation
uses SAVLib, SAVLib_DBF, KoaUtils, SysUtils, VKDBFDataSet, VKDBFNTX, VKDBFIndex,
  VKDBFSorters, UAccessConstant, DB;

{ TSAVAccessDomain }

constructor TSAVAccessDomain.Create;
begin
  inherited Create;
end;

constructor TSAVAccessDomain.Create(aBase: TSAVAccessBase; const aCaption,
  aSID, aDescription: string);
begin
  Create;
  Open(aBase, aCaption, aSID, aDescription);
  Save;
end;

procedure TSAVAccessDomain.GetGroups(List: TStrings);
begin

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
  table1.DBFFileName := IncludeTrailingPathDelimiter(Bases.JournalsDir) +
    csDomainsTable;
  table1.OEM := True;
  table1.AccessMode.AccessMode := 66;
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
  WorkDir := IncludeTrailingPathDelimiter(Bases.DomainsDir) + aSID;
  inherited Open(aBase, aCaption, aSID, aDescription, aParam, aVersion);
end;

procedure TSAVAccessDomain.Save;
var
  table1: TVKDBFNTX;
begin
  inherited;
  table1 := TVKDBFNTX.Create(nil);
  table1.DBFFileName := IncludeTrailingPathDelimiter(Bases.JournalsDir) +
    csDomainsTable;
  table1.OEM := True;
  table1.AccessMode.AccessMode := 66;
  table1.Open;
  if not (table1.Locate(csFieldSID, SID, [])) then
  begin
    table1.Append;
    table1.FieldByName(csFieldSID).AsString := SID;
    table1.FieldByName(csFieldID).AsInteger := table1.GetNextAutoInc(csFieldID);
  end
  else
    table1.Edit;
  table1.FieldByName(csFieldVersion).AsString := GetNewVersion;
  Version := table1.FieldByName(csFieldVersion).AsString;
  table1.FieldByName(csFieldCaption).AsString := Caption;
  table1.FieldByName(csFieldDescription).AsString := Description;
  ID := table1.FieldByName(csFieldID).AsInteger;
  table1.Post;
  table1.Close;
  FreeAndNil(table1);
  WorkDir := IncludeTrailingPathDelimiter(Bases.DomainsDir) + SID;
  ForceDirectories(WorkDir);
  WriteVersion;

end;

end.

