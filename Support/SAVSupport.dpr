program SAVSupport;

uses
  Forms,
  SAVSup01 in 'SAVSup01.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
