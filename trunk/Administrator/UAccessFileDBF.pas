unit UAccessFileDBF;

interface
uses UAccessFile, UAccessContainer, DB, VKDBFDataSet;

type

  TSAVAccessFilesDBF = class(TSAVAccessFiles)
  private
    FTable: TVKDBFNTX;
  public
    function TableCreate: Boolean;
    procedure TablePrepare(const ReadOnly: Boolean = True);
    constructor Create(aContainer: TSAVAccessContainer); overload;
    destructor Destroy; override;
  end;

implementation

uses SysUtils, UAccessConstant;

{ TSAVAccessFilesDBF }

constructor TSAVAccessFilesDBF.Create(aContainer: TSAVAccessContainer);
begin
  inherited Create;
  Container := aContainer;
  FTable := TVKDBFNTX.Create(nil);
  FTable.DBFFileName := IncludeTrailingPathDelimiter(Container.WorkDir) +
    csFilesTable;
  TablePrepare(False);
  if FileExists(FTable.DBFFileName) = False then
    TableCreate;
  FTable.Open;
  DataSource := FTable;
end;

destructor TSAVAccessFilesDBF.Destroy;
begin
  FTable.Close;
  FreeAndNil(FTable);
  DataSource:=nil;
  inherited;
end;

function TSAVAccessFilesDBF.TableCreate: Boolean;
var
  table1: TVKDBFNTX;
begin
  table1 := TVKDBFNTX.Create(nil);
  table1.DBFFileName := FTable.DBFFileName;
  table1.AccessMode.AccessMode := 66;
  table1.oem:=True;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldSrvrFile;
    field_type := 'C';
    len := 50;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldClntFile;
    field_type := 'C';
    len := 254;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldExt;
    field_type := 'C';
    len := 10;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldType;
    field_type := 'C';
    len := 1;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldAction;
    field_type := 'N';
    len := 3;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldMD5;
    field_type := 'C';
    len := 32;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldDescription;
    field_type := 'C';
    len := 150;
  end;
  table1.CreateTable;
  FreeAndNil(table1);
end;

procedure TSAVAccessFilesDBF.TablePrepare(const ReadOnly: Boolean = True);
begin
  if ReadOnly then
    FTable.AccessMode.AccessMode := 64
  else
    FTable.AccessMode.AccessMode := 66;
  FTable.OEM := True;
  FTable.DbfVersion := xClipper;
end;

end.

