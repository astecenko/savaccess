unit U4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, ComCtrls, StdCtrls, Buttons,
  UAccessFileDBF,
  DB, DBCtrls, ActnList;

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
    dlgOpen1: TOpenDialog;
    actlst1: TActionList;
    actFileEdit: TAction;
    actFileAdd: TAction;
    actFileDelete: TAction;
    procedure btnCloseClick(Sender: TObject);
    procedure edtCaptionChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actFileEditExecute(Sender: TObject);
    procedure actFileAddExecute(Sender: TObject);
    procedure actFileDeleteExecute(Sender: TObject);
  private
    FUserFiles: TSAVAccessFilesDBF;
    FFilesDirectory: string;
    procedure SetUserFiles(const Value: TSAVAccessFilesDBF);
    { Private declarations }
  public
    property UserFiles: TSAVAccessFilesDBF read FUserFiles write SetUserFiles;
    property FilesDirectory: string read FFilesDirectory;
    procedure FullAccess(const bParam: Boolean = True);
    // procedure AddFileToTable
  end;

implementation
uses UAccessConstant, U10, KoaUtils;

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
  begin
    dsUserFiles.DataSet := FUserFiles.DataSource;
    FFilesDirectory := IncludeTrailingPathDelimiter(FUserFiles.Container.WorkDir)
      + 'f\';
  end;

end;

procedure TFrm4.actFileEditExecute(Sender: TObject);
var
  Frm02: TFrm10;
begin
  Frm02 := TFrm10.Create(Self);
  Frm02.UserFiles := Self.UserFiles;
  Frm02.edtSrvrFile.Text :=
    dsUserFiles.DataSet.fieldbyname(csFieldSrvrFile).AsString;
  Frm02.edtClntFile.Text :=
    dsUserFiles.DataSet.fieldbyname(csFieldClntFile).AsString;
  Frm02.edtExt.Text := dsUserFiles.DataSet.fieldbyname(csFieldExt).AsString;
  Frm02.edtMD5.Text := dsUserFiles.DataSet.fieldbyname(csFieldMD5).AsString;
  Frm02.edtDescr.Text :=
    dsUserFiles.DataSet.fieldbyname(csFieldDescription).AsString;
  Frm02.cbbType.Text := dsUserFiles.DataSet.fieldbyname(csFieldType).AsString;
  Frm02.seAction.Value :=
    dsUserFiles.DataSet.fieldbyname(csFieldAction).AsInteger;
  Frm02.edtVersion.Text:=dsUserFiles.DataSet.FieldByName(csFieldVersion).AsString;  
  if Frm02.ShowModal = mrok then
  begin
    Frm02.edtSrvrFile.Text := AnsiLowerCase(Frm02.edtSrvrFile.Text);
    Frm02.cbbType.Text := AnsiUpperCase(Frm02.cbbType.Text);
    dsUserFiles.DataSet.Edit;
    dsUserFiles.DataSet.fieldbyname(csFieldSrvrFile).AsString :=
      Frm02.edtSrvrFile.Text;
    dsUserFiles.DataSet.fieldbyname(csFieldClntFile).AsString :=
      Frm02.edtClntFile.Text;
    dsUserFiles.DataSet.fieldbyname(csFieldExt).AsString := Frm02.edtExt.Text;
    dsUserFiles.DataSet.fieldbyname(csFieldMD5).AsString := Frm02.edtMD5.Text;
    dsUserFiles.DataSet.fieldbyname(csFieldDescription).AsString :=
      Frm02.edtDescr.Text;
    dsUserFiles.DataSet.fieldbyname(csFieldType).AsString := Frm02.cbbType.Text;
    dsUserFiles.DataSet.fieldbyname(csFieldAction).AsInteger :=
      Frm02.seAction.Value;
    dsUserFiles.DataSet.FieldByName(csFieldVersion).AsString:=UserFiles.Container.GetNewVersion;
    dsUserFiles.DataSet.Post;
  end;
  FreeAndNil(Frm02);
end;

procedure TFrm4.actFileAddExecute(Sender: TObject);
var
  i: Integer;
  s: string;
  s2: string;
begin
  if dlgOpen1.Execute then
  begin
    i := 0;
    while i < dlgOpen1.Files.Count do
    begin
      s := AnsiLowerCase(ExtractFileName(dlgOpen1.Files[i]));
      if dsUserFiles.DataSet.Locate(csFieldSrvrFile, s, []) then
      begin
        DateTimeToString(s2, 'yymmddhhnn', Now);
        case
          Application.MessageBox(PAnsiChar('Файл/каталог с именем ' + s +
          ' уже существует.'
          + #13#10#13#10 + 'Да - перезаписать файл' + #13#10 +
          'Нет - добавить с уникальным именем' + s2 + s + #13#10 +
          'Отмена - пропустить'), 'Файл уже есть в базе!', MB_YESNOCANCEL +
          MB_ICONWARNING + MB_DEFBUTTON2) of
          IDYES:
            begin
              try
                fDeleteFile(FilesDirectory + s);
                fCopyFile(dlgOpen1.Files[i], FilesDirectory + s);
              except
                ShowMessage('Ошибка при обработке файла "' + s + '"'#10#13 +
                  SysErrorMessage(GetLastError));
              end;
              UserFiles.UpdateFile;
            end;
          IDNO:
            begin
              if UserFiles.AppendAndCopyFile(dlgOpen1.Files[i], s2 + s) = False
                then
                ShowMessage('Ошибка при обработке файла "' + dlgOpen1.Files[i] +
                  '"'#10#13 + SysErrorMessage(GetLastError));
            end;
        end;
      end
      else if UserFiles.AppendAndCopyFile(dlgOpen1.Files[i]) = False then
        ShowMessage('Ошибка при обработке файла "' + dlgOpen1.Files[i] +
          '"'#10#13 + SysErrorMessage(GetLastError));
      Inc(i);
    end;
  end;
  {Frm02 := TFrm10.Create(Self);
  Frm02.UserFiles:=Self.UserFiles;
  if Frm02.ShowModal = mrok then
  begin
    Frm02.edtSrvrFile.Text := AnsiLowerCase(Frm02.edtSrvrFile.Text);
    Frm02.cbbType.Text := AnsiUpperCase(Frm02.cbbType.Text);
    if dsUserFiles.DataSet.Locate(csFieldSrvrFile + ';' + csFieldType,
      VarArrayOf([Frm02.edtSrvrFile.Text, Frm02.cbbType.Text]), []) then
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
  FreeAndNil(Frm02);   }
end;

procedure TFrm4.actFileDeleteExecute(Sender: TObject);
begin
  if
    Application.MessageBox('Вы уверены в необходимости удаления файла/каталога из базы?',
    'Удаление файла/каталога', MB_YESNOCANCEL + MB_ICONWARNING +
    MB_DEFBUTTON2) = IDYES then
    UserFiles.DeleteFile;
end;

end.

