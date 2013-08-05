unit UAccessFileDBF;

interface
uses UAccessFile, UAccessContainer, DB, VKDBFDataSet;

type
    { TODO : Сделать обратные правила! }
  TSAVAccessFilesDBF = class(TSAVAccessFiles)
  private
    FTable: TVKDBFNTX;
    FFilePriorityIndex: string;
    procedure DataSourceAfterDelete(DataSet: TDataSet);
  public
    property FilePriorityIndex: string read FFilePriorityIndex;
    function TableCreate: Boolean;
    function IndexCreate: Boolean;
    procedure TablePrepare(const ReadOnly: Boolean = True);
    constructor Create(aContainer: TSAVAccessContainer); overload;
    destructor Destroy; override;
  end;

implementation

uses SysUtils, UAccessConstant, VKDBFNTX, VKDBFIndex, VKDBFSorters,
  Classes;

{ TSAVAccessFilesDBF }

constructor TSAVAccessFilesDBF.Create(aContainer: TSAVAccessContainer);
var
  t, i: boolean;
begin
  inherited Create(aContainer);
  i := True;
  t := True;
  FTable := TVKDBFNTX.Create(nil);
  FTable.AfterDelete := DataSourceAfterDelete;
  FTable.DBFFileName := IncludeTrailingPathDelimiter(Container.WorkDir) +
    csTableFiles;
  FFilePriorityIndex := ExtractFilePath(FTable.DBFFileName) +
    csFilePriorityIndex;
  TablePrepare(False);
  if not FileExists(FTable.DBFFileName) then
  begin
    t := TableCreate;
    i := IndexCreate;
  end;
  if not FileExists(FFilePriorityIndex) then
    i := IndexCreate;
  if not (t) then
    raise Exception.Create('Table create error!')
  else if not (i) then
    raise Exception.Create('Index create error!');
  if i and t then
  begin
    with FTable.Indexes.Add as TVKNTXIndex do
      NTXFileName := FFilePriorityIndex;
    FTable.Open;
    FTable.SetOrder(1);
  end;
  DataSource := FTable;
end;

procedure TSAVAccessFilesDBF.DataSourceAfterDelete(DataSet: TDataSet);
begin
  with DataSet as TVKDBFNTX do
  begin
    Pack;
  end;
end;

destructor TSAVAccessFilesDBF.Destroy;
begin
  FTable.Close;
  FreeAndNil(FTable);
  DataSource := nil;
  inherited;
end;

function TSAVAccessFilesDBF.IndexCreate: Boolean;
var
  table1: TVKDBFNTX;
begin
  table1 := TVKDBFNTX.Create(nil);
  table1.DBFFileName := FTable.DBFFileName;
  table1.AccessMode.AccessMode := 66;
  table1.oem := True;
  Result := True;
  try
    table1.Open;
    with table1.Indexes.Add as TVKNTXIndex do
    begin
      NTXFileName := ExtractFilePath(table1.DBFFileName) + csFilePriorityIndex;
      ClipperVer := v501;
      KeyExpresion := csFieldPrority;
      CreateIndex(True);
    end;
    table1.Close;
  except
    Result := False;
  end;
  FreeAndNil(table1);
end;

function TSAVAccessFilesDBF.TableCreate: Boolean;
var
  table1: TVKDBFNTX;
begin
  table1 := TVKDBFNTX.Create(nil);
  table1.DBFFileName := FTable.DBFFileName;
  table1.AccessMode.AccessMode := 66;
  table1.oem := True;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldPrority;
    field_type := 'N';
    len := 5;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldSrvrFile;
    field_type := 'C';
    len := 50;
  end;
  with table1.DBFFieldDefs.Add as TVKDBFFieldDef do
  begin
    Name := csFieldVersion;
    field_type := 'C';
    len := 30;
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
  Result := True;
  try
    table1.CreateTable;
  except
    Result := False;
  end;
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
  FTable.LockProtocol := lpClipperLock;
  FTable.LobLockProtocol := lpClipperLock;
  FTable.TrimInLocate := True;
  FTable.TrimCType := True;
end;

end.

