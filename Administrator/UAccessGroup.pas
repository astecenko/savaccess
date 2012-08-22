unit UAccessGroup;

interface
uses Classes, UAccessBase, UAccessContainer, CheckLst;

type
  TSAVAccessGroup = class(TSAVAccessContainer)
  private
    FPriority: Integer;
    procedure SetPriority(const Value: Integer);
    //function UserAdd(const aSID: string): Boolean;
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
    procedure GetUsersSID(List: TStrings; const aCaption: Boolean = False);
      overload;
    procedure GetUsersSID(List: TCheckListBox; const aCaption: Boolean = False);
      overload;
    function UserAdd(const aSID: string): Boolean;
    function UserDelete(const aSID: string): Boolean;
    function UserOff(const aSID: string): Boolean;
    function UserOn(const aSID: string): Boolean;
    function UserSwitch(const aSID: string; const aWork: Boolean):Boolean;
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
  Ini01.WriteBool(csIniUsers, aSID, True);
  FreeAndNil(Ini01);
  try
    Ini01 := TIniFile.Create(IncludeTrailingPathDelimiter(Bases.UsersDir) + aSID
      +
      '\' + csContainerCfg);
    Ini01.WriteInteger(csIniGroups, SID, FPriority);
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
inherited Create;
ContainerType:='G';
end;

procedure TSAVAccessGroup.GetUsersSID(List: TStrings; const aCaption: Boolean =
  False);
var
  Ini01: TIniFile;
  i: Integer;
  s: string;
  OldFiltered: Boolean;
  OldRecNo: Integer;
begin
  Ini01 := TIniFile.Create(IncludeTrailingPathDelimiter(WorkDir) +
    csContainerCfg);
  List.Clear;
  Ini01.ReadSection(csIniUsers, List);
  if (aCaption) and (Bases.TableUsers.RecordCount > 0) then
  begin
    OldFiltered := Bases.TableUsers.Filtered;
    OldRecNo := Bases.TableUsers.RecNo;
    Bases.TableUsers.Filtered := False;
    for i := 0 to List.Count - 1 do
    begin
      if Bases.TableUsers.Locate(csFieldSID, List[i], []) then
        s := Bases.TableUsers.FieldByName(csFieldCaption).AsString
      else
        s := csNotFound;
      List[i] := s + '=' + List[i];
    end;
    Bases.TableUsers.RecNo := OldRecNo;
    Bases.TableUsers.Filtered := OldFiltered;
  end;
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
    + csTableGroups, 66);
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
    + csTableGroups, 66);
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
  Ini01.DeleteKey(csIniUsers, aSID);
  FreeAndNil(Ini01);
  try
    Ini01 := TIniFile.Create(IncludeTrailingPathDelimiter(Bases.UsersDir) + aSID
      +
      '\' + csContainerCfg);
    Ini01.DeleteKey(csIniGroups, SID);
  except
    Result := False;
  end;
  if Assigned(Ini01) then
    FreeAndNil(Ini01);
end;

procedure TSAVAccessGroup.GetUsersSID(List: TCheckListBox;
  const aCaption: Boolean);
var
  Ini01: TMemIniFile;
  i: Integer;
  s: string;
  OldFiltered: Boolean;
  OldRecNo: Integer;
begin
  Ini01 := TMemIniFile.Create(IncludeTrailingPathDelimiter(WorkDir) +
    csContainerCfg);
  List.Clear;
  Ini01.ReadSection(csIniUsers, List.Items);
  for i := 0 to List.Count - 1 do
    List.Checked[i] := Ini01.ReadBool(csIniUsers, List.Items[i], False);
  if (aCaption) and (Bases.TableUsers.RecordCount > 0) then
  begin
    OldFiltered := Bases.TableUsers.Filtered;
    OldRecNo := Bases.TableUsers.RecNo;
    Bases.TableUsers.Filtered := False;
    for i := 0 to List.Count - 1 do
    begin
      if Bases.TableUsers.Locate(csFieldSID, List.Items[i], []) then
        s := Bases.TableUsers.FieldByName(csFieldCaption).AsString
      else
        s := 'Not found';
      List.Items[i] := s + '=' + List.items[i];
    end;
    Bases.TableUsers.RecNo := OldRecNo;
    Bases.TableUsers.Filtered := OldFiltered;
  end;
  FreeAndNil(Ini01);
end;

function TSAVAccessGroup.UserOff(const aSID: string): Boolean;
begin
  Result:=UserSwitch(aSID, False);
end;

function TSAVAccessGroup.UserOn(const aSID: string): Boolean;
begin
  Result:=UserSwitch(aSID, True);
end;

function TSAVAccessGroup.UserSwitch(const aSID: string;
  const aWork: Boolean):Boolean;
var
  Ini01: TIniFile;
begin
  Result := True;
  Ini01 := TIniFile.Create(IncludeTrailingPathDelimiter(WorkDir) +
    csContainerCfg);
  Ini01.WriteBool(csIniUsers, aSID, aWork);
  FreeAndNil(Ini01);
  try
    Ini01 := TIniFile.Create(IncludeTrailingPathDelimiter(Bases.UsersDir) + aSID
      +
      '\' + csContainerCfg);
    if aWork then
      Ini01.WriteInteger(csIniGroups, SID, Priority)
    else
      Ini01.DeleteKey(csIniGroups, SID);
  except
    Result := False;
  end;
  if Assigned(Ini01) then
    FreeAndNil(Ini01);
end;



end.

