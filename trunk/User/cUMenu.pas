unit cUMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, ImgList, StdCtrls, Buttons,
  JvExComCtrls, JvComCtrls, IniFiles, cefvcl, ceflib;

const
  start_protocol = 'run://';
  MainCaption = ' ÎËÂÌÚ ¿—”œ: ';

type

  PMnuItem = ^TMnuItem;
  TMnuItem = record
    Name: string;
    Parent: string;
    Text: string;
    Doc: string;
    Priority: Integer;
  end;

  TSAVClntMenu = class(TForm)
    stat1: TStatusBar;
    il1: TImageList;
    pnl1: TPanel;
    jv1: TJvTreeView;
    spl1: TSplitter;
    btnGoBack: TBitBtn;
    btnGoForward: TBitBtn;
    chrm1: TChromium;
    btnRefresh: TBitBtn;
    procedure jv1Deletion(Sender: TObject; Node: TTreeNode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    { procedure frameRightHotSpotTargetClick(Sender: TObject; const Target,
       URL: WideString; var Handled: Boolean);}
    procedure FormCreate(Sender: TObject);
    procedure btnGoBackClick(Sender: TObject);
    procedure btnGoForwardClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure chrm1LoadStart(Sender: TObject; const browser: ICefBrowser;
      const frame: ICefFrame);
    procedure chrm1LoadEnd(Sender: TObject; const browser: ICefBrowser;
      const frame: ICefFrame; httpStatusCode: Integer);
    procedure chrm1DownloadUpdated(Sender: TObject;
      const browser: ICefBrowser; const downloadItem: ICefDownloadItem;
      const callback: ICefDownloadItemCallback);
    procedure chrm1TitleChange(Sender: TObject; const browser: ICefBrowser;
      const title: ustring);
    procedure chrm1ProtocolExecution(Sender: TObject;
      const browser: ICefBrowser; const url: ustring;
      out allowOsExecution: Boolean);
  private
    FStartProtLength: Integer;
    FLoading: Boolean;
    function IsMain(const b: ICefBrowser; const f: ICefFrame = nil): Boolean;
  public
    procedure LoadMenuFromFile(const aFileName: string);
    procedure GetChildFromIni(ini: TCustomIniFile; aList: TStrings; const
      aParent: string = '');
  end;

implementation
uses cUSettings, SAVLib;

{$R *.dfm}

procedure TSAVClntMenu.LoadMenuFromFile(const aFileName: string);
var
  ini: TMemIniFile;
  listMain: TStringList;
  imain, nmain: Integer;

  procedure AddItemToMnu(const aName, aParent: string; const aParentItems:
    Integer);
  var
    NewDoc: PMnuItem;
    list: TStringList;
    i, n: Integer;
    node: TTreeNode;
  begin
    New(NewDoc);
    list := TStringList.Create;
    NewDoc^.Name := aName;
    NewDoc^.Parent := aParent;
    NewDoc^.Text := ini.ReadString(aName, 'text', '');
    NewDoc^.Doc := ini.ReadString(aName, 'doc', '');
    NewDoc^.Priority := ini.ReadInteger(aName, 'prio', 0);
    if (aParentItems < jv1.Items.Count) and (aParentItems >= 0) then
      node := jv1.Items.AddChildObject(jv1.Items[aParentItems], NewDoc^.Text,
        NewDoc)
    else
      node := jv1.Items.AddChildObject(nil, NewDoc^.Text, NewDoc);
    GetChildFromIni(ini, list, aName);
    n := pred(list.Count);
    for i := 0 to n do
      AddItemToMnu(list[i], aName, node.AbsoluteIndex);
    FreeAndNil(list);
  end;

begin
  if FileExists(aFileName) then
  begin
    ini := TMemIniFile.Create(aFileName);
    listMain := TStringList.Create;
    GetChildFromIni(ini, listMain);
    nmain := pred(listMain.Count);
    for imain := 0 to nmain do
      AddItemToMnu(listMain[imain], '', -1);
    FreeAndNil(listMain);
    FreeAndNil(ini);
  end;
end;

procedure TSAVClntMenu.GetChildFromIni(ini: TCustomIniFile;
  aList: TStrings; const aParent: string);
var
  list: TStringList;
  i, n: Integer;
  s, z: string;
begin
  aList.Clear;
  list := TStringList.Create;
  ini.ReadSections(list);
  n := pred(list.Count);
  for i := 0 to n do
  begin
    s := ini.ReadString(list[i], 'parent', '');
    z := ini.ReadString(list[i], 'text', '');
    if (z <> '') and (s = aParent) then
      aList.Add(list[i]);
  end;
  FreeAndNil(list);
end;

procedure TSAVClntMenu.jv1Deletion(Sender: TObject; Node: TTreeNode);
var
  NewDoc: PMnuItem;
begin
  if Node.Data <> nil then
  begin
    NewDoc := Node.Data;
    Dispose(NewDoc);
    NewDoc := nil;
    Node.Data := nil;
  end;
end;

procedure TSAVClntMenu.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  {while jv1.Items.Count>0 do
    jv1.Items.Delete(jv1.Items[0]);}

end;

{procedure TSAVClntMenu.frameRightHotSpotTargetClick(Sender: TObject;
  const Target, URL: WideString; var Handled: Boolean);
  var
    s:string;
begin
  if Pos(start_protocol,URL)=1 then
  begin
      Handled:=True;
      s:=Copy(URL,succ(FStartProtLength),Length(URL)-FStartProtLength);
      WinExec(PAnsiChar(s),SW_NORMAL)
   // ShowMessage(Copy(URL,succ(FStartProtLength),Length(URL)-FStartProtLength));
  end
  else
  Handled:=False;

end;     }

procedure TSAVClntMenu.FormCreate(Sender: TObject);
begin
  FStartProtLength := Length(start_protocol);
  Self.Caption := MainCaption;
  // FLoading:=False;
end;

procedure TSAVClntMenu.btnGoBackClick(Sender: TObject);
begin
  //frameRight.GoBack;
  if chrm1.Browser <> nil then
    chrm1.Browser.GoBack;
end;

procedure TSAVClntMenu.btnGoForwardClick(Sender: TObject);
begin
  if chrm1.Browser <> nil then
    chrm1.Browser.GoForward;
  //frameRight.GoFwd;
end;

procedure TSAVClntMenu.btnRefreshClick(Sender: TObject);
begin
  if chrm1.Browser <> nil then
    if FLoading then
      chrm1.Browser.StopLoad
    else
      chrm1.Browser.Reload;
end;

function TSAVClntMenu.IsMain(const b: ICefBrowser;
  const f: ICefFrame): Boolean;
begin
  //Result := (b <> nil) and (b.Identifier = chrm1.BrowserId) and ((f = nil) or (f.IsMain));
  Result := True;
end;

procedure TSAVClntMenu.chrm1LoadStart(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame);
begin
  if IsMain(browser, frame) then
    FLoading := True;
end;

procedure TSAVClntMenu.chrm1LoadEnd(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame;
  httpStatusCode: Integer);
begin
  if IsMain(browser, frame) then
    FLoading := False;
end;

procedure TSAVClntMenu.chrm1DownloadUpdated(Sender: TObject;
  const browser: ICefBrowser; const downloadItem: ICefDownloadItem;
  const callback: ICefDownloadItemCallback);
begin
  if downloadItem.IsInProgress then
    stat1.SimpleText := IntToStr(downloadItem.PercentComplete) + '%'
  else
    stat1.SimpleText := '';
end;

procedure TSAVClntMenu.chrm1TitleChange(Sender: TObject;
  const browser: ICefBrowser; const title: ustring);
begin
  if IsMain(browser) then
    Caption := MainCaption + title;
end;

procedure TSAVClntMenu.chrm1ProtocolExecution(Sender: TObject;
  const browser: ICefBrowser; const url: ustring;
  out allowOsExecution: Boolean);
var
  s: string;
begin
  if Pos(start_protocol, Url) = 1 then
  begin
    s := Copy(Url, succ(FStartProtLength), Length(Url) - FStartProtLength);
    //    WinExec(PAnsiChar(s), SW_NORMAL);
    ProcStart(s, SW_NORMAL);
    //  FLoading:=False;
  end
  else if Pos('mailto:', url) = 1 then
  begin
    //    s := url;
    ProcStart(url, SW_NORMAL);
  end;
end;

end.

