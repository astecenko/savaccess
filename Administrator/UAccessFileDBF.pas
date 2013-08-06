unit UAccessFileDBF;

interface
uses UAccessFile, UAccessContainer, DB, VKDBFDataSet;

type
  { TODO : Сделать обратные правила! }
  TSAVAccessFilesDBF = class(TSAVAccessFiles)
  private
    FTable: TVKDBFNTX; // D-A-G-U
    FrTable: TVKDBFNTX; // U-G-A-D
    FWorkDir: string;
    FFilePriorityIndex: string;
    FFilePriorityIndexReverse: string;
    procedure DataSourceAfterDelete(DataSet: TDataSet);
  public
    property FilePriorityIndex: string read FFilePriorityIndex;
    property FilePriorityIndexReverse: string read FFilePriorityIndexReverse;
    property WorkDir: string read FWorkDir;
    function TableCreate(const aTable: string): Boolean;
    function IndexCreate(const aTableName, aIndexName: string): Boolean;
    procedure TablePrepare(aTable: TVKDBFNTX; const ReadOnly: Boolean = True);
    constructor Create(aContainer: TSAVAccessContainer); overload;
    destructor Destroy; override;
  end;

implementation

uses SysUtils, UAccessConstant, VKDBFNTX, VKDBFIndex, VKDBFSorters,
  Classes;

{ TSAVAccessFilesDBF }

constructor TSAVAccessFilesDBF.Create(aContainer: TSAVAccessContainer);

  function DoDBFFileCreate(aTable: TVKDBFNTX; aIndexName: string): boolean;
  var
    t, i: boolean;
  begin
    t:=True;
    i:=True;
    Result := False;
    TablePrepare(aTable, False);
    if not FileExists(aTable.DBFFileName) then
    begin
      t := TableCreate(aTable.DBFFileName);
      i := IndexCreate(aTable.DBFFileName, aIndexName);
    end;
    if not FileExists(aIndexName) then
      i := IndexCreate(aTable.DBFFileName, aIndexName);
    if not (t) then
      raise Exception.Create('Table create error! ' + aTable.DBFFileName)
    else if not (i) then
      raise Exception.Create('Index create error! ' + aIndexName);
    Result := i and t;
    if Result then
    begin
      with aTable.Indexes.Add as TVKNTXIndex do
        NTXFileName := aIndexName;
      aTable.Open;
      aTable.SetOrder(1);
    end;
  end;

begin
  inherited Create(aContainer);
  FWorkDir := IncludeTrailingPathDelimiter(Container.WorkDir);
  FTable := TVKDBFNTX.Create(nil);
  FrTable := TVKDBFNTX.Create(nil);
  FTable.AfterDelete := DataSourceAfterDelete;
  FrTable.AfterDelete := DataSourceAfterDelete;
  FTable.DBFFileName := FWorkDir + csTableFiles;
  FrTable.DBFFileName := FWorkDir + csTableFilesReverse;
  FFilePriorityIndex := FWorkDir + csFilePriorityIndex;
  FFilePriorityIndexReverse := FWorkDir + csFilePriorityIndexReverse;
  DoDBFFileCreate(FTable, FFilePriorityIndex);
  DataSource := FTable;
  DoDBFFileCreate(FrTable, FFilePriorityIndexReverse);
  RDataSource := FrTable;
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
  FrTable.Close;
  FreeAndNil(FrTable);
  DataSource := nil;
  RDataSource:= nil;
  inherited;
end;

function TSAVAccessFilesDBF.IndexCreate(const aTableName, aIndexName: string):
  Boolean;
var
  table1: TVKDBFNTX;
begin
  table1 := TVKDBFNTX.Create(nil);
  table1.DBFFileName := aTableName;
  table1.AccessMode.AccessMode := 66;
  table1.oem := True;
  Result := True;
  try
    table1.Open;
    with table1.Indexes.Add as TVKNTXIndex do
    begin
      NTXFileName := aIndexName;
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

function TSAVAccessFilesDBF.TableCreate(const aTable: string): Boolean;
var
  table1: TVKDBFNTX;
begin
  table1 := TVKDBFNTX.Create(nil);
  table1.DBFFileName := aTable;
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

procedure TSAVAccessFilesDBF.TablePrepare(aTable: TVKDBFNTX; const ReadOnly:
  Boolean = True);
begin
  if ReadOnly then
    aTable.AccessMode.AccessMode := 64
  else
    aTable.AccessMode.AccessMode := 66;
  aTable.OEM := True;
  aTable.DbfVersion := xClipper;
  aTable.LockProtocol := lpClipperLock;
  aTable.LobLockProtocol := lpClipperLock;
  aTable.TrimInLocate := True;
  aTable.TrimCType := True;
end;

end.

