program SAVAccessClient;

{%ToDo 'SAVAccessClient.todo'}

uses
  FastMM4,
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  FastCode,
  FastMove,
  VCLFixPack,
  Forms,
  cUSettings in 'cUSettings.pas',
  cU1 in 'cU1.pas' {Form1},
  UAccessPattern in '..\Administrator\UAccessPattern.pas',
  UAccessBase in '..\Administrator\UAccessBase.pas',
  UAccessConstant in '..\Administrator\UAccessConstant.pas',
  UAccessContainer in '..\Administrator\UAccessContainer.pas',
  UAccessClient in 'UAccessClient.pas',
  PluginManager in '..\PluginAPI\Core\PluginManager.pas',
  PluginAPI in '..\PluginAPI\Headers\PluginAPI.pas',
  UAccessSimple in 'UAccessSimple.pas',
  UAccessUserConst in 'UAccessUserConst.pas';

{$R *.res}

begin
  //CefSingleProcess := False;
  //if not CefLoadLib(Settings.Bases.RootConfig+'cache') then Exit;
  Application.Initialize;
  Application.CreateForm(TSAVClntFrm1, SAVClntFrm1);
  Application.Run;
end.

