library ZIP1;

uses
  SysUtils, sevenzip,
  PluginAPI in '..\PluginAPI\Headers\PluginAPI.pas';

{$R *.res}
{$E .ext}

const
  arch_lib = '7z.dll';

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
  Result := 'Zip extract';
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
  Result := '.zip';
end;

function TPlugin.GetFileType: WideChar;
begin
  Result := 'F';
end;

function TPlugin.ProcessedFile(const aOld, aNew: TClientFile; const aDir,
  aSID, aPath: WideString): Integer; safecall;
var
  s, x, y: string;

begin
  x := IncludeTrailingPathDelimiter(GetCurrentDir) + arch_lib;
  y := ExtractFilePath(ParamStr(0)) + arch_lib;
  if (FileExists(x)) or (FileExists(y)) then
  begin
    s := ExcludeTrailingPathDelimiter(aPath);
    if not (DirectoryExists(s)) then
      ForceDirectories(s);
    with CreateInArchive(CLSID_CFormatZip, arch_lib) do
    begin
      OpenFile(aDir + aNew.SrvrFile);
      ExtractTo(s);
    end;
    Result := 1;
  end
  else
    Result := 0;
end;

end.

