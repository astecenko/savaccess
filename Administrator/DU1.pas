unit DU1;

interface

uses
  SysUtils, Classes, DB, VKDBFDataSet;

type
  Tdtmdl1 = class(TDataModule)
    dsDomain: TDataSource;
    vkdbfDomain: TVKDBFNTX;
    dsUsers: TDataSource;
    vkdbfUsers: TVKDBFNTX;
    dsGroups: TDataSource;
    vkdbfGroups: TVKDBFNTX;
    dsUsersGroup: TDataSource;
    vkdbfUsersGroup: TVKDBFNTX;
    procedure vkdbfDomainAfterInsert(DataSet: TDataSet);
    procedure dsDomainDataChange(Sender: TObject; Field: TField);
    procedure dsUsersDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmdl1: Tdtmdl1;

implementation
uses UAccessConstant, U7;

{$R *.dfm}

procedure Tdtmdl1.vkdbfDomainAfterInsert(DataSet: TDataSet);
begin
  //vkdbfDomain.FieldByName('ID').AsInteger:=vkdbfDomain.GetNextAutoInc('ID');
  //vkdbfDomain.FieldByName('SID').AsString:=vkdbfDomain.FieldByName('ID').AsString;
end;

procedure Tdtmdl1.dsDomainDataChange(Sender: TObject; Field: TField);
begin
  if dsDomain.DataSet.RecordCount > 0 then
  begin
    Settings.Domain.Caption :=
      dsDomain.DataSet.fieldbyname(csFieldCaption).AsString;
    Settings.Domain.ID := dsDomain.DataSet.fieldbyname(csFieldID).AsInteger;
    Settings.Domain.SID := dsDomain.DataSet.fieldbyname(csFieldSID).AsString;
    Settings.Domain.Description :=
      dsDomain.DataSet.fieldbyname(csFieldDescription).AsString;
  end;

end;

procedure Tdtmdl1.dsUsersDataChange(Sender: TObject; Field: TField);
begin
  if dsUsers.DataSet.RecordCount > 0 then
    Settings.User.Open(Settings.Base,
      dsUsers.DataSet.fieldbyname(csFieldCaption).AsString,
      dsUsers.DataSet.fieldbyname(csFieldSID).AsString,
      dsUsers.DataSet.fieldbyname(csFieldDescription).AsString,
      dsUsers.DataSet.fieldbyname(csFieldDomain).AsString,
      dsUsers.DataSet.fieldbyname(csFieldVersion).AsString);
end;

end.

