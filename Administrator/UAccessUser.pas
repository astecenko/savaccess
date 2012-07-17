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

  end;

implementation
uses SAVLib, SAVLib_DBF, KoaUtils, SysUtils, VKDBFDataSet, VKDBFNTX, VKDBFIndex,
  VKDBFSorters, UAccessConstant, DB;

{ TSAVAccessUser }

constructor TSAVAccessUser.Create;
begin
  inherited Create;
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
begin

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
  table1.DBFFileName := IncludeTrailingPathDelimiter(Bases.JournalsDir) +
    csUsersTable;
  table1.AccessMode.AccessMode := 66;
  table1.Open;
  Result := table1.Locate(csFieldSID, s, []);
  if Result then
  begin
    SID := s;
    Caption := table1.fieldByName(csFieldCaption).AsString;
    Description := table1.FieldByName(csFieldDescription).AsString;
    ID := table1.FieldByName(csFieldID).AsInteger;
    Domain := table1.FieldByName(csFieldDomain).AsString;
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
  table1.DBFFileName := IncludeTrailingPathDelimiter(Bases.JournalsDir) +
    csUsersTable;
  table1.AccessMode.AccessMode := 66;
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
  Version:=table1.FieldByName(csFieldVersion).AsString;
  ID := table1.FieldByName(csFieldID).AsInteger;
  table1.Post;
  ForceDirectories(IncludeTrailingPathDelimiter(Bases.UsersDir) + SID);
  table1.Close;
  FreeAndNil(table1);
end;

procedure TSAVAccessUser.SetDomain(const Value: string);
begin
  FDomain := Value;
end;

procedure TSAVAccessUser.Open(aBase: TSAVAccessBase; const aCaption, aSID:
  string; const
  aDescription: string = ''; const aParam: string = ''; const aVersion: TVersionString =
    '');
begin
  inherited Open(aBase,aCaption,aSID,aDescription,aParam,aVersion);
  FDomain := aParam;
end;

end.

