unit plugin;

interface

uses
  Winapi.Windows,  Winapi.Messages, System.SysUtils,
  System.Classes, Vcl.ComCtrls, SciSupport, Vcl.Forms,
  Vcl.Controls, NppPlugin;

type
  TModalResultArray = array[False..True] of TModalResult;

  TBdType = (bdMSSQL, bdSybase, bdODBC);

  TBdTypeStringArray = array [TBdType] of string;

  TItemType = (itServerMS,itServerSYB,itODBC,itBase,itBaseRTI,itLogin);

  TMenuItemCheck = (miHidden,miShown);

  TdsPlugin = class(TNppPlugin)
  private
    { Private declarations }
    FForm: TForm;
  public
    constructor Create;

    procedure DoNppnToolbarModification; override;

    procedure FuncLog;
    procedure FuncExecSQL;
  end;

const
  WM_USER_MESSAGE_FROM_THREAD =  WM_USER + 1;

  cnstSqlWaitResults = 'Waiting........';
  cnstSqlNoResults = 'Command executed';
  cnstSqlExec = 'Results: %s\%s (%s)';

  cnstModalResultArray: TModalResultArray = (mrCancel,mrOk);

  cnstShowPlan_ON = 'set showplan on';
  cnstShowPlan_OFF = 'set showplan off';
  cnstAseOleDB = '[ASEOLEDB]';
  cnstShowPlan = 'PLAN:';
  cnstShowIndx = 'INDX:';
  cnstSqlplanExt = '.sqlplan';
  cnstGo = 'go';

  constLoginBDCaption  = 'Connect to ';
  constLoginBDCaptionArray: TBdTypeStringArray = ('MSSQL','Sybase','ODBC');
  constDSBDCaptionArray: TBdTypeStringArray = ('Server','Server','DataSource');
  cnstErroCaption = 'Error';
  cnstNoBaseSelected = 'You must select Server and Base before executing SQL!';

  cnstMainDlgId = 0;

var
  NPlugin: TdsPlugin;

implementation

uses connectionFormUnit;

procedure _FuncLog; cdecl;
begin
  NPlugin.FuncLog;
end;

procedure _FuncExecSQL; cdecl;
begin
  NPlugin.FuncExecSQL;
end;

{ TdsPlugin }

constructor TdsPlugin.Create;
var
  sk: TShortcutKey;
begin
  inherited;

  PluginName := 'npp.Connections';
  AddFuncItem('Show result panel', _FuncLog);

  sk.IsCtrl := true; sk.IsAlt := false; sk.IsShift := false;
  sk.Key := 69; // 'E'
  AddFuncItem('Execute SQL', _FuncExecSQL, sk);

  Sci_Send(SCI_SETMODEVENTMASK,SC_MOD_INSERTTEXT or SC_MOD_DELETETEXT,0);
end;

procedure TdsPlugin.DoNppnToolbarModification;
var
  tb: TToolbarIcons;
begin
  tb.ToolbarIcon := 0;
  tb.ToolbarBmp := LoadImage(Hinstance, 'TREE', IMAGE_BITMAP, 0, 0, (LR_DEFAULTSIZE));
  Npp_Send(NPPM_ADDTOOLBARICON, WPARAM(self.CmdIdFromDlgId(cnstMainDlgId)), LPARAM(@tb));

  tb.ToolbarBmp := LoadImage(Hinstance, 'SQL', IMAGE_BITMAP, 0, 0, (LR_DEFAULTSIZE));
  Npp_Send(NPPM_ADDTOOLBARICON, WPARAM(self.CmdIdFromDlgId(cnstMainDlgId+1)), LPARAM(@tb));
end;

procedure TdsPlugin.FuncExecSQL;
var S: string;
    N: integer;
begin
  if not Assigned(FForm) then
  begin
    FuncLog;
    TconnectionForm(FForm).DoConnect;
  end
  else
  begin
    S := SelectedText;
    N := Length(S);

    if N < 1 then
    begin
      S := GetText;
      N := Length(S);
    end;

    if N > 1 then
    begin
      TconnectionForm(FForm).DoSql(S);
    end;
  end;
end;

procedure TdsPlugin.FuncLog;
begin
  if not Assigned(FForm) then FForm := TconnectionForm.Create(self, cnstMainDlgId);
  (FForm as TconnectionForm).Carousel;
end;

end.
