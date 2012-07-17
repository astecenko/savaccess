unit U2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons;

type
  TFrm2 = class(TForm)
    pnlControl: TPanel;
    pnlTree: TPanel;
    stat1: TStatusBar;
    spl1: TSplitter;
    pnlView: TPanel;
    lv1: TListView;
    edt1: TEdit;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    txtCaption: TStaticText;
    txtSID: TStaticText;
    txtDescription: TStaticText;
    txtDomain: TStaticText;
    procedure FormActivate(Sender: TObject);
    procedure lv1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses MsAD;

{$R *.dfm}

procedure TFrm2.FormActivate(Sender: TObject);
begin
  GetCurrentComputerName;
 EnumAllUsers(lv1, MsAD.GetDomainController(MsAd.CurrentDomainName),txtDomain.Caption);
end;

procedure TFrm2.lv1Click(Sender: TObject);
begin
txtCaption.Caption:=lv1.ItemFocused.Caption;
txtSID.Caption:=lv1.ItemFocused.SubItems[2];
txtDescription.Caption:=lv1.ItemFocused.SubItems[1];;
end;

end.
