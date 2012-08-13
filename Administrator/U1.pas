unit U1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPStyleActnCtrls, ActnList, ActnMan, ToolWin, ActnCtrls,
  ActnMenus, ComCtrls, StdActns, DB,
  VKDBFDataSet, ExtCtrls, Grids, DBGrids, ImgList, StdCtrls,
  DBCtrls, Buttons, CheckLst;

const
  csFrm1Caption = 'SAV Access - Администратор: ';
  csNotSave = 'Не сохранено*';

type
  TFrm1 = class(TForm)
    stat1: TStatusBar;
    actmmb1: TActionMainMenuBar;
    actmgr1: TActionManager;
    actCreateBase: TAction;
    flxt1: TFileExit;
    act1: TAction;
    actUserAdd: TAction;
    pgc1: TPageControl;
    tsUsers: TTabSheet;
    tsGroups: TTabSheet;
    dbgrdUser: TDBGrid;
    dbgrdGroup: TDBGrid;
    pnl1: TPanel;
    dbgrdDomain: TDBGrid;
    il1: TImageList;
    actBaseSaveAs: TAction;
    actUserDelete: TAction;
    actUserEdit: TAction;
    actUserShow: TAction;
    actGroupAdd: TAction;
    actGroupEdit: TAction;
    actGroupDelete: TAction;
    actGroupShow: TAction;
    actDomainAdd: TAction;
    actDomainEdit: TAction;
    actDomainDelete: TAction;
    actDomainShow: TAction;
    dlgOpen1: TOpenDialog;
    dlgSave1: TSaveDialog;
    dbmmoDESCR: TDBMemo;
    actTemplat: TAction;
    actBaseProperty: TAction;
    btnUserAdd: TBitBtn;
    btnUserDel: TBitBtn;
    pnl2: TPanel;
    spl1: TSplitter;
    pnl3: TPanel;
    chklstGroupUsers: TCheckListBox;
    pnl4: TPanel;
    pnl5: TPanel;
    spl2: TSplitter;
    chklstUserGroups: TCheckListBox;
    btnUserGoTo: TBitBtn;
    btnGroupAdd: TBitBtn;
    btnGroupDel: TBitBtn;
    btnGroupGoTo: TBitBtn;
    actExtDict: TAction;
    procedure actCreateBaseExecute(Sender: TObject);
    procedure actUserAddExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure act1Execute(Sender: TObject);
    procedure actBaseSaveAsExecute(Sender: TObject);
    procedure actDomainEditExecute(Sender: TObject);
    procedure actTemplatExecute(Sender: TObject);
    procedure actDomainAddExecute(Sender: TObject);
    procedure actUserEditExecute(Sender: TObject);
    procedure actBasePropertyExecute(Sender: TObject);
    procedure dbgrdUserDblClick(Sender: TObject);
    procedure actGroupAddExecute(Sender: TObject);
    procedure actGroupEditExecute(Sender: TObject);
    procedure btnUserAddClick(Sender: TObject);
    procedure btnUserDelClick(Sender: TObject);
    procedure chklstGroupUsersClickCheck(Sender: TObject);
    procedure dbgrdGroupDblClick(Sender: TObject);
    procedure dbgrdDomainDblClick(Sender: TObject);
    procedure btnUserGoToClick(Sender: TObject);
    procedure btnGroupGoToClick(Sender: TObject);
    procedure btnGroupDelClick(Sender: TObject);
    procedure actExtDictExecute(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  Frm1: TFrm1;

implementation
uses U3, U4, U5, U6, U7, U8, U9, U11, U12, DU1, UAccessConstant, UAccessFileDBF,
  UAccessGroup;

{$R *.dfm}

procedure TFrm1.actCreateBaseExecute(Sender: TObject);
var
  Frm01: TFrm8;
  list: array[1..5] of string;

  function CheckOnEmpty(const edit1, deftext: string): string;
  begin
    if Trim(edit1) = '' then
      Result := IncludeTrailingPathDelimiter(Settings.Base.StoragePath)
        + deftext
    else
      Result := edit1;
  end;

begin
  Frm01 := TFrm8.Create(Self);
  list[1] := Settings.Base.StoragePath;
  list[2] := Settings.Base.JournalsDir;
  list[3] := Settings.Base.UsersDir;
  list[4] := Settings.Base.GroupsDir;
  list[5] := Settings.Base.DomainsDir;
  if (Frm01.ShowModal = mrok) and (Frm01.edtBase.Text <> '') and
    (dlgSave1.Execute) then
  begin
    Settings.Base.StoragePath := Frm01.edtBase.Text;
    Settings.Base.JournalsDir := CheckOnEmpty(Frm01.edtJournals.Text,
      csDefJournalDir);
    Settings.Base.UsersDir := CheckOnEmpty(Frm01.edtUsers.Text, csDefUserDir);
    Settings.Base.GroupsDir := CheckOnEmpty(Frm01.edtGroups.Text,
      csDefGroupDir);
    Settings.Base.DomainsDir := CheckOnEmpty(Frm01.edtDomains.Text,
      csDefDomainDir);
    Settings.Base.SaveToFile(dlgSave1.FileName);
    if Settings.Base.CreateStorage then
    begin
      Settings.ConfigFile := dlgSave1.FileName;
      Frm1.Caption := csFrm1Caption + ExtractFileName(Settings.ConfigFile);
    end
    else
    begin
      Settings.Base.StoragePath := list[1];
      Settings.Base.JournalsDir := list[2];
      Settings.Base.UsersDir := list[3];
      Settings.Base.GroupsDir := list[4];
      Settings.Base.DomainsDir := list[5];
    end;
  end;
  FreeAndNil(Frm01);
end;

procedure TFrm1.actUserAddExecute(Sender: TObject);
var
  Frm01: TFrm6;
begin
  ShowMessage(Settings.Base.UsersDir);
  Frm01 := TFrm6.Create(Self);
  Frm01.FullAccess(False);
  Frm01.edtDomain.Text := Settings.Domain.SID;
  if (Frm01.ShowModal = mrok) and (Frm01.edtSID.Text <> '') then
  begin
    Settings.User.Clear;
    if Trim(Frm01.edtCaption.Text) = '' then
      Frm01.edtCaption.Text := Frm01.edtSID.Text;
    Settings.User.Open(Settings.Base, Frm01.edtCaption.Text,
      Frm01.edtSID.Text, Frm01.edtDescription.Text, Settings.Domain.SID);
    Settings.User.Save;
    Settings.Base.TableUsers.Close;
    Settings.Base.TableUsers.Open;
  end;
  FreeAndNil(Frm01);
end;

procedure TFrm1.FormCreate(Sender: TObject);
begin
  if (Settings.ConfigFile = '') or (FileExists(Settings.ConfigFile) = False)
    then
  begin
    Frm1.Caption := csFrm1Caption + csNotSave;
    pgc1.Visible := False;
    pnl1.Visible := False;
  end
  else
  begin
    Settings.Base.LoadFromFile(Settings.ConfigFile);
    Frm1.Caption := csFrm1Caption + ExtractFileName(Settings.ConfigFile);
    pgc1.Visible := True;
    pnl1.Visible := True;
  end;
end;

procedure TFrm1.act1Execute(Sender: TObject);
begin
  if dlgOpen1.Execute then
  begin
    Settings.Base.LoadFromFile(dlgOpen1.FileName);
    Settings.ConfigFile := dlgOpen1.FileName;
    Frm1.Caption := csFrm1Caption + ExtractFileName(Settings.ConfigFile);
  end;
end;

procedure TFrm1.actBaseSaveAsExecute(Sender: TObject);
begin
  if dlgSave1.Execute then
  begin
    Settings.Base.SaveToFile(dlgSave1.FileName);
    Settings.ConfigFile := dlgSave1.FileName;
    Frm1.Caption := csFrm1Caption + ExtractFileName(Settings.ConfigFile);
  end;
end;

procedure TFrm1.actDomainEditExecute(Sender: TObject);
var
  Frm01: TFrm4;
  UF01: TSAVAccessFilesDBF;
begin
  Frm01 := TFrm4.Create(Self);
  Frm01.FullAccess(True);
  UF01 := TSAVAccessFilesDBF.Create(Settings.Domain);
  Frm01.edtCaption.Text := Settings.Domain.Caption;
  Frm01.edtSID.Text := Settings.Domain.SID;
  Frm01.edtDescription.Text := Settings.Domain.Description;
  Frm01.edtSID.ReadOnly := True;
  Frm01.UserFiles := UF01;
  if Frm01.ShowModal = mrok then
  begin
    (* Settings.User.Clear;
     if Trim(Frm01.edtCaption.Text) = '' then
       Frm01.edtCaption.Text := Frm01.edtSID.Text;
     Settings.User.Open(Settings.Base, Frm01.edtCaption.Text,
       Frm01.edtSID.Text, Frm01.edtDescription.Text,Settings.Domain.SID);
     Settings.User.Save;
     dbgrdUser.DataSource.DataSet.Close;
     dbgrdUser.DataSource.DataSet.Open;*)
  end;
  FreeAndNil(Frm01);
  FreeAndNil(UF01);
end;

procedure TFrm1.actTemplatExecute(Sender: TObject);
var
  Frm01: TFrm9;
begin
  Frm01 := TFrm9.Create(Self);
  Frm01.ShowModal;
  FreeAndNil(Frm01);
end;

procedure TFrm1.actDomainAddExecute(Sender: TObject);
var
  Frm01: TFrm4;
begin
  Frm01 := TFrm4.Create(Self);
  Frm01.FullAccess(False);
  if (Frm01.ShowModal = mrok) and (Frm01.edtSID.Text <> '') then
  begin
    Settings.Domain.Clear;
    if Trim(Frm01.edtCaption.Text) = '' then
      Frm01.edtCaption.Text := Frm01.edtSID.Text;
    Settings.Domain.Open(Settings.Base, Frm01.edtCaption.Text,
      Frm01.edtSID.Text, Frm01.edtDescription.Text);
    Settings.Domain.Save;
    Settings.Base.TableDomains.Close;
    Settings.Base.TableDomains.Open;
  end;
  FreeAndNil(Frm01);
end;

procedure TFrm1.actUserEditExecute(Sender: TObject);
var
  Frm01: TFrm6;
  UF01: TSAVAccessFilesDBF;
begin
  Frm01 := TFrm6.Create(Self);
  Frm01.FullAccess(True);
  Frm01.edtDomain.Text := Settings.Domain.SID;
  UF01 := TSAVAccessFilesDBF.Create(Settings.User);
  Frm01.edtCaption.Text := Settings.User.Caption;
  Frm01.edtSID.Text := Settings.User.SID;
  Frm01.edtDescription.Text := Settings.User.Description;
  Frm01.edtSID.ReadOnly := True;
  Frm01.btnSelectUser.Enabled := False;
  Frm01.UserFiles := UF01;
  if Frm01.ShowModal = mrok then
  begin
    (* Settings.User.Clear;
     if Trim(Frm01.edtCaption.Text) = '' then
       Frm01.edtCaption.Text := Frm01.edtSID.Text;
     Settings.User.Open(Settings.Base, Frm01.edtCaption.Text,
       Frm01.edtSID.Text, Frm01.edtDescription.Text,Settings.Domain.SID);
     Settings.User.Save;
     dbgrdUser.DataSource.DataSet.Close;
     dbgrdUser.DataSource.DataSet.Open;*)
  end;
  FreeAndNil(Frm01);
  FreeAndNil(UF01);
end;

procedure TFrm1.actBasePropertyExecute(Sender: TObject);
var
  Form1: TForm;
  Memo1: TMemo;
begin
  Form1 := TForm.Create(Self);
  Form1.Width := 640;
  Form1.Height := 240;
  Form1.Position := poDesktopCenter;
  Memo1 := TMemo.Create(Form1);
  Memo1.Parent := Form1;
  Memo1.Align := alClient;
  Memo1.ReadOnly := True;
  Memo1.Font.Size := 13;
  Memo1.ScrollBars := ssBoth;
  Memo1.Lines.Add('Файл конфигурации: ' + Settings.ConfigFile);
  Memo1.Lines.Add('');
  Memo1.Lines.Add('--- ДИРЕКТОРИИ ---');
  Memo1.Lines.Add('Таблицы: ' + Settings.Base.JournalsDir);
  Memo1.Lines.Add('Домены: ' + Settings.Base.DomainsDir);
  Memo1.Lines.Add('Пользователи: ' + Settings.Base.UsersDir);
  Memo1.Lines.Add('Группы: ' + Settings.Base.GroupsDir);
  Memo1.Lines.Add('');
  Memo1.Lines.Add('Версия: ');
  Form1.ShowModal;
  FreeAndNil(Form1);
end;

procedure TFrm1.dbgrdUserDblClick(Sender: TObject);
begin
  actUserEdit.Execute;
end;

procedure TFrm1.actGroupAddExecute(Sender: TObject);
var
  Frm01: TFrm5;
begin
  Frm01 := TFrm5.Create(Self);
  Frm01.FullAccess(False);
  Frm01.edtSID.Hint :=
    'Если не заполнен, цифровой ID будет сгенерирован автоматически при добавлении';
  Frm01.edtSID.ShowHint := True;
  if Frm01.ShowModal = mrok then
  begin
    // dbgrdDomain.DataSource.DataSet.DisableControls;
    Settings.Group.Clear;
    if Trim(Frm01.edtCaption.Text) = '' then
      Frm01.edtCaption.Text := 'Новая группа';
    Settings.Group.Open(Settings.Base, Frm01.edtCaption.Text,
      Frm01.edtSID.Text, Frm01.edtDescription.Text, Frm01.sePriority.Text);
    Settings.Group.Save;
    Settings.Base.TableGroups.Close;
    Settings.Base.TableGroups.Open;
  end;
  FreeAndNil(Frm01);
end;

procedure TFrm1.actGroupEditExecute(Sender: TObject);
var
  Frm01: TFrm5;
  UF01: TSAVAccessFilesDBF;
begin
  Frm01 := TFrm5.Create(Self);
  Frm01.FullAccess(True);
  Frm01.sePriority.Value := Settings.Group.Priority;
  UF01 := TSAVAccessFilesDBF.Create(Settings.Group);
  Frm01.edtCaption.Text := Settings.Group.Caption;
  Frm01.edtSID.Text := Settings.Group.SID;
  Frm01.edtDescription.Text := Settings.Group.Description;
  Frm01.edtSID.ReadOnly := True;
  Frm01.UserFiles := UF01;
  if Frm01.ShowModal = mrok then
  begin
    (* Settings.User.Clear;
     if Trim(Frm01.edtCaption.Text) = '' then
       Frm01.edtCaption.Text := Frm01.edtSID.Text;
     Settings.User.Open(Settings.Base, Frm01.edtCaption.Text,
       Frm01.edtSID.Text, Frm01.edtDescription.Text,Settings.Domain.SID);
     Settings.User.Save;
     dbgrdUser.DataSource.DataSet.Close;
     dbgrdUser.DataSource.DataSet.Open;*)
  end;
  FreeAndNil(Frm01);
  FreeAndNil(UF01);
end;

procedure TFrm1.btnUserAddClick(Sender: TObject);
var
  Form01: TFrm11;
begin
  Form01 := TFrm11.Create(Self);
  Form01.vkdbfntx2.DBFFileName := Settings.Base.TableUsers.DBFFileName;
  Form01.vkdbfntx2.Open;
  if (Form01.ShowModal = mrOk) and (Form01.vkdbfntx2.RecNo > 0) then
  begin
    Settings.Group.UserAdd(Form01.vkdbfntx2.FieldByName(csFieldSID).AsString);
    Settings.Group.GetUsersSID(chklstGroupUsers, True);
  end;
  Form01.vkdbfntx2.Close;
  FreeAndNil(Form01);
end;

procedure TFrm1.btnUserDelClick(Sender: TObject);
begin
  if (chklstGroupUsers.ItemIndex > -1) and
    (Settings.Group.UserDelete(chklstGroupUsers.Items.ValueFromIndex[chklstGroupUsers.ItemIndex])) then
    chklstGroupUsers.DeleteSelected;
end;

procedure TFrm1.chklstGroupUsersClickCheck(Sender: TObject);
begin
  Settings.Group.UserSwitch(chklstGroupUsers.Items.ValueFromIndex[chklstGroupUsers.ItemIndex],
    chklstGroupUsers.Checked[chklstGroupUsers.ItemIndex]);
  Settings.Group.GetUsersSID(chklstGroupUsers, True);
end;

procedure TFrm1.dbgrdGroupDblClick(Sender: TObject);
begin
  actGroupEdit.Execute;
end;

procedure TFrm1.dbgrdDomainDblClick(Sender: TObject);
begin
  actDomainEdit.Execute;
end;

procedure TFrm1.btnUserGoToClick(Sender: TObject);
begin
  if (chklstGroupUsers.ItemIndex > -1) and
    (Settings.Base.TableUsers.Locate(csFieldSID,
    chklstGroupUsers.Items.ValueFromIndex[chklstGroupUsers.ItemIndex], [])) then
    pgc1.ActivePageIndex := 0;
end;

procedure TFrm1.btnGroupGoToClick(Sender: TObject);
begin
  if (chklstUserGroups.ItemIndex > -1) and
    (Settings.Base.TableGroups.Locate(csFieldSID,
    chklstUserGroups.Items.ValueFromIndex[chklstUserGroups.ItemIndex], [])) then
    pgc1.ActivePageIndex := 1;

end;

procedure TFrm1.btnGroupDelClick(Sender: TObject);
begin
  if (chklstUserGroups.ItemIndex > -1) and
    (Settings.User.GroupDelete(chklstUserGroups.Items.ValueFromIndex[chklstUserGroups.itemIndex])) then
    chklstUserGroups.DeleteSelected;
end;

procedure TFrm1.actExtDictExecute(Sender: TObject);
var
  Form01:TFrm12;
begin
Form01:=TFrm12.Create(Self);
Form01.vkdbfExt.DBFFileName:=IncludeTrailingPathDelimiter(Settings.Base.JournalsDir)+csExtTable;
Form01.vkdbfAct.DBFFileName:=IncludeTrailingPathDelimiter(Settings.Base.JournalsDir)+csActionTable;
Form01.ShowModal;
FreeAndNil(Form01);

end;

end.

