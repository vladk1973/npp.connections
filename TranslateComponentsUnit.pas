unit TranslateComponentsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Buttons,
  Vcl.ActnList, Vcl.Grids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.ActnMan, Vcl.ActnCtrls,
  StringGridsUnit, ConstUnit, Vcl.ExtCtrls, Vcl.WinXCtrls, Vcl.ActnPopup, TreeViewExUnit;


procedure TranslateComponents(Form: TForm);

implementation

procedure TranslateComponents(Form: TForm);
var
  i: Integer;
  C: TComponent;
  Strings: TStringList;
begin
  for i := 0 to Form.ComponentCount-1 do
  begin
    C := Form.Components[i];
    if (C is TAction) then
    begin
      if TAction(C).HelpKeyword.Length>0 then
        TAction(C).Caption := TAction(C).HelpKeyword
      else
        TAction(C).Visible := False;
    end
    else
    if (C is TBitBtn) then
    begin
      if TBitBtn(C).HelpKeyword.Length>0 then
        TBitBtn(C).Caption := TBitBtn(C).HelpKeyword;
    end
    else
    if (C is TLabel) then
    begin
      if TLabel(C).HelpKeyword.Length>0 then
      begin
        TLabel(C).Caption := TLabel(C).HelpKeyword;
        TLabel(C).ShowHint := False;
      end;
    end
    else
    if (C is TMenuItem) then
    begin
      if TMenuItem(C).Hint.Length>0 then
        if not Assigned(TMenuItem(C).Action) then TMenuItem(C).Caption := TMenuItem(C).Hint;
    end;
  end;

end;

end.
