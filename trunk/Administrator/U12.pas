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
    dbgrdAct: TDBGrid;
    dbgrdExt: TDBGrid;
    vkdbfExt: TVKDBFNTX;
    vkdbfAct: TVKDBFNTX;
    dsExt: TDataSource;
    dsAct: TDataSource;
    txt1: TStaticText;
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure dsExtDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure vkdbfExtAfterInsert(DataSet: TDataSet);
    procedure vkdbfExtAfterDelete(DataSet: TDataSet);
    procedure vkdbfActAfterDelete(DataSet: TDataSet);
    procedure vkdbfActAfterInsert(DataSet: TDataSet);
    procedure dbgrdExtKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgrdActKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses UAccessConstant;

{$R *.dfm}

procedure TFrm12.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  if NewWidth < 350 then
    NewWidth := 350;
  if NewHeight < 300 then
    NewHeight := 300;
end;

procedure TFrm12.dsExtDataChange(Sender: TObject; Field: TField);
begin
  if not (dsExt.DataSet.IsEmpty) and
    (dsExt.DataSet.fieldByName(csFieldID).AsString <> '') then
  begin
    dsAct.DataSet.Filtered := False;
    dsAct.DataSet.Filter := csFieldFID + '=' +
      dsExt.DataSet.fieldByName(csFieldID).AsString;
    dsAct.DataSet.Filtered := True;
  end;
end;

procedure TFrm12.FormShow(Sender: TObject);
begin
  vkdbfAct.Open;
  vkdbfExt.Open;
end;

procedure TFrm12.vkdbfExtAfterInsert(DataSet: TDataSet);
begin
  vkdbfExt.FieldByName(csFieldID).AsInteger :=
    vkdbfExt.GetNextAutoInc(csFieldID);
end;

procedure TFrm12.vkdbfExtAfterDelete(DataSet: TDataSet);
var
  b: Boolean;
begin
  b := False;
  vkdbfAct.DisableControls;
  vkdbfAct.First;
  while not (vkdbfAct.Eof) do
  begin
    if vkdbfAct.FieldByName(csFieldFID).AsInteger =
      dsExt.DataSet.fieldByName(csFieldID).AsInteger then
    begin
      b := true;
      vkdbfAct.Delete;
    end;
    vkdbfAct.Next;
  end;
  if b then
    vkdbfAct.Pack;
  vkdbfExt.Pack;
  vkdbfAct.EnableControls;
end;

procedure TFrm12.vkdbfActAfterDelete(DataSet: TDataSet);
begin
  if dbgrdAct.Focused then
    vkdbfAct.Pack;
end;

procedure TFrm12.vkdbfActAfterInsert(DataSet: TDataSet);
begin
  vkdbfAct.FieldByName(csFieldFID).AsInteger :=
    vkdbfExt.FieldByName(csFieldID).AsInteger;
end;

procedure TFrm12.dbgrdExtKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_Down:
      begin
        dbgrdExt.DataSource.DataSet.Next;
        Key := 0;
      end;
  end;
end;

procedure TFrm12.dbgrdActKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case Key of
    VK_Down:
      begin
        dbgrdAct.DataSource.DataSet.Next;
        Key := 0;
      end;
  end;
end;

end.

