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
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    dsUserFilesReverse: TDataSource;
    dbgrd2: TDBGrid;
    procedure btnCloseClick(Sender: TObject);
    procedure edtCaptionChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actFileEditExecute(Sender: TObject);
    procedure actFileAddExecute(Sender: TObject);
    procedure actFileDeleteExecute(Sender: TObject);
    procedure dbgrd1EditButtonClick(Sender: TObject);
    procedure dsUserFilesStateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dsUserFilesReverseStateChange(Sender: TObject);
  private
    FUserFiles: TSAVAccessFilesDBF;
    FDataSetUpdated: Boolean;
    FRDataSetUpdated: Boolean;
    FDomainSID: string;
    FUserSID: string;
    FGroupSID: string;
    procedure SetUserFiles(const Value: TSAVAccessFilesDBF);
    procedure SetDataSetUpdated(const Value: Boolean);
    procedure SetDomainSID(const Value: string);
    procedure SetGroupSID(const Value: string);
    procedure SetUserSID(const Value: string);
    procedure SetRDataSetUpdated(const Value: Boolean);
  public
    property UserFiles: TSAVAccessFilesDBF read FUserFiles write SetUserFiles;
    property DataSetUpdated: Boolean read FDataSetUpdated write
      SetDataSetUpdated;
    property RDataSetUpdated: Boolean read FRDataSetUpdated write
      SetRDataSetUpdated;
    property DomainSID: string read FDomainSID write SetDomainSID;
    property UserSID: string read FUserSID write SetUserSID;
    property GroupSID: string read FGroupSID write SetGroupSID;
    procedure FullAccess(const bParam: Boolean = True);
    function ActiveDataSet: TDataSet;
  end;

implementation
uses UAccessConstant, U10, KoaUtils, U12, SAVLib;

{$R *.dfm}

procedure TFrm4.btnCloseClick(Sender: TObject);
begin
  Close;

end;

procedure TFrm4.edtCaptionChange(Sender: TObject);
begin
  if (chkCopyCaption.Checked) and (edtSID.ReadOnly = False) then
    edtSID.Text := SAVLib.TranslitRus2Lat(edtCaption.Text);
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
    dsUserFilesReverse.DataSet := FUserFiles.RDataSource;
  end;
  FDataSetUpdated := False;
  FRDataSetUpdated := False;
end;

procedure TFrm4.actFileEditExecute(Sender: TObject);
var
  Frm02: TFrm10;
  ActiveDS: TDataSet;
begin
  Frm02 := TFrm10.Create(Self);
  Frm02.UserFiles := Self.UserFiles;
  ActiveDS := ActiveDataSet;
  Frm02.edtSrvrFile.Text :=
    ActiveDS.fieldbyname(csFieldSrvrFile).AsString;
  Frm02.edtClntFile.Text :=
    ActiveDS.fieldbyname(csFieldClntFile).AsString;
  Frm02.edtExt.Text := ActiveDS.fieldbyname(csFieldExt).AsString;
  Frm02.edtMD5.Text := ActiveDS.fieldbyname(csFieldMD5).AsString;
  Frm02.edtDescr.Text := ActiveDS.fieldbyname(csFieldDescription).AsString;
  Frm02.cbbType.Text := ActiveDS.fieldbyname(csFieldType).AsString;
  Frm02.seAction.Value := ActiveDS.fieldbyname(csFieldAction).AsInteger;
  Frm02.sePriority.Value := ActiveDS.fieldbyname(csFieldPrority).AsInteger;
  Frm02.edtVersion.Text := ActiveDS.FieldByName(csFieldVersion).AsString;
  if Frm02.ShowModal = mrok then
  begin
    Frm02.edtSrvrFile.Text := AnsiLowerCase(Frm02.edtSrvrFile.Text);
    Frm02.cbbType.Text := AnsiUpperCase(Frm02.cbbType.Text);
    ActiveDS.Edit;
    ActiveDS.fieldbyname(csFieldSrvrFile).AsString := Frm02.edtSrvrFile.Text;
    ActiveDS.fieldbyname(csFieldClntFile).AsString := Frm02.edtClntFile.Text;
    ActiveDS.fieldbyname(csFieldExt).AsString := Frm02.edtExt.Text;
    ActiveDS.fieldbyname(csFieldMD5).AsString := Frm02.edtMD5.Text;
    ActiveDS.fieldbyname(csFieldDescription).AsString := Frm02.edtDescr.Text;
    ActiveDS.fieldbyname(csFieldType).AsString := Frm02.cbbType.Text;
    ActiveDS.fieldbyname(csFieldAction).AsInteger := Frm02.seAction.Value;
    ActiveDS.fieldbyname(csFieldPrority).AsInteger := Frm02.sePriority.Value;
    ActiveDS.FieldByName(csFieldVersion).AsString :=
      UserFiles.Container.GetNewVersion;
    ActiveDS.Post;
    // UserFiles.Container.UpdateVersion;
  end;
  FreeAndNil(Frm02);
end;

procedure TFrm4.actFileAddExecute(Sender: TObject);
var
  i: Integer;
  s: string;
  s2: string;
  b: Boolean;
  aDs:TDataSet;
begin
  b := False;
  if dlgOpen1.Execute then
  begin
    i := 0;
    aDs:=ActiveDataSet;
    while i < dlgOpen1.Files.Count do
    begin
      s := AnsiLowerCase(ExtractFileName(dlgOpen1.Files[i]));
      if aDs.Locate(csFieldSrvrFile, s, []) then
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
                fDeleteFile(UserFiles.FileDir + s);
                fCopyFile(dlgOpen1.Files[i], UserFiles.FileDir + s);
                b := True;
              except
                ShowMessage('Ошибка при обработке файла "' + s + '"'#10#13 +
                  SysErrorMessage(GetLastError));
              end;
              UserFiles.UpdateFile(aDs);
            end;
          IDNO:
            begin
              if UserFiles.AppendAndCopyFile(aDs,dlgOpen1.Files[i], s2 + s) = False
                then
                ShowMessage('Ошибка при обработке файла "' + dlgOpen1.Files[i] +
                  '"'#10#13 + SysErrorMessage(GetLastError))
              else
                b := True;
            end;
        end;
      end
      else
      begin
        if UserFiles.AppendAndCopyFile(aDs, dlgOpen1.Files[i]) = False then
          ShowMessage('Ошибка при обработке файла "' + dlgOpen1.Files[i] +
            '"'#10#13 + SysErrorMessage(GetLastError))
        else
          b := True;
      end;
      Inc(i);
    end;
  end;
  // if b then UserFiles.Container.UpdateVersion;
end;

procedure TFrm4.actFileDeleteExecute(Sender: TObject);
begin
  if
    Application.MessageBox('Вы уверены в необходимости удаления файла/каталога из базы?',
    'Удаление файла/каталога', MB_YESNOCANCEL + MB_ICONWARNING +
    MB_DEFBUTTON2) = IDYES then
    UserFiles.DeleteFile(ActiveDataSet);
end;

procedure TFrm4.dbgrd1EditButtonClick(Sender: TObject);
var
  Form03: TFrm12;
begin
  if dbgrd1.SelectedField.FieldName = csFieldAction then
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
      if dbgrd1.DataSource.DataSet.FieldByName(csFieldExt).AsString <> '' then
        dbgrd1.DataSource.DataSet.FieldByName(csFieldExt).AsString :=
          Form03.vkdbfExt.FieldByName(csFieldExt).AsString;
      if dbgrd1.DataSource.DataSet.FieldByName(csFieldAction).AsString <> ''
        then
        dbgrd1.DataSource.DataSet.FieldByName(csFieldAction).AsString :=
          Form03.vkdbfAct.FieldByName(csFieldAction).AsString;
    end;
    FreeAndNil(Form03);
  end;
end;

procedure TFrm4.dsUserFilesStateChange(Sender: TObject);
begin
  if dsUserFiles.State in [dsInsert, dsEdit] then
    DataSetUpdated := True;
end;

procedure TFrm4.SetDataSetUpdated(const Value: Boolean);
begin
  FDataSetUpdated := Value;
end;

procedure TFrm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetUpdated or RDataSetUpdated then
    UserFiles.Container.UpdateVersion;
end;

procedure TFrm4.SetDomainSID(const Value: string);
begin
  FDomainSID := Value;
end;

procedure TFrm4.SetGroupSID(const Value: string);
begin
  FGroupSID := Value;
end;

procedure TFrm4.SetUserSID(const Value: string);
begin
  FUserSID := Value;
end;

procedure TFrm4.FormCreate(Sender: TObject);
begin
  FUserSID := '';
  FDomainSID := '';
  FGroupSID := '';
end;

function TFrm4.ActiveDataSet: TDataSet;
begin
  if pgc1.TabIndex = 0 then
    Result := UserFiles.DataSource
  else
    Result := UserFiles.RDataSource;
end;

procedure TFrm4.SetRDataSetUpdated(const Value: Boolean);
begin
  FRDataSetUpdated := Value;
end;

procedure TFrm4.dsUserFilesReverseStateChange(Sender: TObject);
begin
  if dsUserFilesReverse.State in [dsInsert, dsEdit] then
    RDataSetUpdated := True;
end;

end.

