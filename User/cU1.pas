unit cU1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvTrayIcon, ActnList, StdActns, Menus, cUSettings,
  StdCtrls, Grids, DBGrids, DB, DBClient, IdBaseComponent, IdComponent,
  IdTCPServer, ExtCtrls;

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
    ds1: TDataSource;
    ds2: TClientDataSet;
    idtcpsrvr1: TIdTCPServer;
    procedure actExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure idtcpsrvr1cmdhUpdateCommand(ASender: TIdCommand);
    procedure idtcpsrvr1cmdhLastCommand(ASender: TIdCommand);
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
  Settings.Init;
  Settings.Client.LoadFromFile(Settings.ConfigFile);
  ds1.DataSet := Settings.Client.DataSet;
  Settings.InUpdating := True;
  Settings.Client.Update;
  Settings.LastUpdate:=Now;
  Settings.InUpdating := False;
  Application.Terminate;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
  Form1.Show;
end;

procedure TForm1.idtcpsrvr1cmdhUpdateCommand(ASender: TIdCommand);
begin
  if not (Settings.InUpdating) then
  begin
    ASender.Reply.NumericCode:=201;
    ASender.Reply.Text.Text := 'Update start';
    Settings.InUpdating := True;
    Settings.Client.Update;
    Settings.LastUpdate := Now;
    Settings.InUpdating := False;
  end
  else
    begin
    ASender.Reply.NumericCode:=204;
    ASender.Reply.Text.Text := 'Update in process';
    end;

end;

procedure TForm1.idtcpsrvr1cmdhLastCommand(ASender: TIdCommand);
begin
ASender.Reply.Text.Text:=DateTimeToStr(Settings.LastUpdate);
end;

end.

