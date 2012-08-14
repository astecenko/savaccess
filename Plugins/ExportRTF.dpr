library ExportRTF;

uses
  SysUtils,
  Classes,
  ActiveX,
  AxCtrls,
  PluginAPI in '..\PluginAPI\Headers\PluginAPI.pas';

{$R *.res}
{$E .rep}

type
  TPlugin = class(TInterfacedObject, IUnknown, IPlugin, IExportPlugin)
  private
    FCore: ICore;
  protected
    // IPlugin
    function GetMask: WideString; safecall;
    function GetDescription: WideString; safecall;

    // IExportPlugin
    procedure ExportRTF(const ARTF: IStream; const AFileName: WideString); safecall;
  public
    constructor Create(const ACore: ICore);
  end;

{ TPlugin }

constructor TPlugin.Create(const ACore: ICore);
begin
  inherited Create;
  FCore := ACore;
  Assert(FCore.Version >= 1);
end;

function TPlugin.GetMask: WideString;
begin
  Result := '*.rtf';
end;

procedure TPlugin.ExportRTF(const ARTF: IStream; const AFileName: WideString);
var
  FS: TFileStream;
  RTFStream: TOleStream;
begin
  FS := TFileStream.Create(AFileName, fmCreate or fmShareExclusive);
  try
    RTFStream := TOleStream.Create(ARTF);
    try
      FS.CopyFrom(RTFStream, 0);
    finally
      FreeAndNil(RTFStream);
    end;
  finally
    FreeAndNil(FS);
  end;
end;

function TPlugin.GetDescription: WideString;
begin
  Result := 'Rich Text (RTF)';
end;

// _________________________________________________________________

function Init(const ACore: ICore): IPlugin; safecall;
begin
  Result := TPlugin.Create(ACore);
end;

procedure Done; safecall;
begin

end;

exports
  Init name SPluginInitFuncName,
  Done name SPluginDoneFuncName;

//begin
//  ReportMemoryLeaksOnShutdown := True;
end.
