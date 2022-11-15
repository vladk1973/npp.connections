unit CustomDialogUnit;

interface

uses
  Windows, Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.StdCtrls, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, NppForms, Vcl.ExtCtrls,
  {$IFDEF NPPCONNECTIONS}TranslateComponentsUnit,{$ENDIF}
  Vcl.Buttons;

type
  TCustomDialogForm = class(TNppForm)
    TopPanel: TPanel;
    OkPanel: TPanel;
    CancelPanel: TPanel;
    CancelBtn: TBitBtn;
    OkBtn: TBitBtn;
    procedure OkPanelMouseEnter(Sender: TObject);
    procedure OkPanelMouseLeave(Sender: TObject);
    procedure TopPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure OkPanelClick(Sender: TObject);
    procedure CancelPanelClick(Sender: TObject);
  private
    { Private declarations }
    procedure WMNCHitTest(var M:TWMNCHitTest); Message WM_NCHitTest;
  protected
    procedure ChangeColorMode(Sender: TObject); override;
  public
    function DoForm: TModalResult; virtual;
  end;

var
  CustomDialogForm: TCustomDialogForm;

implementation

{$R *.dfm}


{ TNppForm1 }

procedure TCustomDialogForm.CancelPanelClick(Sender: TObject);
begin
  CancelBtn.Click;
end;

procedure TCustomDialogForm.ChangeColorMode(Sender: TObject);
var
  i: integer;
  C: TComponent;
begin
  inherited;
  if DarkMode then
  begin
    Self.Color := ColorBackground;

    for i := 0 to ComponentCount-1 do
    begin
      C := Components[i];
      if C is TLabel then TLabel(C).Font.Color := ColorText;
      if C is TCheckBox then
      begin
        TCheckBox(C).Font.Color := ColorText;
      end;
      if C is TComboBox then
      begin
        TComboBox(C).Font.Color := ColorText;
        TComboBox(C).Color := ColorSofterBackground;
      end;
      if C is TGroupBox then
      begin
        TGroupBox(C).Font.Color := ColorText;
        TGroupBox(C).Color := ColorSofterBackground;
      end;
      if C is TMemo then
      begin
        TMemo(C).Font.Color := ColorText;
        TMemo(C).Color := ColorSofterBackground;
      end;
      if C is TEdit then
      begin
        TEdit(C).Font.Color := ColorText;
        TEdit(C).Color := ColorSofterBackground;
      end;
    end;

    CancelPanel.Color := ColorBackground;
    CancelPanel.Font.Color := ColorText;
    OkPanel.Color := ColorBackground;
    OkPanel.Font.Color := ColorText;
    TopPanel.Color := clNone;
    TopPanel.Font.Color := ColorText;
  end
  else
    TopPanel.Color := ColorDefaultBackground;
end;

function TCustomDialogForm.DoForm: TModalResult;
begin
  Result := Self.ShowModal;
end;

procedure TCustomDialogForm.FormCreate(Sender: TObject);
begin
  windows.SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) and not WS_CAPTION);
  windows.SetWindowPos(Handle, HWND_TOP,Left, Top,Width, Height, SWP_FRAMECHANGED);

{$IFDEF NPPCONNECTIONS}
  TranslateComponents(Self);
{$ENDIF}

  if DarkMode then
  begin
    OkPanel.Visible := True;
    OkPanel.Top := OkBtn.Top;
    OkPanel.Caption := OkBtn.Caption;
    OkPanel.Left := OkBtn.Left;
    CancelPanel.Visible := True;
    CancelPanel.Top := CancelBtn.Top;
    CancelPanel.Caption := CancelBtn.Caption;
    CancelPanel.Left := CancelBtn.Left;
    OkBtn.Visible := False;
    CancelBtn.Visible := False;
  end;
  TopPanel.Caption := Caption;

end;

procedure TCustomDialogForm.OkPanelClick(Sender: TObject);
begin
  OkBtn.Click;
end;

procedure TCustomDialogForm.OkPanelMouseEnter(Sender: TObject);
begin
  TPanel(Sender).Color := RGB(GetRValue(Color)+10,GetGValue(Color)+10,GetBValue(Color)+10)
end;

procedure TCustomDialogForm.OkPanelMouseLeave(Sender: TObject);
begin
  TPanel(Sender).Color := Color;
end;

procedure TCustomDialogForm.TopPanelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Self.Perform(WM_SysCommand,$F012,0);
end;

procedure TCustomDialogForm.WMNCHitTest(var M: TWMNCHitTest);
begin
  if M.Result = htClient then
    M.Result := htCaption
  else
    DefaultHandler(M);
end;

end.
