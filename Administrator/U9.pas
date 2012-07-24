unit U9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ExtCtrls, Buttons;

type
  TFrm9 = class(TForm)
    edtTestInput: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    btnTest: TButton;
    lst1: TListBox;
    edtCaption: TEdit;
    edtNewWind: TEdit;
    seOldWind: TSpinEdit;
    edtPath: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    edtPattern: TEdit;
    btnAdd: TButton;
    btnDel: TButton;
    btnSaveFile: TBitBtn;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    lbl8: TLabel;
    edtPatternBegin: TEdit;
    lbl9: TLabel;
    edtPatternEnd: TEdit;
    bvl1: TBevel;
    bvl2: TBevel;
    edtTestResult: TMemo;
    procedure btnTestClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lst1Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveFileClick(Sender: TObject);
    procedure lst1DblClick(Sender: TObject);
    procedure edtPatternBeginChange(Sender: TObject);
    procedure edtPatternEndChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses UAccessPattern, UAccessConstant,U7;
var
  Templ1: TPathTemplate;
{$R *.dfm}

procedure TFrm9.btnTestClick(Sender: TObject);

begin
edtTestResult.Text:=Templ1.GetPath(edtTestInput.Text);
end;

procedure TFrm9.FormCreate(Sender: TObject);
begin
  Templ1 :=
    TPathTemplate.Create(IncludeTrailingPathDelimiter(Settings.Base.JournalsDir) +
    csTemplateMain);
  Templ1.GetPatterns(lst1.Items);
  edtPatternBegin.Text:=Templ1.PatternBegin;
  edtPatternEnd.Text:=Templ1.PatternEnd;

end;

procedure TFrm9.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FreeAndNil(Templ1);
end;

procedure TFrm9.lst1Click(Sender: TObject);
begin
Templ1.Pattern:=lst1.Items[lst1.itemindex];
edtCaption.Text:=Templ1.Caption;
edtNewWind.Text:=Templ1.NewWindows;
edtPath.Text:=Templ1.Path;
edtPattern.Text:=Templ1.Pattern;
seOldWind.Value:=Templ1.OldWindows;
end;

procedure TFrm9.btnAddClick(Sender: TObject);
begin
Templ1.WritePattern(edtPattern.Text,edtCaption.Text,edtPath.Text, seOldWind.Value,edtNewWind.Text);
Templ1.GetPatterns(lst1.Items);
end;

procedure TFrm9.btnDelClick(Sender: TObject);
begin
Templ1.DeletePattern(lst1.Items[lst1.itemindex]);
Templ1.GetPatterns(lst1.Items);
end;

procedure TFrm9.btnSaveClick(Sender: TObject);
begin
Templ1.WritePattern(lst1.Items[lst1.itemindex],edtCaption.Text,edtPath.Text, seOldWind.Value,edtNewWind.Text);
Templ1.GetPatterns(lst1.Items);
end;

procedure TFrm9.btnSaveFileClick(Sender: TObject);
begin
Templ1.Save;
end;

procedure TFrm9.lst1DblClick(Sender: TObject);
begin
edtTestInput.Text:=edtTestInput.Text+Templ1.PatternBegin+lst1.Items[lst1.itemindex]+Templ1.PatternEnd;
end;

procedure TFrm9.edtPatternBeginChange(Sender: TObject);
begin
Templ1.PatternBegin:=edtPatternBegin.Text;
end;

procedure TFrm9.edtPatternEndChange(Sender: TObject);
begin
Templ1.PatternEnd:=edtPatternEnd.Text;
end;

procedure TFrm9.FormResize(Sender: TObject);
begin
if Width<490 then Width:=490;
if Height<340 then Height:=340;
end;

end.

