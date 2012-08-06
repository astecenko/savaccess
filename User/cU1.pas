unit cU1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvTrayIcon, ActnList, StdActns, Menus, cUSettings,
  StdCtrls, Grids, DBGrids, DB, DBClient;

type
  TForm1 = class(TForm)
    jvTray: TJvTrayIcon;
    pmMain: TPopupMenu;
    N1: TMenuItem;
    actlst1: TActionList;
    actExit: TAction;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    mmo1: TMemo;
    btn1: TButton;
    ds1: TDataSource;
    dbgrd1: TDBGrid;
    ds2: TClientDataSet;
    procedure actExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses SAVLib_INI;

{$R *.dfm}

procedure TForm1.actExitExecute(Sender: TObject);
begin
  Application.Terminate
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Settings.Client.LoadFromFile(Settings.ConfigFile);
  ds1.DataSet := Settings.Client.DataSet;
  Settings.Client.Update;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
  Form1.Show;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
 { mmo1.Lines.Add(IncludeTrailingPathDelimiter(Settings.Client.UsersDir) +
    Settings.Client.SID);
  mmo1.Lines.Add(Settings.Client.Workstation);
  mmo1.Lines.Add(IncludeTrailingPathDelimiter(Settings.Client.DomainsDir) +
    Settings.Client.Domain);}
  SAVLib_INI.MergeINI('d:\test_client\test_main.ini','d:\1\TestBase\Domains\NEVZ\f\nevz_main.ini');

end;

end.

