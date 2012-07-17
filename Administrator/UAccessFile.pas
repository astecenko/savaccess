unit UAccessFile;

interface
uses IniFiles, Classes;
type

  TPathTemplate = class(TObject)
  private
    FFileName: string;
    FPattern: string;
    FPath: string;
    FOldWindows: Integer;
    FNewWindows: string;
    FCaption: string;
    FIni: TMemIniFile;
    FPatternBegin: string;
    FPatternEnd: string;
    FPatternBeginLength: Integer;
    FPatternEndLength: Integer;
    procedure SetPatternBegin(const Value: string);
    procedure SetPatternEnd(const Value: string);
    procedure SetCaption(const Value: string);
    procedure SetPattern(const Value: string);
    procedure SetNewWindows(const Value: string);
    procedure SetOldWindows(const Value: Integer);
  public
    property FileName: string read FFileName;
    property Pattern: string read FPattern write SetPattern;
    property Path: string read FPath;
    property Caption: string read FCaption write SetCaption;
    property OldWindows: Integer read FOldWindows write SetOldWindows;
    property NewWindows: string read FNewWindows write SetNewWindows;
    property PatternBegin: string read FPatternBegin write SetPatternBegin;
    property PatternEnd: string read FPatternEnd write SetPatternEnd;
    property PatternBeginLength: Integer read FPatternBeginLength;
    property PatternEndLength: Integer read FPatternEndLength;
    constructor Create(const aFileName: string);
    destructor Destroy; override;
    procedure WritePattern(const aPattern: string; const aCaption: string
      = ''; const aPath: string = ''; const aOldWindows: Integer = -1; const
      aNewWindows: string = '');
    function ReadString(const aPattern: string): string;
    function GetPath(const aPathTemplate: string): string;
    procedure GetPatterns(aList: TStrings);
    procedure Save;
    procedure DeletePattern(const aPattern:string);

  end;

  TMD5 = string[32];

  TSAVAccessFile = class(TObject)
  private
    FFileName: string;
    FFileType: Integer;
    FExtension: string;
    FServerPath: string;
    FClientPath: string;
    FMD5: TMD5;
    FFileAction: Integer;
    procedure SetClientPath(const Value: string);
    procedure SetExtension(const Value: string);
    procedure SetFileAction(const Value: Integer);
    procedure SetFileName(const Value: string);
    procedure SetFileType(const Value: Integer);
    procedure SetMD5(const Value: TMD5);
    procedure SetServerPath(const Value: string);

  protected
    property FileName: string read FFileName write SetFileName;
    property FileType: Integer read FFileType write SetFileType;
    property Extension: string read FExtension write SetExtension;
    property ServerPath: string read FServerPath write SetServerPath;
    property ClientPath: string read FClientPath write SetClientPath;
    property MD5: TMD5 read FMD5 write SetMD5;
    property FileAction: Integer read FFileAction write SetFileAction;

  public

  end;

implementation
uses StrUtils, SysUtils, SAVLib, UAccessConstant;

{ TPathTemplate }

constructor TPathTemplate.Create(const aFileName: string);
begin
  FIni := TMemIniFile.Create(aFileName);
  FPatternBegin := FIni.ReadString(csPattern, 'begin', '~%%');
  FPatternEnd := FIni.ReadString(csPattern, 'end', '%%~');
  FPatternBeginLength := Length(FPatternBegin);
  FPatternEndLength := Length(FPatternEnd);
end;

procedure TPathTemplate.DeletePattern(const aPattern: string);
begin
  FIni.EraseSection(aPattern);
end;

destructor TPathTemplate.Destroy;
begin
  FreeAndNil(FIni);
  inherited;
end;

function TPathTemplate.GetPath(const aPathTemplate: string): string;
var
  i, j, x, PosEnd1, PosEnd2, n: Integer;
  sPattern: string;

begin
  i := Pos(FPatternBegin, aPathTemplate);
  j := PosEx(FPatternEnd, aPathTemplate, i + FPatternBeginLength);
  n := Length(aPathTemplate);
  x := 1;
  if (i > 0) and (j > 0) then
  begin
    Result := '';
    PosEnd1 := i + FPatternBeginLength;
    while (i > 0) and (j > 0) and (j>PosEnd1) and (x < n) do
    begin

      Result := Result + copy(aPathTemplate, x, i - x);
      sPattern := Copy(aPathTemplate, PosEnd1, j - PosEnd1);
      Result := Result + ReadString(sPattern);
      x := j + FPatternEndLength;
      i := PosEx(FPatternBegin, aPathTemplate, x);
      j := PosEx(FPatternEnd, aPathTemplate, i + FPatternBeginLength);
      PosEnd1 := i + FPatternBeginLength;
    end;
    if x <= n then
      Result := Result + copy(aPathTemplate, x, n - x + 1)
  end
  else
    Result := aPathTemplate;
end;

procedure TPathTemplate.GetPatterns(aList: TStrings);
var
  i: Integer;
begin
  FIni.ReadSections(aList);
  i := 0;
  while i < aList.Count do
  begin
    if aList[i] = csPattern then
    begin
      aList.Delete(i);
      i := aList.Count;
    end
    else
      Inc(i);
  end;
end;

function TPathTemplate.ReadString(const aPattern: string): string;
var
  sPath, sNewWind: string;
  iOldWind: Integer;
begin
  if FIni.SectionExists(aPattern) then
  begin
    sPath := Fini.ReadString(aPattern, 'path', '');
    sNewWind := FIni.ReadString(aPattern, 'winnew', '');
    iOldWind := FIni.ReadInteger(aPattern, 'winold', -1);
    if sPath = '' then
      Result := SAVLib.GetSpecialFolderLocation(iOldWind, StringToGUID(sNewWind))
    else
      Result := sPath;
  end
  else
    Result := '';
end;

procedure TPathTemplate.Save;
begin
  FIni.UpdateFile;
end;

procedure TPathTemplate.SetCaption(const Value: string);
begin
  FCaption := Value;
  FIni.WriteString(FPattern, 'caption', Value);
end;

procedure TPathTemplate.SetNewWindows(const Value: string);
begin
  FNewWindows := Value;
  FIni.WriteString(FPattern, 'winnew',Value);
end;

procedure TPathTemplate.SetOldWindows(const Value: Integer);
begin
  FOldWindows := Value;
  FIni.WriteInteger(FPattern, 'winold',Value);
end;

procedure TPathTemplate.SetPattern(const Value: string);
begin
  FPattern := Value;
  FPath := Fini.ReadString(FPattern, 'path', '');
  FCaption := FIni.ReadString(FPattern, 'caption', '');
  FNewWindows := FIni.ReadString(FPattern, 'winnew', '');
  FOldWindows := FIni.ReadInteger(FPattern, 'winold', -1);
end;

procedure TPathTemplate.SetPatternBegin(const Value: string);
begin
  FPatternBegin := Value;
  FPatternBeginLength := Length(Value);
  FIni.WriteString(csPattern, 'begin', Value);
end;

procedure TPathTemplate.SetPatternEnd(const Value: string);
begin
  FPatternEnd := Value;
  FPatternEndLength := Length(Value);
  FIni.WriteString(csPattern, 'end', Value);
end;

procedure TPathTemplate.WritePattern(const aPattern, aCaption, aPath: string;
  const aOldWindows: Integer; const aNewWindows: string);
begin
  FIni.WriteString(aPattern, 'caption', aCaption);
  FIni.WriteString(aPattern, 'path', aPath);
  FIni.WriteInteger(aPattern, 'winold', aOldWindows);
  FIni.WriteString(aPattern, 'winnew', aNewWindows);
end;

{ TSAVAccessFile }

procedure TSAVAccessFile.SetClientPath(const Value: string);
begin
  FClientPath := Value;
end;

procedure TSAVAccessFile.SetExtension(const Value: string);
begin
  FExtension := Value;
end;

procedure TSAVAccessFile.SetFileAction(const Value: Integer);
begin
  FFileAction := Value;
end;

procedure TSAVAccessFile.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

procedure TSAVAccessFile.SetFileType(const Value: Integer);
begin
  FFileType := Value;
end;

procedure TSAVAccessFile.SetMD5(const Value: TMD5);
begin
  FMD5 := Value;
end;

procedure TSAVAccessFile.SetServerPath(const Value: string);
begin
  FServerPath := Value;
end;

end.

