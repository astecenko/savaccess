unit PluginManager;

interface

uses
  Windows,
  SysUtils,
  Classes;

type
  EPluginManagerError = class(Exception);
    EPluginLoadError = class(EPluginManagerError);
      EPluginsLoadError = class(EPluginLoadError)
      private
        FItems: TStrings;
      public
        constructor Create(const AText: String; const AFailedPlugins: TStrings);
        destructor Destroy; override;
        property FailedPluginFileNames: TStrings read FItems;
      end;

  IPlugin = interface
  // protected
    function GetIndex: Integer;
    function GetHandle: HMODULE;
    function GetFileName: String;
    function GetMask: String;
    function GetDescription: String;
    function GetFilterIndex: Integer;
    procedure SetFilterIndex(const AValue: Integer);
  // public
    property Index: Integer read GetIndex;
    property Handle: HMODULE read GetHandle;
    property FileName: String read GetFileName;

    property Mask: String read GetMask;
    property Description: String read GetDescription;

    property FilterIndex: Integer read GetFilterIndex write SetFilterIndex;
  end;

  IPluginManager = interface
  // protected
    function GetItem(const AIndex: Integer): IPlugin;
    function GetCount: Integer;
  // public
    function LoadPlugin(const AFileName: String): IPlugin;
    procedure UnloadPlugin(const AIndex: Integer);

    procedure LoadPlugins(const AFolder: String; const AFileExt: String = '');

    procedure Ban(const AFileName: String);
    procedure Unban(const AFileName: String);

    procedure SaveSettings(const ARegPath: String);
    procedure LoadSettings(const ARegPath: String);

    property Items[const AIndex: Integer]: IPlugin read GetItem; default;
    property Count: Integer read GetCount;

    procedure UnloadAll;

    procedure SetVersion(const AVersion: Integer);
  end;

function Plugins: IPluginManager;

implementation

uses
  Registry,
  PluginAPI;

resourcestring
  rsPluginsLoadError = 'One or more plugins has failed to load:' + sLineBreak + '%s';

type
  TPluginManager = class(TInterfacedObject, IUnknown, IPluginManager, ICore)
  private
    FItems: array of IPlugin;
    FCount: Integer;
    FBanned: TStringList;
    FVersion: Integer;
  protected
    function GetItem(const AIndex: Integer): IPlugin;
    function GetCount: Integer;
    function CanLoad(const AFileName: String): Boolean;
    procedure SetVersion(const AVersion: Integer);
    function GetVersion: Integer; safecall;
  public
    constructor Create;
    destructor Destroy; override;
    function LoadPlugin(const AFileName: String): IPlugin;
    procedure UnloadPlugin(const AIndex: Integer);
    procedure LoadPlugins(const AFolder, AFileExt: String);
    function IndexOf(const APlugin: IPlugin): Integer;
    procedure Ban(const AFileName: String);
    procedure Unban(const AFileName: String);
    procedure SaveSettings(const ARegPath: String);
    procedure LoadSettings(const ARegPath: String);
    procedure UnloadAll;
  end;

  TPlugin = class(TInterfacedObject, IUnknown, IPlugin)
  private
    FManager: TPluginManager;
    FFileName: String;
    FHandle: HMODULE;
    FInit: TInitPluginFunc;
    FDone: TDonePluginFunc;
    FFilterIndex: Integer;
    FPlugin: PluginAPI.IPlugin;
    FInfoRetrieved: Boolean;
    FMask: String;
    FDescription: String;
    procedure GetInfo;
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function GetIndex: Integer;
    function GetHandle: HMODULE;
    function GetFileName: String;
    function GetMask: String;
    function GetDescription: String;
    function GetFilterIndex: Integer;
    procedure SetFilterIndex(const AValue: Integer);
  public
    constructor Create(const APluginManger: TPluginManager; const AFileName: String); virtual;
    destructor Destroy; override;
  end;

{ TPluginManager }

constructor TPluginManager.Create;
begin
  inherited Create;
  FBanned := TStringList.Create;
  SetVersion(1);
end;

destructor TPluginManager.Destroy;
begin
  FreeAndNil(FBanned);
  inherited;
end;

function TPluginManager.LoadPlugin(const AFileName: String): IPlugin;
begin
  if CanLoad(AFileName) then
  begin
    Result := nil;
    Exit;
  end;

  // Загружаем плагин
  try
    Result := TPlugin.Create(Self, AFileName);
  except
    on E: Exception do
      raise EPluginLoadError.Create(Format('[%s] %s', [E.ClassName, E.Message]));
  end;

  // Заносим в список
  if Length(FItems) >= FCount then // "Capacity"
    SetLength(FItems, Length(FItems) + 64);
  FItems[FCount] := Result;
  Inc(FCount);
end;

procedure TPluginManager.LoadPlugins(const AFolder, AFileExt: String);

  function PluginOK(const APluginName, AFileExt: String): Boolean;
  begin
    Result := (AFileExt = '');
    if Result then
      Exit;
    Result := SameFileName(ExtractFileExt(APluginName), AFileExt);
  end;

var
  Path: String;
  SR: TSearchRec;
  Failures: TStringList;
  FailedPlugins: TStringList;
begin
  Path := IncludeTrailingPathDelimiter(AFolder);

  Failures := TStringList.Create;
  FailedPlugins := TStringList.Create;
  try
    if FindFirst(Path + '*.*', 0, SR) = 0 then
    try
      repeat
        if ((SR.Attr and faDirectory) = 0) and
           PluginOK(SR.Name, AFileExt) then
        try
          LoadPlugin(Path + SR.Name);
        except
          on E: Exception do
          begin
            FailedPlugins.Add(SR.Name);
            Failures.Add(Format('%s: %s', [SR.Name, E.Message]));
          end;
        end;
      until FindNext(SR) <> 0;
    finally
      FindClose(SR);
    end;

    if Failures.Count > 0 then
      raise EPluginsLoadError.Create(Format(rsPluginsLoadError, [Failures.Text]), FailedPlugins);
  finally
    FreeAndNil(FailedPlugins);
    FreeAndNil(Failures);
  end;
end;

procedure TPluginManager.UnloadAll;
begin
  Finalize(FItems);
end;

procedure TPluginManager.UnloadPlugin(const AIndex: Integer);
var
  X: Integer;
begin
  // Выгрузить плагин
  FItems[AIndex] := nil;
  // Сдвинуть плагины в списке, чтобы закрыть "дырку"
  for X := AIndex to FCount - 1 do
    FItems[X] := FItems[X + 1];
  // Не забыть учесть последний
  FItems[FCount - 1] := nil;
  Dec(FCount);
end;

function TPluginManager.IndexOf(const APlugin: IPlugin): Integer;
var
  X: Integer;
begin
  Result := -1;
  for X := 0 to FCount - 1 do
    if FItems[X] = APlugin then
    begin
      Result := X;
      Break;
    end;
end;

procedure TPluginManager.Ban(const AFileName: String);
begin
  Unban(AFileName);
  FBanned.Add(AFileName);
end;

procedure TPluginManager.Unban(const AFileName: String);
var
  X: Integer;
begin
  for X := 0 to FBanned.Count - 1 do
    if SameFileName(FBanned[X], AFileName) then
    begin
      FBanned.Delete(X);
      Break;
    end;
end;

function TPluginManager.CanLoad(const AFileName: String): Boolean;
var
  X: Integer;
begin
  // Не грузить отключенные
  for X := 0 to FBanned.Count - 1 do
    if SameFileName(FBanned[X], AFileName) then
    begin
      Result := True;
      Exit;
    end;

  // Не грузить уже загруженные
  for X := 0 to FCount - 1 do
    if SameFileName(FItems[X].FileName, AFileName) then
    begin
      Result := True;
      Exit;
    end;

  Result := False;
end;

const
  SRegDisabledPlugins = 'Disabled plugins';
  SRegPluginX         = 'Plugin%d';

procedure TPluginManager.SaveSettings(const ARegPath: String);
var
  Reg: TRegIniFile;
  Path: String;
  X: Integer;
begin
  Reg := TRegIniFile.Create(ARegPath, KEY_ALL_ACCESS);
  try
    // Удаляем старые
    Reg.EraseSection(SRegDisabledPlugins);
    Path := ARegPath + '\' + SRegDisabledPlugins;
    if not Reg.OpenKey(Path, True) then
      Exit;

    // Сохраняем новые
    for X := 0 to FBanned.Count - 1 do
      Reg.WriteString(Path, Format(SRegPluginX, [X]), FBanned[X]);
  finally
    FreeAndNil(Reg);
  end;
end;

procedure TPluginManager.SetVersion(const AVersion: Integer);
begin
  FVersion := AVersion;
end;

procedure TPluginManager.LoadSettings(const ARegPath: String);
var
  Reg: TRegIniFile;
  Path: String;
  X: Integer;
begin
  Reg := TRegIniFile.Create(ARegPath, KEY_READ);
  try
    FBanned.BeginUpdate;
    try
      FBanned.Clear;

      // Читаем
      Path := ARegPath + '\' + SRegDisabledPlugins;
      if not Reg.OpenKey(Path, True) then
        Exit;
      Reg.ReadSectionValues(Path, FBanned);

      // Убираем "Plugin5=" из строк
      for X := 0 to FBanned.Count - 1 do
        FBanned[X] := FBanned.ValueFromIndex[X];
    finally
      FBanned.EndUpdate;
    end;
  finally
    FreeAndNil(Reg);
  end;
end;

function TPluginManager.GetCount: Integer;
begin
  Result := FCount;
end;

function TPluginManager.GetItem(const AIndex: Integer): IPlugin;
begin
  Result := FItems[AIndex];
end;

function TPluginManager.GetVersion: Integer;
begin
  Result := FVersion;
end;

{ TPlugin }

constructor TPlugin.Create(const APluginManger: TPluginManager;
  const AFileName: String);
begin
  inherited Create;
  FManager := APluginManger;
  FFileName := AFileName;
  FFilterIndex := -1;
  FHandle := SafeLoadLibrary(AFileName, SEM_NOOPENFILEERRORBOX or SEM_FAILCRITICALERRORS);
  Win32Check(FHandle <> 0);
  FDone := GetProcAddress(FHandle, SPluginDoneFuncName);
  FInit := GetProcAddress(FHandle, SPluginInitFuncName);
  Win32Check(Assigned(FInit));
  FPlugin := FInit(FManager);
end;

destructor TPlugin.Destroy;
begin
  FPlugin := nil;
  if Assigned(FDone) then
    FDone;
  if FHandle <> 0 then
  begin
    FreeLibrary(FHandle);
    FHandle := 0;
  end;
  inherited;
end;

function TPlugin.GetFileName: String;
begin
  Result := FFileName;
end;

function TPlugin.GetFilterIndex: Integer;
begin
  Result := FFilterIndex;
end;

function TPlugin.GetHandle: HMODULE;
begin
  Result := FHandle;
end;

function TPlugin.GetIndex: Integer;
begin
  Result := FManager.IndexOf(Self);
end;

procedure TPlugin.GetInfo;
begin
  if FInfoRetrieved then
    Exit;
  FMask := FPlugin.Mask;
  FDescription := FPlugin.Description;
  FInfoRetrieved := True;
end;

function TPlugin.GetMask: String;
begin
  GetInfo;
  Result := FMask;
end;

function TPlugin.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  Result := inherited QueryInterface(IID, Obj);
  if Failed(Result) then
    Result := FPlugin.QueryInterface(IID, Obj);
end;

procedure TPlugin.SetFilterIndex(const AValue: Integer);
begin
  FFilterIndex := AValue;
end;

function TPlugin.GetDescription: String;
begin
  GetInfo;
  Result := FDescription;
end;

{ EPluginsLoadError }

constructor EPluginsLoadError.Create(const AText: String;
  const AFailedPlugins: TStrings);
begin
  inherited Create(AText);
  FItems := TStringList.Create;
  FItems.Assign(AFailedPlugins);
end;

destructor EPluginsLoadError.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

//________________________________________________________________

var
  FPluginManager: IPluginManager;

function Plugins: IPluginManager;
begin
  Result := FPluginManager;
end;

initialization
  FPluginManager := TPluginManager.Create;
finalization
  if Assigned(FPluginManager) then
    FPluginManager.UnloadAll;
  FPluginManager := nil;
end.
