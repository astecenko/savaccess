unit U15;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U4, ActnList, DB, DBCtrls, StdCtrls, Buttons, ComCtrls, Grids,
  DBGrids, ExtCtrls;

type
  TFrm15 = class(TFrm4)
    cbbGroupCn: TComboBox;
    procedure cbbGroupCnChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses MsAD;

{$R *.dfm}

procedure TFrm15.cbbGroupCnChange(Sender: TObject);
begin
  inherited;
  edtCaption.Text:=cbbGroupCn.Items.Names[cbbGroupCn.itemindex];
  edtSID.Text:=cbbGroupCn.Items.ValueFromIndex[cbbGroupCn.itemindex];
end;

procedure TFrm15.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if (Self.ModalResult=mrok) and ((edtCaption.Text='') or (edtSID.Text='')) then
    begin
      ShowMessage('Ќаименование и SID не могут быть пустыми!');
      Action:=caNone;
    end;  
end;

end.
