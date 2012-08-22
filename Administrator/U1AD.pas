unit U1AD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ComObj, ComCtrls, ActiveX, DBGrids, DB, ADODB,
  Buttons, ExtCtrls;

type
  TFrmAD = class(TForm)
    con1: TADOConnection;
    ds1: TDataSource;
    dbgrd1: TDBGrid;
    qry1: TADOQuery;
    btn2: TButton;
    edt1: TEdit;
    cbb1: TComboBox;
    edtDomain: TEdit;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    edtCaption: TEdit;
    edtSID: TEdit;
    edtDescription: TEdit;
    lbl1: TLabel;
    edtUserDomain: TEdit;
    mmo1: TMemo;
    edtDomainNBS: TEdit;
    pnl1: TPanel;
    pnl2: TPanel;
    spl1: TSplitter;
    pnl3: TPanel;
    mmo2: TMemo;
    spl2: TSplitter;
    //procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ds1DataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  {USER_INFO_10 = record
    usri10_name,
      usri10_comment,
      usri10_usr_comment,
      usri10_full_name: pwidechar
  end;
  pUSER_INFO_10 = ^USER_INFO_10;}

var
  FrmAD: TFrmAD;

  {
 <LDAP://dc=nevz,dc=com>;(&(objectCategory=User)(samAccountName=MakarovaNA));samAccountName,Name;subtree
  }
{function NetUserEnum(
  Servername: LPCWSTR; Level: DWORD; Filter: DWORD;
  Buf: PUSER_INFO_10; prefmaxlen: DWORD; entriesread: LPDWORD;
  Totalentries: LPDWORD; resume_handle: LPDWORD
  ): DWORD; stdcall; external 'netapi32.dll'

function NetApiBufferFree(
  Buffer: Pointer
  ): DWORD; stdcall; external 'netapi32.dll'

function NetUserGetInfo(servername, username: pwidechar; level: dword; var
  bufptr: pUSER_INFO_10): dword; stdcall; external 'Netapi32.dll';
 }
implementation
uses MsAD;
{$R *.dfm}

(*procedure TForm1.btn1Click(Sender: TObject);
{var
  Bu, tmpBuffer: Pointer;
  resume_handle, entriesread, totalentries: DWORD;
  prefmaxlen, i: integer;  }
begin
  {
  prefmaxlen := -1;
  entriesread := 0;
  totalentries := 0;
  resume_handle := 0;
  NetUserEnum(nil, 10, 0, @Bu, prefmaxlen, @entriesread, @totalentries,
    @resume_handle);
  tmpBuffer := Bu;
  for i := 1 to totalentries - 1 do
  begin
    mmo1.Lines.Add(PUSER_INFO_10(tmpBuffer).usri10_name);
    tmpBuffer := Pointer(DWORD(tmpBuffer) + SizeOf(USER_INFO_10));
  end;
  NetApiBufferFree(Bu);}
end;
*)

procedure TFrmAD.btn2Click(Sender: TObject);
var
  s: string;
begin
  s := Trim(edt1.Text);
  if s <> '' then
  begin
    qry1.Close;
    qry1.ParamCheck := False;
    qry1.SQL.Clear;
    qry1.SQL.Add('select CN, mail, sAMAccountName, distinguishedName, userPrincipalName, objectSid, description from');
    qry1.SQL.Add('''LDAP://' + edtDomain.Text + '''');
    qry1.SQL.Add('WHERE objectcategory = ''Person'' AND objectclass = ''User'' AND '
      + cbb1.Items.ValueFromIndex[cbb1.itemindex] + ' = ''*' + edt1.Text +
      '*'' order by CN');
    try
      qry1.Open;
    except
      ShowMessage('Œ¯Ë·Í‡! ' + SysErrorMessage(GetLastError));
    end;
  end;
end;

procedure TFrmAD.FormCreate(Sender: TObject);
begin
  con1.Connected := True;
  GetCurrentComputerName;

end;

procedure TFrmAD.dbgrd1DblClick(Sender: TObject);
var
  s, sdns: string;
  i: Integer;
begin
  if ds1.DataSet.RecordCount > 0 then
  begin
    s := '';
    s := ds1.DataSet.fieldbyname('CN').AsString;
    edtCaption.Text := s;
    s := '';
    sdns := GetDNSDomainName(edtDomainNBS.Text);
    s := MsAD.GetSID(ds1.DataSet.FieldByName('sAMAccountName').AsString, sdns);
    edtSID.Text := s;
    s := '';
    try
      s := ds1.DataSet.fieldbyname('description').AsString;
    except
      //      ShowMessage('Œ¯Ë·Í‡: '+SysErrorMessage(GetLastError));
    end;
    edtDescription.Text := s;
    mmo1.Lines.Clear;
    GetAllUserGroups(ds1.DataSet.FieldByName('sAMAccountName').AsString,
      GetDomainController(edtDomainNBS.Text), mmo1.Lines);
    for i := 0 to pred(mmo1.Lines.Count) do
      mmo1.Lines[i] := mmo1.Lines[i] + '=' + GetSID(mmo1.Lines[i], sdns);
  end;
end;

procedure TFrmAD.FormShow(Sender: TObject);
begin
  edtDomainNBS.Text := CurrentDomainName;
  if edtUserDomain.Text = '' then
    edtUserDomain.Text := edtDomainNBS.Text;
end;

procedure TFrmAD.ds1DataChange(Sender: TObject; Field: TField);
begin
  if not (ds1.DataSet.IsEmpty) then
    mmo2.Text := ds1.DataSet.fieldbyname('distinguishedName').AsString
  else
    mmo2.Text := '';
end;

end.

