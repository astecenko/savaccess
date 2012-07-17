unit U1AD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ComObj, ComCtrls, ActiveX, DBGrids, DB, ADODB,
  Buttons;

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
    //procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgrd1DblClick(Sender: TObject);
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
      ShowMessage('Ошибка! ' + SysErrorMessage(GetLastError));
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
  s: string;
begin
  if ds1.DataSet.RecordCount > 0 then
  begin
    s := '';
    s := ds1.DataSet.fieldbyname('CN').AsString;
    edtCaption.Text := s;
    s := '';
    s := MsAD.GetSID(ds1.DataSet.FieldByName('sAMAccountName').AsString,
      GetDNSDomainName(CurrentDomainName));
    edtSID.Text := s;
    s := '';
    try
      s := ds1.DataSet.fieldbyname('description').AsString;
    except
      //      ShowMessage('Ошибка: '+SysErrorMessage(GetLastError));
    end;
    edtDescription.Text := s;
  end;
end;

end.

