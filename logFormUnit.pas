unit logFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.Math, Winapi.ShellApi,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.OleCtrls,
  SHDocVw, Vcl.Grids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ActnCtrls,
  StringGridsUnit, ConstUnit, StringGridExUnit, ExtScrollingWinControlUnit, NppDockingForms, nppplugin,
  {$IFDEF NPPCONNECTIONS}TranslateComponentsUnit,{$ENDIF}
  Vcl.ExtCtrls, Vcl.WinXCtrls, Vcl.ActnPopup, TreeViewExUnit;

type
  TlogForm = class(TNppDockingForm)
    ActionManager1: TActionManager;
    SQLAction: TAction;
    CopyGridRowAction: TAction;
    CopyAllGridAction: TAction;
    ConnectAction: TAction;
    DisonnectSQLAction: TAction;
    rtiRecordAction: TAction;
    rtiRecordStopAction: TAction;
    rtiSaveAction: TAction;
    rtiClearAction: TAction;
    AfterSQLAction: TAction;
    BasesPanel: TSplitView;
    OpenListBDAction: TAction;
    blackTreeImageList: TImageList;
    msModeAction: TAction;
    sybModeAction: TAction;
    AfterAddServerAction: TAction;
    invTreeView: TTreeView;
    Panel1: TPanel;
    TreeViewPopupMenu: TPopupMenu;
    New_Connection: TMenuItem;
    Disconnect: TMenuItem;
    N10: TMenuItem;
    RTIStartItem: TMenuItem;
    RTIStopItem: TMenuItem;
    N12: TMenuItem;
    GridMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    AfterSQLIndexAction: TAction;
    RTI2: TMenuItem;
    N3: TMenuItem;
    AfterRTIAction: TAction;
    AfterClearRTIAction: TAction;
    SaveDialog: TSaveDialog;
    AfterWriteRTIAction: TAction;
    PrAction: TAction;
    N4: TMenuItem;
    N5: TMenuItem;
    odbcModeAction: TAction;
    N7: TMenuItem;
    N13: TMenuItem;
    DeclareVarsAction: TAction;
    postgresqlModeAction: TAction;
    ResultLabel: TPanel;
    ButtonPanel: TPanel;
    P1: TPanel;
    P2: TPanel;
    P3: TPanel;
    P4: TPanel;
    P5: TPanel;
    P6: TPanel;
    P7: TPanel;
    P8: TPanel;
    P9: TPanel;
    P10: TPanel;
    invGrid: TStringGrid;
    sql: TPanel;
    ActivityIndicator1: TActivityIndicator;
    NPanel: TPanel;
    BDPanel: TPanel;
    msSQL: TPanel;
    Sybase: TPanel;
    PostgreSQL: TPanel;
    odbc: TPanel;
    whiteTreeImageList: TImageList;
    N6: TMenuItem;
    My_Connections: TMenuItem;
    AddOrRemoveFavoriteItem: TMenuItem;
    addFavoriteConnectionAction: TAction;
    NFavoriteLine: TMenuItem;
    removeFavoriteConnectionAction: TAction;
    rightPanel: TPanel;
    SqlButton: TPanel;
    ProlivkaButton: TPanel;
    prolivkaShowModeAction: TAction;
    SqlShowModeAction: TAction;
    LogBox: TListBox;
    Images: TImageList;
    AfterPrAction: TAction;
    ReloadPrAction: TAction;
    SubFileAction: TAction;
    AfterConversionAction: TAction;
    pgConvertAction: TAction;
    InstallerLogAction: TAction;
    CopyLogAction: TAction;
    LogPopupMenu: TPopupMenu;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    PostgreSQL1: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    LeftPanel: TPanel;
    onepixelPanel2: TPanel;
    onePixelPanel1: TPanel;
    ScrollBox1: TScrollBox;
    BDPopupMenu: TPopupMenu;
    MSSQL1: TMenuItem;
    SYBASE1: TMenuItem;
    POSTGRESQL2: TMenuItem;
    ODBC1: TMenuItem;
    AfterTableListAction: TAction;
    TableListAction: TAction;
    AfterFieldListAction: TAction;
    procedure FormCreate(Sender: TObject);
    procedure SQLActionExecute(Sender: TObject);
    procedure CopyAllGridActionExecute(Sender: TObject);
    procedure OpenListBDActionExecute(Sender: TObject);
    procedure ConnectActionExecute(Sender: TObject);
    procedure msModeActionExecute(Sender: TObject);
    procedure sybModeActionExecute(Sender: TObject);
    procedure AfterAddServerActionExecute(Sender: TObject);
    procedure msTreeViewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DisonnectSQLActionExecute(Sender: TObject);
    procedure DisonnectSQLActionUpdate(Sender: TObject);
    procedure rtiRecordActionUpdate(Sender: TObject);
    procedure AfterSQLActionExecute(Sender: TObject);
    procedure AfterSQLIndexActionExecute(Sender: TObject);
    procedure CopyGridRowActionExecute(Sender: TObject);
    procedure rtiRecordActionExecute(Sender: TObject);
    procedure AfterRTIActionExecute(Sender: TObject);
    procedure rtiRecordStopActionExecute(Sender: TObject);
    procedure rtiClearActionExecute(Sender: TObject);
    procedure AfterClearRTIActionExecute(Sender: TObject);
    procedure rtiSaveActionExecute(Sender: TObject);
    procedure AfterWriteRTIActionExecute(Sender: TObject);
    procedure PrActionExecute(Sender: TObject);
    procedure odbcModeActionExecute(Sender: TObject);
    procedure DeclareVarsActionExecute(Sender: TObject);
    procedure PrActionUpdate(Sender: TObject);
    procedure postgresqlModeActionExecute(Sender: TObject);
    procedure P1MouseEnter(Sender: TObject);
    procedure P1MouseLeave(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure NPanelClick(Sender: TObject);
    procedure DeclareVarsActionUpdate(Sender: TObject);
    procedure addFavoriteConnectionActionExecute(Sender: TObject);
    procedure TreeViewPopupMenuPopup(Sender: TObject);
    procedure removeFavoriteConnectionActionExecute(Sender: TObject);
    procedure prolivkaShowModeActionExecute(Sender: TObject);
    procedure SqlShowModeActionExecute(Sender: TObject);
    procedure LogBoxDblClick(Sender: TObject);
    procedure LogBoxDrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
      State: TOwnerDrawState);
    procedure AfterPrActionExecute(Sender: TObject);
    procedure ReloadPrActionExecute(Sender: TObject);
    procedure SubFileActionUpdate(Sender: TObject);
    procedure SubFileActionExecute(Sender: TObject);
    procedure AfterConversionActionExecute(Sender: TObject);
    procedure pgConvertActionExecute(Sender: TObject);
    procedure InstallerLogActionExecute(Sender: TObject);
    procedure CopyLogActionExecute(Sender: TObject);
    procedure MSSQL1Click(Sender: TObject);
    procedure AfterTableListActionExecute(Sender: TObject);
    procedure TableListActionExecute(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure AfterFieldListActionExecute(Sender: TObject);
  private
    msTreeView: TTreeViewEx;
    sybTreeView: TTreeViewEx;
    postgresqlTreeView: TTreeViewEx;
    odbcTreeView: TTreeViewEx;

    FCurrentNode: TTreeNode;
    FRTIFileName: TFileName;
    FPushedButton: TPanel;

    FSubFile: TPathName;
    FLogFile: TPathName;
    function IsErrorString(const S: string): boolean;

    function CreateBox: TExScrollBox;
    function rtiFileName(const LoggerPath: TFileName): TFileName;
    procedure SetGridColor(Grid: TStringGridEx);

//    const DarkSchemeHighlightColor: TColor = 4539717; //RGB(69,69,69);
//    const DarkSchemeDefaultColor: TColor = 3355443; //RGB(51,51,51);
//    const DarkSchemePushedColor: TColor = 6710886; //RGB(102,102,102)
    procedure Push(Panel: TPanel);

    procedure WMThreadMessage(var Msg: TMessage); message WM_USER_MESSAGE_FROM_THREAD;

    procedure FillResultGrid(ScrollBox: TExScrollBox; Results: TObjectStrings);

    procedure GridButtonClick(Sender: TObject);

    procedure SetCurrentNode(const Value: TTreeNode);
    procedure OnGetSelectedText(Strings: TStrings);
    procedure OnReplaceSelectedText(Strings: TStrings);
    function GetCurrentScrollBox: TExScrollBox;
    function PanelPushedColor(Sender: TObject): TColor;
    procedure AddServer(const Data: string);

    procedure FavoriteItemsClickProcedure(Sender: TObject);
    procedure RealignBDButtons(const ExecClick: boolean = True);
    procedure RestoreBDButtons;
  protected
    procedure ChangeColorMode(Sender: TObject); override;
    property CurrentNode: TTreeNode read FCurrentNode write SetCurrentNode;
    property CurrentScrollBox: TExScrollBox read GetCurrentScrollBox;
  public

   {$IFNDEF NPPCONNECTIONS}
    procedure DoPrForm;
   {$ENDIF}

    procedure DoHelpSql(help: THelpType; const SqlText: string);
    procedure DoSql(const SqlText: string);
    procedure DoSqlIndex(const SqlText: string);
    procedure DoSqlGetTableList(const SqlTableText: string);
    procedure DoGetFields(const SqlTableName: string);
    procedure DoConnect;
  end;

implementation

uses
  scisupport, Easy.diaplugin,Vcl.Clipbrd,
  ThreadUnit, SqlThreadUnit,
  BDLoginUnit,
  regUnit,
  {$IFNDEF NPPCONNECTIONS}
  LogWriterUnit,diaConstUnit,PrFormUnit,CommandThreadUnit,
  {$ENDIF}
  LogFormHelpersUnit
  ;


{$R *.dfm}

function UserName(Data: string): string;
var
  S: string;
begin
  Result := '';
  S := Data.Substring(Data.IndexOf('Login=')+6,MaxInt);
  S := S.Substring(0,S.IndexOf('|'));
  if S<>'' then Result := Format(' (%s)',[S]);
end;

{$IFNDEF NPPCONNECTIONS}
procedure TlogForm.DoPrForm;
var
  FPrForm: TPrForm;
  CmdThread: TPrThreadObject;
begin

  if not (BasesPanel.BdType in [bdMSSQL,bdSybase]) then
  begin
    MessageError(cnstNoSQLSelected,cnstErroCaption);
    Exit;
  end;
  if BasesPanel.CurrentBase = 'Unknown' then
  begin
    MessageError(cnstNoSQLbaseSelected,cnstErroCaption);
    Exit;
  end;

  FPrForm := TPrForm.Create(self);
  try
    FPrForm.ExternalServer := BasesPanel.CurrentServer;
    FPrForm.ExternalBase   := BasesPanel.CurrentBase;
    FPrForm.InitConnectionString;
    if FPrForm.DoForm = mrOk then
    begin
      prolivkaShowModeAction.Execute;
      LogBox.Items.Clear;
      LogBox.Items.Add(cnstSqlWaitResults);

      ResultLabel.Caption := '';
      FSubFile := IncludeTrailingPathDelimiter(FPrForm.Path) + ChangeFileExt(FPrForm.FileName,cnstT01);
      CmdThread := TPrThreadObject.Create;
      CmdThread.Description := IncludeTrailingPathDelimiter(FPrForm.Path) + FPrForm.FileName;
      CmdThread.Command := Format(cnstBatch,[FPrForm.ConnectString]);
      CmdThread.DestinationPath := FPrForm.Path;
      CmdThread.OnAfterAction := AfterPrAction;
      CmdThread.WinHandle := self.Handle;
      CmdThread.Start;
    end;
  finally
    FPrForm.Free;
    FPrForm := nil;
  end;
end;
{$ENDIF}

procedure TlogForm.DeclareVarsActionExecute(Sender: TObject);
begin
  if Self.ActiveControl is TStringGridEx then
    TStringGridEx(Self.ActiveControl).DeclareVarsToClipboard;
end;

procedure TlogForm.DeclareVarsActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := BasesPanel.BdType in [bdMSSQL, bdSybase];
end;

procedure TlogForm.DisonnectSQLActionExecute(Sender: TObject);
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

procedure TlogForm.DisonnectSQLActionUpdate(Sender: TObject);
var
  TreeNode: TTreeNode;
begin
  inherited;
  TreeNode := BasesPanel.CurrentNode;
  if Assigned(TreeNode) then
    TAction(Sender).Enabled := TreeNode.ItemType in [itServerMS,itServerSYB,itServerPostgreSQL,itODBC]
  else
    TAction(Sender).Enabled := False;
end;

procedure TlogForm.ChangeColorMode(Sender: TObject);
var
  i,j: integer;
  C,G: TComponent;
  Fc,Bc,Wc: TColor;
begin
  inherited;

  if DarkMode then
  begin
    Fc := ColorText;
    Bc := ColorSofterBackground;
    Wc := Bc;
    Self.Color := ColorBackground;
  end
  else
  begin
    Fc := clBlack;
    Bc := clBtnFace;
    Self.Color := clBtnFace;
    Wc := clWhite;
  end;

  LogBox.Color := Wc;
  LogBox.Font.Color := Fc;

  for i := 0 to sql.ControlCount-1 do
  begin
    C := sql.Controls[i];
    if C is TExScrollBox then
    begin
      TExScrollBox(C).Font.Color := Fc;
      TExScrollBox(C).Color := Wc;
      TExScrollBox(C).HorzScrollBar.Color := Wc;
      TExScrollBox(C).VertScrollBar.Color := Wc;
      for j := 0 to TExScrollBox(C).ControlCount-1 do
        if TExScrollBox(C).Controls[j] is TStringGridEx then SetGridColor(TStringGridEx(TExScrollBox(C).Controls[j]));
    end;
  end;

  BDPanel.Color := Color;
  ResultLabel.Color := Color;
  rightPanel.Color := Color;
  ButtonPanel.Color := Color;

  for i := 0 to ComponentCount-1 do
  begin
    C := Components[i];
    if C is TWinControl then
    begin
      if C is TLabel then TLabel(C).Font.Color := Fc;

      if C is TTreeViewEx then
      begin
        TTreeViewEx(C).Font.Color := Fc;
        TTreeViewEx(C).DarkMode := DarkMode;
        TTreeViewEx(C).SelectedColor := RGB(GetRValue(BC)+50,GetGValue(BC)+50,GetBValue(BC)+50);

        if DarkMode then
        begin
          TTreeViewEx(C).Color := RGB(GetRValue(ColorBackground)+10,GetGValue(ColorBackground)+10,GetBValue(ColorBackground)+10);
          TTreeViewEx(C).Images := blackTreeImageList;
        end
        else
        begin
          TTreeViewEx(C).Color := Wc;
          TTreeViewEx(C).Images := whiteTreeImageList;
        end;
      end;
      if C is TPanel then
      begin
        TPanel(C).Font.Color := Fc;

        if C = BDPanel then continue;
        if C = ResultLabel then continue;
        if C = rightPanel then continue;
        if C = ButtonPanel then continue;

        if TPanel(C).Pushed then
          TPanel(C).Color := PanelPushedColor(C)
        else
        if (TControl(C).Parent = BDPanel) or
           (TControl(C).Parent = rightPanel) or
           (TControl(C).Parent = ButtonPanel) then
          TPanel(C).Color := TPanel(TPanel(C).Parent).Color
        else
          TPanel(C).Color := Bc;
      end;
    end;
  end;

  if DarkMode then
  begin
    Panel1.BevelEdges := [];
    ButtonPanel.BevelEdges := [];
    ResultLabel.BevelEdges := [];
    BDPanel.BevelEdges := [];
    LeftPanel.Color := RGB(100,100,100);
    LeftPanel.Visible := True;
    onepixelPanel1.Color := LeftPanel.Color;
    onepixelPanel1.Visible := True;
    onepixelPanel2.Color := LeftPanel.Color;
    onepixelPanel2.Visible := True;

  end
  else
  begin
    Panel1.BevelEdges := [TBevelEdge(beLeft)];
    ButtonPanel.BevelEdges := [beTop];
    ResultLabel.BevelEdges := [beBottom];
    BDPanel.BevelEdges := [beBottom];
    LeftPanel.Visible := False;
    onepixelPanel1.Visible := False;
    onepixelPanel2.Visible := False;
  end;

  Repaint;
end;

procedure TLogForm.SetGridColor(Grid: TStringGridEx);
begin
  Grid.DrawingStyle := gdsClassic;
  if DarkMode then
  begin
    Grid.Color := ColorSofterBackground;
    Grid.Draw_HeaderColor := RGB(GetRValue(ColorBackground)-15,GetGValue(ColorBackground)-15,GetBValue(ColorBackground)-15);
    Grid.Draw_BGColor     := ColorBackground;
    Grid.Draw_FontColor   := RGB(GetRValue(ColorText)-15,GetGValue(ColorText)-15,GetBValue(ColorText)-15);
    Grid.Draw_BGHColor    := ColorSofterBackground;
    Grid.Draw_FontHColor  := ColorDarkerText;
  end
  else
  begin
    Grid.Color := clWhite;
    Grid.Draw_HeaderColor := clBtnFace;
    Grid.Draw_BGColor     := clWhite;
    Grid.Draw_FontColor   := clBlack;
    Grid.Draw_BGHColor    := clHighlight;
    Grid.Draw_FontHColor  := clHighlightText;
  end;
end;

procedure TlogForm.ConnectActionExecute(Sender: TObject);
var
  FBDLoginForm: TBDLoginForm;
  BDType: TBdType;
  TreeView: TTreeViewEx;
  Data,DataBase: string;
  Node: TTreeNode;
begin
  FBDLoginForm := TBDLoginForm.Create(Npp);
  BdType := BasesPanel.BdType;
  try
    FBDLoginForm.BDType := BdType;
    if FBDLoginForm.DoForm = mrOK then
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
        FBDLoginForm.SaveCurrentDataSourceToRegistry;
        AddServer(Data);
      end;
    end;
  finally
    FBDLoginForm.Free;
    FBDLoginForm := nil;
  end;
end;

procedure TlogForm.AddServer(const Data: string);
var
  BDType: TBdType;
  TreeView: TTreeViewEx;
  DataBase: string;
  Node: TTreeNode;
  SqlThread: TSqlQueryObject;
begin
  BdType := BasesPanel.BdType;
  TreeView := BasesPanel.CurrentTreeView;
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

    if BdType = bdPostgreSQL then
    begin
      SqlThread.SQL.Text := constPostgreDBList;
      DataBase := 'postgres';
    end
    else
    if BdType = bdMSSQL then
      SqlThread.SQL.Text := constDBList
    else
    if BdType = bdSybase then
      SqlThread.SQL.Text := constDBList;

    SqlThread.ConnectionString := TSplitView.GetConnectionString(Data,DataBase);
    SqlThread.OnAfterAction := AfterAddServerAction;
    SqlThread.WinHandle := self.Handle;
    SqlThread.Start; //get Databases list
  end;
end;

procedure TlogForm.CopyAllGridActionExecute(Sender: TObject);
begin
  if Self.ActiveControl is TStringGridEx then
    TStringGridEx(Self.ActiveControl).CopyAllToClipboard;
end;

procedure TlogForm.CopyGridRowActionExecute(Sender: TObject);
begin
  if Self.ActiveControl is TStringGridEx then
    TStringGridEx(Self.ActiveControl).CopyToClipboard;
end;

procedure TlogForm.CopyLogActionExecute(Sender: TObject);
begin
  Clipboard.AsText := LogBox.Items.Text;
end;

procedure TlogForm.AfterAddServerActionExecute(Sender: TObject);
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
      bdPostgreSQL: TreeView := postgresqlTreeView;
    else
      TreeView := odbcTreeView;
    end;

    TreeView.AddServer(Obj.Description,Obj.Login,Obj.Query);
  end
  else
   MessageError(Obj.ErrMessage,cnstErroCaption);
end;


procedure TlogForm.AfterSQLActionExecute(Sender: TObject);
  function GetDots(const S: string): string;
  begin
    if length(S) > 150 then
      Result := '...'
    else
      Result := '';
  end;
var
  Obj: TSqlExecutorObject;
begin
  SqlShowModeAction.Execute;
  Obj := TSqlExecutorObject(TAction(Sender).Tag);
  if Obj.ErrMessage <> '' then MessageError(Obj.ErrMessage,cnstErroCaption);
  FillResultGrid(Obj.ScrollBox,Obj.Grids);
  Show;
end;

procedure TlogForm.AfterSQLIndexActionExecute(Sender: TObject);
var
  Obj: TSqlIndexObject;
begin
  Obj := TSqlIndexObject(TAction(Sender).Tag);
  if (Obj.ErrMessage = '') and (Obj.Indexes.Count>0) then
    TDiaPlugin(Npp).ShowAutocompletionIndex(Obj.Description,Obj.Indexes);
end;

procedure TlogForm.AfterTableListActionExecute(Sender: TObject);
var
  Obj: TTableListObject;
begin
  TdiaPlugin(Npp).SetCursor(crNormal);
  Obj := TTableListObject(TAction(Sender).Tag);
  if (Obj.ErrMessage = '') and (Obj.TableList.Count>0) then
  begin
    Obj.Node.TableList.Clear;
    Obj.Node.TableList.Assign(Obj.TableList);
    if Obj.Description<>'' then DoSqlGetTableList(Obj.Description);
  end;
end;

procedure TlogForm.AfterWriteRTIActionExecute(Sender: TObject);
{$IFNDEF NPPCONNECTIONS}
var
  Obj: TSqlQueryRTIObject;
{$ENDIF}
begin
{$IFNDEF NPPCONNECTIONS}

  Obj := TSqlQueryRTIObject(TAction(Sender).Tag);
  if Obj.ErrMessage = '' then
  begin
    if FileExists(Obj.Name) then
      MessageSimple(Format(cnstRecordAfterWriteRTIInformation,[Obj.Name]),cnstRecordConfirmationTitle)
    else
      MessageWarning(Format(cnstRecordAfterWriteRTIInformationNOFILE,[Obj.Name]),cnstRecordConfirmationTitle);
  end
  else
   MessageError(Obj.ErrMessage,cnstErroCaption);
{$ENDIF}
end;

procedure TlogForm.AfterClearRTIActionExecute(Sender: TObject);
{$IFNDEF NPPCONNECTIONS}
var
  Obj: TSqlThreadObject;
  TreeView: TTreeViewEx;
  i: Integer;
  FServer,FBase: string;
{$ENDIF}
begin
{$IFNDEF NPPCONNECTIONS}
  Obj := TSqlThreadObject(TAction(Sender).Tag);
  if Obj.ErrMessage = '' then
  begin
    FBase := Obj.Description;
    FServer := Obj.Name;

    TreeView := TTreeViewEx(Obj.UserTree);
    for i := 0 to TreeView.Items.Count-1 do
    begin
      if TreeView.Items[i].Text = FServer then
        if TreeView.Items[i].IndexOf(TTreeNode(Obj.UserObject)) >= 0 then
        begin
          MessageSimple(Format(cnstRecordClearInformation,[FBase]),cnstRecordConfirmationTitle);
          Exit;
        end;
    end;
  end
  else
   MessageError(Obj.ErrMessage,cnstErroCaption);
{$ENDIF}
end;

procedure TlogForm.AfterConversionActionExecute(Sender: TObject);
{$IFNDEF NPPCONNECTIONS}
var
  Obj: TPgConversionThreadObject;
{$ENDIF}
begin
{$IFNDEF NPPCONNECTIONS}
  Obj := TPgConversionThreadObject(TAction(Sender).Tag);
  if Obj.ErrMessage = '' then
    if FileExists(Obj.DestinationFile) then Npp.DoOpen(Obj.DestinationFile)
  else
  begin
    FLogFile := '';
    FSubFile := '';
    SubFileAction.Update;
    LogBox.Items.Clear;
    LogBox.Items.Add(Obj.ErrMessage);
  end;
  Show;
{$ENDIF}
end;

procedure TlogForm.AfterFieldListActionExecute(Sender: TObject);
var
  Obj: TFieldListObject;
  S: string;
begin
  TdiaPlugin(Npp).SetCursor(crNormal);
  Obj := TFieldListObject(TAction(Sender).Tag);
  if (Obj.ErrMessage = '') and (Obj.FieldList.Count>0) then
  begin
    Obj.FieldList.Delimiter := ' ';
    S := Obj.FieldList.DelimitedText;
    TDiaPlugin(Npp).ShowAutocompletionList(0, S);
  end;
end;

procedure TlogForm.AfterPrActionExecute(Sender: TObject);
{$IFNDEF NPPCONNECTIONS}
var
  Obj: TPrThreadObject;
{$ENDIF}
begin
{$IFNDEF NPPCONNECTIONS}
  Obj := TPrThreadObject(TAction(Sender).Tag);
  if Obj.ErrMessage = '' then
  begin
    FLogFile := Obj.LogFile;
    if FLogFile <> '' then
    begin
      ResultLabel.Caption := Obj.Description;
      ProlivkaButton.Hint := Obj.Description;
      SubFileAction.Update;
      ReloadPRAction.Execute;
    end;
  end
  else
  begin
    FLogFile := '';
    FSubFile := '';
    SubFileAction.Update;
    LogBox.Items.Clear;
    LogBox.Items.Add(Obj.ErrMessage);
  end;
  Show;
{$ENDIF}
end;

procedure TlogForm.AfterRTIActionExecute(Sender: TObject);
var
  Obj: TSqlSilenceObject;
  TreeView: TTreeViewEx;
  i: Integer;
  FServer,FBase,FAnswer: string;
begin
  Obj := TSqlSilenceObject(TAction(Sender).Tag);
  if Obj.ErrMessage <> '' then MessageError(Obj.ErrMessage,cnstErroCaption);
  FAnswer := Obj.Answer;
  if FAnswer = '0'  then
  begin
    FBase := Obj.Description;
    FServer := Obj.Name;

    TreeView := TTreeViewEx(Obj.UserTree);
    for i := 0 to TreeView.Items.Count-1 do
    begin
      if TreeView.Items[i].Text = FServer then
        if TreeView.Items[i].IndexOf(TTreeNode(Obj.UserObject)) >= 0 then
        begin
          TTreeNode(Obj.UserObject).ItemType := TItemType(Obj.UserTag);
          //TreeView.Refresh;
          TreeView.Repaint;
          Exit;
        end;
    end;
  end;

end;

procedure TlogForm.DoConnect;
begin
  ConnectAction.Execute;
end;

procedure TlogForm.DoGetFields(const SqlTableName: string);
var
  SqlThread: TFieldListObject;
  CString,CName: string;
  TreeNode: TTreeNode;
begin
  TreeNode := BasesPanel.CurrentNode;
  if Assigned(TreeNode) then
    if (TreeNode.ItemType in [itBase,itBaseRTI]) then
    begin
      if BasesPanel.BdType = bdODBC then Exit;
      CString := BasesPanel.ConnectionString;
      CName := Format(cnstSqlExec,[
                                   BasesPanel.CurrentServer,
                                   BasesPanel.CurrentBase,
                                   BasesPanel.CurrentUser
                                   ]);
      if CString = '' then
      begin
        CString := CurrentScrollBox.ConnectionString;
        CName   := CurrentScrollBox.Description;
      end;

      if CString <> '' then
      begin
        SqlThread := TFieldListObject.Create;
        SqlThread.SQL.Text := SqlTableName;
        SqlThread.Description := '';
        SqlThread.BdType := BasesPanel.BdType;
        SqlThread.Name := CName;
        SqlThread.ConnectionString := CString;
        SqlThread.OnAfterAction := AfterFieldListAction;
        SqlThread.WinHandle := self.Handle;
        SqlThread.Start;
      end;
    end;
  TableListAction.Hint := '';
end;

procedure TlogForm.DoHelpSql(help: THelpType; const SqlText: string);
var
  helpString: string;
begin
  helpString := Format(cnstHelpArray[BasesPanel.BdType,help],[SqlText]);
  DoSql(helpString);
end;

procedure TlogForm.DoSql(const SqlText: string);
  function GetNumberActivityIndicator: string;
  var
    j,k: integer;
  begin
    k := 0;
    for j := 0 to Self.ComponentCount - 1 do
      if Components[j] is TActivityIndicator then inc(k);
    Result := IntToStr(k);
  end;
var
  SqlThread: TSqlExecutorObject;
  CString,CName: string;
  FResultScrollBox: TExScrollBox;
  ActivityIndicator: TActivityIndicator;
begin
  FResultScrollBox := CurrentScrollBox;

  CString := BasesPanel.ConnectionString;
  CName := Format(cnstSqlExec,[
                               BasesPanel.CurrentServer,
                               BasesPanel.CurrentBase,
                               BasesPanel.CurrentUser
                               ]);
  {if CString = '' then
  begin
    CString := FResultScrollBox.ConnectionString;
    CName   := FResultScrollBox.Description;
  end;}

  if CString <> '' then
  begin
    FResultScrollBox.ClearComponents;

    ActivityIndicator := TActivityIndicator.Create(nil);
    ActivityIndicator.Parent := FResultScrollBox;
    ActivityIndicator.Name := 'Indicator' + GetNumberActivityIndicator;
    ActivityIndicator.Left := 5;
    ActivityIndicator.Top := 5;
    ActivityIndicator.IndicatorSize := aisLarge;
    if DarkMode then ActivityIndicator.IndicatorColor := aicWhite;
    ActivityIndicator.Visible := True;
    ActivityIndicator.Animate := True;


    FResultScrollBox.InsertComponent(ActivityIndicator);
    FResultScrollBox.Hint := SqlText.Trim;
    FResultScrollBox.ShowHint := True;

    SqlThread := TSqlExecutorObject.Create;
    SqlThread.Description := SqlText.Trim;
    SqlThread.BdType := BasesPanel.BdType;
    SqlThread.SQL.Text := SqlThread.Description;
    SqlThread.Name := CName;
    SqlThread.ConnectionString := CString;
    SqlThread.OnAfterAction := AfterSQLAction;
    SqlThread.WinHandle := self.Handle;
    SqlThread.ScrollBox := FResultScrollBox;
    SqlThread.Start;
  end
  else
    MessageError(cnstNoBaseSelected,cnstErroCaption);
end;

procedure TlogForm.DoSqlGetTableList(const SqlTableText: string);
var
  TreeNode: TTreeNode;
  S: string;
  iPos,iLastPos: integer;
begin
  TreeNode := BasesPanel.CurrentNode;
  if Assigned(TreeNode) and (TreeNode.ItemType in [itBase,itBaseRTI]) then
  begin
    if TreeNode.TableList.Count>0 then
    begin
      TreeNode.TableList.Delimiter := ' ';
      S := ' ' + TreeNode.TableList.DelimitedText;
      iPos := S.IndexOf(' '+SqlTableText);
      if iPos>=0 then
      begin
        iLastPos := S.LastIndexOf(' '+SqlTableText);
        if iLastPos<iPos then iLastPos := iPos;

        iLastPos := S.IndexOf(' ',iLastPos+1);
        if iLastPos<0 then
          S := S.Substring(iPos+1,MaxInt)
        else
          S := S.Substring(iPos+1,iLastPos-iPos-1);

        TDiaPlugin(Npp).ShowAutocompletionList(Length(SqlTableText), S);
      end;
    end
    else
    begin
      TableListAction.Hint := SqlTableText;
      TableListAction.Execute;
    end;
  end;
end;

procedure TlogForm.DoSqlIndex(const SqlText: string);
var
  SqlThread: TSqlIndexObject;
  CString,CName: string;
begin
  if BasesPanel.BdType = bdPostgreSQL then Exit;

  CString := BasesPanel.ConnectionString;
  CName := Format(cnstSqlExec,[
                               BasesPanel.CurrentServer,
                               BasesPanel.CurrentBase,
                               BasesPanel.CurrentUser
                               ]);
  if CString = '' then
  begin
    CString := CurrentScrollBox.ConnectionString;
    CName   := CurrentScrollBox.Description;
  end;

  if CString <> '' then
  begin
    SqlThread := TSqlIndexObject.Create;
    SqlThread.SQL.Text := SqlText;
    SqlThread.Description := SqlText;
    SqlThread.BdType := BasesPanel.BdType;
    SqlThread.Name := CName;
    SqlThread.ConnectionString := CString;
    SqlThread.OnAfterAction := AfterSQLIndexAction;
    SqlThread.WinHandle := self.Handle;
    SqlThread.Start;
  end;
end;

procedure TlogForm.FormCreate(Sender: TObject);
begin
  Caption := Npp.PluginName;

  NppDefaultDockingMask := DWS_DF_FLOATING;
  FRTIFileName := '';
  sql.Align := alClient;
  LogBox.Align := alClient;

  msTreeView := TTreeViewEx.Create(Self);
  msTreeView.OnChange := TreeViewChange;
  msTreeView.Parent := BasesPanel;
  msTreeView.PopupMenu := TreeViewPopupMenu;
  msTreeView.BdType := bdMSSQL;

  sybTreeView := TTreeViewEx.Create(Self);
  sybTreeView.OnChange := TreeViewChange;
  sybTreeView.Parent := BasesPanel;
  sybTreeView.PopupMenu := TreeViewPopupMenu;
  sybTreeView.BdType := bdSybase;

  postgresqlTreeView := TTreeViewEx.Create(Self);
  postgresqlTreeView.OnChange := TreeViewChange;
  postgresqlTreeView.Parent := BasesPanel;
  postgresqlTreeView.PopupMenu := TreeViewPopupMenu;
  postgresqlTreeView.BdType := bdPostgreSQL;

  odbcTreeView := TTreeViewEx.Create(Self);
  odbcTreeView.Parent := BasesPanel;
  odbcTreeView.PopupMenu := TreeViewPopupMenu;
  odbcTreeView.BdType := bdODBC;

  FPushedButton := nil;
  Push(P1);

  RestoreBDButtons;
  RealignBDButtons;

{$IFDEF NPPCONNECTIONS}
  rightPanel.Visible := False;
  TranslateComponents(Self);
{$ENDIF}

  SqlShowModeAction.Execute;
end;

procedure TlogForm.RestoreBDButtons;
var
  i,j: integer;
  P: TPanel;
begin
  for i := 0 to BDPanel.ControlCount-1 do
  begin
    if BDPanel.Controls[i] is TPanel then
    begin
      P := TPanel(BDPanel.Controls[i]);
      P.Visible := TOptionsReg.GetVisibleStatusBDButton(P.BDType);
      for j := 0 to BDPopupMenu.Items.Count-1 do
        if BDPopupMenu.Items[j].HelpContext = p.HelpContext then
        begin
          BDPopupMenu.Items[j].Checked := P.Visible;
          break;
        end;
    end;
  end;
end;

procedure TlogForm.RealignBDButtons(const ExecClick: boolean = True);
var
  i,bdLeft: integer;
  P,vP: TPanel;
begin
  bdLeft := 0;
  vP := nil;
  for i := 0 to BDPanel.ControlCount-1 do
  begin
    if BDPanel.Controls[i] is TPanel then
    begin
      P := TPanel(BDPanel.Controls[i]);
      if P.Visible then
      begin
        P.Left := bdLeft;
        if not Assigned(vP) then vP := P;
        bdLeft := bdLeft + P.Width;
      end;
    end;
  end;
  if Assigned(vP) and ExecClick then vP.Click;
end;

procedure TlogForm.FormDestroy(Sender: TObject);
begin
  inherited;
  //ButtonPanel.RemoveExScrollBoxes(sql);
end;

procedure TlogForm.FillResultGrid(ScrollBox: TExScrollBox; Results: TObjectStrings);
var i,j,k,maxWidthGrid,aTop: integer;
    Grid: TStringGridEx;
    FResultScrollBox: TExScrollBox;
    ChildPanel: TPanel;
begin
  FResultScrollBox := CurrentScrollBox;
  ChildPanel := ButtonPanel.FindPanelByScrollBox(ScrollBox);
  if Assigned(ChildPanel) then
    FResultScrollBox := ChildPanel.ExScrollBox;

  if Assigned(Results) then ResultLabel.Caption := Results.Name;

  maxWidthGrid := 0;
  Grid := nil;
  try

    FResultScrollBox.ClearComponents;
    FResultScrollBox.Hint := '';
    FResultScrollBox.ShowHint := False;
    FResultScrollBox.HorzScrollBar.Range := MaxInt;
    FResultScrollBox.VertScrollBar.Range:= MaxInt;
    FResultScrollBox.DisableAlign;
    FResultScrollBox.Description := Results.Name;
    FResultScrollBox.ConnectionString := Results.ConnectionString;


    if Assigned(Results) then
    begin
      Results.OwnsObjects := False;
      aTop := 0;
      for i := 0 to Results.Count - 1 do
      begin
        Grid := TStringGridEx(Results[i]);
        SetGridColor(Grid);
        Grid.Parent := FResultScrollBox;
        FResultScrollBox.InsertComponent(Grid);
        Grid.Align := alTop;
        Grid.FixedCols := 0;

        if Grid.RowCount > 1 then
          Grid.FixedRows := 1
        else
          Grid.FixedRows := 0;

        Grid.Options := Grid.Options + [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goColSizing];
        if (Grid.ColCount = 1) and (Grid.RowCount = 1) then Grid.Options := [];


      //  Grid.Font.Assign(invGrid.Font);
      //  Grid.Height := {(Grid.DefaultRowHeight+2)} (Abs(invGrid.Font.Height)+2) * (Grid.RowCount+1);

        if Grid.Hint <> '' then
          Grid.OnButtonClick := GridButtonClick;
        Grid.PopupMenu := GridMenu;
        Grid.OnGetSelectedText := Self.OnGetSelectedText;
        Grid.OnReplaceSelectedText := Self.OnReplaceSelectedText;

        k := 0;
        for j := 0 to Grid.ColCount - 1 do
        begin
          Grid.ColWidths[j] := Min(Grid.ColWidths[j],1027) * Grid.Font.Size;
          k := k + Grid.ColWidths[j];
        end;
        Grid.Width := k+Grid.ColCount*Grid.GridLineWidth+50;


        k := 0;
        for j := 0 to Grid.RowCount - 1 do
        begin
          k := k + Grid.RowHeights[j]+ Grid.GridLineWidth;
        end;
        Grid.Height := k+18;


        //Max(k,CurrentPanel.Width);
        maxWidthGrid := Max(maxWidthGrid,Grid.Width);

        //Grid.Top := aTop;
       // Grid.SetBounds(0, aTop, Grid.Width, Grid.Height);

       // SetWindowPos(Grid.Handle, 0, 0, aTop, Grid.Width, Grid.Height,
       //   SWP_NOZORDER + SWP_NOACTIVATE);

        //Grid.Visible := True;

        aTop := aTop + Grid.Height + 1;

      end;

      FResultScrollBox.HorzScrollBar.Position := 0;
      FResultScrollBox.HorzScrollBar.Range := maxWidthGrid;
      FResultScrollBox.VertScrollBar.Position := 0;
      FResultScrollBox.VertScrollBar.Range := aTop;

      for k := Results.Count-1 downto 0 do
      begin
        if k = 0 then
          Grid := TStringGridEx(Results[0]);
        Results.Delete(k);
      end;
      if Assigned(Grid) and Grid.CanFocus then Grid.SetFocus;
    end;

  finally
    FResultScrollBox.EnableAlign;
    if Assigned(ChildPanel) then Push(ChildPanel);
  end;
end;

function TlogForm.GetCurrentScrollBox: TExScrollBox;
begin
  Result := ButtonPanel.GetCurrentScrollBox;
end;

procedure TlogForm.GridButtonClick(Sender: TObject);
var
  lpTempFileName: array[0..MAX_PATH] of char;
  i: integer;
  ATempPath: string;
  S: AnsiString;
  Stream: TFileStream;
begin
  if Confirmed(cnstOpenPlanMessage,cnstConfirm) then
  begin
    ATempPath := TempPath;
    GetTempFileName(PChar(ATempPath), 'p', 0, lpTempFileName);
    i := StrLen(lpTempFileName);
    if i > 0 then
    begin
      SetLength(ATempPath,i);
      StrCopy(PChar(ATempPath),lpTempFileName);
      if Sender is TStringGridEx then
      begin
        ATempPath := ChangeFileExt(ATempPath,cnstSqlplanExt);
        Stream := TFileStream.Create(ATempPath, fmCreate);
        try
          S := TStringGridEx(Sender).Hint;
          Stream.WriteBuffer(Pointer(S)^, Length(S));
        finally
          Stream.Free;
        end;
      end;

      if FileExists(ATempPath) then
        ShellExecute(Self.Npp.NppData.NppHandle, 'open', PChar(ATempPath), nil, nil, SW_SHOWNORMAL);

    end;
  end;
end;

procedure TlogForm.InstallerLogActionExecute(Sender: TObject);
begin
  ShellExecute(Npp.NppData.NppHandle, 'explore', nppPChar(Npp.InstallerLogPath(FSubFile)), nil, nil, SW_SHOWNORMAL);
end;

function TlogForm.IsErrorString(const S: string): boolean;
begin
  Result := (S.IndexOf('Msg ')=0) or (S.IndexOf('Сообщение ')=0);
end;

procedure TlogForm.LogBoxDblClick(Sender: TObject);
  function GetNumber(S: string): integer;
  var i: Longint;
      S0: string;
  begin
    Result := 0;
    S := S.Trim;
    S0 := '';
    for i := 1 to Length(S) do
      if cnstNumbers.IndexOf(S[i])>=0 then S0 := S0 + S[i];

    if S0.Length>0 then Result := S0.ToInteger;
  end;

  procedure GetProcNameAndErrorLine(const S: string;
    var ProcName: string; var LineNumber: integer);
  var Strings: TStrings;
      i: integer;
      S0: string;
  begin
    LineNumber := 0;
    ProcName := '';
    S0 := '|' + StringReplace(S,',','|,|',[rfReplaceAll]) + '|';
    Strings := TStringList.Create;
    try
      Strings.Delimiter := ',';
      Strings.QuoteChar := '|';
      Strings.DelimitedText := S0;
      //StringsToAnsi(Strings);
      i := Strings.Count - 1;
      if i > 0 then
      begin
        {Ищем номер}
        LineNumber := GetNumber(Strings[i]); //Предположительно, здесь "Line XXX" или "Строка XXX"

        {Ищем наименование процедуры}
        Dec(i);
        if i >= 0 then
        begin
          S0 := Trim(Strings[i]);
          i := Pos(' ',S0); //Предположительно, здесь "Procedure XXX"
          if i > 0 then
          begin
            S0 := Copy(S0,i+1,MaxInt);
            ProcName := RemoveGarbage(S0);
          end;
        end;
      end;
    finally
      Strings.Free;
    end;
  end;

var ItemNo: Integer;
    ProcName: string;
    Index,LineNumber: integer;
    Strings: TStrings;
begin
  ItemNo := LogBox.ItemIndex;
  if (ItemNo >= 0) and IsErrorString(LogBox.Items[ItemNo]) then
  begin
    if (FSubFile <> '') and FileExists(FSubFile) then
    begin
      GetProcNameAndErrorLine(LogBox.Items[ItemNo],ProcName,LineNumber);
      Index := 0;
      if ProcName <> '' then
      begin
        Strings := TStringList.Create;
        try
          Strings.LoadFromFile(FSubFile);
          Index := Strings.IndexOf(cnstBeginProcArray[0] + ProcName);
          if Index < 0 then Index := Strings.IndexOf(cnstBeginProcArray[1] + ProcName);
          Inc(Index);
        finally
          Strings.Free;
        end;
      end;
      Self.Npp.DoOpen(FSubFile,LineNumber + Index - 1);
    end;
  end;
end;

procedure TlogForm.LogBoxDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  S: string;
  Offset: Integer;
begin
  with (Control as TListBox).Canvas do
	begin
  	FillRect(Rect);
  	Offset := 2;
    S := (Control as TListBox).Items[Index];

    if IsErrorString(S) then Images.Draw((Control as TListBox).Canvas,Rect.Left + Offset, Rect.Top,0);
    Offset := 22;
  	TextOut(Rect.Left + Offset, Rect.Top, S)
	end;
end;

procedure TlogForm.msModeActionExecute(Sender: TObject);
begin
  if not msModeAction.Checked then
  begin
    msModeAction.Checked := True;
    sybModeAction.Checked := False;
    odbcModeAction.Checked:= False;
    postgresqlModeAction.Checked := False;
    sybTreeView.HideMe;
    odbcTreeView.HideMe;
    postgresqlTreeView.HideMe;
    msTreeView.ShowMe;

    msSQL.Pushed := True;
    Sybase.Pushed := False;
    PostgreSQL.Pushed := False;
    odbc.Pushed := False;

    msSQL.Color := PanelPushedColor(msSql);
    Sybase.Color := BDPanel.Color;
    PostgreSQL.Color := BDPanel.Color;
    odbc.Color := BDPanel.Color;
  end;
end;

procedure TlogForm.MSSQL1Click(Sender: TObject);
  function OneCheckedItem: boolean;
  var
    i,j: integer;
  begin
    j := 0;
    for i := 0 to BDPopupMenu.Items.Count-1 do
      j := j + integer(BDPopupMenu.Items[i].Checked);
    Result := j<2;
  end;
var
  i: integer;
  M: TMenuItem;
  P: TPanel;
begin
  M := TMenuItem(Sender);
  if M.Checked and OneCheckedItem then Exit;
  M.Checked := not M.Checked;
  P := nil;
  for i := 0 to BDPanel.ControlCount-1 do
  begin
    if BDPanel.Controls[i] is TPanel then
    begin
      if BDPanel.Controls[i].HelpContext = M.HelpContext then
      begin
        P := TPanel(BDPanel.Controls[i]);
        P.Visible := M.Checked;
        TOptionsReg.SetVisibleStatusBDButton(P.BDType,P.Visible);
        break;
      end;
    end;
  end;
  RealignBDButtons(Assigned(P) and P.Pushed);
end;

procedure TlogForm.msTreeViewMouseDown(Sender: TObject; Button: TMouseButton;
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

procedure TlogForm.NPanelClick(Sender: TObject);
var
  Panel: TPanel;
  PrevButtonName: string;
begin
  if NPanel.Caption = '>>' then
  begin
    Panel := ButtonPanel.NextButton(NPanel);
    if Assigned(Panel) then Push(Panel)
  end
  else
  begin
    Panel := ButtonPanel.PrevButton(NPanel);
    if Assigned(Panel) and (Panel.Name <> 'P1') then
    begin
      if Panel.Pushed then
      begin
        PrevButtonName := 'P' + IntToStr(StrToInt(Copy(Panel.Name,2,2))-1);
        Push(TPanel(FindComponent(PrevButtonName)));
      end;
      Panel.Pushed := False;
      Panel.Visible := False;
      Panel.ExScrollBox := nil;
    end;
  end
end;

procedure TlogForm.odbcModeActionExecute(Sender: TObject);
begin
  if not odbcModeAction.Checked then
  begin
    odbcModeAction.Checked := True;
    msModeAction.Checked := False;
    sybModeAction.Checked:= False;
    postgresqlModeAction.Checked := False;
    msTreeView.HideMe;
    sybTreeView.HideMe;
    postgresqlTreeView.HideMe;
    odbcTreeView.ShowMe;

    msSQL.Pushed := False;
    Sybase.Pushed := False;
    PostgreSQL.Pushed := False;
    odbc.Pushed := True;

    msSQL.Color := BDPanel.Color;
    Sybase.Color := BDPanel.Color;
    PostgreSQL.Color := BDPanel.Color;
    odbc.Color := PanelPushedColor(odbc);
  end;
end;

procedure TlogForm.OnGetSelectedText(Strings: TStrings);
var S: string;
    N: integer;
begin
  S := string(TDiaPlugin(Npp).SelectedText);
  N := Length(S);
  if N > 0 then Strings.Text := S;
end;

procedure TlogForm.OnReplaceSelectedText(Strings: TStrings);
var S: AnsiString;
begin
  if Strings.Count > 0 then
  begin
    S := UTF8Encode(Strings.Text);
    Npp.Sci_Send(SCI_REPLACESEL, 0, LPARAM(PAnsiChar(S)));
  end;
end;

procedure TlogForm.OpenListBDActionExecute(Sender: TObject);
begin
  if BasesPanel.Opened then
    BasesPanel.Close
  else
    BasesPanel.Open;
end;

procedure TlogForm.P1Click(Sender: TObject);
begin
  Push(TPanel(Sender));
end;

procedure TlogForm.P1MouseEnter(Sender: TObject);
var
  Parent: TPanel;
begin
  Parent := TPanel(TPanel(Sender).Parent);

  if TPanel(Sender).Pushed then TPanel(Sender).Color := PanelPushedColor(Sender)
  else
  begin
    if DarkMode then
      TPanel(Sender).Color := RGB(GetRValue(Parent.Color)+10,GetGValue(Parent.Color)+10,GetBValue(Parent.Color)+10)
    else
      TPanel(Sender).Color := RGB(216,230,242);
  end;
end;

function TLogForm.PanelPushedColor(Sender: TObject): TColor;
var
  Parent: TPanel;
begin
  Parent := TPanel(TPanel(Sender).Parent);
  if DarkMode then
    Result := RGB(GetRValue(Parent.Color)+20,GetGValue(Parent.Color)+20,GetBValue(Parent.Color)+20)
  else
    Result := RGB(144,200,246);
end;

procedure TlogForm.P1MouseLeave(Sender: TObject);
begin
  inherited;
  if TPanel(Sender).Pushed then
    TPanel(Sender).Color := PanelPushedColor(Sender)
  else
    TPanel(Sender).Color := TPanel(TPanel(Sender).Parent).Color;
end;

procedure TlogForm.pgConvertActionExecute(Sender: TObject);
{$IFNDEF NPPCONNECTIONS}
var
  CmdThread: TPgConversionThreadObject;
{$ENDIF}
begin
{$IFNDEF NPPCONNECTIONS}
  CmdThread := TPgConversionThreadObject.Create;
  CmdThread.Description := FSubFile;
  CmdThread.SourceFile := FSubFile;
  CmdThread.DestinationFile := FSubFile + '.pg.sql';
  CmdThread.OnAfterAction := AfterConversionAction;
  CmdThread.WinHandle := self.Handle;
  CmdThread.Start;
{$ENDIF}
end;


procedure TlogForm.postgresqlModeActionExecute(Sender: TObject);
begin
  if not postgresqlModeAction.Checked then
  begin
    postgresqlModeAction.Checked := True;
    msModeAction.Checked := False;
    odbcModeAction.Checked:= False;
    sybModeAction.Checked := False;
    msTreeView.HideMe;
    odbcTreeView.HideMe;
    sybTreeView.HideMe;
    postgresqlTreeView.ShowMe;

    msSQL.Pushed := False;
    Sybase.Pushed := False;
    PostgreSQL.Pushed := True;
    odbc.Pushed := False;

    msSQL.Color := BDPanel.Color;
    Sybase.Color := BDPanel.Color;
    PostgreSQL.Color := PanelPushedColor(PostgreSQL);
    odbc.Color := BDPanel.Color;
  end;
end;

procedure TlogForm.PrActionExecute(Sender: TObject);
begin
  {$IFNDEF NPPCONNECTIONS}DoPrForm;{$ENDIF}
end;

procedure TlogForm.PrActionUpdate(Sender: TObject);
var
  TreeNode: TTreeNode;
begin
  inherited;
  TreeNode := BasesPanel.CurrentNode;
  if Assigned(TreeNode) then
  begin
    TAction(Sender).Enabled := (TreeNode.ItemType in [itBase,itBaseRTI]) and
      (BasesPanel.BdType in [bdMSSQL, bdSybase]);
  end
  else
    TAction(Sender).Enabled := False;
end;

procedure TlogForm.Push(Panel: TPanel);
begin
  if Panel = FPushedButton then Exit;

  if Panel.ExScrollBox = nil then Panel.ExScrollBox := CreateBox;
  ResultLabel.Caption := Panel.ExScrollBox.Description;

  if Assigned(FPushedButton) then FPushedButton.ExScrollBox.HideMe;

  Panel.ExScrollBox.ShowMe;
  Panel.Pushed := True;
  Panel.Visible := True;

  if Assigned(FPushedButton) then FPushedButton.Pushed := False;

  Panel.Color := PanelPushedColor(Panel);
  if Assigned(FPushedButton) then FPushedButton.Color := ButtonPanel.Color;

  FPushedButton := Panel;
end;

procedure TlogForm.ReloadPrActionExecute(Sender: TObject);
{$IFNDEF NPPCONNECTIONS}
  procedure SetLogBoxHorzScrollBarVisible;
  var
    i, MaxWidth: integer;
  begin
    MaxWidth := 0;
    for i := 0 to LogBox.Items.Count - 1 do
      MaxWidth := Max(MaxWidth,LogBox.Canvas.TextWidth(LogBox.Items.Strings[i]+'wwwww'));
    SendMessage(LogBox.Handle, LB_SETHORIZONTALEXTENT, MaxWidth, 0);
  end;

var
  Strings: TStringList;
{$ENDIF}
begin
{$IFNDEF NPPCONNECTIONS}
  if (FLogFile <> '') and FileExists(FLogFile) then
  begin
    Strings := TStringList.Create;
    try
      Strings.LoadFromFile(FLogFile);
      StringsToAnsi(Strings);
      LogBox.Items.Clear;
      LogBox.Items.Assign(Strings);
    finally
      Strings.Free;
    end;
    SetLogBoxHorzScrollBarVisible;
  end;
{$ENDIF}
end;

procedure TlogForm.rtiClearActionExecute(Sender: TObject);
{$IFNDEF NPPCONNECTIONS}
var
  SqlThread: TSqlSilenceObject;
{$ENDIF}
begin
{$IFNDEF NPPCONNECTIONS}
  if Confirmed(Format(cnstRecordClearConfirmation,[BasesPanel.CurrentBase]),cnstRecordConfirmationTitle) then
  begin
    SqlThread := TSqlSilenceObject.Create;
    if BasesPanel.BdType = bdPostgreSQL then
      SqlThread.SQL.Text := constSQL_RTI_Clear_PostgreSQL
    else
      SqlThread.SQL.Text := Format(constSQL_RTI_Clear,[BasesPanel.CurrentUser,BasesPanel.CurrentBase]);
    SqlThread.Description := BasesPanel.CurrentBase;
    SqlThread.BdType := BasesPanel.BdType;
    SqlThread.Name := BasesPanel.CurrentServer;
    SqlThread.UserObject := BasesPanel.CurrentNode;
    SqlThread.UserTree := BasesPanel.CurrentTreeView;
    SqlThread.ConnectionString := BasesPanel.ConnectionString;
    SqlThread.OnAfterAction := AfterClearRTIAction;
    SqlThread.WinHandle := self.Handle;
    SqlThread.Start;
  end;
{$ENDIF}
end;

procedure TlogForm.rtiRecordActionExecute(Sender: TObject);
{$IFNDEF NPPCONNECTIONS}
var
  SqlThread: TSqlSilenceObject;
{$ENDIF}
begin
{$IFNDEF NPPCONNECTIONS}
  if Confirmed(Format(cnstRecordConfirmation,[BasesPanel.CurrentBase]),cnstRecordConfirmationTitle) then
  begin
    SqlThread := TSqlSilenceObject.Create;

    if BasesPanel.BdType = bdPostgreSQL then
      SqlThread.SQL.Text := Format(constSQL_RTI_PostgreSQL,[1,1])
    else
      SqlThread.SQL.Text := Format(constSQL_RTI,[BasesPanel.CurrentUser,1,1,0,BasesPanel.CurrentBase]);

    SqlThread.Description := BasesPanel.CurrentBase;
    SqlThread.BdType := BasesPanel.BdType;
    SqlThread.Name := BasesPanel.CurrentServer;
    SqlThread.UserObject := BasesPanel.CurrentNode;
    SqlThread.UserTree := BasesPanel.CurrentTreeView;
    SqlThread.UserTag := NativeInt(itBaseRTI);
    SqlThread.ConnectionString := BasesPanel.ConnectionString;
    SqlThread.OnAfterAction := AfterRTIAction;
    SqlThread.WinHandle := self.Handle;
    SqlThread.Start;
  end;
{$ENDIF}
end;

procedure TlogForm.rtiRecordStopActionExecute(Sender: TObject);
{$IFNDEF NPPCONNECTIONS}
var
  SqlThread: TSqlSilenceObject;
{$ENDIF}
begin
{$IFNDEF NPPCONNECTIONS}
  if Confirmed(Format(cnstRecordStopConfirmation,[BasesPanel.CurrentBase]),cnstRecordConfirmationTitle) then
  begin
    SqlThread := TSqlSilenceObject.Create;
    if BasesPanel.BdType = bdPostgreSQL then
      SqlThread.SQL.Text := Format(constSQL_RTI_PostgreSQL,[0,0])
    else
      SqlThread.SQL.Text := Format(constSQL_RTI,[BasesPanel.CurrentUser,0,0,0,BasesPanel.CurrentBase]);
    SqlThread.Description := BasesPanel.CurrentBase;
    SqlThread.BdType := BasesPanel.BdType;
    SqlThread.Name := BasesPanel.CurrentServer;
    SqlThread.UserObject := BasesPanel.CurrentNode;
    SqlThread.UserTree := BasesPanel.CurrentTreeView;
    SqlThread.UserTag := NativeInt(itBase);
    SqlThread.ConnectionString := BasesPanel.ConnectionString;
    SqlThread.OnAfterAction := AfterRTIAction;
    SqlThread.WinHandle := self.Handle;
    SqlThread.Start;
  end;
{$ENDIF}
end;

procedure TlogForm.rtiSaveActionExecute(Sender: TObject);
{$IFNDEF NPPCONNECTIONS}
var
  F: string;
  SqlThread: TSqlQueryRTIObject;
{$ENDIF}
begin
{$IFNDEF NPPCONNECTIONS}
  if FRTIFileName <> '' then F := FRTIFileName
  else
    Npp.GetFullFileName(F);

  SaveDialog.InitialDir := ExtractFilePath(F);
  SaveDialog.FileName := ExtractFileName(rtiFileName(ExtractFilePath(F)));
  if SaveDialog.Execute then
  begin

    if FileExists(SaveDialog.FileName) then
    begin
       if Confirmed(Format(cnstRecordConfirmRewriteExistingFile,[SaveDialog.FileName]),cnstRecordConfirmationTitle) then
         //Если необходимо перезаписать - удаляем файл
         DeleteFile((SaveDialog.FileName))
       else
         Exit;
    end;

    FRTIFileName := SaveDialog.FileName;

    if BasesPanel.BdType = bdPostgreSQL then
      SqlThread := TPostgreSQLQueryRTIObject.Create
    else
      SqlThread := TSqlQueryRTIObject.Create;

    SqlThread.Name := SaveDialog.FileName;
    SqlThread.BdType := BasesPanel.BdType;
    SqlThread.ConnectionString := BasesPanel.ConnectionString;
    SqlThread.OnAfterAction := AfterWriteRTIAction;
    SqlThread.WinHandle := self.Handle;
    SqlThread.Start;
  end;
{$ENDIF}
end;

procedure TlogForm.rtiRecordActionUpdate(Sender: TObject);
var
  TreeNode: TTreeNode;
begin
  inherited;
  TreeNode := BasesPanel.CurrentNode;
  if Assigned(TreeNode) then
    TAction(Sender).Enabled := TreeNode.ItemType in [itBase,itBaseRTI]
  else
    TAction(Sender).Enabled := False;
end;

procedure TlogForm.SetCurrentNode(const Value: TTreeNode);
begin
  FCurrentNode := Value;
end;

procedure TlogForm.SQLActionExecute(Sender: TObject);
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
    TdiaPlugin(Npp).FuncExecSQL;
end;

procedure TlogForm.SqlShowModeActionExecute(Sender: TObject);
begin
  if not SqlShowModeAction.Checked then
  begin
    SqlShowModeAction.Checked := True;
    prolivkaShowModeAction.Checked := False;

    SqlButton.Pushed := True;
    ProlivkaButton.Pushed := False;

    ProlivkaButton.Color := ResultLabel.Color;
    SqlButton.Color := PanelPushedColor(SqlButton);

    LogBox.Visible := False;
    ButtonPanel.Visible := True;
    ResultLabel.Caption := FPushedButton.ExScrollBox.Description;
  end;
end;

procedure TlogForm.SubFileActionExecute(Sender: TObject);
begin
  if (FSubFile <> '') and FileExists(FSubFile) then Npp.DoOpen(FSubFile);
end;

procedure TlogForm.SubFileActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (FSubFile <> '') and FileExists(FSubFile);
end;

procedure TlogForm.sybModeActionExecute(Sender: TObject);
begin
  if not sybModeAction.Checked then
  begin
    sybModeAction.Checked := True;
    msModeAction.Checked := False;
    odbcModeAction.Checked:= False;
    postgresqlModeAction.Checked := False;
    msTreeView.HideMe;
    odbcTreeView.HideMe;
    postgresqlTreeView.HideMe;
    sybTreeView.ShowMe;

    msSQL.Pushed := False;
    Sybase.Pushed := True;
    PostgreSQL.Pushed := False;
    odbc.Pushed := False;

    msSQL.Color := BDPanel.Color;
    Sybase.Color := PanelPushedColor(SyBase);
    PostgreSQL.Color := BDPanel.Color;
    odbc.Color := BDPanel.Color;
  end;
end;

procedure TlogForm.prolivkaShowModeActionExecute(Sender: TObject);
begin
  if not prolivkaShowModeAction.Checked then
  begin
    SqlShowModeAction.Checked := False;
    prolivkaShowModeAction.Checked := True;

    ProlivkaButton.Pushed := True;
    SqlButton.Pushed := False;

    ProlivkaButton.Color := PanelPushedColor(ProlivkaButton);
    SqlButton.Color := ResultLabel.Color;

    LogBox.Visible := True;
    ButtonPanel.Visible := False;

    ResultLabel.Caption := ProlivkaButton.Hint;
  end;
end;

procedure TlogForm.addFavoriteConnectionActionExecute(Sender: TObject);
var
  Data: string;
  TreeNode: TTreeNode;
begin
  inherited;
  TreeNode := BasesPanel.CurrentNode;
  if Assigned(TreeNode) then
  begin
    Data := TTreeNodeEx(TreeNode).DataSource;
    TOptionsReg.SaveFavoriteConnection(BasesPanel.BdType,Data.Substring(0,Data.IndexOf('|')) + UserName(Data),Data);
  end;
end;

procedure TlogForm.removeFavoriteConnectionActionExecute(Sender: TObject);
var
  Data: string;
  TreeNode: TTreeNode;
begin
  inherited;
  TreeNode := BasesPanel.CurrentNode;
  if Assigned(TreeNode) then
  begin
    Data := TTreeNodeEx(TreeNode).DataSource;
    TOptionsReg.DeleteFavoriteConnection(BasesPanel.BdType,Data.Substring(0,Data.IndexOf('|')) + UserName(Data));
  end;
end;

procedure TlogForm.TableListActionExecute(Sender: TObject);
var
  SqlThread: TTableListObject;
  CString,CName: string;
  TreeNode: TTreeNode;
begin
  TreeNode := BasesPanel.CurrentNode;
  if Assigned(TreeNode) then
    if (TreeNode.ItemType in [itBase,itBaseRTI]) and (TreeNode.TableList.Count=0) then
    begin
      if BasesPanel.BdType = bdODBC then Exit;
      CString := BasesPanel.ConnectionString;
      CName := Format(cnstSqlExec,[
                                   BasesPanel.CurrentServer,
                                   BasesPanel.CurrentBase,
                                   BasesPanel.CurrentUser
                                   ]);
      if CString = '' then
      begin
        CString := CurrentScrollBox.ConnectionString;
        CName   := CurrentScrollBox.Description;
      end;

      if CString <> '' then
      begin
        TdiaPlugin(Npp).SetCursor(crWait);
        SqlThread := TTableListObject.Create;
        SqlThread.SQL.Text := '';
        SqlThread.Description := TableListAction.Hint;
        SqlThread.BdType := BasesPanel.BdType;
        SqlThread.Name := CName;
        SqlThread.Node := TreeNode;
        SqlThread.ConnectionString := CString;
        SqlThread.OnAfterAction := AfterTableListAction;
        SqlThread.WinHandle := self.Handle;
        SqlThread.Start;
      end;
    end;
  TableListAction.Hint := '';
end;

procedure TlogForm.TreeViewChange(Sender: TObject; Node: TTreeNode);
begin
  if Assigned(Node) and not Application.Terminated then
    if (Node.ItemType in [itBase,itBaseRTI]) and (Node.TableList.Count>0) then
    begin
      Node.TableList.Clear;
      TableListAction.Hint := '';
      TableListAction.Execute;
    end;
end;

procedure TlogForm.TreeViewPopupMenuPopup(Sender: TObject);
  procedure CheckInStrings(Strings: TStringList; index: integer);
  var
    Item: TMenuItem;
    Data: string;
    j: Integer;
    found: boolean;
  begin
    Item := My_Connections[index];
    found := False;
    if Strings.Count>0 then
      for j := Strings.Count-1 to 0 do
      begin
        Data := Strings[j];
        found := Item.Hint = Data;
        if found then break;
      end;
    if found then Strings.Delete(j)
    else
    begin
      My_Connections.Delete(index);
      Item.Free;
      Item := nil;
    end;
  end;

var
  Strings: TStringList;
  Data: string;
  Item: TMenuItem;
  TreeNode: TTreeNode;
  i: integer;
begin
  TreeNode := BasesPanel.CurrentNode;
  AddOrRemoveFavoriteItem.Action := addFavoriteConnectionAction;
  Strings := TOptionsReg.GetFavoriteList(BasesPanel.BdType);
  try
    for i := My_Connections.Count-1 downto 2 do
      CheckInStrings(Strings,i);

    for i := 0 to Strings.Count-1 do
    begin
      Data := Strings[i];
      Item := TMenuItem.Create(My_Connections);
      Item.Caption := Data.Substring(0,Data.IndexOf('|')) + UserName(Data);
      Item.Hint := Data;
      Item.OnClick := FavoriteItemsClickProcedure;
      My_Connections.Insert(My_Connections.Count, Item);
    end;

    if Assigned(TreeNode) then
      for i := My_Connections.Count-1 downto 2 do
        if My_Connections[i].Hint = TTreeNodeEx(TreeNode).DataSource then
          AddOrRemoveFavoriteItem.Action := removeFavoriteConnectionAction;

  finally
    Strings.Free;
  end;
end;

procedure TlogForm.FavoriteItemsClickProcedure(Sender: TObject);
begin
  AddServer(TMenuItem(Sender).Hint);
end;

function TlogForm.CreateBox: TExScrollBox;
var
  ResultPanel0: TExScrollBox;
begin
  ResultPanel0:= TExScrollBox.Create(sql);
  ResultPanel0.Parent := sql;
  if DarkMode then
  begin
    ResultPanel0.Color := ColorSofterBackground;
    ResultPanel0.Font.Color := ColorText
  end
  else
    ResultPanel0.Color := clWhite;

  ResultPanel0.DoubleBuffered := True;
  ResultPanel0.Align := alClient;
  ResultPanel0.BorderStyle := bsNone;
  ResultPanel0.Visible := True;
  Result := ResultPanel0;
end;

procedure TlogForm.WMThreadMessage(var Msg: TMessage);
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

function TlogForm.rtiFileName(const LoggerPath: TFileName): TFileName;
  function GetHostName: String;
  var
    Buf: array[0..MAX_COMPUTERNAME_LENGTH] of char;
    BufLength: DWORD;
  begin
    BufLength := sizeof(Buf);
    if GetComputerName(Buf, BufLength) then
      Result := Buf
    else
      Result := '';
  end;
var S,CurrentBD,FFileName: string;
    Counter : integer;
begin
  Result := '';
  CurrentBD := BasesPanel.CurrentBase;
  if LoggerPath <> '' then Result := IncludeTrailingPathDelimiter(LoggerPath);
  if CurrentBD<>'' then
  begin
    S := Result + GetHostName + '_' +
         BasesPanel.CurrentUser + '_' +
         BasesPanel.CurrentServer + '_' +
         CurrentBD + '_SRV';

      Counter := -1;
      while True do
      begin
        // подбираем имя файла
        inc(Counter);
        FFileName := S;
        if Counter > 0 then
          FFileName := FFileName + '_' + IntToStr(Counter);
        if (FileExists(FFileName + '.rti')) then
          Continue;
        Break;
      end;
      Result := FFileName + '.rti';
  end;
end;

end.
