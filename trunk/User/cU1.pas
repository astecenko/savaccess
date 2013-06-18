unit cU1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvTrayIcon, ActnList, StdActns, Menus, cUSettings,
  StdCtrls, IdBaseComponent, IdComponent, IdTCPServer, ExtCtrls, Sockets,
  IdThreadMgr, IdThreadMgrDefault, IdAntiFreezeBase, IdAntiFreeze, AppEvnts;

type
  TSAVClntFrm1 = class(TForm)
    jvTray: TJvTrayIcon;
    pmMain: TPopupMenu;
    N1: TMenuItem;
    actlst1: TActionList;
    actExit: TAction;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    idtcpsrvr1: TIdTCPServer;
    idthrdmgrdflt1: TIdThreadMgrDefault;
    idntfrz1: TIdAntiFreeze;
    aplctnvnts1: TApplicationEvents;
    actShowMenu: TAction;
    procedure actExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure idtcpsrvr1cmdhUpdateCommand(ASender: TIdCommand);
    procedure idtcpsrvr1Connect(AThread: TIdPeerThread);
    procedure idtcpsrvr1Disconnect(AThread: TIdPeerThread);
    procedure idtcpsrvr1cmdhOpenCommand(ASender: TIdCommand);
    procedure idtcpsrvr1cmdhListCommand(ASender: TIdCommand);
    procedure idtcpsrvr1cmdhStatusCommand(ASender: TIdCommand);
    procedure idtcpsrvr1cmdhInfoCommand(ASender: TIdCommand);
    procedure idtcpsrvr1cmdhHelpCommand(ASender: TIdCommand);
    procedure idtcpsrvr1cmdhExecCommand(ASender: TIdCommand);
    procedure idtcpsrvr1cmdhQuitCommand(ASender: TIdCommand);
    procedure idtcpsrvr1BeforeCommandHandler(ASender: TIdTCPServer;
      const AData: string; AThread: TIdPeerThread);
    procedure aplctnvnts1Exception(Sender: TObject; E: Exception);
    procedure idtcpsrvr1cmdhScreenCommand(ASender: TIdCommand);
    procedure idtcpsrvr1cmdhLoginCommand(ASender: TIdCommand);
    procedure idtcpsrvr1TIdCommandPasswordCommand(ASender: TIdCommand);
    procedure idtcpsrvr1cmdhLogoutCommand(ASender: TIdCommand);
    procedure idtcpsrvr1cmdhWhoamiCommand(ASender: TIdCommand);
    procedure actShowMenuExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure idtcpsrvr1cmdhDisupdateCommand(ASender: TIdCommand);
    procedure idtcpsrvr1cmdhVersionCommand(ASender: TIdCommand);
    procedure idtcpsrvr1cmdhExecConsCommand(ASender: TIdCommand);
    procedure idtcpsrvr1cmdhExecConsWinCommand(ASender: TIdCommand);
  private
    { Private declarations }
  public
    function GetNowTimeFile: string;
    function AccessGranted(ASender: TIdCommand): Boolean;
  end;

var
  SAVClntFrm1: TSAVClntFrm1;

implementation
uses SAVLib_INI, Registry, UAccessSimple, SAVLib, Support, UAccessUserConst,
  shelllink;

{$R *.dfm}

function TSAVClntFrm1.GetNowTimeFile: string;
begin
  DateTimeToString(Result, 'yyyy_mm_dd-hh-nn-ss', Now);
end;

procedure TSAVClntFrm1.actExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TSAVClntFrm1.FormCreate(Sender: TObject);
const
  csLinkName = 'savacc.lnk';
var
  reg: TRegistry;
  b: Boolean;
  s: string;
begin

  b := True;
  try
    idtcpsrvr1.Active := True
  except
    b := False;
  end;
  if b then
  begin
    reg := TRegistry.Create;
    reg.OpenKey('SOFTWARE\SAVClient', True);
    reg.WriteString('path', Application.ExeName);
    reg.CloseKey;
    FreeAndNil(reg);
    s := IncludeTrailingPathDelimiter(GetSpecialFolderLocation(CSIDL_STARTUP,
      FOLDERID_Startup));
    if not (FileExists(s + csLinkName)) then
    begin
      shelllink.CreateShortcut(Application.ExeName, _OTHERFOLDER, s, '', '', '',
        csLinkName);
    end;
    Settings.Init;
    //  Settings.Bases.GetCaption();
  end
  else
    Application.Terminate;
  //Settings.Client.LoadFromFile(Settings.ConfigFile);
  //ds1.DataSet := Settings.Client.DataSet;
  //Settings.InUpdating := True;
  // Settings.Client.Update;
  // Settings.LastUpdate := Now;
  // Settings.InUpdating := False;
  // Application.Terminate;

end;

procedure TSAVClntFrm1.idtcpsrvr1cmdhUpdateCommand(ASender: TIdCommand);
begin
  if AccessGranted(ASender) then
  begin
    if ASender.Params.Count > 0 then
    begin
      if Settings.Bases.Update(ASender.Params[0]) then
        ASender.Reply.Text.Text := 'Updated'
      else
      begin
        ASender.Reply.NumericCode := 402;
        ASender.Reply.Text.Text := 'Update is not successful';
      end;
    end
    else
    begin
      ASender.Reply.NumericCode := 401;
      ASender.Reply.Text.Text := 'Need base name as parameter';
    end;
  end;
  Settings.Log.SaveCommand(ASender);
end;

procedure TSAVClntFrm1.idtcpsrvr1Connect(AThread: TIdPeerThread);
var
  Client: TSimpleClient;
begin
  Client := TSimpleClient.Create;
  Client.DNS := AThread.Connection.LocalName;
  Client.Caption := 'No';
  Client.UID := DateTimeToStr(Now);
  { Assign the thread to it for ease in finding }
  Client.Thread := AThread;
  { Assign it to the thread so we can identify it later }
  AThread.Data := Client;
  { Add it to the clients list }
  Settings.Clients.Items.Add(Client);
end;

procedure TSAVClntFrm1.idtcpsrvr1Disconnect(AThread: TIdPeerThread);
var
  Client: TSimpleClient;
  n, i: Integer;
begin
  Client := Pointer(AThread.Data);
  n := Settings.Clients.Count;
  i := 0;
  while (i < n) and (TSimpleClient(Settings.Clients.Items[i]).UID <> Client.UID)
    do
    inc(i);
  if i <> n then
    Settings.Clients.Items.Delete(i);
  FreeAndNil(Client);
  AThread.Data := nil;
end;

procedure TSAVClntFrm1.idtcpsrvr1cmdhOpenCommand(ASender: TIdCommand);
begin
  if AccessGranted(ASender) then
  begin
    if ASender.Params.Count > 0 then
    begin
      if Settings.Bases.Add(ASender.Params[0]) then
        ASender.Reply.Text.Text := 'Added'
      else
      begin

        ASender.Reply.Text.Text := 'Error with config file!';
        ASender.Reply.NumericCode := 401;
        ASender.Thread.Connection.LocalName;
      end
    end
    else
    begin
      ASender.Reply.Text.Text := 'Need config filename as parameter!';
      ASender.Reply.NumericCode := 402;
    end;
  end;
  Settings.Log.SaveCommand(ASender);
end;

procedure TSAVClntFrm1.idtcpsrvr1cmdhListCommand(ASender: TIdCommand);
var
  list: TStringList;
begin
  if AccessGranted(ASender) then
  begin
    list := TStringList.Create;
    Settings.Bases.GetCaptions(list, True);
    ASender.Reply.Text.Assign(list);
    FreeAndNil(list);
  end;
  Settings.Log.SaveCommand(ASender);
end;

procedure TSAVClntFrm1.idtcpsrvr1cmdhStatusCommand(ASender: TIdCommand);
var
  list: TStringList;
begin
  list := TStringList.Create;
  Settings.Bases.GetStatus(list);
  ASender.Reply.Text.Assign(list);
  FreeAndNil(list);
  Settings.Log.SaveCommand(ASender);
end;

procedure TSAVClntFrm1.idtcpsrvr1cmdhInfoCommand(ASender: TIdCommand);
var
  list: TStringList;
begin
  if AccessGranted(ASender) then
  begin
    if ASender.Params.Count > 0 then
    begin
      list := TStringList.Create;
      if not Settings.Bases.GetItemInfo(ASender.Params[0], list) then
        ASender.Reply.NumericCode := 402;
      ASender.Reply.Text.Assign(list);
      FreeAndNil(list);
    end
    else
    begin
      ASender.Reply.Text.Text := 'Need base name as parameter!';
      ASender.Reply.NumericCode := 401;
    end;
  end;
  Settings.Log.SaveCommand(ASender);
end;

procedure TSAVClntFrm1.idtcpsrvr1cmdhHelpCommand(ASender: TIdCommand);
begin
  if (ASender.Params.Count > 0) and (AnsiUpperCase(ASender.Params[0]) = 'ALL')
    then
  begin
    ASender.Response.Add('EXEC <file name> - Program launch');
    ASender.Response.Add('Screen <file name> - Save client screenshot as <file name>');
  end;
  Settings.Log.SaveCommand(ASender);
end;

procedure TSAVClntFrm1.idtcpsrvr1cmdhExecCommand(ASender: TIdCommand);
begin
  if AccessGranted(ASender) then
  begin
    if ASender.Params.Count = 0 then
    begin
      ASender.Reply.NumericCode := 401;
      ASender.Reply.Text.Text := 'Parameter is required';

    end
    else
    begin
      ProcStart(ASender.Params[0], SW_NORMAL);
      ASender.Reply.Text.Text := 'Program is executed: ' + ASender.Params[0];
    end;
  end;
  Settings.Log.SaveCommand(ASender);
end;

procedure TSAVClntFrm1.idtcpsrvr1cmdhQuitCommand(ASender: TIdCommand);
begin
  Settings.Log.SaveCommand(ASender);
end;

procedure TSAVClntFrm1.idtcpsrvr1BeforeCommandHandler(ASender: TIdTCPServer;
  const AData: string; AThread: TIdPeerThread);
begin
  Settings.Log.Add('[' + AThread.Connection.LocalName + ']', AData);
end;

procedure TSAVClntFrm1.aplctnvnts1Exception(Sender: TObject; E: Exception);
begin
  if Assigned(Settings.Log) then
    Settings.Log.Add(DateTimeToStr(Now), 'AppError', E.Message);
end;

procedure TSAVClntFrm1.idtcpsrvr1cmdhScreenCommand(ASender: TIdCommand);
var
  s: string;
begin
  if AccessGranted(ASender) then
  begin
    if ASender.Params.Count = 0 then
    begin
      ASender.Reply.NumericCode := 401;
      ASender.Reply.Text.Text := 'Parameter is required';

    end
    else
    begin
      s := ExcludeTrailingPathDelimiter(ASender.Params[0]);
      if DirectoryExists(s) then
      begin
        s := s + '\' + GetNowTimeFile + '.jpg';
        if DoScreenshot(s, 80) then
          ASender.Reply.Text.Text := 'Screenshot saved as: ' + s
        else
        begin
          ASender.Reply.NumericCode := 403;
          ASender.Reply.Text.Text := 'Can not save file as: ' + s;
        end
      end
      else
      begin
        ASender.Reply.NumericCode := 402;
        ASender.Reply.Text.Text := 'Directory not exsist';
      end;
    end;
  end;
  Settings.Log.SaveCommand(ASender);
end;

function TSAVClntFrm1.AccessGranted(ASender: TIdCommand): Boolean;
begin
  Result := TSimpleClient(Asender.Thread.Data).Authorized;
  if not Result then
  begin
    ASender.Reply.Text.Text := 'Access denied! Not authorized!';
    ASender.Reply.NumericCode := 500;
  end;
end;

procedure TSAVClntFrm1.idtcpsrvr1cmdhLoginCommand(ASender: TIdCommand);
begin
  if TSimpleClient(Asender.Thread.Data).Authorized then
  begin
    ASender.Reply.Text.Text :=
      'You are already logged. At first exit from your account!';
    ASender.Reply.NumericCode := 401;
  end
  else
  begin
    if ASender.Params.Count > 0 then
    begin
      TSimpleClient(Asender.Thread.Data).Login := ASender.Params[0];
      ASender.Reply.Text.Text := 'Login ' + ASender.Params[0] +
        ' accepted. Password needed.';
    end
    else
    begin
      ASender.Reply.Text.Text := 'Parameter needed';
      ASender.Reply.NumericCode := 402;
    end;
  end;
  Settings.Log.SaveCommand(ASender);
end;

procedure TSAVClntFrm1.idtcpsrvr1TIdCommandPasswordCommand(
  ASender: TIdCommand);
var
  s: string;
  Client: TSimpleClient;
begin
  Client := TSimpleClient(Asender.Thread.Data);
  if Client.Authorized then
  begin
    ASender.Reply.Text.Text :=
      'You are already logged. At first exit from your account!';
    ASender.Reply.NumericCode := 401;
  end
  else
  begin
    if ASender.Params.Count > 0 then
    begin
      s := Settings.Clients.GetUserPasswMD5(Client.Login);
      if s = '' then
      begin
        ASender.Reply.Text.Text := 'User does not exist';
        ASender.Reply.NumericCode := 403;
      end
      else
      begin
        if Settings.Clients.GetMD5(ASender.Params[0]) = s then
        begin
          Client.Password := s;
          Client.Authorized := True;
        end
        else
        begin
          ASender.Reply.Text.Text := 'Bad password!';
          ASender.Reply.NumericCode := 404;
        end
      end
    end
    else
    begin
      ASender.Reply.Text.Text := 'Parameter needed';
      ASender.Reply.NumericCode := 402;
    end;
  end;
  Settings.Log.SaveCommand(ASender);
end;

procedure TSAVClntFrm1.idtcpsrvr1cmdhLogoutCommand(ASender: TIdCommand);
begin
  TSimpleClient(Asender.Thread.Data).Authorized := False;
  TSimpleClient(Asender.Thread.Data).Login := '';
  TSimpleClient(Asender.Thread.Data).Password := '';
end;

procedure TSAVClntFrm1.idtcpsrvr1cmdhWhoamiCommand(ASender: TIdCommand);
begin
  if TSimpleClient(Asender.Thread.Data).Authorized then
    ASender.Reply.Text.Text := 'Authorized as ' +
      TSimpleClient(Asender.Thread.Data).Login
  else
  begin
    ASender.Reply.Text.Text := 'Not authorized';
    if TSimpleClient(Asender.Thread.Data).Login <> '' then
      ASender.Reply.Text.Text := ASender.Reply.Text.Text + ', login "' +
        TSimpleClient(Asender.Thread.Data).Login + '"';
  end
end;

procedure TSAVClntFrm1.actShowMenuExecute(Sender: TObject);
var
  //  MnuFrm: TSAVClntMenu;
  h: HWND;
  s: string;
begin
  if Settings.Bases.Count > 0 then
  begin
    s := csMainCaption + Settings.Bases.GetCaption(0);
    h := FindWindow('TSAVClntMenu', PChar(s));
    if h = 0 then
      ProcStart('SAVMenu.exe')
    else
      ShowWindow(h, SW_SHOWNORMAL);
  end
    (*  s := TSAVClntMenu.ClassName;
      h := FindWindow(PAnsiChar(s), nil);
      if h = 0 then
      begin
        MnuFrm := TSAVClntMenu.Create(Self);
        try
          //  MnuFrm.wb1.
          //MnuFrm.frameRight.LoadFromFile(Settings.Bases.RootConfig+'Client\index.html');
          //MnuFrm.chrm1.defaulturl:=Settings.Bases.RootConfig+'Client\index.html';
          //MnuFrm.chrm1.Load('file:///C:/Documents%20and%20Settings/StetsenkoAV/Application%20Data/NEVZ/OASUP/Client/index.html');
          MnuFrm.chrm1.Load('http://opennet.ru/');
          // MnuFrm.chrm1.defaulturl:='file:///C:/Documents%20and%20Settings/StetsenkoAV/Application%20Data/NEVZ/OASUP/Client/index.html';
          // MnuFrm.chrm1.Refresh;
           // MnuFrm.frameRight.FwdButtonEnabled:=True;
           // MnuFrm.frameRight.BackButtonEnabled:=True;
          MnuFrm.LoadMenuFromFile(Settings.Bases.RootConfig + 'Client\client.mnu');
          MnuFrm.ShowModal;
        finally
          FreeAndNil(MnuFrm);
        end;
      end
      else
        ShowWindow(h,SW_SHOWNORMAL);
      *)
end;

procedure TSAVClntFrm1.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if idtcpsrvr1.Active then
  begin
    Settings.Clients.DisconnectAll;
    idtcpsrvr1.Active := False;
  end;
end;

procedure TSAVClntFrm1.idtcpsrvr1cmdhDisupdateCommand(ASender: TIdCommand);
begin
  if AccessGranted(ASender) then
  begin
    if ASender.Params.Count > 0 then
    begin
      if not Settings.Bases.DisUpdate(ASender.Params[0]) then
      begin
        ASender.Reply.Text.Text := 'Base not founded!';
        ASender.Reply.NumericCode := 402;
      end;
    end
    else
    begin
      ASender.Reply.Text.Text := 'Need base name as parameter!';
      ASender.Reply.NumericCode := 401;
    end;
  end;
  Settings.Log.SaveCommand(ASender);
end;

procedure TSAVClntFrm1.idtcpsrvr1cmdhVersionCommand(ASender: TIdCommand);
begin
  ASender.Reply.Text.Text := 'Client App Version: ' +
    SAvlib.FileVersion(Application.ExeName);
end;

function GetDosOutput(const CommandLine: string): string;
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array[0..255] of AnsiChar;
  BytesRead: Cardinal;
  {cmdLine,}Line: string;
begin
  Application.ProcessMessages;
  with SA do
  begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SA, 0);
  try
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE);
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    //cmdLine := PChar(ExtractFilePath(application.exename) + '\cmd.exe /c ping -n 10 ya.ru');
    WasOK := CreateProcess(nil, PChar(CommandLine), nil, nil, True, 0, nil,
      PChar(ExtractFilePath(application.exename)), SI, PI);
    CloseHandle(StdOutPipeWrite);
    if WasOK then
      try
        Line := '';
        repeat
          WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);
          if BytesRead > 0 then
          begin
            Buffer[BytesRead] := #0;
            oemtochara(buffer, buffer);
            Line := Line + string(AnsiString(Buffer));
          end;
        until not WasOK or (BytesRead = 0);
        WaitForSingleObject(PI.hProcess, INFINITE);
      finally
        CloseHandle(PI.hThread);
        CloseHandle(PI.hProcess);
      end;
  finally
    result := Line;
    CloseHandle(StdOutPipeRead);
  end;
end;

procedure TSAVClntFrm1.idtcpsrvr1cmdhExecConsCommand(ASender: TIdCommand);
var
  list2: TStringList;
  i: integer;
begin
  if AccessGranted(ASender) then
  begin
    if ASender.Params.Count = 0 then
    begin
      ASender.Reply.NumericCode := 401;
      ASender.Reply.Text.Text := 'Parameter is required';

    end
    else
    begin
      list2 := TStringList.Create;
      i := 0;
      try
        list2.Text := GetDosOutput(DosToWin(ASender.Params[0]));
        while i < list2.Count do
          if Trim(list2[i]) = '' then
            list2.Delete(i)
          else
            Inc(i);
        ASender.Reply.Text.Text := WinToDos(list2.Text) + #10#13;
      finally
        FreeAndNil(list2);
      end;
    end;
  end;
  Settings.Log.SaveCommand(ASender);
end;

procedure TSAVClntFrm1.idtcpsrvr1cmdhExecConsWinCommand(
  ASender: TIdCommand);
var
  list2: TStringList;
  i: integer;
begin
  if AccessGranted(ASender) then
  begin
    if ASender.Params.Count = 0 then
    begin
      ASender.Reply.NumericCode := 401;
      ASender.Reply.Text.Text := 'Parameter is required';

    end
    else
    begin
      list2 := TStringList.Create;
      i := 0;
      try
        list2.Text := GetDosOutput(ASender.Params[0]);
        while i < list2.Count do
          if Trim(list2[i]) = '' then
            list2.Delete(i)
          else
            Inc(i);
        ASender.Reply.Text.Text := list2.Text + #10#13;
      finally
        FreeAndNil(list2);
      end;
    end;
  end;
  Settings.Log.SaveCommand(ASender);
end;

end.

