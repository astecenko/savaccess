unit U4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, ComCtrls, StdCtrls, Buttons,
  UAccessFileDBF,
  DB, DBCtrls;

type
  TFrm4 = class(TForm)
    lbl1: TLabel;
    edtCaption: TEdit;
    lbl2: TLabel;
    edtSID: TEdit;
    pnl1: TPanel;
    stat1: TStatusBar;
    tv1: TTreeView;
    spl1: TSplitter;
    dbgrd1: TDBGrid;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    lbl3: TLabel;
    edtDescription: TEdit;
    btnDelete: TBitBtn;
    btnFileAdd: TBitBtn;
    btnFileEdit: TBitBtn;
    btnFileDelete: TBitBtn;
    chkCopyCaption: TCheckBox;
    dsUserFiles: TDataSource;
    dbnvgr1: TDBNavigator;
    procedure btnCloseClick(Sender: TObject);
    procedure edtCaptionChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnFileAddClick(Sender: TObject);
  private
    FUserFiles: TSAVAccessFilesDBF;
    procedure SetUserFiles(const Value: TSAVAccessFilesDBF);
    { Private declarations }
  public
    property UserFiles: TSAVAccessFilesDBF read FUserFiles write SetUserFiles;
    procedure FullAccess(const bParam: Boolean = True);
  end;

implementation
uses UAccessConstant, U10, ;

{$R *.dfm}

procedure TFrm4.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrm4.edtCaptionChange(Sender: TObject);
begin
  if (chkCopyCaption.Checked) and (edtSID.ReadOnly = False) then
    edtSID.Text := edtCaption.Text;
end;

procedure TFrm4.FullAccess(const bParam: Boolean);
begin
  btnFileAdd.Enabled := bParam;
  btnFileEdit.Enabled := bParam;
  btnFileDelete.Enabled := bParam;
  btnDelete.Enabled := bParam;
  pnl1.Enabled := bParam;
end;

procedure TFrm4.SetUserFiles(const Value: TSAVAccessFilesDBF);
begin
  FUserFiles := Value;
end;

procedure TFrm4.FormShow(Sender: TObject);
begin
  if Assigned(UserFiles) then
    dsUserFiles.DataSet := FUserFiles.DataSource;
end;

procedure TFrm4.btnFileAddClick(Sender: TObject);
var
  Frm02: TFrm10;
begin
  Frm02 := TFrm10.Create(Self);
  if Frm02.ShowModal = mrok then
  begin
    Frm02.edtSrvrFile.Text := AnsiLowerCase(Frm02.edtSrvrFile.Text);
    Frm02.cbb1.Text := AnsiUpperCase(Frm02.cbb1.Text);
    if dsUserFiles.DataSet.Locate(csFieldSrvrFile + ';' + csFieldType,
      VarArrayOf([Frm02.edtSrvrFile.Text, Frm02.cbb1.Text]), []) then
    begin
      if
        Application.MessageBox('Файл/каталог с таким именем уже существует. Заменить?',
        'Добавление файла/каталога', MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2)
        = IDYES then
      begin
        dsUserFiles.DataSet.Edit;

        dsUserFiles.DataSet.Post;
      end
    end
    else
    begin
      dsUserFiles.DataSet.Append;

      dsUserFiles.DataSet.Post;
    end;

  end;
  FreeAndNil(Frm02);
end;

end.

