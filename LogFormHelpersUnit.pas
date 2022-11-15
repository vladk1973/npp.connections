unit LogFormHelpersUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Winapi.ShellApi,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.OleCtrls,
  SHDocVw, Vcl.Grids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ActnCtrls,
  TreeViewExUnit, ConstUnit, NppDockingForms, nppplugin, regUnit,
  Vcl.ExtCtrls, Vcl.CategoryButtons, Vcl.WinXCtrls, Vcl.ActnPopup,
  ExtScrollingWinControlUnit;


type

  TNppPluginHelper = class helper for TNppPlugin
  private
    const AdmServerPath = 'AdminToolKit\Server\';
    const AdmServerFile = AdmServerPath + 'Include\Macro.h';
  public
    function InstallerLogPath(const Path: TPathName): string;
  end;

  TSmallWinControlHelper = class helper for TWinControl
    procedure ShowMe;
    procedure HideMe;
  end;

  TSplitViewHelper = class helper for TSplitView
  private
    const constInCatalog = 'Initial Catalog=%s;';
    const constInPgCatalog = 'DATABASE=%s';
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

  TPanelHelper = class helper for TPanel
  private
    function GetExScrollBox: TExScrollBox;
    procedure SetExScrollBox(const Value: TExScrollBox);
    function GetPushed: boolean;
    procedure SetPushed(const Value: boolean);
    function GetBDType: TBdType;
  public

    function GetCurrentScrollBox: TExScrollBox;
    function FindPanelByScrollBox(ScrollBox: TExScrollBox): TPanel;

    function NextButton(NPanel: TPanel): TPanel;
    function PrevButton(NPanel: TPanel): TPanel;
    procedure RemoveExScrollBoxes(FromComponent: TWinControl);
    procedure Click;
    property ExScrollBox: TExScrollBox read GetExScrollBox write SetExScrollBox;
    property Pushed: boolean read GetPushed write SetPushed;
    property BDType: TBdType read GetBDType;
  end;


implementation

//Provider=MSDASQL.1;Password=123456;Persist Security Info=True;User ID=diasoft;Extended Properties="DRIVER={PostgreSQL Unicode};SERVER=eisrko;PORT=5432;DATABASE=postgres"

{ TNppPluginHelper }

function TNppPluginHelper.InstallerLogPath(const Path: TPathName): string;
var
  S: string;
begin
  Result := '';
  if Path <> '' then
  begin
    S := ExtractFilePath(Path) + '..\..\';
    if FileExists(S + AdmServerFile) then
    begin
      Result := S + AdmServerPath;
      Exit;
    end;
    S := S + '..\';
    if FileExists(S + AdmServerFile) then
    begin
      Result := S + AdmServerPath;
      Exit;
    end;
    S := S + '..\';
    if FileExists(S + AdmServerFile) then
    begin
      Result := S + AdmServerPath;
      Exit;
    end;
  end;
end;

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
    if Node.ItemType in [itODBC] then
      Result := GetConnectionString(TTreeNodeEx(Node).DataSource);
    {if Node.ItemType in [itServerMS,itServerSYB] then
      Result := GetConnectionString(TTreeNodeEx(Node).DataSource);
    if Node.ItemType in [itServerPostgreSQL] then
      Result := GetConnectionString(TTreeNodeEx(Node).DataSource,'postgres');}
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



    if TBdType(Strings.Values['BdType'].ToInteger) = bdMSSQL then
    begin
      if DataBase <> '' then DB := Format(constInCatalog,[DataBase]);
      Result := Format(TOptionsReg.GetConnectionString(bdMSSQL),[FPassword,FLogin,DB,FServer+','+FPort]);
    end
    else
    if TBdType(Strings.Values['BdType'].ToInteger) = bdSybase then
    begin
      if DataBase <> '' then DB := Format(constInCatalog,[DataBase]);
      Result := Format(TOptionsReg.GetConnectionString(bdSybase),[FPassword,FLogin,FServer,FPort,DB]);
    end
    else
    if TBdType(Strings.Values['BdType'].ToInteger) = bdPostgreSQL then
    begin
      if DataBase <> '' then DB := Format(constInPgCatalog,[DataBase]);
      Result := Format(TOptionsReg.GetConnectionString(bdPostgreSQL),[FPassword,FLogin,FServer,FPort,DB]);
    end
    else
    begin
      Result := Format(TOptionsReg.GetConnectionString(bdODBC),[FDataSource]);
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

{ TPanelHelper }

procedure TPanelHelper.Click;
begin
  Self.OnClick(Self);
end;

function TPanelHelper.FindPanelByScrollBox(ScrollBox: TExScrollBox): TPanel;
begin
  Result := TPanel(Self.FindComponent(Copy(ScrollBox.Name,2,MaxInt)));
end;

function TPanelHelper.GetBDType: TBdType;
var
  fBdType: TBdType;
begin
  for fBdType := Low(TBdType) to High(TBdType) do
    if constLoginBDCaptionArray[fBdType][1] = Self.Caption[1] then break;
  Result := fBdType;
end;

function TPanelHelper.GetCurrentScrollBox: TExScrollBox;
var
  i: Integer;
  ChildPanel: TPanel;
begin
  Result := nil;
  for i := 0 to Self.ControlCount-1 do
    if (Self.Controls[i] is TPanel) and Self.Controls[i].Visible then
    begin
      ChildPanel := TPanel(Self.Controls[i]);
      if ChildPanel.Pushed then
      begin
        Result := ChildPanel.ExScrollBox;
        Exit;
      end;
    end;
end;

function TPanelHelper.GetExScrollBox: TExScrollBox;
var
  C: TComponent;
begin
  C := Self.Owner.FindComponent('sql');
  Result := TExScrollBox(C.FindComponent('s'+Self.Name));
end;

function TPanelHelper.GetPushed: boolean;
begin
  Result := Self.Tag=100;
end;

procedure TPanelHelper.RemoveExScrollBoxes(FromComponent: TWinControl);
var
  i: Integer;
  EBox: TExScrollBox;
begin
  for i := 0 to FromComponent.ControlCount-1 do
    if FromComponent.Controls[i] is TExScrollBox then
    begin
      EBox := TExScrollBox(FromComponent.Controls[i]);
      FromComponent.RemoveComponent(EBox);
      Ebox.Free;
    end;
end;

procedure TPanelHelper.SetExScrollBox(const Value: TExScrollBox);
var
  i: Integer;
  sql: TPanel;
  EBox: TExScrollBox;
begin
  if Value = nil then
  begin
    sql := TPanel(Self.Owner.FindComponent('sql'));
    for i := 0 to sql.ControlCount-1 do
      if sql.Controls[i] is TExScrollBox then
      begin
        EBox := TExScrollBox(sql.Controls[i]);
        if EBox.Controller = Self then
        begin
          sql.RemoveComponent(EBox);
          Ebox.Free;
          Exit;
        end;
      end;
  end
  else
  begin
    Value.Controller := Self;
    Value.Name := 's'+Self.Name;
  end;
end;

procedure TPanelHelper.SetPushed(const Value: boolean);
begin
  if Value then
    Self.Tag := 100
  else
    Self.Tag :=0;
end;

function TPanelHelper.NextButton(NPanel: TPanel): TPanel;
var
  i: Integer;
  ChildPanel: TPanel;
begin
  Result := nil;
  for i := 0 to Self.ControlCount-1 do
    if (Self.Controls[i] is TPanel)
       and (Self.Controls[i] <> NPanel)
       and (TWinControl(Self.Controls[i]).Left = NPanel.Left) then
    begin
      ChildPanel := TPanel(Self.Controls[i]);
      break;
    end;
  if Assigned(ChildPanel) then
  begin
    if ChildPanel.Name = 'P10' then
      NPanel.Caption := '<<';
    NPanel.Left := NPanel.Left + ChildPanel.Width;
    Result := ChildPanel;
  end;
end;

function TPanelHelper.PrevButton(NPanel: TPanel): TPanel;
var
  i: Integer;
  ChildPanel: TPanel;
begin
  Result := nil;
  for i := 0 to Self.ControlCount-1 do
    if (Self.Controls[i] is TPanel)
       and (Self.Controls[i] <> NPanel)
       and ((TWinControl(Self.Controls[i]).Left + TWinControl(Self.Controls[i]).Width)= NPanel.Left) then
    begin
      ChildPanel := TPanel(Self.Controls[i]);
      break;
    end;
  if Assigned(ChildPanel) then
  begin
    if ChildPanel.Name = 'P2' then
      NPanel.Caption := '>>';
    NPanel.Left := ChildPanel.Left;
    Result := ChildPanel;
  end;
end;

end.
