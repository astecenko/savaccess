unit UAccessFile;

interface
uses Classes, UAccessContainer, DB, md5;
type

  TMD5 = string[32];

  TSAVAccessFiles = class(TObject)
  private
    FContainer: TSAVAccessContainer;
    FDataSource: TDataSet;
    FRDataSource: TDataSet;
    FFileDir: string;
    procedure SetContainer(const Value: TSAVAccessContainer);
    procedure SetDataSource(const Value: TDataSet);
    procedure SetRDataSource(const Value: TDataSet);
  public
    property Container: TSAVAccessContainer read FContainer write SetContainer;
    property DataSource: TDataSet read FDataSource write SetDataSource;
    property RDataSource: TDataSet read FRDataSource write SetRDataSource;
    property FileDir: string read FFileDir;
    function GetMD5(const aFileName: string): string;
    function AppendFile(aDS:TDataSet; const aFileName: string): Boolean; virtual;
    function AppendAndCopyFile(aDS:TDataSet; const aFileName: string; const aNewFileName:
      string = ''): Boolean; virtual;
    function UpdateFile(aDS:TDataSet): Boolean; virtual;
    function DeleteFile(aDS:TDataSet): Boolean; virtual;
    constructor Create(aContainer: TSAVAccessContainer); overload;
  end;

  TSAVAccessFile = class(TObject)
  private
    FFileName: string;
    FFileType: Integer;
    FExtension: string;
    FServerPath: string;
    FClientPath: string;
    FMD5: TMD5;
    FFileAction: Integer;
    procedure SetClientPath(const Value: string);
    procedure SetExtension(const Value: string);
    procedure SetFileAction(const Value: Integer);
    procedure SetFileName(const Value: string);
    procedure SetFileType(const Value: Integer);
    procedure SetMD5(const Value: TMD5);
    procedure SetServerPath(const Value: string);
  protected
    property FileName: string read FFileName write SetFileName;
    property FileType: Integer read FFileType write SetFileType;
    property Extension: string read FExtension write SetExtension;
    property ServerPath: string read FServerPath write SetServerPath;
    property ClientPath: string read FClientPath write SetClientPath;
    property MD5: TMD5 read FMD5 write SetMD5;
    property FileAction: Integer read FFileAction write SetFileAction;
  public

  end;

implementation
uses StrUtils, SysUtils, SAVLib, UAccessConstant, KoaUtils;

{ TSAVAccessFile }

procedure TSAVAccessFile.SetClientPath(const Value: string);
begin
  FClientPath := Value;
end;

procedure TSAVAccessFile.SetExtension(const Value: string);
begin
  FExtension := Value;
end;

procedure TSAVAccessFile.SetFileAction(const Value: Integer);
begin
  FFileAction := Value;
end;

procedure TSAVAccessFile.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

procedure TSAVAccessFile.SetFileType(const Value: Integer);
begin
  FFileType := Value;
end;

procedure TSAVAccessFile.SetMD5(const Value: TMD5);
begin
  FMD5 := Value;
end;

procedure TSAVAccessFile.SetServerPath(const Value: string);
begin
  FServerPath := Value;
end;

{ TSAVAccessFiles }

function TSAVAccessFiles.AppendAndCopyFile(aDS:TDataSet; const aFileName,
  aNewFileName: string): Boolean;
var
  s: string;
begin
  if aNewFileName = '' then
    s := ExtractFileName(aFileName)
  else
    s := aNewFileName;
  Result := True;
  try
    fCopyFile(aFileName, FFileDir + s);
  except
    Result := False;
  end;
  if Result then
    Result := AppendFile(aDS, FFileDir + s);
end;

function TSAVAccessFiles.AppendFile(aDS:TDataSet; const aFileName: string): Boolean;
begin
  try
    Result := True;
    aDS.Append;
    ads.FieldByName(csFieldPrority).AsInteger:=100;
    aDS.FieldByName(csFieldSrvrFile).AsString :=
      AnsiLowerCase(ExtractFileName(aFileName));
    aDS.FieldByName(csFieldExt).AsString :=
      ExtractFileExt(aDS.FieldByName(csFieldSrvrFile).AsString);
    aDS.FieldByName(csFieldMD5).AsString := GetMD5(aFileName);
    aDS.FieldByName(csFieldVersion).AsString := Container.GetNewVersion;
    aDS.Post;

  except
    Result := False;
  end;
end;

constructor TSAVAccessFiles.Create(aContainer: TSAVAccessContainer);
begin
  inherited Create;
  FContainer := aContainer;
  FFileDir := IncludeTrailingPathDelimiter(FContainer.WorkDir) + 'f\';
end;

function TSAVAccessFiles.DeleteFile(aDS:TDataSet): Boolean;
begin
  Result := True;
  try
    fDeleteFile(FFileDir + aDS.FieldByName(csFieldSrvrFile).AsString);
  except
    Result := False;
  end;
  if Result then
    aDS.Delete;
end;

function TSAVAccessFiles.GetMD5(const aFileName: string): string;
begin
  try
    Result := MD5DigestToStr(MD5File(aFileName));
  except
    Result := '';
  end;
end;

procedure TSAVAccessFiles.SetContainer(const Value: TSAVAccessContainer);
begin
  FContainer := Value;
end;

procedure TSAVAccessFiles.SetDataSource(const Value: TDataSet);
begin
  FDataSource := Value;
end;

procedure TSAVAccessFiles.SetRDataSource(const Value: TDataSet);
begin
  FRDataSource := Value;
end;

function TSAVAccessFiles.UpdateFile(aDS:TDataSet): Boolean;
var
  s: string;
begin
  Result := False;
  if aDS.FieldByName(csFieldSrvrFile).AsString <> '' then
  begin
    s := GetMD5(FFileDir + aDS.FieldByName(csFieldSrvrFile).AsString);
    if s <> aDS.FieldByName(csFieldMD5).AsString then
    begin
      aDS.Edit;
      aDS.FieldByName(csFieldMD5).AsString := s;
      aDS.FieldByName(csFieldVersion).AsString :=
        Container.GetNewVersion;
      aDS.Post;
    end;
    Result := True;
  end;
end;

end.

