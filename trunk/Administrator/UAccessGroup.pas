unit UAccessGroup;

interface
uses Classes, UAccessBase, UAccessContainer;

type
  TSAVAccessGroup = class(TSAVAccessContainer)
  private
    FPriority:Integer;
    procedure SetPriority(const Value: Integer);
  protected

  public
    property Priority:Integer read FPriority write SetPriority;
    constructor Create; overload;
    constructor Create(aBase: TSAVAccessBase; const aCaption, aSID, aPriority,
      aDescription:
      string);
      overload;
    procedure Save; override;
    function Load(aSID: string = ''): Boolean; override;
    procedure GetUsersSID(List: TStrings);
    procedure Clear; override;

  end;

implementation

{ TSAVAccessGroup }

procedure TSAVAccessGroup.Clear;
begin
  inherited;
  FPriority:=0;
end;

constructor TSAVAccessGroup.Create(aBase: TSAVAccessBase; const aCaption,
  aSID, aPriority, aDescription: string);
begin

end;

constructor TSAVAccessGroup.Create;
begin

end;

procedure TSAVAccessGroup.GetUsersSID(List: TStrings);
begin

end;

function TSAVAccessGroup.Load(aSID: string): Boolean;
begin

end;

procedure TSAVAccessGroup.Save;
begin
  inherited;

end;

procedure TSAVAccessGroup.SetPriority(const Value: Integer);
begin
  FPriority := Value;
end;

end.
