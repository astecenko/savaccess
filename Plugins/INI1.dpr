library INI1;

uses
  SysUtils,
  SAVLib_INI,
  PluginAPI in '..\PluginAPI\Headers\PluginAPI.pas',
  UAccessClientFile in '..\PluginAPI\Headers\UAccessClientFile.pas';

{$R *.res}
{$E .ext}

type
  TPlugin = class(TInterfacedObject, IUnknown, IPlugin, ISAVAccessFileAct)
  private
    FCore: ICore;
  protected
    // IPlugin
    function GetDescription: WideString; safecall;
    function GetActionID: Integer; safecall;
    function GetExtension: WideString; safecall;
    function GetFileType: WideChar; safecall;
    // ISAVAccessFileAct
    function ProcessedFile(const aOld,
      aNew: TClientFile; const aDir, aSID, aPath: WideString): Integer;
        safecall;
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

function TPlugin.GetActionID: Integer;
begin
  Result := 1;
end;

function TPlugin.GetDescription: WideString;
begin
  Result := 'Ini merging';
end;

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


function TPlugin.GetExtension: WideString;
begin
  Result := '.ini';
end;

function TPlugin.GetFileType: WideChar;
begin
  Result:='F';
end;

function TPlugin.ProcessedFile(const aOld, aNew: TClientFile; const aDir,
  aSID, aPath: WideString): Integer; safecall;
begin
  SAVLib_INI.MergeINI(aPath, aDir + aNew.SrvrFile);
  Result := 1;
end;

end.

