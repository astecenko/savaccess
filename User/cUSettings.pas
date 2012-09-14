unit cUSettings;

interface
uses Classes, SingletonTemplate, SAVLib, UAccessBase, UAccessClient,
  UAccessSimple, JvLogFile, JvLogClasses, IdTCPServer;

type
  TSAVLog = class(TJvLogFile)
  public
    procedure SaveCommand(ASender: TIdCommand);
  end;

  TSettings = class(TSingleton)
  protected
    constructor Create; override;
  public
    destructor Destroy; override;
  private
    FConfigFile: string;
    FNetLog: string;
    //    FClient: TSAVAccessClient;
    FMainIniFile: string;
    FInUpdating: Boolean;
    FClients: TSimpleClients;
    FBases: TSimpleBases;
    FLog: TSAVLog;
    FUserName: string;
    FNetBiosName: string;
    FLastUpdate: TDateTime;
    procedure SetConfigFile(const Value: string);
    //    procedure SetClient(const Value: TSAVAccessClient);
    procedure SetInUpdating(const Value: Boolean);
    procedure SetLastUpdate(const Value: TDateTime);
    procedure SetBases(const Value: TSimpleBases);
    procedure SetClients(const Value: TSimpleClients);
    procedure SetLog(const Value: TSAVLog);
    procedure SetNetLog(const Value: string);

  public
    //   property Client: TSAVAccessClient read FClient write SetClient;
    property MainIniFile: string read FMainIniFile;
    property NetLog: string read FNetLog write SetNetLog;
    property Log: TSAVLog read FLog write SetLog;
    property ConfigFile: string read FConfigFile write SetConfigFile;
    property InUpdating: Boolean read FInUpdating write SetInUpdating;
    property LastUpdate: TDateTime read FLastUpdate write SetLastUpdate;
    property Clients: TSimpleClients read FClients write SetClients;
    property Bases: TSimpleBases read FBases write SetBases;
    property UserName: string read FUserName;
    property NetBiosName: string read FNetBiosName;
    procedure Init;
    procedure WriteNetLog(const aCon: string);
    procedure NetLogErr;
  end;

function Settings: TSettings;

implementation
uses SysUtils, Windows, PluginManager, PluginAPI, IniFiles, UAccessConstant,
  MsAD;

function Settings: TSettings;
begin
  Result := TSettings.GetInstance;
end;

{ TSettings }

constructor TSettings.Create;
var
  ini: TIniFile;
  sPath, sDir: string;
begin
  inherited;
  FInUpdating := False;
  FUserName := MsAD.GetCurrentUserName;
  SetLength(FUserName, pred(Length(FUserName)));
  FNetBiosName := MsAD.GetCurrentComputerName;
  FClients := TSimpleClients.Create;
  FBases := TSimpleBases.Create;
  FBases.RootConfig := 'NEVZ\OASUP';
  FLog := TSAVLog.Create(nil);
  SetErrorMode(SetErrorMode(0) or SEM_NOOPENFILEERRORBOX or
    SEM_FAILCRITICALERRORS);
  Plugins.SetVersion(1);
  // Загрузка всех плагинов. Подразумевается, что они лежат в под-папке Plugins
  Plugins.LoadPlugins(ExtractFilePath(ParamStr(0)) + 'Plugins', SPluginExt);
  FLastUpdate := EncodeDate(2000, 1, 1);
  sDir := FBases.RootConfig + 'Client\';
  if not DirectoryExists(sDir) then
    ForceDirectories(sDir);
  FLog.FileName := sDir + csTCPLog;
  FLog.Severity := lesInformation;
  FLog.SizeLimit := 10240;
  FLog.AutoSave := True;
  FLog.Active := True;
  sPath := sDir + csContainerCfg;
  ini := TIniFile.Create(sPath);
  FNetLog := ini.ReadString('option', 'netlog',
    '\\nevz\nevz\ASUP_Data1\PDO\1\');
  //  FClient := TSAVAccessClient.Create('NEVZ\OASUP\Client');
  if (ParamCount > 0) and (FileExists(ParamStr(1))) then
    FConfigFile := ParamStr(1)
  else
    FConfigFile := ini.ReadString('option', 'config', '');
  if Bases.Add(FConfigFile) then
  begin
    Bases.Update(0);
    Ini.WriteString('option', 'config', FConfigFile);
  end;
  WriteNetLog('1');
  FreeAndNil(ini);
end;

destructor TSettings.Destroy;
begin
  WriteNetLog('0');
  FreeAndNil(FClients);
  FreeAndNil(FBases);
  FreeAndNil(FLog);
  inherited;
end;

procedure TSettings.Init;
begin
  ;
end;

procedure TSettings.NetLogErr;
begin
  Log.Add(DateTimeToStr(Now), '[' + FNetBiosName + '] NetLog Err: ' +
    SysErrorMessage(GetLastError))
end;

procedure TSettings.SetBases(const Value: TSimpleBases);
begin
  FBases := Value;
end;

procedure TSettings.SetClients(const Value: TSimpleClients);
begin
  FClients := Value;
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

procedure TSettings.SetLog(const Value: TSAVLog);
begin
  FLog := Value;
end;

procedure TSettings.SetNetLog(const Value: string);
begin
  FNetLog := Value;
end;

procedure TSettings.WriteNetLog(const aCon: string);
var
  lhFile: Cardinal;
  dwWritten: Cardinal;
  s: string;
  b:Boolean;
begin
  DateTimeToString(s, 'yyyy_mm_dd".csv"', Now);
  if DirectoryExists(FNetLog) then
  begin
    s := FNetLog + s;
    b:=not FileExists(s);
    lhFile := CreateFile(PChar(s), GENERIC_WRITE,
      FILE_SHARE_WRITE or FILE_SHARE_READ, nil,
      OPEN_ALWAYS, FILE_FLAG_WRITE_THROUGH, 0);
    if lhFile = INVALID_HANDLE_VALUE then
      NetLogErr
    else
    begin
      SetFilePointer(lhFile, 0, Nil, FILE_END);
      if b then
        begin
          s:='time;con;pc;user'#13#10;
          if not WriteFile(lhFile, S[1], Length(S), dwWritten, nil) then
        NetLogErr;
        end;
      s := DateTimeToStr(Now) + ';' + aCon + ';' + FNetBiosName + ';' +
        FUserName+#13#10;
      if not WriteFile(lhFile, S[1], Length(S), dwWritten, nil) then
        NetLogErr;
      CloseHandle(lhFile);
    end;
  end;
end;

{ TSAVLog }

procedure TSAVLog.SaveCommand(ASender: TIdCommand);
begin
  Add(DateTimeToStr(Now), '[' + ASender.Thread.Connection.LocalName + '] ' +
    ASender.CommandHandler.Command, ASender.Reply.TextCode);
end;

end.

