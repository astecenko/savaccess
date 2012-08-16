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
    edtName: TEdit;
    lbl2: TLabel;
    edtSID: TEdit;
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses UAccessConstant;

{$R *.dfm}

procedure TFrm11.btn1Click(Sender: TObject);
begin
  vkdbfntx2.Filtered:=False;
  vkdbfntx2.Filter:='';
  if edtName.Text<>'' then
    vkdbfntx2.Filter:=csFieldCaption+'='+QuotedStr(edtName.Text+'*');
  if Length(edtSID.Text)>0 then
  begin
    if vkdbfntx2.Filter<>'' then vkdbfntx2.Filter:=vkdbfntx2.Filter+' AND ';
    vkdbfntx2.Filter:=vkdbfntx2.Filter+csFieldSID+'='+QuotedStr(edtSID.Text+'*');
  end;
  vkdbfntx2.Filtered:=True;
end;

end.
