program SAVMenu;

uses
  FastMM4,
  FastCode,
  FastMove,
  VCLFixPack,
  ceflib,
  Forms,
  SAVLib,
  cUMenu in 'cUMenu.pas' {SAVClntMenu},
  cUMenuSett in 'cUMenuSett.pas',
  UAccessUserConst in '..\User\UAccessUserConst.pas';

{$R *.res}

begin
  CefSingleProcess := False;
  if not CefLoadLib(Settings.ConfigDir+'cache','','','','','',LOGSEVERITY_DISABLE,True) then Exit;
  Application.Initialize;
  Application.CreateForm(TSAVClntMenu, SAVClntMenu);
  Application.Run;
end.
