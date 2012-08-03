unit UAccClient_INI;

interface
uses UAccessClient, SAVLib_INI;

function UACCopyINI(const rNew, rOld: TClientFile; const aDir, aSID:
  string; const aPath: string = ''): Boolean;

implementation

function UACCopyINI(const rNew, rOld: TClientFile; const aDir, aSID:
  string; const aPath: string = ''): Boolean;
begin
  SAVLib_INI.MergeINI(aPath,aDir+rNew.SrvrFile);
  Result:=True;
end;

end.

