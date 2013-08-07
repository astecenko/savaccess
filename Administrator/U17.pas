unit U17;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, JvCsvData, StdCtrls, Mask, JvExMask,
  JvToolEdit, Spin, Buttons;

const
  csNoname='noname';

type
  TFrm17 = class(TForm)
    ds1: TDataSource;
    dbgrd1: TDBGrid;
    jvcsvdtst1: TJvCsvDataSet;
    edt1: TJvFilenameEdit;
    btn1: TButton;
    btn2: TButton;
    se1: TSpinEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    edt5: TEdit;
    btn3: TButton;
    mmo1: TMemo;
    btn4: TButton;
    btn5: TButton;
    edtLogin: TEdit;
    edtPsw: TEdit;
    btn6: TSpeedButton;
    btn7: TSpeedButton;
    btn8: TSpeedButton;
    btn9: TSpeedButton;
    dlgOpen1: TOpenDialog;
    dlgSave1: TSaveDialog;
    lbl1: TLabel;
    btn10: TSpeedButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure btn9Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InsertTemplate(const TemplateStr: string);
  end;

implementation
uses SAVLib;

{$R *.dfm}

procedure TFrm17.btn1Click(Sender: TObject);
begin
  if FileExists(edt1.Text) then
  begin
    jvcsvdtst1.Close;
    jvcsvdtst1.FileName := edt1.Text;
    jvcsvdtst1.Open;
  end;
end;

procedure TFrm17.btn2Click(Sender: TObject);
begin
  if jvcsvdtst1.RecordCount > 0 then
    SAVLib.ProcStart('telnet ' + jvcsvdtst1.fieldbyname('pc').AsString + ' ' +
      se1.Text, SW_SHOWNORMAL);
end;

procedure TFrm17.btn4Click(Sender: TObject);
begin
  InsertTemplate('$user$');
end;

procedure TFrm17.btn5Click(Sender: TObject);
begin
  InsertTemplate('$pc$');
end;

procedure TFrm17.InsertTemplate(const TemplateStr: string);
var
  s: string;
begin
  s := mmo1.Lines.Text;
  Insert(TemplateStr, s, mmo1.SelStart + 1);
  mmo1.Lines.Text := s;
end;

procedure TFrm17.btn8Click(Sender: TObject);
begin
  mmo1.Clear;
end;

procedure TFrm17.btn9Click(Sender: TObject);
begin
  if dlgOpen1.Execute then
    try
      mmo1.Lines.LoadFromFile(dlgOpen1.FileName);
      lbl1.Caption := dlgOpen1.FileName;
      lbl1.Hint := dlgOpen1.FileName;
    except
      ShowMessage('Ошибка открытия файла!');
    end;
end;

procedure TFrm17.btn6Click(Sender: TObject);
begin
  if dlgSave1.Execute then
    try
      mmo1.Lines.SaveToFile(dlgSave1.FileName);
      lbl1.Caption := dlgSave1.FileName;
      lbl1.Hint := dlgSave1.FileName;
    except
      ShowMessage('Ошибка сохранения файла!');
    end;
end;

procedure TFrm17.btn7Click(Sender: TObject);
begin
  if lbl1.Caption <> csNoname then
    try
      mmo1.Lines.SaveToFile(lbl1.Caption);
    except
      ShowMessage('Ошибка сохранения файла!');
    end;
end;

procedure TFrm17.FormCreate(Sender: TObject);
begin
   lbl1.Caption:=csNoname;
   lbl1.Hint:=csNoname;
end;

end.

