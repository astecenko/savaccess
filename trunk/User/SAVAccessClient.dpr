program SAVAccessClient;

uses
  FastMM4,
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
  UAccClient_INI in 'UAccClient_INI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
