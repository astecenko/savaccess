unit UAccessFile;

interface
uses Classes,UAccessContainer, DB;
type

  TMD5 = string[32];

  TSAVAccessFiles = class (TObject)
  private
    FContainer:TSAVAccessContainer;
    FDataSource:TDataSet;
    procedure SetContainer(const Value: TSAVAccessContainer);
    procedure SetDataSource(const Value: TDataSet);
  public
    property Container:TSAVAccessContainer read FContainer write SetContainer;
    property DataSource:TDataSet read FDataSource write SetDataSource;
    constructor Create overload;
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
uses StrUtils, SysUtils, SAVLib, UAccessConstant;

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

constructor TSAVAccessFiles.Create;
begin

end;

procedure TSAVAccessFiles.SetContainer(const Value: TSAVAccessContainer);
begin
  FContainer := Value;
end;

procedure TSAVAccessFiles.SetDataSource(const Value: TDataSet);
begin
  FDataSource := Value;
end;

end.

