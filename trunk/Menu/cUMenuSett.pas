unit cUMenuSett;

interface
uses Classes, SingletonTemplate, SAVLib;

const
  SAVAccessPath = 'SAVAccessClient\Menu\';
  SAVAccessCfg = 'Menu.cfg';

type
  TSettings = class(TSingleton)
  protected
    constructor Create; override;
  public
    destructor Destroy; override;
  private
    FConfigFile: string;
    FConfigDir: string;
  public
    property ConfigFile: string read FConfigFile;
    property ConfigDir: string read FConfigDir;
  end;

function Settings: TSettings;

implementation
uses SysUtils, Windows;

function Settings: TSettings;
begin
  Result := TSettings.GetInstance;
end;

{ TSettings }

constructor TSettings.Create;

begin
  inherited;
  if ParamCount = 0 then
  begin
    FConfigFile := GetSpecialFolderLocation(CSIDL_APPDATA,
      FOLDERID_RoamingAppData);
    if FConfigFile = '' then
      FConfigFile := GetCurrentDir;
    FConfigFile := IncludeTrailingPathDelimiter(FConfigFile) + SAVAccessPath;
    if not (DirectoryExists(FConfigFile)) then
      ForceDirectories(FConfigFile);
    FConfigDir := FConfigFile;
    FConfigFile := FConfigFile + SAVAccessCfg;
  end
  else
  begin
    FConfigFile := ParamStr(1);
    FConfigDir := ExtractFilePath(FConfigFile);
  end;
end;

destructor TSettings.Destroy;
begin

  inherited;
end;

end.

