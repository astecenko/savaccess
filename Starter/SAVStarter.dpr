program SAVStarter;

{$APPTYPE CONSOLE}

uses
  FastMM4, FastCode, FastMove, SysUtils, Windows, Classes, Registry,
  IdException, DateUtils, IdTCPClient;

const
  localhost = '127.0.0.1';
  erMes_1 = 'Access base file is not set';
  erMes_2 = 'The client application is not installed';
  erMes_3 = 'The client application is not running on the path ';
  erMes_4 = 'An network error occurred during communication: ';
  erMes_5 = 'An unknown error occurred during communication: ';
  erMes_6 = 'An network error occurred while trying to connect: ';
  erMes_7 = 'An unknown error occurred while trying to connect: ';

  paramHost = 'host';
  paramBase = 'base';
  paramPort = 'port';
  paramPath = 'path';
  paramCapt = 'caption';
  paramLast = 'lastupdate';
  paramUpda = 'updating';
  paramDebug = 'debug';
  paramMin = 'minutes';

  ClientForm = 'TSAVClntFrm1';
  regPath = 'NEVZ\OASUP\Client';

  ClientLogin = 'arty';
  ClientPassw = '12345';

var
  reg: TRegistry;
  i: Integer;
  updating: Boolean;
  ParamList, TempList: TStringList;
  shost, sconf, srun, scapt, sparam: string;
  iport, idebug, iminute: Integer;
  idClient: TIdTCPClient;
  LastUpd, NoUpd: TDateTime;
  progres: Char;

procedure ProcStart(const s: string; const awShowWnd: Word = 0; const aWait:
  Boolean = False; const aWaitTime: DWORD = $FFFFFFFF);
var
  si: TStartupInfo;
  p: TProcessInformation;
begin
  FillChar(Si, SizeOf(Si), 0);
  with Si do
  begin
    cb := SizeOf(Si);
    dwFlags := startf_UseShowWindow;
    wShowWindow := awShowWnd;
  end;
  if Createprocess(nil, PAnsiChar(s), nil, nil, false,
    Create_default_error_mode, nil, nil, si, p) then
    if aWait then
      Waitforsingleobject(p.hProcess, aWaitTime);
  CloseHandle(p.hProcess);
end;

function IsLocalhost(const aHost: string): Boolean;
begin
  Result := aHost = 'localhost';
  if not Result then
    if Length(aHost) > 8 then
      Result := Copy(aHost, 1, 4) = '127.';
end;

procedure WriteLnDebug(const aStr: string);
begin
  if idebug = 1 then
    System.Writeln(aStr);
end;

begin
  progres := '0';
  if ParamCount = 1 then
  begin
    sparam := AnsiLowerCase(ParamStr(1));
    if (sparam = 'help') or (sparam = '?') or (sparam = '/?') then
    begin
      Writeln('SAVAccess starter. Param list:');
      Writeln('base - full path to config base file. REQUIRED');
      Writeln('host - host PC IP address, DNS or NetBIOS name. Default=127.0.0.1');
      Writeln('port - host PC networks port. Default=45890');
      Writeln('caption - base caption. Needed if config base file not accessed from this PC. Default not set');
      Writeln('debug - show debug info if equal 1. Default not set');
      Writeln('minutes - the number of minutes since the last update, above which should launch a new update. If the last database update took less than setting the time, the new update does not start. Default=3');
      Writeln('');
      Writeln('Examples:');
      Writeln('All defaults: ' + ExtractFileName(ParamStr(0)) +
        ' base=\\bs4\share1\file1.savaccess');
      Writeln('More parameters: ' + ExtractFileName(ParamStr(0)) +
        ' base=\\bs4\share1\file1.savaccess host=172.16.0.1 port=8888 minutes=5 caption="main base" debug=1');
      Exit;
    end;
  end;
  if ParamCount > 0 then
  begin
    ParamList := TStringList.Create;
    for i := 1 to ParamCount do
      ParamList.Add(AnsiLowerCase(ParamStr(i)));
    shost := ParamList.Values[paramHost];
    if shost = '' then
      shost := localhost;
    sconf := ParamList.Values[paramBase];
    scapt := ParamList.Values[paramCapt];
    iport := StrToIntDef(ParamList.Values[paramPort], 0);
    iminute := StrToIntDef(ParamList.Values[paramMin], 3);
    idebug := StrToIntDef(ParamList.Values[paramDebug], 0);
    if iport = 0 then
      iport := 45890;
    if (sconf = '') or (not FileExists(sconf)) then
      WriteLnDebug(erMes_1)
    else
    begin
      if IsLocalhost(shost) then
      begin
        if FindWindow(ClientForm, nil) = 0 then
        begin
          reg := TRegistry.Create;
          reg.OpenKey(regPath, False);
          srun := reg.ReadString(paramPath);
          reg.CloseKey;
          FreeAndNil(reg);
          if srun = '' then
          begin
            WriteLnDebug(erMes_2);
            Exit;
          end;
          ProcStart(srun, SW_SHOWNORMAL);
          if FindWindow(ClientForm, nil) <> 0 then
          begin
            WriteLnDebug(erMes_3 + srun);
            Exit;
          end;
        end;
      end;
      idClient := TIdTCPClient.Create(nil);
      idClient.Host := shost;
      idClient.Port := iport;
      TempList := TStringList.Create;
      NoUpd := EncodeDate(2000, 01, 01);
      try
        if scapt = '' then
        begin
          TempList.LoadFromFile(sconf);
          scapt := TempList.Values[paramCapt];
          TempList.Clear;
          if scapt = '' then
            scapt := ExtractFileName(sconf);
        end;
        with idClient do
        begin
          Connect;
          try
            try
              GetResponse(200);
              SendCmd('login ' + ClientLogin);
              if LastCmdResult.NumericCode = 200 then
              begin
                SendCmd('password ' + ClientPassw);
                if LastCmdResult.NumericCode = 200 then
                begin
                  SendCmd('info ' + scapt);
                  if LastCmdResult.NumericCode = 200 then
                  begin
                    TempList.Assign(LastCmdResult.Text);
                    LastUpd := StrToDateTimeDef(TempList.Values[paramLast],
                      NoUpd);
                    updating := StrtoBoolDef(TempList.Values[paramUpda], False);
                    WriteLnDebug(TempList.Text);
                    if (MinutesBetween(LastUpd, NoUpd) > iminute) and (not
                      updating) then
                    begin
                      SendCmd('update ' + scapt);
                      WriteLnDebug(LastCmdResult.Text.Text);
                      if LastCmdResult.NumericCode = 200 then
                        progres := '1';
                    end;
                  end
                  else
                  begin
                    SendCmd('open ' + sconf);
                    WriteLnDebug(LastCmdResult.Text.Text);
                    if LastCmdResult.NumericCode = 200 then
                    begin
                      SendCmd('update ' + scapt);
                      WriteLnDebug(LastCmdResult.Text.Text);
                      if LastCmdResult.NumericCode = 200 then
                      begin
                        progres := '1';
                      end
                    end;
                  end;
                end;
              end;
            finally
              Disconnect;
            end;
          except
            on E: EIdException do
              WriteLnDebug(ermes_4 + E.Message);
            on E: Exception do
              WriteLnDebug(ermes_5 + E.Message);
          end;
        end;
      except
        on E: EIdException do
          WriteLnDebug(ermes_6 + E.Message);
        on E: Exception do
          WriteLnDebug(ermes_7 + E.Message);
      end;
      FreeAndNil(TempList);
      FreeAndNil(idClient);
    end;
    FreeAndNil(ParamList);
  end;
  Write(progres);
end.

