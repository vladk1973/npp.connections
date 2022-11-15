{
    This file is part of DBGP Plugin for Notepad++
    Copyright (C) 2007  Damjan Zobo Cvetko

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
}

unit NppForms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Forms, Vcl.ExtCtrls, Vcl.Controls, System.UITypes,
  Vcl.Dialogs, Graphics, NppPlugin;

type
  TNppForm = class(TForm)
  private
    FColorEdge: TColor;
    FColorSofterBackground: TColor;
    FColorText: TColor;
    FColorDefaultForeground: TColor;
    FColorDefaultBackground: TColor;
    FColorLinkText: TColor;
    FColorErrorBackground: TColor;
    FColorPureBackground: TColor;
    FColorDarkerText: TColor;
    FColorBackground: TColor;
    FColorHotBackground: TColor;
    FColorDisabledText: TColor;
    procedure SetColorBackground(const Value: TColor);
    procedure SetColorDarkerText(const Value: TColor);
    procedure SetColorDefaultBackground(const Value: TColor);
    procedure SetColorDefaultForeground(const Value: TColor);
    procedure SetColorDisabledText(const Value: TColor);
    procedure SetColorEdge(const Value: TColor);
    procedure SetColorErrorBackground(const Value: TColor);
    procedure SetColorHotBackground(const Value: TColor);
    procedure SetColorLinkText(const Value: TColor);
    procedure SetColorPureBackground(const Value: TColor);
    procedure SetColorSofterBackground(const Value: TColor);
    procedure SetColorText(const Value: TColor);
    { Private declarations }
  protected
    procedure DoClose(var Action: TCloseAction); override;
    function DarkMode: boolean;
    procedure ChangeColorMode(Sender: TObject); virtual;
  public
    { Public declarations }
    Npp: TNppPlugin;
    DefaultCloseAction: TCloseAction;
    constructor Create(NppParent: TNppPlugin); overload;
    constructor Create(AOwner: TNppForm); overload;

    function Confirmed(const ACaption,ATitle: nppString): boolean;
    procedure MessageWarning(const ATitle, ACaption: nppString);
    procedure MessageError(const ATitle,ACaption: nppString);
    procedure MessageSimple(const ATitle,ACaption: nppString);
    procedure OnAfterChangeDarkMode(Sender: TObject);
    destructor Destroy; override;

    property ColorDefaultBackground: TColor read FColorDefaultBackground write SetColorDefaultBackground;
    property ColorDefaultForeground: TColor read FColorDefaultForeground write SetColorDefaultForeground;
    property ColorBackground       :  TColor read FColorBackground write SetColorBackground;
    property ColorSofterBackground :  TColor read FColorSofterBackground write SetColorSofterBackground;
    property ColorHotBackground    :  TColor read FColorHotBackground write SetColorHotBackground;
    property ColorPureBackground   :  TColor read FColorPureBackground write SetColorPureBackground;
    property ColorErrorBackground  :  TColor read FColorErrorBackground write SetColorErrorBackground;
    property ColorText             :  TColor read FColorText write SetColorText;
    property ColorDarkerText       :  TColor read FColorDarkerText write SetColorDarkerText;
    property ColorDisabledText     :  TColor read FColorDisabledText write SetColorDisabledText;
    property ColorLinkText         :  TColor read FColorLinkText write SetColorLinkText;
    property ColorEdge             :  TColor read FColorEdge write SetColorEdge;
  end;

var
  NppForm: TNppForm;

implementation

{$R *.dfm}

{ TNppForm }

constructor TNppForm.Create(NppParent: TNppPlugin);
begin
  Npp := NppParent;
  DefaultCloseAction := caNone;
  inherited Create(nil);
  // We figure right now this does more damage than good.
  // So let the main transalte and dispatch do it's thing instead of isdialogmessage
  Npp.RegisterAsDialog(Handle);
  OnAfterChangeDarkMode(Self);
end;

procedure TNppForm.ChangeColorMode(Sender: TObject);
begin
  {Ничего не делаем}
end;

function TNppForm.Confirmed(const ACaption, ATitle: nppString): boolean;
begin
  Result := False;
  if Assigned(Application) then
    Result := (Application.MessageBox(nppPChar(ACaption),nppPChar(ATitle),
        MB_ICONQUESTION + MB_YESNO) = IDYES);
end;

constructor TNppForm.Create(AOwner: TNppForm);
begin
  Npp := AOwner.Npp;
  DefaultCloseAction := caNone;
  inherited Create(AOwner);
  Npp.RegisterAsDialog(Handle);
  OnAfterChangeDarkMode(Self);
end;

function TNppForm.DarkMode: boolean;
begin
  Result := Boolean(Npp.Npp_Send(NPPM_ISDARKMODEENABLED,0,0));
end;

destructor TNppForm.Destroy;
begin
  if (self.HandleAllocated) then
    Npp.UnRegisterAsDialog(Handle);
  inherited;
end;

procedure TNppForm.DoClose(var Action: TCloseAction);
begin
  if (self.DefaultCloseAction <> caNone) then Action := self.DefaultCloseAction;
  inherited;
end;

procedure TNppForm.MessageError(const ATitle, ACaption: nppString);
begin
  if Assigned(Application) then
    Application.MessageBox(nppPChar(ATitle),nppPChar(ACaption),MB_ICONSTOP + MB_OK);
end;

procedure TNppForm.MessageSimple(const ATitle, ACaption: nppString);
begin
  if Assigned(Application) then
    Application.MessageBox(nppPChar(ATitle),nppPChar(ACaption),MB_OK);
end;

procedure TNppForm.MessageWarning(const ATitle, ACaption: nppString);
begin
  if Assigned(Application) then
    Application.MessageBox(nppPChar(ATitle),nppPChar(ACaption),MB_ICONWARNING + MB_OK);
end;

procedure TNppForm.OnAfterChangeDarkMode(Sender: TObject);
var
  C: TNppDarkModeColors;
  C_old: TNppDarkModeColors_ver8;
  Size: Integer;
  R: boolean;
begin
  ColorDefaultForeground := TColor(Npp.Npp_Send(NPPM_GETEDITORDEFAULTFOREGROUNDCOLOR,0,0));
  ColorDefaultBackground := TColor(Npp.Npp_Send(NPPM_GETEDITORDEFAULTBACKGROUNDCOLOR,0,0));

  Size := SizeOf(TNppDarkModeColors_ver8);
  R := Boolean(Npp.Npp_Send(NPPM_GETDARKMODECOLORS,Size, LPARAM(@C_old)));
  if R then
  begin
    ColorBackground       := TColor(C_old.background);
    ColorSofterBackground := TColor(C_old.softerBackground);
    ColorHotBackground    := TColor(C_old.hotBackground);
    ColorPureBackground   := TColor(C_old.pureBackground);
    ColorErrorBackground  := TColor(C_old.errorBackground);
    ColorText             := TColor(C_old.text);
    ColorDarkerText       := TColor(C_old.darkerText);
    ColorDisabledText     := TColor(C_old.disabledText);
    ColorLinkText         := TColor(C_old.linkText);
    ColorEdge             := TColor(C_old.edge);
  end
  else
  begin
    Size := SizeOf(TNppDarkModeColors);
    R := Boolean(Npp.Npp_Send(NPPM_GETDARKMODECOLORS,Size, LPARAM(@C)));
    if R then
    begin
      ColorBackground       := TColor(C.background);
      ColorSofterBackground := TColor(C.softerBackground);
      ColorHotBackground    := TColor(C.hotBackground);
      ColorPureBackground   := TColor(C.pureBackground);
      ColorErrorBackground  := TColor(C.errorBackground);
      ColorText             := TColor(C.text);
      ColorDarkerText       := TColor(C.darkerText);
      ColorDisabledText     := TColor(C.disabledText);
      ColorLinkText         := TColor(C.linkText);
      ColorEdge             := TColor(C.edge);
    end;
  end;
  ChangeColorMode(Sender);
end;

procedure TNppForm.SetColorBackground(const Value: TColor);
begin
  FColorBackground := Value;
end;

procedure TNppForm.SetColorDarkerText(const Value: TColor);
begin
  FColorDarkerText := Value;
end;

procedure TNppForm.SetColorDefaultBackground(const Value: TColor);
begin
  FColorDefaultBackground := Value;
end;

procedure TNppForm.SetColorDefaultForeground(const Value: TColor);
begin
  FColorDefaultForeground := Value;
end;

procedure TNppForm.SetColorDisabledText(const Value: TColor);
begin
  FColorDisabledText := Value;
end;

procedure TNppForm.SetColorEdge(const Value: TColor);
begin
  FColorEdge := Value;
end;

procedure TNppForm.SetColorErrorBackground(const Value: TColor);
begin
  FColorErrorBackground := Value;
end;

procedure TNppForm.SetColorHotBackground(const Value: TColor);
begin
  FColorHotBackground := Value;
end;

procedure TNppForm.SetColorLinkText(const Value: TColor);
begin
  FColorLinkText := Value;
end;

procedure TNppForm.SetColorPureBackground(const Value: TColor);
begin
  FColorPureBackground := Value;
end;

procedure TNppForm.SetColorSofterBackground(const Value: TColor);
begin
  FColorSofterBackground := Value;
end;

procedure TNppForm.SetColorText(const Value: TColor);
begin
  FColorText := Value;
end;

end.
