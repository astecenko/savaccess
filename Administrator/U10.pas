unit U10;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, Buttons, UAccessFileDBF;

type
  TFrm10 = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    edtSrvrFile: TEdit;
    edtClntFile: TEdit;
    btnTest: TBitBtn;
    edtExt: TEdit;
    lbl4: TLabel;
    lbl5: TLabel;
    cbbType: TComboBox;
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
    lbl8: TLabel;
    edtDescr: TEdit;
    lbl3: TLabel;
    edtVersion: TEdit;
    btn1: TButton;
    sePriority: TSpinEdit;
    lbl9: TLabel;
    procedure FormResize(Sender: TObject);
    procedure btnMD5Click(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    FUserFiles: TSAVAccessFilesDBF;
    procedure SetUserFiles(const Value: TSAVAccessFilesDBF);

  public
    property UserFiles: TSAVAccessFilesDBF read FUserFiles write SetUserFiles;
  end;

implementation
uses md5, U9, U12, UAccessConstant, DB;
{$R *.dfm}

procedure TFrm10.FormResize(Sender: TObject);
begin
  Height := 350;
end;

procedure TFrm10.SetUserFiles(const Value: TSAVAccessFilesDBF);
begin
  FUserFiles := Value;
end;

procedure TFrm10.btnMD5Click(Sender: TObject);
begin
  if Trim(edtSrvrFile.Text) <> '' then
    edtMD5.Text :=
      UserFiles.GetMD5(IncludeTrailingPathDelimiter(UserFiles.Container.WorkDir)
      + 'f\' + Trim(edtSrvrFile.Text));
end;

procedure TFrm10.btnTestClick(Sender: TObject);
var
  Frm02: TFrm9;
begin
  Frm02 := TFrm9.Create(Self);
  Frm02.edtTestInput.Text := edtClntFile.text;
  if Frm02.ShowModal = mrOk then
    edtClntFile.Text := Frm02.edtTestInput.Text;
  FreeAndNil(Frm02);
end;

procedure TFrm10.btn1Click(Sender: TObject);
var
  Form03: TFrm12;
begin
    Form03 := TFrm12.Create(Self);
    Form03.vkdbfExt.DBFFileName :=
      IncludeTrailingPathDelimiter(UserFiles.Container.Bases.JournalsDir) +
      csTableExt;
    Form03.vkdbfAct.DBFFileName :=
      IncludeTrailingPathDelimiter(UserFiles.Container.Bases.JournalsDir) +
      csTableAction;
    if Form03.ShowModal = mrOk then
    begin
      edtExt.Text := Form03.vkdbfExt.FieldByName(csFieldExt).AsString;
      seAction.Value  :=  Form03.vkdbfAct.FieldByName(csFieldAction).AsInteger;
      cbbType.Text := Form03.vkdbfExt.FieldByName(csFieldType).AsString;
    end;
    FreeAndNil(Form03);
end;

end.

