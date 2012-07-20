unit U1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPStyleActnCtrls, ActnList, ActnMan, ToolWin, ActnCtrls,
  ActnMenus, ComCtrls, StdActns, DB,
  VKDBFDataSet, ExtCtrls, Grids, DBGrids, ImgList, StdCtrls,
  DBCtrls;

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
    ts1: TTabSheet;
    ts2: TTabSheet;
    ts3: TTabSheet;
    dbgrdUser: TDBGrid;
    dbgrdGroup: TDBGrid;
    dbgrd1: TDBGrid;
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
    dbnvgr1: TDBNavigator;
    dbmmoDESCR: TDBMemo;
    actTemplat: TAction;
    procedure actCreateBaseExecute(Sender: TObject);
    procedure actUserAddExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure act1Execute(Sender: TObject);
    procedure actBaseSaveAsExecute(Sender: TObject);
    procedure actDomainEditExecute(Sender: TObject);
    procedure actTemplatExecute(Sender: TObject);
    procedure actDomainAddExecute(Sender: TObject);
    procedure actUserEditExecute(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  Frm1: TFrm1;

implementation
uses U3, U4, U5, U6, U7, U8, U9, DU1, UAccessConstant,UAccessFileDBF;

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
  //  Frm2.Show;
  ShowMessage(Settings.Base.UsersDir);
  Frm01 := TFrm6.Create(Self);
  Frm01.FullAccess(False);
  Frm01.edtDomain.Text:=Settings.Domain.SID;
  if (Frm01.ShowModal = mrok) and (Frm01.edtSID.Text <> '') then
  begin
    // dbgrdDomain.DataSource.DataSet.DisableControls;
    Settings.User.Clear;
    if Trim(Frm01.edtCaption.Text) = '' then
      Frm01.edtCaption.Text := Frm01.edtSID.Text;
    Settings.User.Open(Settings.Base, Frm01.edtCaption.Text,
      Frm01.edtSID.Text, Frm01.edtDescription.Text,Settings.Domain.SID);
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

begin
  Frm01 := TFrm4.Create(Self);
  Frm01.pnl1.Enabled := True;

  if Frm01.ShowModal = mrok then
  begin

  end;
  FreeAndNil(Frm01);

end;

procedure TFrm1.actTemplatExecute(Sender: TObject);
var
  Frm01: TFrm9;
begin
  Frm01 := TFrm9.Create(Self);
  Frm01.ShowModal;
  FreeAndNil(Frm01);
  (*  Templ1 :=
      TPathTemplate.Create(IncludeTrailingPathDelimiter(MainBase.JournalsDir) +
      'Main.tpl');
    Templ1.WritePattern('1','',$001A,'{3EB685DB-65F9-4CF6-A03A-E3EF65729F3D}');
    Templ1.WritePattern('2','',$0007,'{B97D20BB-F46A-4C97-BA10-5E3608430854}');
    Templ1.WritePattern('3','D:\LWS');
    Templ1.Save;
    FreeAndNil(Templ1); *)
end;

procedure TFrm1.actDomainAddExecute(Sender: TObject);
var
  Frm01: TFrm4;
begin
  Frm01 := TFrm4.Create(Self);
  Frm01.FullAccess(False);
  if (Frm01.ShowModal = mrok) and (Frm01.edtSID.Text <> '') then
  begin
    // dbgrdDomain.DataSource.DataSet.DisableControls;
    Settings.Domain.Clear;
    if Trim(Frm01.edtCaption.Text) = '' then
      Frm01.edtCaption.Text := Frm01.edtSID.Text;
    Settings.Domain.Open(Settings.Base, Frm01.edtCaption.Text,
      Frm01.edtSID.Text, Frm01.edtDescription.Text);
    Settings.Domain.Save;
    //dbgrdDomain.DataSource.DataSet.EnableControls;
    //DU1.dtmdl1.vkdbfDomain.UpdateCursorPos;
    //Application.ProcessMessages;
    Settings.Base.TableDomains.Close;
    Settings.Base.TableDomains.Open;
  end;
  FreeAndNil(Frm01);
end;

procedure TFrm1.actUserEditExecute(Sender: TObject);
var
  Frm01: TFrm6;
  UF01:TSAVAccessFilesDBF;
begin
  //  Frm2.Show;
  Frm01 := TFrm6.Create(Self);
  Frm01.FullAccess(True);
  Frm01.edtDomain.Text:=Settings.Domain.SID;
  UF01:=TSAVAccessFilesDBF.Create(Settings.User);
  Frm01.edtCaption.Text:=Settings.User.Caption;
  Frm01.edtSID.Text:=Settings.User.SID;
  Frm01.edtDescription.Text:=Settings.User.Description;
  Frm01.edtSID.ReadOnly:=True;
  Frm01.btnSelectUser.Enabled:=False;
  Frm01.UserFiles:=UF01;
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

end.

