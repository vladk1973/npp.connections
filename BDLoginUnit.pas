unit BDLoginUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  System.IniFiles, System.Win.Registry, System.Actions, Vcl.ActnList,
  plugin, NppForms;

type
  TBDLoginForm = class(TNppForm)
    Panel1: TPanel;
    Panel2: TPanel;
    OkBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox1: TGroupBox;
    Panel3: TPanel;
    ServerList: TComboBox;
    Login: TComboBox;
    SLabel: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Password: TEdit;
    Image1: TImage;
    ActionList1: TActionList;
    OkAction: TAction;
    procedure FormActivate(Sender: TObject);
    procedure PasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LoginKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ServerListDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure OkActionExecute(Sender: TObject);
    procedure OkActionUpdate(Sender: TObject);
  private
    { Private declarations }
    FBDType: TBdType;
    procedure FillDSNList(Strings: TStrings);

    const cnstMSSqlServersKey0 = 'SOFTWARE\Microsoft\MSSQLServer\Client\ConnectTo';
    const cnstMSSqlServersKey1 = 'SOFTWARE\Wow6432Node\Microsoft\MSSQLServer\Client\ConnectTo';
    const cnstItem = '%s|Server=%s|Port=%s';
    const cnstData = '|Login=%s|Password=%s|BdType=%d';
    const cnstSrcSybase = 'SQL.INI';
    const cnstSybaseName = 'SYBASE';
    const cnstSybaseRoot = 'SYBROOT';
    const cnstNothing = 'Empty list';

    procedure FillNothing;
    procedure FillServerListMS;
    procedure FillServerListSyb;
    procedure FillODBCSources;
  public
    const constDBList = 'select name from master..sysdatabases order by name';

    procedure Get(var aDataSource,aServer,aPort,aLogin,aPassword: string);
    function Data: string;
    property BDType: TBdType read FBDType write FBDType;
  end;


implementation

//ODBC


function SQLDataSources(EnvironmentHandle:LongWord;Direction:Smallint;
    ServerName:PAnsiChar;BufferLength1:Smallint;NameLength1Ptr:PSmallInt;
    Description:PAnsiChar;BufferLength2:Smallint;NameLength2Ptr:PSmallInt): Smallint; stdcall; external 'odbc32.dll';
function SQLAllocHandle(HandleType:Smallint;InputHandle:Smallint;
    OutputHandlePtr:Pointer): Smallint; stdcall; external 'odbc32.dll';
function SQLSetEnvAttr(EnvironmentHandle:LongWord;Attribute:Integer;
    ValuePtr:Pointer;StringLength:Integer): Smallint; stdcall; external 'odbc32.dll';
function SQLFreeHandle(HandleType:Smallint;Handle:LongWord): Smallint; stdcall; external 'odbc32.dll';
function SQLAllocEnv(var phenv: Pointer):Smallint; stdcall; external 'odbc32.dll';

function SQLAllocConnect(henv: Pointer;var phdbc: Pointer):Smallint; stdcall; external 'odbc32.dll';

{$R *.dfm}

procedure TBDLoginForm.FillDSNList(Strings: TStrings);
const
  MAX_BUF=1024;
  SQL_HANDLE_ENV=1;
  SQL_NULL_HENV=0;
  SQL_ATTR_ODBC_VERSION=200;
  SQL_IS_INTEGER=-6;
  SQL_FETCH_FIRST_USER=31;
  SQL_FETCH_FIRST=2;
  SQL_FETCH_NEXT=1;
  SQL_OV_ODBC3=3;
  SQL_NO_DATA=100;
var
  datasrc,descrip:array [0..MAX_BUF-1] of AnsiChar;
  direction:Smallint;
  rdsrc,rdesc:SmallInt;
  hEnv:Cardinal;
begin
  rdsrc:=0;
  rdesc:=0;
  datasrc[0]:=#0;
  descrip[0]:=#0;
  SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HENV, @hEnv);
  SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION,POINTER(SQL_OV_ODBC3),SQL_IS_INTEGER);
  direction:=SQL_FETCH_FIRST;
  Strings.Clear;
  while (SQLDataSources(hEnv,direction,@datasrc[0],MAX_BUF,@rdsrc,@descrip[0],MAX_BUF,@rdesc)<>SQL_NO_DATA) do
  begin
    Strings.Add(AnsiString(datasrc)+ '||');
    direction:=SQL_FETCH_NEXT;
  end;
  SQLFreeHandle(SQL_HANDLE_ENV, hEnv);
end;

function TBDLoginForm.Data: string;
var
  i: Integer;
begin
  i := ServerList.ItemIndex;
  if i >= 0 then
    Result := ServerList.Items[ServerList.ItemIndex] +
      Format(cnstData,[Login.Text,Password.Text,Integer(FBdType)])
  else
    Result := '';
end;

procedure TBDLoginForm.FillNothing;
begin
  ServerList.Clear;
  ServerList.AddItem(cnstNothing,Pointer(1));
  ServerList.ItemIndex := 0;
  ServerList.Enabled := False;
  OkBtn.Enabled := False;
end;

procedure TBDLoginForm.FillODBCSources;
begin
  ServerList.clear;
  FillDSNList(ServerList.Items);
  if ServerList.Items.Count = 0 then
  begin
    FillNothing;
    Exit;
  end
  else
    ServerList.ItemIndex := 0;
end;

procedure TBDLoginForm.FillServerListMS;
var
  Registry: TRegistry;
  Servers,Servers32 : TStringList;
  i,j: integer;
  S,FDataSource,FServer,FPort: string;
begin
  Registry := TRegistry.Create(KEY_READ);
  Servers := TStringList.Create;
  Servers.Duplicates := dupIgnore;
  Servers32 := TStringList.Create;
  Servers32.Duplicates := dupIgnore;
  try
    try
      Registry.RootKey := HKEY_LOCAL_MACHINE;
      if Registry.OpenKey(cnstMSSqlServersKey0, False) then
        Registry.GetValueNames(Servers);

      if Registry.OpenKey(cnstMSSqlServersKey1, False) then
          Registry.GetValueNames(Servers32);

      Servers.AddStrings(Servers32);

      if Servers.Count = 0 then
      begin
        FillNothing;
        Exit;
      end;

      Servers.Sorted := True;
      for i := 0 to Servers.Count - 1 do
      begin
        S := Registry.ReadString(Servers[i]);

        FDataSource := Servers[i];

        j := Pos(',',S);
        if j > 0 then
        begin
          FServer := Copy(S,j+1,MaxInt);
          j := Pos(',',FServer);

          if j > 0 then
          begin
            FPort := Copy(FServer,j+1,MaxInt);
            FServer := Copy(FServer,1,j-1);
          end;
        end;

        ServerList.AddItem(Format(cnstItem,[FDataSource,FServer,FPort]),nil);
      end;
    finally
      Registry.CloseKey;
    end;
  finally
    Registry.Free;
    Servers.Free;
    Servers32.Free;
    if ServerList.Items.Count > 0 then ServerList.ItemIndex := 0;
  end;
end;

procedure TBDLoginForm.FillServerListSyb;
  procedure GetEnvironmentStrings(Vars: TStrings);
  var
    ptr: LPWSTR;
    s: string;
    Done: boolean;
  begin
    Vars.Clear;
    s := '';
    Done := FALSE;
    ptr := Winapi.Windows.GetEnvironmentStrings;
    while Done = false do begin
      if ptr^ = #0 then begin
        inc(ptr);
        if ptr^ = #0 then Done := TRUE
        else Vars.Add(s);
        s := ptr^;
      end else s := s + ptr^;
      inc(ptr);
    end;
  end;
var
  Strings: TStringList;
  i,j: integer;
  FIni: TIniFile;
  S,FDataSource,FServer,FPort,FName: string;
begin
  Strings := TStringList.Create;
  try
    FName := '';
    GetEnvironmentStrings(Strings);
    for i := 0 to Strings.Count-1 do
      if (Strings.Names[i] = cnstSybaseName) or (Strings.Names[i] = cnstSybaseRoot) then
      begin
        FName := Strings.Values[Strings.Names[i]];
        break;
      end;

    if FName = '' then
    begin
      FillNothing;
      Exit;
    end;

    FName := IncludeTrailingPathDelimiter(FName) + 'ini\' + cnstSrcSybase;
    if FileExists(FName) then
    begin
      FIni := TIniFile.Create(FName);
      try
        Strings.Clear;
        FIni.ReadSections(Strings);
        Strings.Sorted := True;

        for i := 0 to Strings.Count - 1 do
        begin
          FDataSource := Strings[i];
          S := FIni.ReadString(FDataSource,'query','');
          j := Pos(',',S);
          if j > 0 then
          begin
            FServer := Copy(S,j+1,MaxInt);
            j := Pos(',',FServer);

            if j > 0 then
            begin
              FPort := Copy(FServer,j+1,MaxInt);
              FServer := Copy(FServer,1,j-1);
            end;
          end;
          ServerList.AddItem(Format(cnstItem,[FDataSource,FServer,FPort]),nil);
        end;
      finally
        FIni.Free;
      end;
    end
    else
    begin
      FillNothing;
      Exit;
    end;
  finally
    Strings.Free;
    if ServerList.Items.Count > 0 then ServerList.ItemIndex := 0;
  end;
end;

procedure TBDLoginForm.FormActivate(Sender: TObject);
begin
  inherited;
  Caption := constLoginBDCaption + constLoginBDCaptionArray[FBDType];
  SLabel.Caption := constDSBDCaptionArray[FBDType];
  ServerList.Clear;
  if FBDType = bdMSSQL then
    FillServerListMS
  else
  if FBDType = bdSybase then
    FillServerListSyb
  else
  begin
    FillODBCSources;
    OkAction.OnUpdate := nil;
  end;
end;

procedure TBDLoginForm.Get(var aDataSource, aServer, aPort, aLogin,
  aPassword: string);
var
  Strings: TStringList;
  i: Integer;
begin
  i := ServerList.ItemIndex;
  if i >= 0 then
  begin
    Strings := TStringList.Create;
    try
      Strings.Delimiter := '|';
      Strings.DelimitedText := ServerList.Items[ServerList.ItemIndex];
      aDataSource := Strings[0];
      aServer := Strings[1];
      aPort := Strings[2];
      aLogin := Login.Text;
      aPassword := Password.Text;
    finally
      Strings.Free;
    end;
  end;
end;

procedure TBDLoginForm.PasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then OkBtn.Click;
  if Key = VK_ESCAPE then CancelBtn.Click;
end;

procedure TBDLoginForm.ServerListDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  Bitmap: TBitmap;
  Offset: Integer;
  S: string;
begin
  with (Control as TComboBox).Canvas do  { Draw on control canvas, not on the form. }
  begin
    S := (Control as TComboBox).Items[Index];
    FillRect(Rect);       { Clear the rectangle. }
    Offset := 2;          { Provide default offset. }

    if Pos('|',S) = 0 then
      Offset := 6
    else
    begin
      Bitmap := Image1.Picture.Bitmap;
      if Bitmap <> nil then
      begin
        //DrawIcon(Handle, Rect.Left + Offset, Rect.Top, Icon.Handle);
        BrushCopy(
        Bounds(Rect.Left + Offset, Rect.Top+2, Bitmap.Width, Bitmap.Height),
        Bitmap,
        Bounds(0, 0, Bitmap.Width, Bitmap.Height),
        clWhite);  {render bitmap}
        Offset := Bitmap.width + 6;    { Add four pixels between bitmap and text. }
      end;
      S := Copy(S,1,Pos('|',S)-1);
    end;

    TextOut(Rect.Left + Offset, Rect.Top+1, S);
  end;
end;

procedure TBDLoginForm.LoginKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then CancelBtn.Click;
end;

procedure TBDLoginForm.OkActionExecute(Sender: TObject);
begin
  OkBtn.Enabled := False;
  Self.Refresh;
end;

procedure TBDLoginForm.OkActionUpdate(Sender: TObject);
begin
  OkAction.Enabled := (Login.Text <> '') and
                     (Password.Text  <> '');
end;

end.
