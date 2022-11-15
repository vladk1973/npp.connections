unit TreeViewExUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ComCtrls, ConstUnit, Data.Db,
  Vcl.Dialogs, Vcl.ExtCtrls;

type

  TTreeNodeEx = class(TTreeNode)
  private
    FDataSource: string;
    FTableList: TStringList;
  public
    constructor Create(AOwner: TTreeNodes); override;
    destructor Destroy; override;
    property DataSource: string read FDataSource write FDataSource;
  end;

  TTreeViewEx = class(TCustomTreeView)
  private
    FBdType: TBdType;
    FDarkMode: boolean;
    FSelectedColor: TColor;
    procedure TreeViewCompare(Sender: TObject; Node1, Node2: TTreeNode;
      Data: Integer; var Compare: Integer);
    procedure WMRButtonDown(var Message: TWMLButtonDblClk); message WM_RBUTTONDOWN;
    function Destroying: boolean;
    procedure SetBdType(const Value: TBdType);
  protected
    function IsCustomDrawn(Target: TCustomDrawTarget; Stage: TCustomDrawStage): Boolean; override;
    function CustomDrawItem(Node: TTreeNode; State: TCustomDrawState;
      Stage: TCustomDrawStage; var PaintImages: Boolean): Boolean; override;
    procedure TreeViewExGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure TreeViewExGetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure TreeViewCreateNodeClass(Sender: TCustomTreeView;
      var NodeClass: TTreeNodeClass);
  public
    constructor Create(AOwner: TComponent); override;
    function NodeFoundByDataSource(TreeView: TTreeViewEx; DataSource: string): TTreeNode;
    procedure AddServer(const Data: TCommand; Login: string; Bases: TDataset);
    property BdType: TBdType read FBdType write SetBdType;
    property DarkMode: boolean read FDarkMode write FDarkMode;
    property SelectedColor: TColor read FSelectedColor write FSelectedColor;
  published
    property Align;
    property Anchors;
    property AutoExpand;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind default bkNone;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property ChangeDelay;
    property Color;
    property Ctl3D;
    property Constraints;
    property DoubleBuffered;
    property DragKind;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property HotTrack;
    property Images;
    property Indent;
    property MultiSelect;
    property MultiSelectStyle;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property RightClickSelect;
    property RowSelect;
    property ShowButtons;
    property ShowHint;
    property ShowLines;
    property ShowRoot;
    property SortType;
    property StateImages;
    property TabOrder;
    property TabStop default True;
    property ToolTips;
    property Touch;
    property Visible;
    property StyleElements;
    property OnAddition;
    property OnAdvancedCustomDraw;
    property OnAdvancedCustomDrawItem;
    property OnCancelEdit;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnCollapsed;
    property OnCollapsing;
    property OnCompare;
    property OnContextPopup;
    property OnCreateNodeClass;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnDblClick;
    property OnDeletion;
    property OnDragDrop;
    property OnDragOver;
    property OnEdited;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnExpanding;
    property OnExpanded;
    property OnGesture;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property OnHint;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    { Items must be published after OnGetImageIndex and OnGetSelectedIndex }
    property Items;
  end;

  TTreeNodeHelper = class helper for TTreeNode
  private
    function GetItemType: TItemType;
    procedure SetItemType(const Value: TItemType);
    function GetTableList: TStringList;
  public
    property ItemType: TItemType read GetItemType write SetItemType;
    property TableList: TStringList read GetTableList;
  end;


implementation

{ TTreeNodeHelper }

function TTreeNodeHelper.GetItemType: TItemType;
begin
  Result := TItemType(Self.Data);
end;

function TTreeNodeHelper.GetTableList: TStringList;
begin
  Result := TTreeNodeEx(Self).FTableList;
end;

procedure TTreeNodeHelper.SetItemType(const Value: TItemType);
begin
  Self.Data := Pointer(Integer(Value));
end;

{ TTreeViewEx }

constructor TTreeViewEx.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OnCompare := TreeViewCompare;
  ReadOnly := True;
  SortType := stText;
  Align := alClient;
  HideSelection := False;
  ShowRoot := False;

  BevelOuter := bvNone;
  BevelInner := bvNone;
  BorderStyle := bsNone;
  BorderWidth := 4;

  OnGetImageIndex := TreeViewExGetImageIndex;
  OnGetSelectedIndex := TreeViewExGetSelectedIndex;
  OnCreateNodeClass := TreeViewCreateNodeClass;
end;

function TTreeViewEx.CustomDrawItem(Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage; var PaintImages: Boolean): Boolean;
var
  NodeRect: TRect;
begin
  Result := inherited CustomDrawItem(Node,State,Stage,PaintImages);
  if (Stage = cdPrePaint) and PaintImages then
  begin
    if Node.ItemType = itLogin then
      Canvas.Font.Style := Canvas.Font.Style + [fsBold]
    else
    begin
      Canvas.Font.Style := Canvas.Font.Style - [fsBold];

      if (State = [cdsSelected]) and FDarkMode then
      begin
        Canvas.Brush.Color := FSelectedColor; //RGB(120,120,120); // RGB(34,61,84);
        NodeRect := Node.DisplayRect(True);
        NodeRect.Left := NodeRect.Left - Images.Width - 5;
        NodeRect.Right := NodeRect.Right + 2;
        Canvas.FillRect(NodeRect);
        Canvas.Font.Color := clBlack;
      end;
    end;
  end;
end;

function TTreeViewEx.IsCustomDrawn(Target: TCustomDrawTarget;
  Stage: TCustomDrawStage): Boolean;
begin
  if (Stage = cdPrePaint) and (Target = dtItem) then
    Result := True
  else
    Result := inherited IsCustomDrawn(Target, Stage);
end;

procedure TTreeViewEx.SetBdType(const Value: TBdType);
begin
  FBdType := Value;
end;

procedure TTreeViewEx.TreeViewCompare(Sender: TObject; Node1, Node2: TTreeNode;
  Data: Integer; var Compare: Integer);
begin
  if TTreeView(Sender).Visible then
  begin
    if Node1.ItemType = itLogin then
    begin
      Compare := -1;
      Exit;
    end;
    if Node2.ItemType = itLogin then
    begin
      Compare := 1;
      Exit;
    end;
    Compare := lstrcmp(PChar(Node1.Text), PChar(Node2.Text))
  end;
end;

procedure TTreeViewEx.TreeViewCreateNodeClass(Sender: TCustomTreeView;
  var NodeClass: TTreeNodeClass);
begin
  NodeClass := TTreeNodeEx;
end;

procedure TTreeViewEx.TreeViewExGetImageIndex(Sender: TObject; Node: TTreeNode);
begin
  if Node.HasChildren then
    Node.ImageIndex := 0
  else
    case Node.ItemType of
      itBase    : Node.ImageIndex := 1;
      itBaseRTI : Node.ImageIndex := 2;
      itLogin   : Node.ImageIndex := 3;
    end;
end;

procedure TTreeViewEx.TreeViewExGetSelectedIndex(Sender: TObject; Node: TTreeNode);
begin
  Node.SelectedIndex := Node.ImageIndex;
end;

function TTreeViewEx.Destroying: boolean;
begin
  Result := (csDestroying in ComponentState) or Application.Terminated;
end;

procedure TTreeViewEx.WMRButtonDown(var Message: TWMLButtonDblClk);
var
  Node: TTreeNode;
begin
  if Destroying then Exit;
  Node := TTreeNode(GetNodeAt(TWMMouse(Message).XPos, TWMMouse(Message).YPos));
  if Assigned(Node) then
  begin
    Self.Selected := Node;
  end;
end;

procedure TTreeViewEx.AddServer(const Data: TCommand; Login: string;
  Bases: TDataset);
var
  TreeNode,Node: TTreeNode;
begin
  TreeNode := Items.AddChild(nil,Data.Substring(0,Data.IndexOf('|')));
  TreeNode.Data := Pointer(Self.BdType); //Передаем тип сервера
  TTreeNodeEx(TreeNode).DataSource := Data;
  if not Login.IsEmpty then
  begin
    Node := Items.AddChild(TreeNode,Login);
    Node.Data := Pointer(Integer(itLogin));
  end;
  if Assigned(Bases) and Bases.Active then
  begin
    Bases.First;
    while not Bases.Eof do
    begin
      Node := Items.AddChild(TreeNode,Bases.Fields[0].AsString);
      Node.Data := Pointer(Integer(itBase));
      Bases.Next;
    end;
    Bases.Close;
  end;
  TreeNode.Expand(True);
end;

function TTreeViewEx.NodeFoundByDataSource(TreeView: TTreeViewEx;
  DataSource: string): TTreeNode;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to TreeView.Items.Count-1 do
    if TreeView.Items[i].Parent = nil then
      if TTreeNodeEx(TreeView.Items[i]).DataSource = DataSource then
      begin
        Result := TreeView.Items[i];
        break;
      end;
end;

{ TTreeNodeEx }

constructor TTreeNodeEx.Create(AOwner: TTreeNodes);
begin
  inherited;
  FTableList := TStringList.Create;
end;

destructor TTreeNodeEx.Destroy;
begin
  FTableList.Free;
  inherited;
end;

end.
