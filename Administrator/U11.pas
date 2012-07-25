unit U11;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, VKDBFDataSet, Grids, DBGrids, StdCtrls, Buttons;

type
  TFrm11 = class(TForm)
    lbl1: TLabel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    ds1: TDataSource;
    dbgrd1: TDBGrid;
    vkdbfntx2: TVKDBFNTX;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
