unit U15;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U4, ActnList, DB, DBCtrls, StdCtrls, Buttons, ComCtrls, Grids,
  DBGrids, ExtCtrls;

type
  TFrm15 = class(TFrm4)
    cbbGroupCn: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure cbbGroupCnChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses MsAD;

{$R *.dfm}

procedure TFrm15.FormShow(Sender: TObject);
begin
  inherited;
  GetAllGroups(DomainSID,cbbGroupCn.items,True);
end;

procedure TFrm15.cbbGroupCnChange(Sender: TObject);
begin
  inherited;
  edtCaption.Text:=cbbGroupCn.Items.Names[cbbGroupCn.itemindex];
  edtSID.Text:=cbbGroupCn.Items.ValueFromIndex[cbbGroupCn.itemindex];
end;

end.
