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
  private
    FUserFiles: TSAVAccessFilesDBF;
    FDataSetUpdated: Boolean;
    FDomainSID: string;
    FUserSID: string;
    FGroupSID: string;
    procedure SetUserFiles(const Value: TSAVAccessFilesDBF);
    procedure SetDataSetUpdated(const Value: Boolean);
    procedure SetDomainSID(const Value: string);
    procedure SetGroupSID(const Value: string);
    procedure SetUserSID(const Value: string);
  public
    property UserFiles: TSAVAccessFilesDBF read FUserFiles write SetUserFiles;
    property DataSetUpdated: Boolean read FDataSetUpdated write
      SetDataSetUpdated;
    property DomainSID: string read FDomainSID write SetDomainSID;
    property UserSID: string read FUserSID write SetUserSID;
    property GroupSID: string read FGroupSID write SetGroupSID;
    procedure FullAccess(const bParam: Boolean = True);
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
    dsUserFiles.DataSet := FUserFiles.DataSource;
  FDataSetUpdated := False;
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
  Frm02.sePriority.Value :=
    dsUserFiles.DataSet.fieldbyname(csFieldPrority).AsInteger;
  Frm02.edtVersion.Text :=
    dsUserFiles.DataSet.FieldByName(csFieldVersion).AsString;

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
    dsUserFiles.DataSet.fieldbyname(csFieldPrority).AsInteger :=
      Frm02.sePriority.Value;
    dsUserFiles.DataSet.FieldByName(csFieldVersion).AsString :=
      UserFiles.Container.GetNewVersion;
    dsUserFiles.DataSet.Post;
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
begin
  b := False;
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
          Application.MessageBox(PAnsiChar('����/������� � ������ ' + s +
          ' ��� ����������.'
          + #13#10#13#10 + '�� - ������������ ����' + #13#10 +
          '��� - �������� � ���������� ������' + s2 + s + #13#10 +
          '������ - ����������'), '���� ��� ���� � ����!', MB_YESNOCANCEL +
          MB_ICONWARNING + MB_DEFBUTTON2) of
          IDYES:
            begin
              try
                fDeleteFile(UserFiles.FileDir + s);
                fCopyFile(dlgOpen1.Files[i], UserFiles.FileDir + s);
                b := True;
              except
                ShowMessage('������ ��� ��������� ����� "' + s + '"'#10#13 +
                  SysErrorMessage(GetLastError));
              end;
              UserFiles.UpdateFile;
            end;
          IDNO:
            begin
              if UserFiles.AppendAndCopyFile(dlgOpen1.Files[i], s2 + s) = False
                then
                ShowMessage('������ ��� ��������� ����� "' + dlgOpen1.Files[i] +
                  '"'#10#13 + SysErrorMessage(GetLastError))
              else
                b := True;
            end;
        end;
      end
      else
      begin
        if UserFiles.AppendAndCopyFile(dlgOpen1.Files[i]) = False then
          ShowMessage('������ ��� ��������� ����� "' + dlgOpen1.Files[i] +
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
    Application.MessageBox('�� ������� � ������������� �������� �����/�������� �� ����?',
    '�������� �����/��������', MB_YESNOCANCEL + MB_ICONWARNING +
    MB_DEFBUTTON2) = IDYES then
    UserFiles.DeleteFile;
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
  if DataSetUpdated then
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

end.

