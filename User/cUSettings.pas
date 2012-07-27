unit cUSettings;

interface
uses SingletonTemplate, SAVLib, UAccessBase;
type
  TSettings = class(TSingleton)
  protected
    constructor Create; override;
  public
    destructor Destroy; override;
  private
    FConfigFile: string;
    FSettingPath: string;
    FMainIniFile: string;
    FBase: TSAVAccessBase;
    procedure SetConfigFile(const Value: string);
    procedure SetBase(const Value: TSAVAccessBase);
  public
    property MainIniFile:string read FMainIniFile;
    property SettingPath: string read FSettingPath;
    property ConfigFile: string read FConfigFile write SetConfigFile;
    property Base: TSAVAccessBase read FBase write SetBase;
  end;

function Settings: TSettings;

implementation
uses IniFiles, SysUtils, Windows;

function Settings: TSettings;
begin
  Result := TSettings.GetInstance;
end;

{ TSettings }

constructor TSettings.Create;
var
  ini: TIniFile;
begin
  inherited;
  FSettingPath := GetSpecialFolderLocation(CSIDL_APPDATA,
    FOLDERID_RoamingAppData);
  if FSettingPath = '' then
    FSettingPath := GetCurrentDir;
  FSettingPath := IncludeTrailingPathDelimiter(FSettingPath) +
    'SAVAccessClient\';
  FMainIniFile := FSettingPath + 'SAVAccessClient.ini';
  if (ParamCount > 0) and (FileExists(ParamStr(1))) then
    FConfigFile := ParamStr(1)
  else if FileExists(FMainIniFile) then
  begin
    ini := TIniFile.Create(FMainIniFile);
    FConfigFile := ini.ReadString('option', 'config', '');
    FreeAndNil(ini);
  end;
  if not (FileExists(FConfigFile)) then
  begin
    MessageBoxW(0, 'Файл конфигурации не обнаружен!', 'Ошибка!', MB_OK +
      MB_ICONSTOP + MB_DEFBUTTON2);
    if CallTerminateProcs then
      PostQuitMessage(0);
  end
  else
    FBase := TSAVAccessBase.Create;

end;

destructor TSettings.Destroy;
var
  ini: TIniFile;
begin
  if not (DirectoryExists(FSettingPath)) then
    ForceDirectories(FSettingPath);
  ini := TIniFile.Create(FMainIniFile);
  ini.WriteString('option', 'config', FConfigFile);
  ini.UpdateFile;
  FreeAndNil(ini);
  if Assigned(FBase) then
    FreeAndNil(FBase);
  inherited;
end;

procedure TSettings.SetBase(const Value: TSAVAccessBase);
begin
  FBase := Value;
end;

procedure TSettings.SetConfigFile(const Value: string);
begin
  FConfigFile := Value;
end;

end.

