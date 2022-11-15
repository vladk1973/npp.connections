unit regUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NppForms, StdCtrls, Buttons, ExtCtrls,
  ConstUnit,
  {$IFNDEF NPPCONNECTIONS}diaConstUnit,{$ENDIF}
  IniFiles, Registry, System.Actions;

type
  TOptionsReg = class
  public
    procedure SaveConnectToString(bd: TBdType; const Key,Value: string);
    function GetConnectToList(bd: TBdType): TStringList;

    class function GetConnectionString(bd: TBdType): string;

    {$IFNDEF NPPCONNECTIONS}
    class function GetPostgreSQLConvertString: string;
    {$ENDIF}

    class procedure SaveFavoriteConnection(bd: TBdType; const Key,Value: string);
    class procedure DeleteFavoriteConnection(bd: TBdType; const Value: string);
    class function GetFavoriteList(bd: TBdType): TStringList;

    class function GetVisibleStatusBDButton(bd: TBdType): boolean;
    class procedure SetVisibleStatusBDButton(bd: TBdType; const Value: boolean);

  end;

implementation

{ TOptionsReg }


function TOptionsReg.GetConnectToList(bd: TBdType): TStringList;
var
  i: Integer;
  Registry: TRegistry;
  Servers: TStringList;
begin
  Registry := TRegistry.Create(KEY_READ);
  Result := TStringList.Create;
  Servers := TStringList.Create;
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.OpenKeyReadOnly(cnstDllKey + '\' + constLoginBDCaptionArray[bd] + '\ConnectTo') then
      Registry.GetValueNames(Servers);

    if Servers.Count = 0 then Exit;
    Servers.Sorted := True;

    for i := 0 to Servers.Count - 1 do
    begin
      Result.Add(Registry.ReadString(Servers[i]));
    end;
  finally
    Registry.CloseKey;
    Registry.Free;
    Servers.Free;
  end;
end;

class function TOptionsReg.GetFavoriteList(bd: TBdType): TStringList;
var
  i: Integer;
  Registry: TRegistry;
  Servers: TStringList;
begin
  Registry := TRegistry.Create(KEY_READ);
  Result := TStringList.Create;
  Servers := TStringList.Create;
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.OpenKeyReadOnly(cnstDllKey + '\' + constLoginBDCaptionArray[bd] + '\Favorite') then
      Registry.GetValueNames(Servers);

    if Servers.Count = 0 then Exit;
    Servers.Sorted := True;

    for i := 0 to Servers.Count - 1 do
    begin
      Result.Add(Registry.ReadString(Servers[i]));
    end;
  finally
    Registry.CloseKey;
    Registry.Free;
    Servers.Free;
  end;
end;

{$IFNDEF NPPCONNECTIONS}
class function TOptionsReg.GetPostgreSQLConvertString: string;
var
  S: string;
  Registry: TRegistry;
begin
  S := '';
  Registry := TRegistry.Create(KEY_ALL_ACCESS);
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    Registry.CreateKey(cnstDllKey + '\' + constLoginBDCaptionArray[bdPostgreSQL] + '\Conversion');
    if Registry.OpenKey(cnstDllKey + '\' + constLoginBDCaptionArray[bdPostgreSQL] + '\Conversion',True) then
      S := Registry.ReadString('ConversionString');

    if S = '' then
    begin
      S := cnstConvert;
      Registry.WriteString('ConversionString', S);
    end;
  finally
    Registry.CloseKey;
    Registry.Free;
  end;

  Result := S;
end;
{$ENDIF}

class function TOptionsReg.GetVisibleStatusBDButton(bd: TBdType): boolean;
var
  Registry: TRegistry;
begin
  Result := True;
  Registry := TRegistry.Create(KEY_READ);
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.OpenKeyReadOnly(cnstDllKey + '\' + constLoginBDCaptionArray[bd] + '\Visible\') then
      Result := Registry.ReadBool('Visible');
  finally
    Registry.CloseKey;
    Registry.Free;
  end;
end;

class procedure TOptionsReg.SetVisibleStatusBDButton(bd: TBdType;
  const Value: boolean);
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create(KEY_WRITE or KEY_WOW64_64KEY);
  try
    try
      Registry.RootKey := HKEY_CURRENT_USER;
      Registry.CreateKey(cnstDllKey + '\' + constLoginBDCaptionArray[bd] + '\Visible');
      if Registry.OpenKey(cnstDllKey + '\' + constLoginBDCaptionArray[bd] + '\Visible',True) then
        Registry.WriteBool('Visible', Value);
    finally
      Registry.CloseKey;
    end;
  finally
    Registry.Free;
  end;
end;

class procedure TOptionsReg.DeleteFavoriteConnection(bd: TBdType; const Value: string);
var
  Registry: TRegistry;
  Deleted: boolean;
begin
  Registry := TRegistry.Create(KEY_ALL_ACCESS or KEY_WOW64_64KEY);
  try
    try
      Registry.RootKey := HKEY_CURRENT_USER;
      if Registry.OpenKey(cnstDllKey + '\' + constLoginBDCaptionArray[bd] + '\Favorite',True) then
        Deleted := Registry.DeleteValue(Value);
    finally
      Registry.CloseKey;
    end;
  finally
    Registry.Free;
  end;
end;

class function TOptionsReg.GetConnectionString(bd: TBdType): string;
var
  S: string;
  Registry: TRegistry;
begin
  S := '';
  Registry := TRegistry.Create(KEY_ALL_ACCESS);
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    Registry.CreateKey(cnstDllKey + '\' + constLoginBDCaptionArray[bd] + '\Connection');
    if Registry.OpenKey(cnstDllKey + '\' + constLoginBDCaptionArray[bd] + '\Connection',True) then
      S := Registry.ReadString('ConnectionString');

    if S = '' then
    begin
      S := constConnectionStringArray[bd];
      Registry.WriteString('ConnectionString', S);
    end;
  finally
    Registry.CloseKey;
    Registry.Free;
  end;

  Result := S;
end;

procedure TOptionsReg.SaveConnectToString(bd: TBdType; const Key,Value: string);
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create(KEY_WRITE or KEY_WOW64_64KEY);
  try
    try
      Registry.RootKey := HKEY_CURRENT_USER;
      Registry.CreateKey(cnstDllKey + '\' + constLoginBDCaptionArray[bd] + '\ConnectTo');
      if Registry.OpenKey(cnstDllKey + '\' + constLoginBDCaptionArray[bd] + '\ConnectTo',True) then
        Registry.WriteString(Key, Value);
    finally
      Registry.CloseKey;
    end;
  finally
    Registry.Free;
  end;
end;

class procedure TOptionsReg.SaveFavoriteConnection(bd: TBdType; const Key,
  Value: string);
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create(KEY_WRITE or KEY_WOW64_64KEY);
  try
    try
      Registry.RootKey := HKEY_CURRENT_USER;
      Registry.CreateKey(cnstDllKey + '\' + constLoginBDCaptionArray[bd] + '\Favorite');
      if Registry.OpenKey(cnstDllKey + '\' + constLoginBDCaptionArray[bd] + '\Favorite',True) then
        Registry.WriteString(Key, Value);
    finally
      Registry.CloseKey;
    end;
  finally
    Registry.Free;
  end;
end;

end.
