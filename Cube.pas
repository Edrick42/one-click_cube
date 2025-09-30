unit Cube;

interface

uses
  System.SysUtils,
  System.Generics.Collections;

type
  TCubeFilled = record
    value: Integer;
    x: Integer;
    y: Integer;
    z: Integer;
  end;

  ICube = Interface
  ['{1CAEAF60-EE12-4811-B070-65D3E870503F}']
    function GetX: Integer;
    function GetY: Integer;
    function GetZ: Integer;
    function GetListOfFilledCubes: TList<TCubeFilled>;

    procedure SetX(const Value: Integer);
    procedure SetY(const Value: Integer);
    procedure SetZ(const Value: Integer);
    procedure SetListOfFilledCubes(const Value: TList<TCubeFilled>);

    property X: Integer read GetX write SetX;
    property Y: Integer read GetY write SetY;
    property Z: Integer read GetZ write SetZ;

    property ListOfFilledCubes: TList<TCubeFilled>
      read GetListOfFilledCubes
      write SetListOfFilledCubes;

    function Volume: Integer;
    function toFillRandom: TList<TCubeFilled>;
  end;

  TCube = class(TInterfacedObject, ICube)
  private
    fX: Integer;
    fY: Integer;
    fZ: Integer;

    fListOfFilledCubes: TList<TCubeFilled>;

    function GetX: Integer;
    function GetY: Integer;
    function GetZ: Integer;
    function GetListOfFilledCubes: TList<TCubeFilled>;

    procedure SetX(const Value: Integer);
    procedure SetY(const Value: Integer);
    procedure SetZ(const Value: Integer);
    procedure SetListOfFilledCubes(const Value: TList<TCubeFilled>);
  public
    function Ref: ICube;

    property X: Integer read GetX write SetX;
    property Y: Integer read GetY write SetY;
    property Z: Integer read GetZ write SetZ;

    property ListOfFilledCubes: TList<TCubeFilled>
      read GetListOfFilledCubes
      write SetListOfFilledCubes;

    function Volume: Integer;
    function toFillRandom: TList<TCubeFilled>;

    constructor create; overload;
    constructor create(const pX: Integer; const pY: Integer; const pZ: Integer); overload;

    destructor destroy; override;
  end;

implementation

{ Cube }

constructor TCube.create;
begin
  Self.fX := 0;
  Self.fY := 0;
  Self.fZ := 0;

  Self.fListOfFilledCubes := TList<TCubeFilled>.Create();
end;

constructor TCube.create(const pX, pY, pZ: Integer);
begin
  Self.create;

  Self.fX := pX;
  Self.fY := pY;
  Self.fZ := pZ;
end;

destructor TCube.destroy;
begin
  if Assigned(fListOfFilledCubes) then
    FreeAndNil(fListOfFilledCubes);

  inherited;
end;

function TCube.GetListOfFilledCubes: TList<TCubeFilled>;
begin
  Result := fListOfFilledCubes;
end;

function TCube.GetX: Integer;
begin
  Result := Self.FX;
end;

function TCube.GetY: Integer;
begin
  Result := Self.FY;
end;

function TCube.GetZ: Integer;
begin
  Result := Self.FZ;
end;

function TCube.Ref: ICube;
begin
  Result := Self;
end;

procedure TCube.SetListOfFilledCubes(const Value: TList<TCubeFilled>);
begin
  Self.fListOfFilledCubes := Value;
end;

procedure TCube.SetX(const Value: Integer);
begin
  Self.FX := Value;
end;

procedure TCube.SetY(const Value: Integer);
begin
  Self.FY := Value;
end;

procedure TCube.SetZ(const Value: Integer);
begin
  Self.FZ := Value;
end;

function TCube.toFillRandom: TList<TCubeFilled>;
var
  i, j, k: Integer;
  cubeFilled: TCubeFilled;
begin
  if not Assigned(Self.fListOfFilledCubes) then
    Self.fListOfFilledCubes := TList<TCubeFilled>.Create();

  Self.fListOfFilledCubes.Clear;

  for i := 0 to Self.fX - 1 do
  begin
    for j := 0 to Self.fY - 1 do
    begin
      for k := 0 to Self.fZ - 1 do
      begin
        cubeFilled.value := Random(100);

        cubeFilled.x := i;
        cubeFilled.y := j;
        cubeFilled.z := k;

        Self.fListOfFilledCubes.Add(cubeFilled);
      end;
    end;
  end;
end;

function TCube.Volume: Integer;
begin
  Result := Self.fX * Self.fY * Self.fZ;
end;

end.
