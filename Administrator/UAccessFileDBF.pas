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
  end;

implementation

uses SysUtils, UAccessConstant;

{ TSAVAccessFilesDBF }

constructor TSAVAccessFilesDBF.Create(aContainer: TSAVAccessContainer);
begin
  inherited Create;
  Container := aContainer;
  FTable := TVKDBFNTX.Create(nil);
  DataSource := FTable;
  FTable.DBFFileName := IncludeTrailingPathDelimiter(Container.WorkDir) +
    csFilesTable;
  TablePrepare(False);
  if FileExists(FTable.DBFFileName) then
  begin
    //окрытие файла
  end
  else
  begin
    //создание файла
  end;
end;

function TSAVAccessFilesDBF.TableCreate: Boolean;
begin

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

