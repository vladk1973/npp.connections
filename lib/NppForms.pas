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
  System.Classes, Vcl.Forms,
  Vcl.Dialogs, NppPlugin;

type
  TNppForm = class(TForm)
  private
    { Private declarations }
  protected
    procedure DoClose(var Action: TCloseAction); override;
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
    destructor Destroy; override;
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

end.
