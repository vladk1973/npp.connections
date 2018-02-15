unit connectionFormHelpersUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.ComCtrls, Vcl.WinXCtrls, TreeViewExUnit, plugin;

type

  TSmallWinControlHelper = class helper for TWinControl
    procedure ShowMe;
    procedure HideMe;
  end;

  TSplitViewHelper = class helper for TSplitView
  private
    const constInCatalog = 'Initial Catalog=%s;';
    const constConnectionMSSQL =  'Provider=SQLOLEDB.1;Password=%s;Persist Security Info=True;User ID=%s;%sData Source=%s';
    const constConnectionSybase = 'Provider=ASEOLEDB.1;Password=%s;Persist Security Info=True;User ID=%s;Data Source=%s:%s;%sExtended Properties="LANGUAGE=us_english";Connect Timeout=3';
    const constConnectionODBC = 'Provider=MSDASQL.1;Persist Security Info=False;Data Source=%s';
  public
    class function GetConnectionString(DataSource: string; const DataBase: string = ''): string;
    function CurrentTreeView: TTreeViewEx;
    function CurrentNode: TTreeNode;
    function CurrentBase: string;
    function CurrentUser: string;
    function CurrentServer: string;
    function ConnectionString: string;
    function BdType: TBdType;
  end;

implementation

{ TSplitViewHelper }

function TSplitViewHelper.BdType: TBdType;
var
  i: Integer;
begin
  for i := 0 to Self.ControlCount-1 do
  begin
    if (Self.Controls[i] is TTreeViewEx) and TTreeViewEx(Self.Controls[i]).Visible then
    begin
      Result := TTreeViewEx(Self.Controls[i]).BdType;
      break;
    end;
  end;
end;

function TSplitViewHelper.ConnectionString: string;
var
  Node: TTreeNode;
begin
  Result := '';
  Node := Self.CurrentNode;
  if Assigned(Node) then
  begin
    if Node.ItemType = itLogin then Exit;
    if Node.ItemType in [itServerMS,itServerSYB,itODBC] then
      Result := GetConnectionString(TTreeNodeEx(Node).DataSource);
    if Node.ItemType in [itBase,itBaseRTI] then
      Result := GetConnectionString(TTreeNodeEx(Node.Parent).DataSource,Node.Text);
  end;
end;

function TSplitViewHelper.CurrentBase: string;
var
  Node: TTreeNode;
begin
  Result := 'Unknown';
  Node := Self.CurrentNode;
  if Assigned(Node) then
  begin
    if Node.ItemType in [itBase,itBaseRTI] then
      Result := Node.Text;
  end;
end;

function TSplitViewHelper.CurrentNode: TTreeNode;
begin
  Result := CurrentTreeView.Selected;
end;

function TSplitViewHelper.CurrentServer: string;
var
  Node: TTreeNode;
begin
  Result := '';
  Node := Self.CurrentNode;
  if Assigned(Node) then
  begin
    if Assigned(Node.Parent) then Node := Node.Parent;
    Result := Node.Text;
  end;
end;

function TSplitViewHelper.CurrentTreeView: TTreeViewEx;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.ControlCount-1 do
    if (Self.Controls[i] is TTreeViewEx) and TTreeViewEx(Self.Controls[i]).Visible then
    begin
      Result := TTreeViewEx(Self.Controls[i]);
      break;
    end;
end;

function TSplitViewHelper.CurrentUser: string;
var
  Node: TTreeNode;
  i: Integer;
begin
  Result := 'Unknown';
  Node := Self.CurrentNode;
  if Assigned(Node) then
  begin
    if Assigned(Node.Parent) then Node := Node.Parent;
    for i := 0 to Node.Count-1 do
      if Node.Item[i].ItemType = itLogin then
      begin
        Result := Node.Item[i].Text;
        Exit;
      end;
  end;
end;

class function TSplitViewHelper.GetConnectionString(DataSource: string;
  const DataBase: string = ''): string;
var
  Strings: TStringList;
  DB,FServer,FPassword,FLogin,FDataSource,FPort: string;
begin
  Strings := TStringList.Create;
  try
    Strings.Delimiter := '|';
    Strings.DelimitedText := DataSource;
    DB := '';

    FDataSource := Strings[0];
    FServer := Strings.Values['Server'];
    FPort := Strings.Values['Port'];
    FLogin := Strings.Values['Login'];
    FPassword := Strings.Values['Password'];

    if DataBase <> '' then DB := Format(constInCatalog,[DataBase]);

    if TBdType(Strings.Values['BdType'].ToInteger) = bdMSSQL then
      Result := Format(constConnectionMSSQL,[FPassword,FLogin,DB,FDataSource])
    else
    if TBdType(Strings.Values['BdType'].ToInteger) = bdSybase then
      Result := Format(constConnectionSybase,[FPassword,FLogin,FServer,FPort,DB])
    else
    begin
      Result := Format(constConnectionODBC,[FDataSource]);
      if FLogin <> '' then Result := Result + ';User ID=' + FLogin;
      if FPassword <> '' then Result := Result + ';Password=' + FPassword;
    end;
  finally
    Strings.Free;
  end;
end;


{ TSmallWinControlHelper }

procedure TSmallWinControlHelper.HideMe;
begin
  Self.Align := alNone;
  Self.Visible := False;
end;

procedure TSmallWinControlHelper.ShowMe;
begin
  Self.Align := alClient;
  Self.Visible := True;
end;

end.
