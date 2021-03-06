program SAVAccessAdmin;

uses
  FastMM4,
  Fastcode,
  FastMove,
  VCLFixPack,
  Forms,
  DU1 in 'DU1.pas' {dtmdl1: TDataModule},
  U7 in 'U7.pas' {Singelton},
  U1 in 'U1.pas' {Frm1},
  U4 in 'U4.pas' {Frm4},
  U15 in 'U15.pas' {Frm15},
  UAccessADGroup in 'UAccessADGroup.pas',
  U17 in 'U17.pas' {Frm17};

(*  U12 in 'U12.pas' {Frm12},
  UAccessBase in 'UAccessBase.pas',
  UAccessConstant in 'UAccessConstant.pas',
  UAccessUser in 'UAccessUser.pas',
  UAccessContainer in 'UAccessContainer.pas',
  UAccessGroup in 'UAccessGroup.pas',
  U3 in 'U3.pas' {Frm3},
  U4 in 'U4.pas' {Frm4},
  U5 in 'U5.pas' {Frm5},
  U6 in 'U6.pas' {Frm6},
  UAccessDomain in 'UAccessDomain.pas',
  U8 in 'U8.pas' {Frm8},
  UAccessPattern in 'UAccessPattern.pas',
  U9 in 'U9.pas' {Frm9},
  U1AD in 'U1AD.pas' {FrmAD},
  UAccessFileDBF in 'UAccessFileDBF.pas',
  U10 in 'U10.pas' {Frm10},
  U11 in 'U11.pas' {Frm11};*)

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdtmdl1, dtmdl1);
  Application.CreateForm(TFrm1, Frm1);
  Application.Run;
end.

