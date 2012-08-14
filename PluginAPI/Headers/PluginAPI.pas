unit PluginAPI;

interface

uses
  ActiveX;

type
  ICore = interface
  ['{26D3EED3-A843-4E9C-83C1-FEE1ED544490}']
  // private
    function GetVersion: Integer; safecall;
  // public
    property Version: Integer read GetVersion;
  end;

  IPlugin = interface
  ['{174C7DBF-C9D8-4568-8FBA-89CA8D785754}']
  // private
    function GetMask: WideString; safecall;
    function GetDescription: WideString; safecall;
  // public
    property Mask: WideString read GetMask;
    property Description: WideString read GetDescription;
  end;

  IExportPlugin = interface
  ['{F78CDFC4-D72E-4D30-9639-378614F9F672}']
    procedure ExportRTF(const ARTF: IStream; const AFileName: WideString); safecall;
  end;

  IImportPlugin = interface
  ['{52D2829D-596E-459C-B78E-9A4A2234338E}']
    procedure ImportRTF(const AFileName: WideString; const ARTF: IStream); safecall;
  end;

  

type
  TInitPluginFunc = function(const ACore: ICore): IPlugin; safecall;
  TDonePluginFunc = procedure; safecall;

const
  SPluginInitFuncName = 'D211F00C19BD4BD1BEC90B1A763983E3';
  SPluginDoneFuncName = SPluginInitFuncName + '_done';
  SPluginExt          = '.savext';

implementation

end.


