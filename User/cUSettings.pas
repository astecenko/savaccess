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
    FInUpdating:Boolean;
    FLastUpdate:TDateTime;
    procedure SetConfigFile(const Value: string);
    procedure SetClient(const Value: TSAVAccessClient);
    procedure SetInUpdating(const Value: Boolean);
    procedure SetLastUpdate(const Value: TDateTime);
  public
    property Client: TSAVAccessClient read FClient write SetClient;
    property MainIniFile: string read FMainIniFile;
    property ConfigFile: string read FConfigFile write SetConfigFile;
    property InUpdating: Boolean read FInUpdating write SetInUpdating;
    property LastUpdate:TDateTime read FLastUpdate write SetLastUpdate;
    procedure Init;
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
  FInUpdating:=False;
  FLastUpdate:=EncodeDate(2000,1,1);
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
    //FClient.Actions.Add(TSAVAccessFileAction.Create('F', '.ini', 1, UACCopyINI))
  end;
end;

destructor TSettings.Destroy;
begin
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

procedure TSettings.SetInUpdating(const Value: Boolean);
begin
  FInUpdating := Value;
end;

procedure TSettings.SetLastUpdate(const Value: TDateTime);
begin
  FLastUpdate := Value;
end;

end.

