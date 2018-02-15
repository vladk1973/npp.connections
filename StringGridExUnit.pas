unit StringGridExUnit;

interface

uses
  System.SysUtils, Winapi.Windows, Winapi.Messages, Vcl.Clipbrd,
  scisupport, Vcl.Controls, System.Contnrs, Vcl.ComCtrls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Graphics, Vcl.Grids, Vcl.StdCtrls, System.StrUtils, System.Classes;

type
  TStringGridEx = class(TStringGrid)
  private
    function DoKeyUp(var Message: TWMKey): Boolean;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMSysKeyDown(var Message: TWMSysKeyDown); message WM_SYSKEYDOWN;
  protected
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    function CopyToClipboard: boolean;
    function CopyAllToClipboard: boolean;
  end;

implementation

function tabba(const S: string): string;
begin
  if Length(Trim(S))=0 then Result := '' else Result := #9;
end;

{ TStringGridEx }

constructor TStringGridEx.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DefaultColWidth := 10;
  ScrollBars := ssNone;
  BorderStyle:= bsNone;
  FixedColor := clBtnFace;
  DefaultRowHeight := 18;
  Options := [];
  Anchors := [akLeft, akTop];
  DoubleBuffered := True;
  TabStop := false;
end;

procedure TStringGridEx.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
var
  Hold: Integer;
  bColor, predColorB, fColor, predColorF: TColor;
  S: string;
begin
  if UseRightToLeftAlignment then
  begin
    ARect.Left := ClientWidth - ARect.Left;
    ARect.Right := ClientWidth - ARect.Right;
    Hold := ARect.Left;
    ARect.Left := ARect.Right;
    ARect.Right := Hold;
    ChangeGridOrientation(False);
  end;

  with Canvas do
  begin
    predColorB := Brush.Color;
    predColorF := Font.Color;
    try
      fColor := clBlack;
      S := TStringGrid(Self).Cells[ACol, ARow];

      bColor := clWhite;

      if (gdFixed in AState) then
        Font.Style := Font.Style + [fsBold]
      else
        Font.Style := Font.Style - [fsBold];

      if gdSelected in AState then
      begin
        if (RowCount > 1) and (ColCount > 1) then
        begin
          bColor := clHighlight;
          fColor := clHighlightText;
        end;
      end;

      if gdFixed in AState then
      begin
        bColor := clBtnFace;
      end;

      Brush.Color := bColor;
      Font.Color  := fColor;

      FillRect(ARect);
      TextRect(ARect,ARect.Left+2,ARect.Top+2, S);
    finally
      Brush.Color := predColorB;
      Font.Color  := predColorF;
    end;
  end;
  if UseRightToLeftAlignment then ChangeGridOrientation(True);
end;

procedure TStringGridEx.WMKeyDown(var Message: TWMKeyDown);
begin
  if not DoKeyUp(Message) then inherited;
end;

procedure TStringGridEx.WMSysKeyDown(var Message: TWMSysKeyDown);
begin
  if not DoKeyUp(Message) then inherited;
end;

function TStringGridEx.CopyToClipboard: boolean;
var
  i,j: integer;
  S,S0: string;
begin
  Result := False;
  if Focused then
  begin
    S := '';

    for i := Selection.Top to Selection.Bottom do
    begin
      S0 := '';
      for j := Selection.Left to Selection.Right do
        S0 := S0 + tabba(S0) + Cells[j,i];
      S := S + S0;
      if Length(S) > 0 then
        if i < Selection.Bottom then
        begin
          j := Length(S);
          if j > 2 then
          begin
            if Copy(S,j-1,MaxInt) <> sLineBreak then S := S + sLineBreak;
          end
          else S := S + sLineBreak;
        end;
    end;
    if Length(S)>0 then
    begin
      Clipboard.AsText := S;
      Row := Selection.Top;
      Result := True;
    end;
    Exit;
  end;
end;

function TStringGridEx.CopyAllToClipboard: boolean;
var i,j: integer;
    S,S0: string;
begin
  Result := False;
  if Focused then
  begin
    S := '';

    for i := 0 to RowCount-1 do
    begin
      S0 := '';
      for j := 0 to ColCount-1 do
        S0 := S0 + tabba(S0) + Cells[j,i];
      S := S + S0;
      if Length(S) > 0 then
        if i < Selection.Bottom then
        begin
          j := Length(S);
          if j > 2 then
          begin
            if Copy(S,j-1,MaxInt) <> sLineBreak then S := S + sLineBreak;
          end
          else S := S + sLineBreak;
        end;
    end;
    if Length(S)>0 then
    begin
      Clipboard.AsText := S;
      Result := True;
    end;
    Exit;
  end;
end;

function TStringGridEx.DoKeyUp(var Message: TWMKey): Boolean;
var
  ShiftState: TShiftState;
  LCharCode: Word;
begin
  Result := True;
  with Message do
  begin
    ShiftState := KeyDataToShiftState(KeyData);
    if ssCtrl in ShiftState then
      if not (csNoStdEvents in ControlStyle) then
        if CharCode = 67 then
        begin
          CopyToClipboard;
          Exit;
        end;
  end;
  Result := False;
end;

function TStringGridEx.DoMouseWheel(Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint): Boolean;
begin
  Result := False;
end;

end.
