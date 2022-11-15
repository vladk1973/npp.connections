unit StringGridsUnit;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.Contnrs,
  System.Win.ComObj, Vcl.Grids, Graphics, StringGridExUnit;

type
  TObjectStrings = class(TObjectList)
  private
    FName: string;
    FTag: integer;
    FDescription: string;
    FConnectionString: string;
    function GetItem(Index: Integer): TStringGrid;
    procedure SetItem(Index: Integer; const Value: TStringGrid);
    procedure SetName(const Value: string);
    procedure SetConnectionString(const Value: string);
  public
    function Add: TStringGridEx;overload;
    property Items[Index: Integer]: TStringGrid read GetItem write SetItem; default;
    property Name: string read FName write SetName;
    property Tag: integer read FTag write FTag;
    property Description: string read FDescription write FDescription;
    property ConnectionString: string read FConnectionString write SetConnectionString;
  end;

  TStringGrids = class(TObjectStrings);

implementation

{ TObjectStrings }

function TObjectStrings.Add: TStringGridEx;
begin
  Result := TStringGridEx.Create(nil);
  inherited Add(Result);
end;

function TObjectStrings.GetItem(Index: Integer): TStringGrid;
begin
  Result := TStringGrid(inherited Items[Index]);
end;

procedure TObjectStrings.SetConnectionString(const Value: string);
begin
  FConnectionString := Value;
end;

procedure TObjectStrings.SetItem(Index: Integer; const Value: TStringGrid);
begin
  inherited Items[Index] := Value;
end;

procedure TObjectStrings.SetName(const Value: string);
begin
  FName := Value;
end;

end.
