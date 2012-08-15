unit UAccessClientFile;

interface
uses SysUtils, Classes;
type
  TClientFile = record
    SrvrFile: WideString;
    Version: WideString;
    ClntFile: WideString;
    Ext: WideString;
    TypeF: WideChar;
    Action: Integer;
    MD5: WideString;
    Source: WideChar;
    SID: WideString;
  end;

(*  TStreamClientFileDecorator = class
  private
    // Управление потоком, с которым мы будем работать
    FStream: TStream;
    FOwn: Boolean;
    procedure SetStream(const Value: TStream);

    // Вспомогательные методы: добавьте свои на каждый тип динамических данных
    procedure ReadBuffer(var ABuffer; ABufferSize: Integer); overload;
    procedure ReadBuffer(out AStr: string); overload;
    procedure WriteBuffer(const ABuffer; ABufferSize: Integer); overload;
    procedure WriteBuffer(const AStr: WideString); overload;
  public
    // Декоратор
    constructor Create(const AStream: TStream = nil; const AOwn: Boolean =
      True);
    destructor Destroy; override;

    // Просто для удобства
    property Stream: TStream read FStream write SetStream;
    property Own: Boolean read FOwn write FOwn;

    // Вот ради чего всё делалось: высокоуровневый код
    procedure Write(const AData: TClientFile);
    procedure Read(out AData: TClientFile);
    function EoS: Boolean;
  end;  *)

implementation

(*
{ TStreamClientFileDecorator }

constructor TStreamClientFileDecorator.Create(const AStream: TStream;
  const AOwn: Boolean);
begin
  inherited Create;
  FStream := AStream;
  FOwn := AOwn;
end;

destructor TStreamClientFileDecorator.Destroy;
begin
  Stream := nil;
  inherited Destroy;
end;

function TStreamClientFileDecorator.EoS: Boolean;
begin
  Assert(Assigned(FStream));
  Result := (FStream.Position >= FStream.Size);
end;

procedure TStreamClientFileDecorator.Read(out AData: TClientFile);
begin
  Assert(Assigned(FStream));
  ReadBuffer(AData.SrvrFile);
  ReadBuffer(AData.Version);
  ReadBuffer(AData.ClntFile);
  ReadBuffer(AData.Ext);
  ReadBuffer(AData.TypeF,SizeOf(AData.TypeF));
  ReadBuffer(AData.Action,SizeOf(AData.Action));
  ReadBuffer(AData.MD5);
  ReadBuffer(AData.Source,SizeOf(AData.Source));
  ReadBuffer(AData.SID);
end;

procedure TStreamClientFileDecorator.ReadBuffer(var ABuffer;
  ABufferSize: Integer);
begin
  Assert(Assigned(FStream));
  FStream.ReadBuffer(ABuffer, ABufferSize);
end;

procedure TStreamClientFileDecorator.ReadBuffer(out AStr: string);
var
  Len: LongInt;
  Str: WideString;
begin
  ReadBuffer(Len, SizeOf(Len));
  SetLength(Str, Len);
  if Len > 0 then
    ReadBuffer(Str[1], Length(Str) * SizeOf(Str[1]));
  AStr := Str;
end;

procedure TStreamClientFileDecorator.SetStream(const Value: TStream);
begin
  if Assigned(FStream) and FOwn then
    FreeAndNil(FStream);
  FStream := Value;
  FOwn := False;
end;

procedure TStreamClientFileDecorator.Write(const AData: TClientFile);
begin
  Assert(Assigned(FStream));
  WriteBuffer(AData.SrvrFile);
  WriteBuffer(AData.Version);
  WriteBuffer(AData.ClntFile);
  WriteBuffer(AData.Ext);
  WriteBuffer(AData.TypeF,SizeOf(AData.TypeF));
  WriteBuffer(AData.Action,SizeOf(AData.Action));
  WriteBuffer(AData.MD5);
  WriteBuffer(AData.Source,SizeOf(AData.Source));
  WriteBuffer(AData.SID);
end;

procedure TStreamClientFileDecorator.WriteBuffer(const AStr: WideString);
var
  Len: LongInt;
begin
  Len := Length(AStr);
  WriteBuffer(Len, SizeOf(Len));
  if Len > 0 then
    WriteBuffer(AStr[1], Length(AStr) * SizeOf(AStr[1]));
end;

procedure TStreamClientFileDecorator.WriteBuffer(const ABuffer;
  ABufferSize: Integer);
begin
  Assert(Assigned(FStream));
  FStream.WriteBuffer(ABuffer, ABufferSize);
end;   *)

end.

