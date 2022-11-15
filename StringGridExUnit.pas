unit StringGridExUnit;

interface

uses
  System.SysUtils, Winapi.Windows, Winapi.Messages, Vcl.Clipbrd,
  scisupport, Vcl.Controls, System.Contnrs, Vcl.ComCtrls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Graphics, Vcl.Grids, Vcl.StdCtrls, System.StrUtils, System.Classes, System.Math;

type
  TOnSelectedTextEvent = procedure(Strings: TStrings) of object;

  TStringGridEx = class(TStringGrid)
  private
    FButtonCoord: TPoint;
    FOnButtonClick: TNotifyEvent;
    FOnGetSelectedText: TOnSelectedTextEvent;
    FOnReplaceSelectedText: TOnSelectedTextEvent;
    FDraw_FontColor: TColor;
    FDraw_FontHColor: TColor;
    FDraw_BGColor: TColor;
    FDraw_BGHColor: TColor;
    FDraw_HeaderColor: TColor;
    function GetButtonVisible: boolean;
    function DoKeyUp(var Message: TWMKey): Boolean;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMSysKeyDown(var Message: TWMSysKeyDown); message WM_SYSKEYDOWN;
  protected
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint): Boolean; override;
    property ButtonVisible: boolean read GetButtonVisible;
  public
    constructor Create(AOwner: TComponent); override;
    function CopyToClipboard: boolean;
    function CopyAllToClipboard: boolean;
    function DeclareVarsToClipboard: boolean;
    property OnButtonClick: TNotifyEvent read FOnButtonClick write FOnButtonClick;
    property OnGetSelectedText: TOnSelectedTextEvent read FOnGetSelectedText write FOnGetSelectedText;
    property OnReplaceSelectedText: TOnSelectedTextEvent read FOnReplaceSelectedText write FOnReplaceSelectedText;

    property Draw_HeaderColor: TColor read FDraw_HeaderColor write FDraw_HeaderColor;
    property Draw_BGColor: TColor read FDraw_BGColor write FDraw_BGColor;
    property Draw_FontColor: TColor read FDraw_FontColor write FDraw_FontColor;
    property Draw_BGHColor: TColor read FDraw_BGHColor write FDraw_BGHColor;
    property Draw_FontHColor: TColor read FDraw_FontHColor write FDraw_FontHColor;
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

function TStringGridEx.DeclareVarsToClipboard: boolean;
var i,j, ilen, iMax, iPrec: integer;
    S,S0,S1: string;
    Strings, SelStrings: TStringList;
  function PADR(Src: string; Lg: Integer): string;
  var s0: string;
      k,x: integer;
  begin
    x := 0;
    Result := '';
    if iPrec = 4 then
    begin
      s0 := '@' + Src;
      x := 1;
    end
    else
      s0 := Src;

    if SelStrings.Count > 0 then
    begin
      for k := 0 to SelStrings.Count - 1 do
        if LowerCase(trim(SelStrings[k])) = LowerCase(s0) then
        begin
          Result := s0;
          break;
        end;
    end
    else
      Result := s0;

    if Result <> '' then
      Result := Result.PadRight(Lg+x);
  end;

begin
  Result := False;
  if Focused then
  begin
    S := '';
    ilen := 0;

    if RowCount > 1 then
      for i := 0 to ColCount - 1 do
        if Cells[i,0] = 'Prec' then
        begin
          iPrec := i;
          break;
        end;
    if not iPrec in [3,4] then Exit;

    if ColCount > 4 then
    begin
      Strings := TStringList.Create;
      SelStrings := TStringList.Create;
      if Assigned(FOnGetSelectedText) then FOnGetSelectedText(SelStrings);

      iMax := 0;
      try
        if SelStrings.Count = 0 then
          for i := 1 to RowCount-1 do
            ilen := Max(length(Cells[0,i]),ilen)
        else
          for i := 0 to SelStrings.Count-1 do
            ilen := Max(length(trim(SelStrings[i])),ilen);

        if ilen = 0  then Exit;

        for i := 1 to RowCount-1 do
        begin
          S0 := PADR(Cells[0,i],ilen+1);
          if S0 <> '' then
          begin
            S1 := Cells[1,i];
            if (S1 = 'char') or (S1 = 'varchar') then S1 := S1 + '(' + Cells[iPrec,i] + ')';
            if S1 = 'numeric' then S1 := S1 + '(' + trim(Cells[iPrec,i]) + ',' + trim(Cells[iPrec+1,i]) + ')';
            S := S0 + S1;
            iMax := Max(iMax,length(S));
            Strings.Add(S);
          end;
        end;
        if Strings.Count>0 then
        begin
          for i := 0 to Strings.Count - 2 do
          begin
            S := Strings[i];
            Strings[i] := S.PadRight(iMax + 1) + ',';
          end;
          S := Strings.Text;;
          for i := 0 to SelStrings.Count-1 do
            if Pos(trim(SelStrings[i]) +' ',S) = 0 then Strings.Add('--' + SelStrings[i]);


          if Assigned(FOnReplaceSelectedText) and (SelStrings.Count > 0) then
            FOnReplaceSelectedText(Strings)
          else
            Clipboard.AsText := Strings.Text;

          Result := True;
        end;
      finally
        Strings.Free;
        SelStrings.Free;
      end
    end;
  end;
end;

procedure TStringGridEx.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
var
  Hold: Integer;
  bColor, predColorB, fColor, predColorF: TColor;
  S: string;
  FButton: TBitMap;
begin
  with Canvas do
  begin
    predColorB := Brush.Color;
    predColorF := Font.Color;
    try
      fColor := FDraw_FontColor; //clBlack;
      S := TStringGrid(Self).Cells[ACol, ARow];
      if Length(S)>1024 then S := Copy(S,1,1024) + '...';


      bColor := FDraw_BGColor; //clWhite;

      if (gdFixed in AState) then
        Font.Style := Font.Style + [fsBold]
      else
        Font.Style := Font.Style - [fsBold];

      if gdSelected in AState then
      begin
        if (RowCount > 1) and (ColCount > 1) then
        begin
          bColor := FDraw_BGHColor; //clHighlight;
          fColor := FDraw_FontHColor; //clHighlightText;
        end;
      end;

      if gdFixed in AState then
      begin
        bColor := FDraw_HeaderColor; //clBtnFace;
      end;

      Brush.Color := bColor;
      Font.Color  := fColor;

      FillRect(ARect);

      TextRect(ARect,ARect.Left+2,ARect.Top+2, S);

      if (ACol = 0) and (ARow = 1) and ButtonVisible then
      begin
        FButton := TBitMap.Create;
        try
          if FDraw_BGColor = clWhite then
            FButton.LoadFromResourceName(HInstance,'PLAN')
          else
            FButton.LoadFromResourceName(HInstance,'PLANDARK');
          FButton.Transparent := True;

          FButtonCoord.X := ARect.Right - FButton.Width - 1;
          FButtonCoord.Y := ARect.Top+1;

          Canvas.Draw(FButtonCoord.X,FButtonCoord.Y,FButton);
        finally
          FButton.Free;
        end;
      end;

    finally
      Brush.Color := predColorB;
      Font.Color  := predColorF;
    end;
  end;
end;

procedure TStringGridEx.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Cell: TGridCoord;
begin
  inherited MouseUp(Button, Shift, X, Y);
  if (Button = mbLeft) and (Shift = [])then
  begin
    Cell := MouseCoord(X,Y);
    if (Cell.X = 0) and (Cell.Y = 1) and ButtonVisible then
    begin
      if (X >= FButtonCoord.X) and (X <= FButtonCoord.X + 16)
        and (Y >= FButtonCoord.Y) and (Y <= FButtonCoord.Y + 16) then
        if Assigned(FOnButtonClick) then FOnButtonClick(Self);
    end;
  end;
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

function TStringGridEx.GetButtonVisible: boolean;
begin
  Result := Assigned(FOnButtonClick);
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
