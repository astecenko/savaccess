unit U12;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, VKDBFDataSet, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls;

type
  TFrm12 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    btnAdd: TBitBtn;
    dbgrdAct: TDBGrid;
    dbgrdExt: TDBGrid;
    vkdbfExt: TVKDBFNTX;
    vkdbfAct: TVKDBFNTX;
    dsExt: TDataSource;
    dsAct: TDataSource;
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrm12.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  if NewWidth < 350 then
    NewWidth := 350;
  if NewHeight < 300 then
    NewHeight := 300;
end;

end.

