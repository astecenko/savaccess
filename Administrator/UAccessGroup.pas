unit UAccessGroup;

interface
uses Classes, UAccessBase, UAccessContainer;

type
  TSAVAccessGroup = class(TSAVAccessContainer)
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
    procedure GetUsersSID(List: TStrings);
    function UserAdd(const aSID: string): Boolean;
    function UserDelete(const aSID: string): Boolean;
    procedure Clear; override;

  end;

implementation
uses SysUtils, VKDBFDataSet, VKDBFNTX, VKDBFIndex, VKDBFSorters,
  UAccessConstant, SAVLib_DBF, IniFiles;
{ TSAVAccessGroup }

function TSAVAccessGroup.UserAdd(const aSID: string): Boolean;
var
  Ini01: TIniFile;
begin
  Result := True;
  Ini01 := TIniFile.Create(IncludeTrailingPathDelimiter(WorkDir) +
    csContainerCfg);
  Ini01.WriteBool('users', aSID, True);
  FreeAndNil(Ini01);
  try
    Ini01 := TIniFile.Create(IncludeTrailingPathDelimiter(Bases.UsersDir) + aSID
      +
      '\' + csContainerCfg);
    Ini01.WriteInteger('groups', SID, FPriority);
  except
    Result := False
  end;
  if Assigned(Ini01) then
    FreeAndNil(Ini01);
end;

procedure TSAVAccessGroup.Clear;
begin
  inherited;
  FPriority := 0;
end;

constructor TSAVAccessGroup.Create(aBase: TSAVAccessBase; const aCaption,
  aSID, aPriority, aDescription: string);
begin
  Create;
  Open(aBase, aCaption, aSID, aDescription, aPriority);
  Save;
end;

constructor TSAVAccessGroup.Create;
begin

end;

procedure TSAVAccessGroup.GetUsersSID(List: TStrings);
var
  Ini01: TIniFile;
begin
  Ini01 := TIniFile.Create(IncludeTrailingPathDelimiter(WorkDir) +
    csContainerCfg);
  Ini01.ReadSectionValues('users', List);
  FreeAndNil(Ini01);
end;

function TSAVAccessGroup.Load(aSID: string): Boolean;
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
    + csGroupsTable, 66);
  table1.Open;
  Result := table1.Locate(csFieldSID, s, []);
  if Result then
  begin
    SID := s;
    Caption := table1.fieldByName(csFieldCaption).AsString;
    Description := table1.FieldByName(csFieldDescription).AsString;
    ID := table1.FieldByName(csFieldID).AsInteger;
    Priority := table1.FieldByName(csFieldPrority).AsInteger;
    WorkDir := IncludeTrailingPathDelimiter(Bases.GroupsDir) + SID;
    ReadVersion;
  end;
  table1.Close;
  FreeAndNil(table1);
end;

procedure TSAVAccessGroup.Open(aBase: TSAVAccessBase; const aCaption, aSID,
  aDescription, aParam: string; const aVersion: TVersionString);
begin
  WorkDir := IncludeTrailingPathDelimiter(aBase.GroupsDir) + aSID;
  inherited Open(aBase, aCaption, aSID, aDescription, aParam, aVersion);
  FPriority := StrToInt(aParam);
end;

procedure TSAVAccessGroup.Save;
var
  table1: TVKDBFNTX;
  j: Integer;
begin
  inherited;
  table1 := TVKDBFNTX.Create(nil);
  SAVLib_DBF.InitOpenDBF(table1, IncludeTrailingPathDelimiter(Bases.JournalsDir)
    + csGroupsTable, 66);
  table1.Open;
  if (SID = '') or (not (table1.Locate(csFieldSID, SID, []))) then
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
  WorkDir := IncludeTrailingPathDelimiter(Bases.GroupsDir) + SID;
  ForceDirectories(WorkDir);
  WriteVersion;
end;

procedure TSAVAccessGroup.SetPriority(const Value: Integer);
begin
  FPriority := Value;
end;

function TSAVAccessGroup.UserDelete(const aSID: string): Boolean;
var
  Ini01: TIniFile;
begin
  Result := True;
  Ini01 := TIniFile.Create(IncludeTrailingPathDelimiter(WorkDir) +
    csContainerCfg);
  Ini01.DeleteKey('users', aSID);
  FreeAndNil(Ini01);
  try
    Ini01 := TIniFile.Create(IncludeTrailingPathDelimiter(Bases.UsersDir) + aSID
      +
      '\' + csContainerCfg);
    Ini01.DeleteKey('groups', SID);
  except
    Result := False;
  end;
  if Assigned(Ini01) then
    FreeAndNil(Ini01);
end;

end.

