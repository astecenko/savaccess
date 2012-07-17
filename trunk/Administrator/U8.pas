unit U8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFrm8 = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    edtBase: TEdit;
    edtJournals: TEdit;
    edtDomains: TEdit;
    edtUsers: TEdit;
    edtGroups: TEdit;
    lbl6: TLabel;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    btn5: TButton;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses FileCtrl;
{$R *.dfm}

function SelDirectoryPath: string;
var
  s: string;
begin
  s := '';
  SelectDirectory(s, [sdAllowCreate, sdPerformCreate, sdPrompt], 0);
  Result := s;
end;

procedure TFrm8.btn1Click(Sender: TObject);
begin
  edtBase.Text := SelDirectoryPath;
end;

procedure TFrm8.btn2Click(Sender: TObject);
begin
  edtJournals.Text := SelDirectoryPath;
end;

procedure TFrm8.btn3Click(Sender: TObject);
begin
  edtDomains.Text := SelDirectoryPath;
end;

procedure TFrm8.btn4Click(Sender: TObject);
begin
  edtUsers.Text := SelDirectoryPath;
end;

procedure TFrm8.btn5Click(Sender: TObject);
begin
  edtGroups.Text := SelDirectoryPath;
end;

end.

