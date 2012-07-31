unit UAccessContainer;

interface
uses Classes, UAccessBase;

type
  TVersionString = string[30];

  TSAVAccessContainer = class(TObject)
  private
    FCaption: string;
    FDescription: string;
    FSID: string;
    FVersion: TVersionString;
    FID: Integer;
    FWorkDir: string;
    FFilepath: string;
    FContainerType:Char;
    FIniPath: string;
    FBases: TSAVAccessBase;
    procedure SetBases(const Value: TSAVAccessBase);
    procedure SetCaption(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetFilePath(const Value: string);
    procedure SetIniPath(const Value: string);
    procedure SetSID(const Value: string);
    procedure SetID(const Value: Integer);
    procedure SetVersion(const Value: TVersionString);
    procedure SetWorkDir(const Value: string);
    procedure SetContainerType(const Value: Char);
  public
    property Caption: string read FCaption write SetCaption;
    property Description: string read FDescription write SetDescription;
    property WorkDir: string read FWorkDir write SetWorkDir;
    property ID: Integer read FID write SetID;
    property SID: string read FSID write SetSID;
    property ContainerType:Char read FContainerType write SetContainerType;
    property FilePath: string read FFilePath write SetFilePath;
    property IniPath: string read FIniPath write SetIniPath;
    property Version: TVersionString read FVersion write SetVersion;
    property Bases: TSAVAccessBase read FBases write SetBases;
    constructor Create; overload;
    procedure Save; virtual; abstract;
    function Load(aSID: string = ''): Boolean; virtual; abstract;
    procedure GetImportantList(List: TStrings); virtual;
    procedure GetIndependentList(List: TStrings); virtual;
    procedure Clear; virtual;
    procedure Open(aBase: TSAVAccessBase; const aCaption, aSID: string; const
      aDescription: string = ''; const aParam: string = ''; const aVersion:
      TVersionString = ''); virtual;
    function GetNewVersion: string;
    function WriteVersion(const aFileName: string = ''): Boolean;
    function ReadVersion(const aFileName: string = ''): Boolean;
  end;

implementation
uses Sysutils, IniFiles, UAccessConstant;

{ TSAVAccessContainer }

constructor TSAVAccessContainer.Create;
begin

end;

procedure TSAVAccessContainer.SetBases(const Value: TSAVAccessBase);
begin
  FBases := Value
end;

procedure TSAVAccessContainer.SetCaption(const Value: string);
begin

end;

procedure TSAVAccessContainer.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

procedure TSAVAccessContainer.SetFilePath(const Value: string);
begin
  FFilepath := Value;
end;

procedure TSAVAccessContainer.SetIniPath(const Value: string);
begin
  FIniPath := Value
end;

procedure TSAVAccessContainer.SetID(const Value: Integer);
begin
  FID := Value
end;

procedure TSAVAccessContainer.SetSID(const Value: string);
begin
  FSID := Value
end;

procedure TSAVAccessContainer.Clear;
begin
  FCaption := '';
  FDescription := '';
  FSID := '';
  FID := 0;
  FFilepath := '';
  FIniPath := '';
  FBases := nil;
  FVersion := '';
  FWorkDir := '';
end;

procedure TSAVAccessContainer.GetImportantList(List: TStrings);
begin

end;

procedure TSAVAccessContainer.GetIndependentList(List: TStrings);
begin

end;

procedure TSAVAccessContainer.SetVersion(const Value: TVersionString);
begin
  FVersion := Value;
end;

function TSAVAccessContainer.GetNewVersion: string;
begin
  DateTimeToString(Result, 'yymmddhhnnss', Now);
end;

procedure TSAVAccessContainer.Open(aBase: TSAVAccessBase; const aCaption,
  aSID, aDescription, aParam: string; const aVersion: TVersionString);
begin
  FBases := aBase;
  FCaption := aCaption;
  FSID := aSID;
  FDescription := aDescription;
  if aVersion = '' then
  begin
    ReadVersion;
    if FVersion = '' then
      FVersion := GetNewVersion
  end
  else
    FVersion := aVersion;
end;

function TSAVAccessContainer.ReadVersion(const aFileName: string): Boolean;
var
  Ini01: TIniFile;
  sF: string;
begin
  Result := True;
  if aFileName = '' then
    sF := IncludeTrailingPathDelimiter(WorkDir) + csContainerCfg
  else
    sF := aFileName;
  Ini01 := TIniFile.Create(sF);
  try
    FVersion := Ini01.ReadString('main', 'version', '');
  except
    Result := False;
    FVersion := '';
  end;
  FreeAndNil(Ini01);
end;

function TSAVAccessContainer.WriteVersion(
  const aFileName: string): Boolean;
var
  Ini01: TMemIniFile;
  sF: string;
begin
  Result := True;
  if aFileName = '' then
    sF := IncludeTrailingPathDelimiter(WorkDir) + csContainerCfg
  else
    sF := aFileName;
  Ini01 := TMemIniFile.Create(sF);
  try
    Ini01.WriteString('main', 'version', FVersion);
    Ini01.WriteString('main', 'type', FContainerType);
    Ini01.UpdateFile;
  except
    Result := False;
  end;
  FreeAndNil(Ini01);
end;

procedure TSAVAccessContainer.SetWorkDir(const Value: string);
begin
  FWorkDir := Value;
end;

procedure TSAVAccessContainer.SetContainerType(const Value: Char);
begin
  FContainerType := Value;
end;

end.

