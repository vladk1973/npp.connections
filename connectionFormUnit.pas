unit connectionFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.Math, Winapi.ShellApi,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.OleCtrls,
  SHDocVw, Vcl.Grids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ActnCtrls,
  StringGridsUnit, ExtScrollingWinControlUnit, NppDockingForms, nppplugin,
  Vcl.ExtCtrls, Vcl.WinXCtrls, Vcl.ActnPopup,
  plugin, TreeViewExUnit;

type
  TconnectionForm = class(TNppDockingForm)
    Images: TImageList;
    ActionManager1: TActionManager;
    SQLAction: TAction;
    CopyGridRowAction: TAction;
    CopyAllGridAction: TAction;
    ConnectAction: TAction;
    DisonnectSQLAction: TAction;
    AfterSQLAction: TAction;
    BasesPanel: TSplitView;
    OpenListBDAction: TAction;
    TreeImageList: TImageList;
    msModeAction: TAction;
    sybModeAction: TAction;
    ActionToolBar2: TActionToolBar;
    AfterAddServerAction: TAction;
    invTreeView: TTreeView;
    Panel1: TPanel;
    TabControl: TTabControl;
    sql: TPanel;
    invGrid: TStringGrid;
    ResultLabel: TPanel;
    TreeViewPopupMenu: TPopupMenu;
    N8: TMenuItem;
    N9: TMenuItem;
    GridMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    RefreshButton: TToolButton;
    ToolButton3: TToolButton;
    RefreshMenu: TPopupMenu;
    odbcModeAction: TAction;
    tabPopupMenu: TPopupMenu;
    DeleteTabAction: TAction;
    N6: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure SQLActionExecute(Sender: TObject);
    procedure CopyAllGridActionExecute(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure OpenListBDActionExecute(Sender: TObject);
    procedure ConnectActionExecute(Sender: TObject);
    procedure msModeActionExecute(Sender: TObject);
    procedure sybModeActionExecute(Sender: TObject);
    procedure AfterAddServerActionExecute(Sender: TObject);
    procedure msTreeViewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DisonnectSQLActionExecute(Sender: TObject);
    procedure DisonnectSQLActionUpdate(Sender: TObject);
    procedure AfterSQLActionExecute(Sender: TObject);
    procedure CopyGridRowActionExecute(Sender: TObject);
    procedure odbcModeActionExecute(Sender: TObject);
    procedure DeleteTabActionUpdate(Sender: TObject);
    procedure DeleteTabActionExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    msTreeView: TTreeViewEx;
    sybTreeView: TTreeViewEx;
    odbcTreeView: TTreeViewEx;

    FCurrentNode: TTreeNode;
    FMenuItemCheck: TMenuItemCheck;
    procedure SetMenuItemCheck(const Value: TMenuItemCheck);

    const MaxTabIndex = 10;

    function CreateBox: TExScrollBox;
    procedure HideAllExcept(const aIndex: Integer);
    procedure WMThreadMessage(var Msg: TMessage); message WM_USER_MESSAGE_FROM_THREAD;

    procedure FillResultGrid(Results: TObjectStrings);

    procedure SetCurrentNode(const Value: TTreeNode);
    function GetResultPanel: TExScrollBox;
  protected
    property CurrentNode: TTreeNode read FCurrentNode write SetCurrentNode;
    property ResultPanel: TExScrollBox read GetResultPanel;
  public
    procedure DoSql(const SqlText: string);
    procedure DoConnect;
    procedure Carousel;
    property MenuItemCheck: TMenuItemCheck read FMenuItemCheck write SetMenuItemCheck;
  end;

implementation

uses
  Vcl.Clipbrd,
  ThreadUnit,StringGridExUnit,
  SqlThreadUnit,
  BDLoginUnit, connectionFormHelpersUnit;


{$R *.dfm}

procedure TconnectionForm.DeleteTabActionExecute(Sender: TObject);
var
  aIndex: Integer;
  EBox: TExScrollBox;
begin
  aIndex := TabControl.TabIndex;
  if aIndex = TabControl.Tabs.Count-2 then
   TabControl.TabIndex := TabControl.TabIndex-1
  else
   TabControl.TabIndex := TabControl.TabIndex+1;


  HideAllExcept(TabControl.TabIndex);
  EBox := TExScrollBox(TabControl.Tabs.Objects[aIndex]);
  TabControl.Tabs.Delete(aIndex);

  sql.RemoveComponent(EBox);
  Ebox.Free;
end;

procedure TconnectionForm.DeleteTabActionUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (TabControl.Tabs.Count>2)
    and (TabControl.TabOrder < (TabControl.Tabs.Count-1));
end;

procedure TconnectionForm.DisonnectSQLActionExecute(Sender: TObject);
var
  TreeNode: TTreeNode;
begin
  inherited;
  TreeNode := BasesPanel.CurrentNode;
  if Assigned(TreeNode) then
  begin
    if Assigned(TreeNode.Parent) then
      TreeNode := TreeNode.Parent;
    TreeNode.Delete;
  end;
end;

procedure TconnectionForm.DisonnectSQLActionUpdate(Sender: TObject);
var
  TreeNode: TTreeNode;
begin
  inherited;
  TreeNode := BasesPanel.CurrentNode;
  if Assigned(TreeNode) then
    TAction(Sender).Enabled := TreeNode.ItemType in [itServerMS,itServerSYB,itODBC]
  else
    TAction(Sender).Enabled := False;
end;

procedure TconnectionForm.Carousel;
begin
  if MenuItemCheck  = miShown then
    Hide
  else
  begin
    Show;
    MenuItemCheck := miShown;
  end;
end;

procedure TconnectionForm.ConnectActionExecute(Sender: TObject);
var
  FBDLoginForm: TBDLoginForm;
  BDType: TBdType;
  TreeView: TTreeViewEx;
  Data: string;
  Node: TTreeNode;
  SqlThread: TSqlQueryObject;
begin
  FBDLoginForm := TBDLoginForm.Create(Npp);
  BdType := BasesPanel.BdType;
  try
    FBDLoginForm.BDType := BdType;

    if FBDLoginForm.ShowModal = mrOK then
    begin
      TreeView := BasesPanel.CurrentTreeView;
      Data := FBDLoginForm.Data;
      Node := TreeView.NodeFoundByDataSource(TreeView,Data);
      if Assigned(Node) then
      begin
        Node.Selected := True;
        Node.Expanded := True
      end
      else
      begin
        SqlThread := TSqlQueryObject.Create;
        SqlThread.Description := Data;
        SqlThread.BdType := BdType;

        if BdType <> bdODBC then
          SqlThread.SQL.Text := FBDLoginForm.constDBList;

        SqlThread.ConnectionString := TSplitView.GetConnectionString(Data);
        SqlThread.OnAfterAction := AfterAddServerAction;
        SqlThread.WinHandle := self.Handle;
        SqlThread.Start; //Запрашивам список баз
      end;
    end;
  finally
    FBDLoginForm.Free;
  end;
end;

procedure TconnectionForm.CopyAllGridActionExecute(Sender: TObject);
begin
  if Self.ActiveControl is TStringGridEx then
    TStringGridEx(Self.ActiveControl).CopyAllToClipboard;
end;

procedure TconnectionForm.CopyGridRowActionExecute(Sender: TObject);
begin
  if Self.ActiveControl is TStringGridEx then
    TStringGridEx(Self.ActiveControl).CopyToClipboard;
end;

procedure TconnectionForm.AfterAddServerActionExecute(Sender: TObject);
var
  Obj: TSqlQueryObject;
  TreeView: TTreeViewEx;
begin
  Obj := TSqlQueryObject(TAction(Sender).Tag);
  if Obj.ErrMessage = '' then
  begin
    case Obj.BdType of
      bdMSSQL: TreeView := msTreeView;
      bdSybase: TreeView := sybTreeView;
    else
      TreeView := odbcTreeView;
    end;

    TreeView.AddServer(Obj.Description,Obj.Login,Obj.Query);
  end
  else
   MessageError(Obj.ErrMessage,cnstErroCaption);
end;


procedure TconnectionForm.AfterSQLActionExecute(Sender: TObject);
  function GetDots(const S: string): string;
  begin
    if length(S) > 150 then
      Result := '...'
    else
      Result := '';
  end;
  procedure SetItem(const Value: string);
  var
    i: integer;
    NewItem: TMenuItem;
    S: string;
  begin
    if Length(Value) > 3 then
    begin
      for i := 0 to RefreshMenu.Items.Count - 1 do
        if RefreshMenu.Items[i].Hint = Value then Exit;

      S := Trim(StringReplace(Value,sLineBreak,' ',[rfReplaceAll]));
      NewItem := TMenuItem.Create(RefreshMenu);
      RefreshMenu.Items.Add(NewItem);
      NewItem.Caption := Copy(S,1,150) + GetDots(S);
      NewItem.Hint := Value;
      NewItem.OnClick := SQLActionExecute;
      NewItem.ImageIndex := 0;
    end
  end;


var
  Obj: TSqlExecutorObject;
begin
  Obj := TSqlExecutorObject(TAction(Sender).Tag);
  if Obj.ErrMessage = '' then
  begin
    FillResultGrid(Obj.Grids);
    SetItem(Obj.Description);//Add menu Item

    if MenuItemCheck = miHidden then Carousel;
  end
  else
   MessageError(Obj.ErrMessage,cnstErroCaption);
end;

procedure TconnectionForm.DoConnect;
begin
  ConnectAction.Execute;
end;

procedure TconnectionForm.DoSql(const SqlText: string);
var
  SqlThread: TSqlExecutorObject;
  CString,CName: string;
begin
  CString := BasesPanel.ConnectionString;
  CName := Format(cnstSqlExec,[
                               BasesPanel.CurrentServer,
                               BasesPanel.CurrentBase,
                               BasesPanel.CurrentUser
                               ]);
  if CString = '' then
  begin
    CString := ResultPanel.ConnectionString;
    CName   := ResultPanel.Description;
  end;

  if CString <> '' then
  begin
    SqlThread := TSqlExecutorObject.Create;
    SqlThread.Description := SqlText.Trim;
    SqlThread.BdType := BasesPanel.BdType;
    SqlThread.SQL.Text := SqlThread.Description;
    SqlThread.Name := CName;
    SqlThread.ConnectionString := CString;
    SqlThread.OnAfterAction := AfterSQLAction;
    SqlThread.WinHandle := self.Handle;
    SqlThread.Start;
  end
  else
    MessageError(cnstNoBaseSelected,cnstErroCaption);
end;

procedure TconnectionForm.FormCreate(Sender: TObject);
begin
  NppDefaultDockingMask := DWS_DF_FLOATING;
  FMenuItemCheck := miHidden;

  msTreeView := TTreeViewEx.Create(Self);
  msTreeView.Parent := BasesPanel;
  msTreeView.Images := TreeImageList;
  msTreeView.PopupMenu := TreeViewPopupMenu;
  msTreeView.BdType := bdMSSQL;

  sybTreeView := TTreeViewEx.Create(Self);
  sybTreeView.Parent := BasesPanel;
  sybTreeView.Images := TreeImageList;
  sybTreeView.PopupMenu := TreeViewPopupMenu;
  sybTreeView.BdType := bdSybase;


  odbcTreeView := TTreeViewEx.Create(Self);
  odbcTreeView.Parent := BasesPanel;
  odbcTreeView.Images := TreeImageList;
  odbcTreeView.PopupMenu := TreeViewPopupMenu;
  odbcTreeView.BdType := bdODBC;

  TabControl.Tabs.Objects[0] := CreateBox;
  TabControl.Tabs.Objects[1] := nil;
  msModeAction.Execute;
end;

procedure TconnectionForm.FormDestroy(Sender: TObject);
var
  i: Integer;
  EBox: TExScrollBox;
begin
  for i := 0 to TabControl.Tabs.Count-1 do
    if Assigned(TabControl.Tabs.Objects[i]) then
    begin
      EBox := TExScrollBox(TabControl.Tabs.Objects[i]);
      try
        sql.RemoveComponent(EBox);
      finally
        Ebox.Free;
        TabControl.Tabs.Objects[i] := nil;
      end;
    end;
end;

procedure TconnectionForm.FormHide(Sender: TObject);
begin
  MenuItemCheck := miHidden;
end;

procedure TconnectionForm.FillResultGrid(Results: TObjectStrings);
var i,j,k,maxWidthGrid,aTop: integer;
    Temp: TComponent;
    Grid: TStringGridEx;
begin
  ResultLabel.Caption := Results.Name;

  maxWidthGrid := 0;
  Grid := nil;
  try

    for i := ResultPanel.ControlCount - 1 downto 0 do
    begin
      Temp := ResultPanel.Controls[i];
      if (Temp is TStringGrid) or (Temp is TButton) then
      begin
        ResultPanel.RemoveComponent(Temp);
        Temp.Free;
      end;
    end;

    ResultPanel.HorzScrollBar.Range := MaxInt;
    ResultPanel.VertScrollBar.Range:= MaxInt;
    ResultPanel.DisableAlign;
    ResultPanel.Description := Results.Name;
    ResultPanel.ConnectionString := Results.ConnectionString;


    Results.OwnsObjects := False;
    aTop := 0;
    for i := 0 to Results.Count - 1 do
    begin
      Grid := TStringGridEx(Results[i]);
      Grid.Parent := ResultPanel;
      ResultPanel.InsertComponent(Grid);

      Grid.Align := alTop;
      Grid.FixedCols := 0;

      if Grid.RowCount > 1 then
        Grid.FixedRows := 1
      else
        Grid.FixedRows := 0;

      Grid.Options := Grid.Options + [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goColSizing];
      if (Grid.ColCount = 1) and (Grid.RowCount = 1) then Grid.Options := [];


      Grid.Font.Assign(invGrid.Font);
      Grid.PopupMenu := GridMenu;

      k := 0;
      for j := 0 to Grid.ColCount - 1 do
      begin
        Grid.ColWidths[j] := Grid.ColWidths[j] * Grid.Font.Size;
        k := k + Grid.ColWidths[j];
      end;
      Grid.Width := k+50;


      k := 0;
      for j := 0 to Grid.RowCount - 1 do
      begin
        k := k + Grid.RowHeights[j]+ Grid.GridLineWidth;
      end;
      Grid.Height := k+18;


      maxWidthGrid := Max(maxWidthGrid,Grid.Width);

      aTop := aTop + Grid.Height + 1;
    end;

    ResultPanel.HorzScrollBar.Position := 0;
    ResultPanel.HorzScrollBar.Range := maxWidthGrid;
    ResultPanel.VertScrollBar.Position := 0;
    ResultPanel.VertScrollBar.Range := aTop;

    for k := Results.Count-1 downto 0 do
    begin
      if k = 0 then
        Grid := TStringGridEx(Results[0]);
      Results.Delete(k);
    end;
    if Assigned(Grid) and Grid.CanFocus then Grid.SetFocus;

  finally
    ResultPanel.EnableAlign;
    ResultPanel.ShowMe;
  end;
end;

function TconnectionForm.GetResultPanel: TExScrollBox;
begin
  Result := TExScrollBox(TabControl.Tabs.Objects[TabControl.TabIndex]);
end;

procedure TconnectionForm.msModeActionExecute(Sender: TObject);
begin
  if not TAction(Sender).Checked then
  begin
    TAction(Sender).Checked := True;
    sybModeAction.Checked := False;
    odbcModeAction.Checked:= False;
    sybTreeView.HideMe;
    odbcTreeView.HideMe;
    msTreeView.ShowMe;
  end;
end;

procedure TconnectionForm.msTreeViewMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  TreeView: TTreeViewEx;
  Node: TTreeNode;
begin
  TreeView := BasesPanel.CurrentTreeView;
  if Assigned(TreeView) then
  begin
    Node := TreeView.GetNodeAt(X,Y);
    if Assigned(Node) then Node.Selected := True;
  end;
end;

procedure TconnectionForm.odbcModeActionExecute(Sender: TObject);
begin
  if not TAction(Sender).Checked then
  begin
    TAction(Sender).Checked := True;
    msModeAction.Checked := False;
    sybModeAction.Checked:= False;
    msTreeView.HideMe;
    sybTreeView.HideMe;
    odbcTreeView.ShowMe;
  end;
end;

procedure TconnectionForm.OpenListBDActionExecute(Sender: TObject);
begin
  if BasesPanel.Opened then
    BasesPanel.Close
  else
    BasesPanel.Open;
end;

procedure TconnectionForm.SetCurrentNode(const Value: TTreeNode);
begin
  FCurrentNode := Value;
end;

procedure TconnectionForm.SetMenuItemCheck(const Value: TMenuItemCheck);
begin
  if Value <> FMenuItemCheck then
  begin
    SendMessage(Npp.NppData.NppHandle, NPPM_SETMENUITEMCHECK, CmdId, LPARAM(Value));
    FMenuItemCheck := Value;
  end;
end;

procedure TconnectionForm.SQLActionExecute(Sender: TObject);
var
  S: string;
begin
  if Sender is TMenuItem then
    S := TMenuItem(Sender).Hint
  else
    S := '';

  if not S.IsEmpty then
    DoSql(S)
  else
    TdsPlugin(Npp).FuncExecSQL;
end;

procedure TconnectionForm.sybModeActionExecute(Sender: TObject);
begin
  if not TAction(Sender).Checked then
  begin
    TAction(Sender).Checked := True;
    msModeAction.Checked := False;
    odbcModeAction.Checked:= False;
    msTreeView.HideMe;
    odbcTreeView.HideMe;
    sybTreeView.ShowMe;
  end;
end;

function TconnectionForm.CreateBox: TExScrollBox;
var
  ResultPanel0: TExScrollBox;
begin
  ResultPanel0:= TExScrollBox.Create(sql);
  ResultPanel0.Parent := sql;
  ResultPanel0.Color := clWhite;
  ResultPanel0.DoubleBuffered := True;
  ResultPanel0.Align := alClient;
  ResultPanel0.BorderStyle := bsNone;
  ResultPanel0.Visible := True;
  Result := ResultPanel0;
end;

procedure TconnectionForm.HideAllExcept(const aIndex: Integer);
var
  i: Integer;
begin
  for i := 0 to TabControl.Tabs.Count-1 do
    if TabControl.Tabs.Objects[i] <> nil then
    begin
      if i = aIndex then
      begin
        TExScrollBox(TabControl.Tabs.Objects[i]).ShowMe;
        ResultLabel.Caption := TExScrollBox(TabControl.Tabs.Objects[i]).Description;
      end
      else
        TExScrollBox(TabControl.Tabs.Objects[i]).HideMe
    end;
end;

procedure TconnectionForm.TabControlChange(Sender: TObject);
var
  i: Integer;
begin
  i := TTabControl(Sender).TabIndex;

  if not Assigned(TTabControl(Sender).Tabs.Objects[i]) then
  begin
    if i = MaxTabIndex then
     TTabControl(Sender).TabIndex := i-1
    else
    begin
      TTabControl(Sender).Tabs.Objects[i] := CreateBox;
      with TTabControl(Sender).Tabs do
      begin
        Strings[i] := 'SQL';
        AddObject('Add',nil);
      end;
    end;
  end;
  HideAllExcept(i);
end;

procedure TconnectionForm.WMThreadMessage(var Msg: TMessage);
var
  ExecObject: TExecObject;
begin
  ExecObject := TExecObject(Msg.LParam);
  try
    ExecObject.Finish;
  finally
    ExecObject.Free;
  end;
end;

end.
