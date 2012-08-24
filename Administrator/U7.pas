unit U7;

interface
uses SingletonTemplate, SAVLib, UAccessBase, UAccessUser, UAccessGroup,
  UAccessADGroup, UAccessFile, UAccessDomain;
type
  TSettings = class(TSingleton)
  protected
    constructor Create; override;
  public
    destructor Destroy; override;
  private
    FConfigFile: string;
    FSettingPath: string;
    FBase: TSAVAccessBase;
    FDomain: TSAVAccessDomain;
    FUser: TSAVAccessUser;
    FGroup: TSAVAccessGroup;
    FADGroup: TSAVAccessADGroup;
    procedure SetConfigFile(const Value: string);
    procedure SetBase(const Value: TSAVAccessBase);
    procedure SetDomain(const Value: TSAVAccessDomain);
    procedure SetGroup(const Value: TSAVAccessGroup);
    procedure SetUser(const Value: TSAVAccessUser);
    procedure SetADGroup(const Value: TSAVAccessADGroup);
  public
    property SettingPath: string read FSettingPath;
    property ConfigFile: string read FConfigFile write SetConfigFile;
    property Base: TSAVAccessBase read FBase write SetBase;
    property Domain: TSAVAccessDomain read FDomain write SetDomain;
    property User: TSAVAccessUser read FUser write SetUser;
    property Group: TSAVAccessGroup read FGroup write SetGroup;
    property ADGroup: TSAVAccessADGroup read FADGroup write SetADGroup;
  end;

function Settings: TSettings;

implementation
uses IniFiles, SysUtils, DU1;

function Settings: TSettings;
begin
  Result := TSettings.GetInstance;
end;

{ TSettings }

constructor TSettings.Create;
var
  ini: TMemIniFile;
begin
  inherited;
  FSettingPath := GetSpecialFolderLocation(CSIDL_APPDATA,
    FOLDERID_RoamingAppData);
  if FSettingPath = '' then
    FSettingPath := GetCurrentDir;
  FSettingPath := IncludeTrailingPathDelimiter(FSettingPath) +
    'SAVAccessAdmin\';
  ini := TMemIniFile.Create(FSettingPath + 'SAVAccessAdmin.ini');
  FConfigFile := ini.ReadString('option', 'config', '');
  FreeAndNil(ini);
  FBase := TSAVAccessBase.Create;
  FBase.TableUsers := dtmdl1.vkdbfUsers;
  FBase.TableDomains := dtmdl1.vkdbfDomain;
  FBase.TableGroups := dtmdl1.vkdbfGroups;
  FBase.TableADGroups := dtmdl1.vkdbfADGroups;
  FDomain := TSAVAccessDomain.Create;
  FUser := TSAVAccessUser.Create;
  FGroup := TSAVAccessGroup.Create;
  FADGroup := TSAVAccessADGroup.Create;

end;

destructor TSettings.Destroy;
var
  ini: TMemIniFile;
begin
  if not (DirectoryExists(FSettingPath)) then
    ForceDirectories(FSettingPath);
  ini := TMemIniFile.Create(FSettingPath + 'SAVAccessAdmin.ini');
  ini.WriteString('option', 'config', FConfigFile);
  ini.UpdateFile;
  FreeAndNil(ini);
  FreeAndNil(FBase);
  FreeAndNil(FDomain);
  FreeAndNil(FUser);
  FreeAndNil(FGroup);
  FreeAndNil(FADGroup);
  inherited;
end;

procedure TSettings.SetADGroup(const Value: TSAVAccessADGroup);
begin
  FADGroup := Value;
end;

procedure TSettings.SetBase(const Value: TSAVAccessBase);
begin
  FBase := Value;
end;

procedure TSettings.SetConfigFile(const Value: string);
begin
  FConfigFile := Value;
end;

procedure TSettings.SetDomain(const Value: TSAVAccessDomain);
begin
  FDomain := Value;
end;

procedure TSettings.SetGroup(const Value: TSAVAccessGroup);
begin
  FGroup := Value;
end;

procedure TSettings.SetUser(const Value: TSAVAccessUser);
begin
  FUser := Value;
end;

end.

