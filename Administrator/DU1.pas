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
    dsADGroups: TDataSource;
    vkdbfADGroups: TVKDBFNTX;
    procedure dsDomainDataChange(Sender: TObject; Field: TField);
    procedure dsUsersDataChange(Sender: TObject; Field: TField);
    procedure dsGroupsDataChange(Sender: TObject; Field: TField);
    procedure dsADGroupsDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmdl1: Tdtmdl1;

implementation
uses UAccessConstant, U7, UAccessContainer,u1;

{$R *.dfm}

procedure Tdtmdl1.dsDomainDataChange(Sender: TObject; Field: TField);
begin
  if dsDomain.DataSet.RecordCount > 0 then
    Settings.Domain.Open(Settings.Base,
      dsDomain.DataSet.fieldbyname(csFieldCaption).AsString,
      dsDomain.DataSet.fieldbyname(csFieldSID).AsString,
      dsDomain.DataSet.fieldbyname(csFieldDescription).AsString, '',
      dsDomain.DataSet.fieldbyname(csFieldVersion).AsString);
end;

procedure Tdtmdl1.dsUsersDataChange(Sender: TObject; Field: TField);
begin
  if dsUsers.DataSet.RecordCount > 0 then
  begin
    Settings.User.Open(Settings.Base,
      dsUsers.DataSet.fieldbyname(csFieldCaption).AsString,
      dsUsers.DataSet.fieldbyname(csFieldSID).AsString,
      dsUsers.DataSet.fieldbyname(csFieldDescription).AsString,
      dsUsers.DataSet.fieldbyname(csFieldDomain).AsString,
      dsUsers.DataSet.fieldbyname(csFieldVersion).AsString);
    Settings.User.GetGroups(Frm1.chklstUserGroups.Items);  
   end;
end;

procedure Tdtmdl1.dsGroupsDataChange(Sender: TObject; Field: TField);
begin
  if dsGroups.DataSet.RecordCount > 0 then
  begin
    Settings.Group.Open(Settings.Base,
      dsGroups.DataSet.fieldbyname(csFieldCaption).AsString,
      dsGroups.DataSet.fieldbyname(csFieldSID).AsString,
      dsGroups.DataSet.fieldbyname(csFieldDescription).AsString,
      dsGroups.DataSet.fieldbyname(csFieldPrority).AsString,
      dsGroups.DataSet.fieldbyname(csFieldVersion).AsString);
    Settings.Group.GetUsersSID(Frm1.chklstGroupUsers,True);
  end
end;

procedure Tdtmdl1.dsADGroupsDataChange(Sender: TObject; Field: TField);
begin
 if dsADGroups.DataSet.RecordCount > 0 then
  begin
    Settings.ADGroup.Open(Settings.Base,
      dsADGroups.DataSet.fieldbyname(csFieldCaption).AsString,
      dsADGroups.DataSet.fieldbyname(csFieldSID).AsString,
      dsADGroups.DataSet.fieldbyname(csFieldDescription).AsString,
      dsADGroups.DataSet.fieldbyname(csFieldPrority).AsString,
      dsADGroups.DataSet.fieldbyname(csFieldVersion).AsString);
    Settings.ADGroup.GetUsersSID(Frm1.lstADGroupUsers.Items,Settings.Domain.SID,True);
  end
end;

end.

