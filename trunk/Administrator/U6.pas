unit U6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U4, ComCtrls, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, DB,
  DBCtrls, VKDBFDataSet, ActnList;

type
  TFrm6 = class(TFrm4)
    btnSelectUser: TBitBtn;
    edtDomain: TEdit;
    procedure btnSelectUserClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



implementation
         uses U1AD;
{$R *.dfm}

procedure TFrm6.btnSelectUserClick(Sender: TObject);
var
  Frm02:TFrmAD;
begin
  Frm02:=TFrmAD.Create(Self);
  Frm02.edtUserDomain.Text:=edtDomain.Text;
  if Frm02.ShowModal=mrok then
  begin
    edtCaption.Text:=Frm02.edtCaption.Text;
    edtSID.Text:=Frm02.edtSID.Text;
    edtDescription.Text:=Frm02.edtDescription.Text;
    chkCopyCaption.Checked:=False;
  end;
  FreeAndNil(Frm02);
end;

procedure TFrm6.FormShow(Sender: TObject);
begin
  inherited;
  edtDomain.Text:=DomainSID;
end;

end.
