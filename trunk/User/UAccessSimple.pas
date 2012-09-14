unit UAccessSimple;

interface
uses Classes, UAccessClient;
type
  TSimpleClient = class(TObject)
  private
    FCaption: string;
    FLogin: string;
    FPassword: string;
    FDNS: string;
    FAuthorized: Boolean;
    FDateTime: TDateTime;
    FUID: string;
    FThread: Pointer;
    procedure SetCaption(const Value: string);
    procedure SetDateTime(const Value: TDateTime);
    procedure SetDNS(const Value: string);
    procedure SetLogin(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetThread(const Value: Pointer);
    procedure SetUID(const Value: string);
    procedure SetAuthorized(const Value: Boolean);
  public
    property Authorized: Boolean read FAuthorized write SetAuthorized;
    property Caption: string read FCaption write SetCaption;
    property Login: string read FLogin write SetLogin;
    property Password: string read FPassword write SetPassword;
    property DNS: string read FDNS write SetDNS;
    property DateTime: TDateTime read FDateTime write SetDateTime;
    property UID: string read FUID write SetUID;
    property Thread: Pointer read FThread write SetThread;
    constructor Create;
  end;

  TSimpleBase = class(TObject)
  private
    FCaption: string;
    FConfigFile: string;
    FUpdating: Boolean;
    FClient: TSAVAccessClient;
    FLastUpdate: TDateTime;
    FUploading: Boolean;
    procedure SetCaption(const Value: string);
    procedure SetConfigFile(const Value: string);
    procedure SetLastUpdate(const Value: TDateTime);
    procedure SetUploading(const Value: Boolean);
    procedure SetClient(const Value: TSAVAccessClient);
    procedure SetUpdating(const Value: Boolean);
  public
    property Caption: string read FCaption write SetCaption;
    property ConfigFile: string read FConfigFile write SetConfigFile;
    property Uploading: Boolean read FUploading write SetUploading;
    property Updating: Boolean read FUpdating write SetUpdating;
    property LastUpdate: TDateTime read FLastUpdate write SetLastUpdate;
    property Client: TSAVAccessClient read FClient write SetClient;
    constructor Create;
    destructor Destroy; override;
  end;

  TSimpleBases = class(TObject)
  private
    FItems: TList;
    FRootConfig: string;
    procedure SetItems(const Value: TList);
    procedure SetRootConfig(const Value: string);
    function GetCount: integer;
  public
    property Items: TList read FItems write SetItems;
    property RootConfig: string read FRootConfig write SetRootConfig;
    property Count: integer read GetCount;
    constructor Create;
    destructor Destroy; override;
    function GetItem(const aCaption: string): Pointer;
    function GetIndex(const aCaption: string): integer;
    procedure GetCaptions(aList: TStrings; const aConfigFile: Boolean = False);
    procedure GetStatus(aList: TStrings);
    function GetItemInfo(const aCaption: string; aList: TStrings): Boolean;
    procedure Clear;
    function Add(const aCaption, aConfigFile: string): Boolean; overload;
    function Add(const aConfigFile: string): boolean; overload;
    function Update(const aIndex: Integer): Boolean; overload;
    function Update(const aCaption: string): Boolean; overload;
    procedure Delete(const aIndex: Integer);
  end;

  TSimpleClients = class(TObject)
  private
    FItems: TList;
    FPasswordFile: string;
    procedure SetItems(const Value: TList);
    function GetCount: integer;
    procedure SetPasswordFile(const Value: string);
  public
    property Items: TList read FItems write SetItems;
    property Count: integer read GetCount;
    property PasswordFile: string read FPasswordFile write SetPasswordFile;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Delete(const aIndex: Integer);
    procedure DisconnectAll;
    function GetIndex(const aUID: string): integer;
    function GetItem(const aUID: string): Pointer;
    function GetUserPasswMD5(const aLogin: string): string;
    function GetMD5(const aSource: string): string;
  end;

implementation
uses SysUtils, SAVLib, IdTCPServer, md5;

{ TSimpleBase }

constructor TSimpleBase.Create;
begin
  inherited;
  FLastUpdate := EncodeDate(2000, 01, 01);
  FUpdating := False;
end;

destructor TSimpleBase.Destroy;
begin
  FClient.Free;
  inherited;
end;

procedure TSimpleBase.SetCaption(const Value: string);
begin
  FCaption := AnsiUpperCase(Value);
end;

procedure TSimpleBase.SetClient(const Value: TSAVAccessClient);
begin
  FClient := Value;
end;

procedure TSimpleBase.SetConfigFile(const Value: string);
begin
  FConfigFile := Value;
end;

procedure TSimpleBase.SetLastUpdate(const Value: TDateTime);
begin
  FLastUpdate := Value;
end;

procedure TSimpleBase.SetUpdating(const Value: Boolean);
begin
  FUpdating := Value;
end;

procedure TSimpleBase.SetUploading(const Value: Boolean);
begin
  FUploading := Value;
end;

{ TSimpleBases }

constructor TSimpleBases.Create;
begin
  FItems := TList.Create;
  FRootConfig := ExtractFilePath(ParamStr(0));
end;

destructor TSimpleBases.Destroy;
begin
  Clear;
  FreeAndNil(Fitems);
  inherited;
end;

function TSimpleBases.GetIndex(const aCaption: string): integer;
var
  i: Integer;
  s: string;
begin
  Result := -1;
  i := 0;
  s := AnsiUpperCase(aCaption);
  while (i < FItems.Count) and (Result = -1) do
  begin
    if TSimpleBase(FItems[i]).Caption = s then
      Result := i;
    inc(i);
  end;
end;

function TSimpleBases.GetItem(const aCaption: string): Pointer;
var
  i: Integer;
begin
  Result := nil;
  i := GetIndex(aCaption);
  if i > -1 then
    Result := FItems.Items[i];
end;

procedure TSimpleBases.SetItems(const Value: TList);
begin
  FItems := Value;
end;

procedure TSimpleBases.GetCaptions(aList: TStrings; const aConfigFile: Boolean =
  False);
var
  i: Integer;
  s: string;
begin
  i := 0;
  aList.Clear;
  while i < FItems.Count do
  begin
    s := TSimpleBase(FItems[i]).Caption;
    if aConfigFile then
      s := s + '=[' + DateTimeToStr(TSimpleBase(FItems[i]).LastUpdate) + '] ' +
        TSimpleBase(FItems[i]).ConfigFile;
    aList.Add(s);
    inc(i);
  end;
end;

procedure TSimpleBases.Clear;
var
  i: Integer;
begin
  i := 0;
  while i < FItems.Count do
  begin
    TSimpleBase(FItems.Items[i]).Free;
    inc(i);
  end;
  FItems.Clear;
end;

function TSimpleBases.Add(const aCaption, aConfigFile: string): boolean;
var
  i: integer;
  simplebas: TSimpleBase;
  aclient: TSAVAccessClient;
  s: string;
begin
  s := AnsiUpperCase(aCaption);
  i := GetIndex(s);
  if i = -1 then
  begin
    simplebas := TSimpleBase.Create;
    simplebas.Caption := s;
    simplebas.ConfigFile := aConfigFile;
    aclient := TSAVAccessClient.Create(RootConfig + s);
    aclient.LoadFromFile(aConfigFile);
    simplebas.Client := aclient;
    FItems.Add(simplebas);
    Result := True;
  end
  else
  begin
    TSimpleBase(FItems.Items[i]).ConfigFile := aConfigFile;
    TSimpleBase(FItems.Items[i]).Client.LoadFromFile(aConfigFile);
    Result := False;
  end;
end;

procedure TSimpleBases.SetRootConfig(const Value: string);
var
  s1, s2: string;
begin
  if Value = '' then
    s1 := 'SAVAccessClient'
  else
    s1 := Value;
  s2 := GetSpecialFolderLocation(CSIDL_APPDATA,
    FOLDERID_RoamingAppData);
  if s2 = '' then
    s2 := GetCurrentDir;
  FRootConfig :=
    IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(s2) + s1);
  if not (DirectoryExists(FRootConfig)) then
    ForceDirectories(FRootConfig);
end;

function TSimpleBases.Update(const aIndex: Integer): Boolean;
begin
  with TSimpleBase(FItems.Items[aIndex]) do
  begin
    Result := not Updating;
    if Result then
    begin
      Updating := True;
      Client.Update;
      LastUpdate := Now;
      Updating := False;
    end;
  end;
end;

procedure TSimpleBases.Delete(const aIndex: Integer);
begin
  if aIndex < FItems.Count then
  begin
    TSimpleBase(FItems.Items[aIndex]).Free;
    FItems.Delete(aIndex);
  end;
end;

function TSimpleBases.GetCount: integer;
begin
  Result := FItems.Count;
end;

procedure TSimpleBases.GetStatus(aList: TStrings);
var
  i: Integer;
  s: string;
begin
  i := 0;
  aList.Clear;
  while i < FItems.Count do
  begin
    s := TSimpleBase(FItems[i]).Caption + '=' +
      BoolToStr(TSimpleBase(FItems[i]).Updating);
    aList.Add(s);
    inc(i);
  end;
end;

function TSimpleBases.GetItemInfo(const aCaption: string;
  aList: TStrings): boolean;
var
  i: Integer;
begin
  aList.Clear;
  i := GetIndex(aCaption);
  Result := i > -1;
  if Result then
    with TSimpleBase(FItems.Items[i]) do
    begin
      aList.Add('caption=' + Caption);
      aList.Add('lastupdate=' + DateTimeToStr(LastUpdate));
      aList.Add('updating=' + BoolToStr(Updating));
      aList.Add('config=' + ConfigFile);
      aList.Add('journals=' + Client.JournalsDir);
      aList.Add('domains=' + Client.DomainsDir);
      aList.Add('adgroups=' + Client.ADGroupsDir);
      aList.Add('groups=' + Client.GroupsDir);
      aList.Add('users=' + Client.UsersDir);
    end
  else
    aList.Add('Not found');
end;

function TSimpleBases.Add(const aConfigFile: string): boolean;
var
  sCapt: string;
  list: TStringList;
begin
  Result := FileExists(aConfigFile);
  if Result then
  begin
    list := TStringList.Create;
    list.LoadFromFile(aConfigFile);
    sCapt := list.Values['caption'];
    FreeAndNil(list);
    if sCapt = '' then
      sCapt := ExtractFileName(aConfigFile);
    Result := Add(sCapt, aConfigFile);
  end;
end;

function TSimpleBases.Update(const aCaption: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  i := GetIndex(aCaption);
  if i > -1 then
    Result := Update(i);
end;

{ TSimpleClients }

procedure TSimpleClients.Clear;
var
  i, n: Integer;
begin
  n := Pred(FItems.Count);
  for i := 0 to n do
    Delete(i);
  FItems.Clear;
end;

constructor TSimpleClients.Create;
begin
  FItems := TList.Create;
  FPasswordFile := 'd:\ProjectsD\SAVAccess\managers.pwd';
end;

procedure TSimpleClients.Delete(const aIndex: Integer);

begin
  if aIndex < FItems.Count then
  begin
    TObject(FItems.Items[aIndex]).Free;
    FItems.Delete(aIndex);
  end;
end;

destructor TSimpleClients.Destroy;
begin
  Clear;
  FreeAndNil(Fitems);
  inherited;
end;

procedure TSimpleClients.DisconnectAll;
var
  i: Integer;
  client1: TSimpleClient;
  thrt1: TIdPeerThread;
begin
  for i := pred(FItems.Count) downto 0 do
  begin
    client1 := FItems.Items[i];
    thrt1 := client1.thread;
    thrt1.Connection.DisconnectSocket;
  end;
end;

function TSimpleClients.GetCount: integer;
begin
  Result := FItems.Count;
end;

function TSimpleClients.GetIndex(const aUID: string): integer;
var
  i: Integer;
begin
  Result := -1;
  i := 0;
  while (i < FItems.Count) and (Result = -1) do
  begin
    if TSimpleClient(FItems[i]).UID = aUID then
      Result := i;
    inc(i);
  end;

end;

function TSimpleClients.GetItem(const aUID: string): Pointer;
var
  i: Integer;
begin
  Result := nil;
  i := GetIndex(aUID);
  if i > -1 then
    Result := FItems.Items[i];
end;

procedure TSimpleClients.SetItems(const Value: TList);
begin
  FItems := Value;
end;

function TSimpleClients.GetUserPasswMD5(const aLogin: string): string;
var
  list: TStringList;
  s: string;
begin
  Result := '';
  s:=Trim(AnsiLowerCase(aLogin));
  try
    list := TStringList.Create;
    list.LoadFromFile(FPasswordFile);
    Result := list.Values[aLogin];
  finally
    FreeAndNil(list);
  end;
end;

procedure TSimpleClients.SetPasswordFile(const Value: string);
begin
  FPasswordFile := Value;
end;

function TSimpleClients.GetMD5(const aSource: string): string;
begin
  Result := MD5DigestToStr(MD5String(aSource));
end;

{ TSimpleClient }

constructor TSimpleClient.Create;
begin
  FLogin := '';
  FPassword := '';
  FCaption := '';
  FDNS := '';
  FUID := '';
  FAuthorized := False;
end;

procedure TSimpleClient.SetAuthorized(const Value: Boolean);
begin
  FAuthorized := Value;
end;

procedure TSimpleClient.SetCaption(const Value: string);
begin
  FCaption := Value;
end;

procedure TSimpleClient.SetDateTime(const Value: TDateTime);
begin
  FDateTime := Value;
end;

procedure TSimpleClient.SetDNS(const Value: string);
begin
  FDNS := Value;
end;

procedure TSimpleClient.SetLogin(const Value: string);
begin
  FLogin := Value;
end;

procedure TSimpleClient.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

procedure TSimpleClient.SetThread(const Value: Pointer);
begin
  FThread := Value;
end;

procedure TSimpleClient.SetUID(const Value: string);
begin
  FUID := Value;
end;

end.

