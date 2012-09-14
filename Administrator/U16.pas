unit U16;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrm16 = class(TForm)
    edt1: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    edt2: TEdit;
    btnAdd: TButton;
    bvl1: TBevel;
    lstUser: TListBox;
    btnDel: TButton;
    btnSaveAs: TButton;
    btnOpen: TButton;
    lblChanged: TLabel;
    dlgOpen1: TOpenDialog;
    dlgSave1: TSaveDialog;
    btnSave: TButton;
    lblFileName: TLabel;
    btnNew: TButton;
    procedure btnAddClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveAsClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
  private

  public
    procedure OpenFFileName;
  end;

implementation
uses md5, UAccessConstant;

{$R *.dfm}

procedure TFrm16.btnAddClick(Sender: TObject);
var
  sLogin, sPasw: string;
begin
  sLogin := AnsiLowerCase(Trim(edt1.Text));
  if (sLogin <> '') and (edt2.Text <> '') then
  begin
    if lstUser.Items.Values[sLogin] = '' then
    begin
      sPasw := md5.MD5DigestToStr(MD5String(edt2.Text));
      lstUser.Items.Add(sLogin + '=' + sPasw);
      lblChanged.Enabled := True;
      btnSave.Enabled := lblFileName.Caption <> '';
    end
    else
      ShowMessage('ѕользователь ' + sLogin + ' уже существует');
  end
  else
    ShowMessage('ѕол€ "логин" и "пароль" не могут быть пустыми!');
end;

procedure TFrm16.btnOpenClick(Sender: TObject);
begin
  if dlgOpen1.Execute then
  begin
    try
      lstUser.Items.LoadFromFile(dlgOpen1.FileName);
      lblChanged.Enabled := False;
      lblFileName.Caption := dlgOpen1.FileName;
      btnSave.Enabled := lblFileName.Caption <> '';
    except
      ShowMessage(UAccessConstant.csOpenError + dlgOpen1.FileName);
    end;
  end;
end;

procedure TFrm16.btnSaveAsClick(Sender: TObject);
begin
  if dlgSave1.Execute then
    try
      lstUser.Items.SaveToFile(dlgSave1.FileName);
      lblChanged.Enabled := False;
      lblFileName.Caption := dlgSave1.FileName;
      btnSave.Enabled := lblFileName.Caption <> '';
    except
      ShowMessage('Ќевозможно сохранить ' + dlgSave1.FileName)
    end;
end;

procedure TFrm16.btnDelClick(Sender: TObject);
begin
  if lstUser.ItemIndex > -1 then
  begin
    lstUser.DeleteSelected;
    lblChanged.Enabled := True;
    btnSave.Enabled := lblFileName.Caption <> '';
  end;
end;

procedure TFrm16.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if lblChanged.Enabled then
    CanClose :=
      Application.MessageBox('¬ы уверены что хотите закрыть окно, с потерей всех не сохраненных изменений?',
      '≈сть не сохраненные изменени€', MB_YESNOCANCEL + MB_ICONWARNING +
      MB_DEFBUTTON2) = IDYES;
end;

procedure TFrm16.FormShow(Sender: TObject);
begin
  OpenFFileName;
end;

procedure TFrm16.btnSaveClick(Sender: TObject);
begin
  try
    lstUser.Items.SaveToFile(lblFileName.Caption);
    lblChanged.Enabled:=False;
    btnSave.Enabled:=False;
  except
    ShowMessage(csSaveError+lblFileName.Caption);
  end;
end;

procedure TFrm16.OpenFFileName;
begin
  if lblFileName.Caption <> '' then
    try
      lstUser.Items.LoadFromFile(lblFileName.Caption);
    except
      ShowMessage(UAccessConstant.csOpenError + lblFileName.Caption);
    end;
end;

procedure TFrm16.btnNewClick(Sender: TObject);
begin
lstUser.Clear;
lblFileName.Caption:='';
lblChanged.Enabled:=False;
btnSave.Enabled:=False;
end;

end.

