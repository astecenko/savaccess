unit U10;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, Buttons;

type
  TFrm10 = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    edtSrvrFile: TEdit;
    edtClntFile: TEdit;
    btnTest: TBitBtn;
    edtExt: TEdit;
    lbl4: TLabel;
    lbl5: TLabel;
    cbb1: TComboBox;
    lbl6: TLabel;
    seAction: TSpinEdit;
    bvl1: TBevel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    btnShow: TBitBtn;
    btnLoad: TBitBtn;
    lbl7: TLabel;
    edtMD5: TEdit;
    btnMD5: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
