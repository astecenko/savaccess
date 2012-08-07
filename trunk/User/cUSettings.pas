unit cUSettings;

interface
uses SingletonTemplate, SAVLib, UAccessBase, UAccessClient;
type
  TSettings = class(TSingleton)
  protected
    constructor Create; override;
  public
    destructor Destroy; override;
  private
    FConfigFile: string;
    FClient: TSAVAccessClient;
    FMainIniFile: string;
    procedure SetConfigFile(const Value: string);
    procedure SetClient(const Value: TSAVAccessClient);
  public
    property Client: TSAVAccessClient read FClient write SetClient;
    property MainIniFile: string read FMainIniFile;
    property ConfigFile: string read FConfigFile write SetConfigFile;
    procedure Init;
  end;

function Settings: TSettings;

implementation
uses SysUtils, Windows, UAccClient_INI;

function Settings: TSettings;
begin
  Result := TSettings.GetInstance;
end;

{ TSettings }

constructor TSettings.Create;
begin
  inherited;
  FClient := TSAVAccessClient.Create('NEVZ\OASUP\Client');
  if (ParamCount > 0) and (FileExists(ParamStr(1))) then
    FConfigFile := ParamStr(1)
  else if FileExists(Client.IniFile.FileName) then
    FConfigFile := FClient.IniFile.ReadString('option', 'config', '');
  if not (FileExists(FConfigFile)) then
  begin
    MessageBoxW(0, 'Файл конфигурации не обнаружен!', 'Ошибка!', MB_OK +
      MB_ICONSTOP + MB_DEFBUTTON2);
    if CallTerminateProcs then
      PostQuitMessage(0);
  end
  else
  begin
    FClient.IniFile.WriteString('option', 'config', FConfigFile);
    { TODO 1 -oStecenko -cСовершенствование : Сделать добавление обработчиков из плагинов/dll или из Pascal Script }
    FClient.Actions.Add(TSAVAccessFileAction.Create('F', '.ini', 1, UACCopyINI))
  end;
end;

destructor TSettings.Destroy;
begin
  if not (DirectoryExists(FClient.ConfigDir)) then
    ForceDirectories(FClient.ConfigDir);
  FreeAndNil(FClient);
  inherited;
end;

procedure TSettings.Init;
begin
 ;
end;

procedure TSettings.SetClient(const Value: TSAVAccessClient);
begin
  FClient := Value;
end;

procedure TSettings.SetConfigFile(const Value: string);
begin
  FConfigFile := Value;
end;

end.

