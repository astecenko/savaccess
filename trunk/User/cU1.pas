unit cU1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvTrayIcon, ActnList, StdActns, Menus,cUSettings;

type
  TForm1 = class(TForm)
    jvTray: TJvTrayIcon;
    pmMain: TPopupMenu;
    N1: TMenuItem;
    actlst1: TActionList;
    actExit: TAction;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure actExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.actExitExecute(Sender: TObject);
begin
Application.Terminate
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Settings.Base.LoadFromFile(Settings.ConfigFile);
end;

end.
