unit Easy.diaplugin;

interface

uses
  Winapi.Windows,  Winapi.Messages, System.SysUtils,
  Vcl.Dialogs, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls,
  System.Classes, Vcl.ComCtrls, SciSupport, System.Contnrs, System.Math,
  NppPlugin, ConstUnit,
  {$IFNDEF NPPCONNECTIONS}diaConstUnit,{$ENDIF}
  logFormUnit;

type

  TdiaPlugin = class(TNppPlugin)
  private
    { Private declarations }
    FLogForm: TLogForm;
    procedure ProcessSqlFields(const S: string);
  public
    constructor Create;

    procedure DoNppnToolbarModification; override;
    procedure DoNppnCharAdded(const ASCIIKey: Integer); override;
    procedure DoNppnUpdateAutoSelection(P: PAnsiChar); override;
    procedure DoChangePluginTheme; override;
    procedure DoNppnShutdown; override;

    procedure SetCursor(const Mode: TCursorMode);

    procedure ShowAutocompletionList(const lengthEntered: NativeInt; Tables: AnsiString);
    procedure ShowAutocompletionIndex(const TableName: string; Indx: TStringList);
    procedure FuncLog;
    procedure FuncExecThisSQL(S: string);
    procedure FuncExecHelpSQL(help: THelpType; S: string);
    procedure FuncExecSQL;
    procedure FuncExecSQLPlan;

    procedure FuncSP_HELP;
    procedure FuncSP_HELPINDEX;
    procedure FuncSP_HELPTEXT;
    procedure FuncExecSQLTables;

    {$IFNDEF NPPCONNECTIONS}
    procedure FuncPrForm;
    procedure FuncInsertParam;
    {$ENDIF}

  end;

var
  Npp: TdiaPlugin;

implementation

{$IFNDEF NPPCONNECTIONS}
procedure _FuncPrForm; cdecl;
begin
  Npp.FuncPrForm;
end;

procedure f_M_BUSINESSLOG_PARAM; cdecl;
begin
  Npp.FuncInsertParam;
end;

procedure f_M_BUSINESSLOG_BEGIN; cdecl;
begin
  Npp.FuncInsertText(cnstBSL_B);
end;

procedure f_M_BUSINESSLOG_BLOCK_BEGIN; cdecl;
begin
  Npp.FuncInsertText(cnstBSBL_B);
end;

procedure f_M_BUSINESSLOG_BLOCK_END; cdecl;
begin
  Npp.FuncInsertText(cnstBSBL_E);
end;

procedure f_M_BUSINESSLOG_CHECKPOINT; cdecl;
begin
  Npp.FuncInsertText(cnstBSL_C);
end;

procedure f_M_LOG_TABLE_REQ; cdecl;
begin
  Npp.FuncInsertText(cnstBSL_T);
end;
{$ENDIF}

procedure _FuncExecSQLPlan; cdecl;
begin
  Npp.FuncExecSQLPlan;
end;

procedure _FuncLog; cdecl;
begin
  Npp.FuncLog;
end;

procedure _FuncExecSQL; cdecl;
begin
  Npp.FuncExecSQL;
end;

procedure f_SP_HELP; cdecl;
begin
  Npp.FuncSP_HELP;
end;

procedure f_SP_HELPINDEX; cdecl;
begin
  Npp.FuncSP_HELPINDEX;
end;

procedure f_SP_HELPTEXT; cdecl;
begin
  Npp.FuncSP_HELPTEXT;
end;

procedure _FuncExecSQLTables; cdecl;
begin
  Npp.FuncExecSQLTables;
end;

{ TdiaPlugin }

constructor TdiaPlugin.Create;
var
  sk: TShortcutKey;
begin
  inherited;
{$IFNDEF NPPCONNECTIONS}
  PluginName := 'Easy.dia';
  AddFuncItem(PluginName, _FuncLog);

  sk.IsCtrl := true; sk.IsAlt := false; sk.IsShift := false;
  sk.Key := 120; // F9
  AddFuncItem('Пролить скрипт на базу', _FuncPrForm, sk);

  sk.IsCtrl := true; sk.IsAlt := false; sk.IsShift := false;
  sk.Key := 69; // 'E'
  AddFuncItem('Выполнить запрос SQL', _FuncExecSQL, sk);
  AddFuncItem('Получить план запроса SQL', _FuncExecSQLPlan);

  AddFuncItem('Получить список p/t таблиц', _FuncExecSQLTables);
{$ELSE}
  PluginName := 'Npp.connections';
  AddFuncItem(PluginName, _FuncLog);

  sk.IsCtrl := true; sk.IsAlt := false; sk.IsShift := false;
  sk.Key := 69; // 'E'
  AddFuncItem('Execute SQL query', _FuncExecSQL, sk);
  AddFuncItem('Get SQL execution plan', _FuncExecSQLPlan);
  AddFuncItem('Get a list of SQL tables', _FuncExecSQLTables);
{$ENDIF}

{$IFNDEF NPPCONNECTIONS}
  AddFuncItem('-', nil );
  AddFuncItem('M_BUSINESSLOG_BEGIN'      ,f_M_BUSINESSLOG_BEGIN);
  AddFuncItem('M_BUSINESSLOG_BLOCK_BEGIN',f_M_BUSINESSLOG_BLOCK_BEGIN);
  AddFuncItem('M_BUSINESSLOG_BLOCK_END'  ,f_M_BUSINESSLOG_BLOCK_END);
  AddFuncItem('M_BUSINESSLOG_CHECKPOINT' ,f_M_BUSINESSLOG_CHECKPOINT);
  AddFuncItem('M_BUSINESSLOG_PARAM'      ,f_M_BUSINESSLOG_PARAM);
  AddFuncItem('M_LOG_TABLE_REQ'          ,f_M_LOG_TABLE_REQ);
{$ENDIF}
  AddFuncItem('-', nil );


  sk.IsCtrl := true; sk.IsAlt := false; sk.IsShift := false;
  sk.Key := 123; // F12
  AddFuncItem('sp_help' ,f_SP_HELP,sk);
  AddFuncItem('sp_helpindex' ,f_SP_HELPINDEX);
  AddFuncItem('sp_helptext' ,f_SP_HELPTEXT);

  Sci_Send(SCI_SETMODEVENTMASK,SC_MOD_INSERTTEXT or SC_MOD_DELETETEXT,0);
end;

procedure TdiaPlugin.DoChangePluginTheme;
begin
  inherited;
  if Assigned(FLogForm) then FLogForm.OnAfterChangeDarkMode(Self);
end;

procedure TdiaPlugin.DoNppnCharAdded(const ASCIIKey: Integer);
var
  Size,Len: Integer;
  S: AnsiString;
begin
  if not Assigned(FLogForm) then Exit;

  if ASCIIKey in [cnstTracingChar,cnstTracingFieldChar] then
  begin
    Size := Sci_Send(SCI_GETCURLINE, 0, 0);
    SetLength(S,Size);
    try
      Len := Sci_Send(SCI_GETCURLINE, Size, LPARAM(PAnsiChar(S)));
      if not HasV5Apis then
        SetLength(S,Size-1);

      {$IFNDEF NPPCONNECTIONS}
      if ASCIIKey = cnstTracingChar then
        ProcessSqlIndex(Copy(string(S),1,Len-1),FlogForm.DoSqlIndex);
      {$ENDIF}
      if ASCIIKey = cnstTracingFieldChar then
        ProcessSqlFields(Copy(string(S),1,Len-1));

    finally
      SetLength(S,0);
    end;
  end;
end;

procedure TdiaPlugin.DoNppnShutdown;
begin
  if Assigned(FLogForm) then
  begin
    FLogForm.Free;
    FLogForm := nil;
  end;
  inherited;
end;

procedure TdiaPlugin.ProcessSqlFields(const S: string);
const
  cnstLastOperator = True;
  cnstFirstOperator = False;
var
  i, iPos, LineCount, Line: Integer;
  S0, alias, Txt: string;
begin
  iPos := S.LastIndexOf(' ');
  if iPos>=0 then
    alias := S.Substring(iPos+1)
  else
    alias := S;

  if alias.Length>0 then
  begin
    LineCount := GetLineCount;
    Line := CurrentLine;

    for i := Line downto 0 do
    begin
      Txt := string(GetLine(i)).Replace(alias+'.',' ');

      S0 := WordBefore(alias,Txt);
      if S0<>'' then Break;
      if FindOperator(Txt) then Break;
    end;

    if (S0.Length=0) and (Line<=LineCount-2) then
      for i := Line+1 to LineCount-1 do
      begin
        Txt := String(GetLine(i)).Replace(alias+'.',' ');

        S0 := WordBefore(alias,Txt);
        if S0<>'' then Break;
        if FindOperator(Txt) then Break;
      end;

    if S0.Length=0 then S0 := alias;
    FLogForm.DoGetFields(S0);
  end;
end;

procedure TdiaPlugin.SetCursor(const Mode: TCursorMode);
begin
  if Mode = crNormal then Sci_Send(SCI_SETCURSOR, WPARAM(SC_CURSORNORMAL),0);
  if Mode = crWait then Sci_Send(SCI_SETCURSOR, SC_CURSORWAIT, 0);
end;

procedure TdiaPlugin.ShowAutocompletionIndex(const TableName: string; Indx: TStringList);
var
  S: AnsiString;
begin
  Sci_Send(SCI_AUTOCCANCEL, 0, 0);
  Indx.Delimiter := ' ';
  S := Indx.DelimitedText;
  Sci_Send(SCI_AUTOCSHOW, 0, LPARAM(PAnsiChar(S)));
end;

procedure TdiaPlugin.ShowAutocompletionList(const lengthEntered: NativeInt;  Tables: AnsiString);
begin
  Sci_Send(SCI_AUTOCCANCEL, 0, 0);
  Sci_Send(SCI_AUTOCSETIGNORECASE, 1, 1);
  Sci_Send(SCI_AUTOCSHOW, WPARAM(lengthEntered), LPARAM(PAnsiChar(Tables)));
end;

procedure TdiaPlugin.DoNppnToolbarModification;
var
  tb: TToolbarIcons;
  tb8: TTbIconsDarkMode;
  NppVersion: Cardinal;
  i: Integer;
begin
  NppVersion := GetNppVersion;
  i := 0;
  if (HIWORD(NppVersion) >= 8) then
  begin
    tb8.ToolbarIcon := LoadImage(Hinstance, 'ITREEF', IMAGE_ICON, 0, 0, (LR_DEFAULTSIZE));
    tb8.ToolbarIconDarkMode := LoadImage(Hinstance, 'ITREEFDARK', IMAGE_ICON, 0, 0, (LR_DEFAULTSIZE));
    tb8.ToolbarBmp := LoadImage(Hinstance, 'TREE', IMAGE_BITMAP, 0, 0, (LR_DEFAULTSIZE));
    Npp_Send(NPPM_ADDTOOLBARICON_FORDARKMODE, WPARAM(self.CmdIdFromDlgId(i)), LPARAM(@tb8));

{$IFNDEF NPPCONNECTIONS}
    Inc(i);
    tb8.ToolbarIcon := LoadImage(Hinstance, 'ISERVER', IMAGE_ICON, 0, 0, (LR_DEFAULTSIZE));
    tb8.ToolbarIconDarkMode := LoadImage(Hinstance, 'ISERVERDARK', IMAGE_ICON, 0, 0, (LR_DEFAULTSIZE));
    tb8.ToolbarBmp := LoadImage(Hinstance, 'PROLIVKA', IMAGE_BITMAP, 0, 0, (LR_DEFAULTSIZE));
    Npp_Send(NPPM_ADDTOOLBARICON_FORDARKMODE, WPARAM(self.CmdIdFromDlgId(i)), LPARAM(@tb8));
{$ENDIF}

    Inc(i);
    tb8.ToolbarIcon := LoadImage(Hinstance, 'ISQL', IMAGE_ICON, 0, 0, (LR_DEFAULTSIZE));
    tb8.ToolbarIconDarkMode := LoadImage(Hinstance, 'ISQLDARK', IMAGE_ICON, 0, 0, (LR_DEFAULTSIZE));
    tb8.ToolbarBmp := LoadImage(Hinstance, 'SQL', IMAGE_BITMAP, 0, 0, (LR_DEFAULTSIZE));
    Npp_Send(NPPM_ADDTOOLBARICON_FORDARKMODE, WPARAM(self.CmdIdFromDlgId(i)), LPARAM(@tb8));

    Inc(i);
    tb8.ToolbarIcon := LoadImage(Hinstance, 'IPLAN', IMAGE_ICON, 0, 0, (LR_DEFAULTSIZE));
    tb8.ToolbarIconDarkMode := LoadImage(Hinstance, 'IPLANDARK', IMAGE_ICON, 0, 0, (LR_DEFAULTSIZE));
    tb8.ToolbarBmp := LoadImage(Hinstance, 'PLAN', IMAGE_BITMAP, 0, 0, (LR_DEFAULTSIZE));
    Npp_Send(NPPM_ADDTOOLBARICON_FORDARKMODE, WPARAM(self.CmdIdFromDlgId(i)), LPARAM(@tb8));
  end
  else
  begin
    tb.ToolbarIcon := 0;
    tb.ToolbarBmp := LoadImage(Hinstance, 'TREE', IMAGE_BITMAP, 0, 0, (LR_DEFAULTSIZE));
    Npp_Send(NPPM_ADDTOOLBARICON, WPARAM(self.CmdIdFromDlgId(i)), LPARAM(@tb));

{$IFNDEF NPPCONNECTIONS}
    Inc(i);
    tb.ToolbarIcon := 0;
    tb.ToolbarBmp := LoadImage(Hinstance, 'PROLIVKA', IMAGE_BITMAP, 0, 0, (LR_DEFAULTSIZE));
    Npp_Send(NPPM_ADDTOOLBARICON, WPARAM(self.CmdIdFromDlgId(i)), LPARAM(@tb));
{$ENDIF}
    Inc(i);
    tb.ToolbarIcon := 0;
    tb.ToolbarBmp := LoadImage(Hinstance, 'SQL', IMAGE_BITMAP, 0, 0, (LR_DEFAULTSIZE));
    Npp_Send(NPPM_ADDTOOLBARICON, WPARAM(self.CmdIdFromDlgId(i)), LPARAM(@tb));

    Inc(i);
    tb.ToolbarIcon := 0;
    tb.ToolbarBmp := LoadImage(Hinstance, 'PLAN', IMAGE_BITMAP, 0, 0, (LR_DEFAULTSIZE));
    Npp_Send(NPPM_ADDTOOLBARICON, WPARAM(self.CmdIdFromDlgId(i)), LPARAM(@tb));
  end;


end;

procedure TdiaPlugin.FuncExecHelpSQL(help: THelpType; S: string);
var N: integer;
begin
  if not Assigned(FLogForm) then
  begin
    FLogForm := TLogForm.Create(self, 0);
    TLogForm(FLogForm).DoConnect;
  end
  else
  begin
    N := Length(S);

    if (N > 1) and Assigned(FLogForm) then
      TLogForm(FLogForm).DoHelpSql(help,S);
  end;
end;

procedure TdiaPlugin.FuncExecSQL;
var S: string;
    N: integer;
begin
  S := SelectedText;
  N := Length(S);

  if N < 1 then
  begin
    S := GetText;
    N := Length(S);
  end;

  FuncExecThisSQL(S);
end;

procedure TdiaPlugin.FuncExecSQLPlan;
var S: string;
    N: integer;
begin
  if not Assigned(FLogForm) then FLogForm := TLogForm.Create(self, 0);
  S := SelectedText;
  N := Length(S);

  if N < 1 then
  begin
    S := GetText;
    N := Length(S);
  end;

  if (N > 1) and Assigned(FLogForm) then
  begin
    TLogForm(FLogForm).DoSql(cnstShowPlan + S);
  end;

end;

procedure TdiaPlugin.FuncExecSQLTables;
var
  Size: NativeInt;
  S: AnsiString;
  S1: string;
  i, iCurrentPos: Integer;
begin
  Size := Sci_Send(SCI_GETCURLINE, 0, 0);

  SetLength(S,Size);
  try
    iCurrentPos := Sci_Send(SCI_GETCURLINE, Size, LPARAM(PAnsiChar(S)));
    if not HasV5Apis then
      SetLength(S,Size-1);
    S1 := RemoveCarriageReturn(Copy(S,1,iCurrentPos));

    if S1 = '' then Exit;
    if S1.EndsWith(' ') then Exit;

    S1 := WholeWord(S1,MaxInt);
{$IFNDEF NPPCONNECTIONS}
    for i in cnstTracingDataBaseChar do
      if S1.StartsWith(Char(i)) then
      begin
        FLogForm.DoSqlGetTableList(S1);
        Exit;
      end;
{$ELSE}
    FLogForm.DoSqlGetTableList(S1);
{$ENDIF}

  finally
    SetLength(S,0);
  end;
end;

procedure TdiaPlugin.FuncExecThisSQL(S: string);
var N: integer;
begin
  if not Assigned(FLogForm) then
  begin
    FLogForm := TLogForm.Create(self, 0);
    TLogForm(FLogForm).DoConnect;
  end
  else
  begin
    N := Length(S);

    if (N > 1) and Assigned(FLogForm) then
    begin
      TLogForm(FLogForm).DoSql(S);
    end;
  end;
end;

procedure TdiaPlugin.FuncLog;
begin
  if not Assigned(FLogForm) then FLogForm := TLogForm.Create(self, 0);
  (FLogForm as TLogForm).Show;
end;

procedure TdiaPlugin.FuncSP_HELP;
var S: string;
    N: integer;
begin
  S := SelectedText;
  N := Length(S);

  if N = 0 then
  begin
    S := GetWord;
    N := Length(S);
  end;

  if N > 1 then
    FuncExecHelpSQL(spHelp,S);
end;

procedure TdiaPlugin.FuncSP_HELPINDEX;
var S: string;
    N: integer;
begin
  S := SelectedText;
  N := Length(S);

  if N = 0 then
  begin
    S := GetWord;
    N := Length(S);
  end;

  if N > 1 then
    FuncExecHelpSQL(spHelpindex,S);
end;

procedure TdiaPlugin.FuncSP_HELPTEXT;
var S: string;
    N: integer;
begin
  S := SelectedText;
  N := Length(S);

  if N = 0 then
  begin
    S := GetWord;
    N := Length(S);
  end;

  if N > 1 then
    FuncExecHelpSQL(spHelptext,S);
end;

procedure TdiaPlugin.DoNppnUpdateAutoSelection(P: PAnsiChar);
var
  S: AnsiString;
  pS: PAnsiChar;
  iLen: Integer;
begin
  S := P;
  if Length(S) = 0 then
  begin
    GetMem(pS,255);
    try
      iLen := Sci_Send(SCI_AUTOCGETCURRENTTEXT,0,LPARAM(pS));
      if iLen > 0 then
      begin
        SetLength(S,iLen);
        StrLCopy(PAnsiChar(S),pS,iLen);
      end;
    finally
      FreeMem(pS);
    end;
  end;

  if (Length(S)>0) and  (S[1]= 'X') then
    if (Pos('(',S) > 0) and (Pos(')',S) = Length(S)) then
    begin
      iLen := Pos('(',S);
      try
        S := Copy(S,1,iLen-1);
        Sci_Send(SCI_AUTOCCANCEL,0,0);
        iLen := CurrentPos;
        Sci_Send(SCI_INSERTTEXT, WPARAM(-1), LPARAM(PAnsiChar(S)));
        Sci_Send(SCI_GOTOPOS,iLen + Length(S)+1,0);
      finally
        SetLength(S,0);
      end;
    end;
end;

{$IFNDEF NPPCONNECTIONS}
procedure TdiaPlugin.FuncPrForm;
begin
  if not Assigned(FLogForm) then FLogForm := TLogForm.Create(self, 0);
  (FLogForm as TLogForm).DoPrForm;
end;

procedure TdiaPlugin.FuncInsertParam;
const NoDuplicates = True;
      CheckLeftSymbols = False;
var
  S0,SText: AnsiString;
  Strings,Strings1: TStringList;
  Range: TCharacterRange;
  i,j,iPos: Integer;
begin
  S0 := SelectedText;
  Strings := RemoveNoVarString(WholeWords(S0,NoDuplicates),CheckLeftSymbols);
  if Assigned(Strings) then
  begin
    try
      Range.cpMin := 0;
      Range.cpMax := CurrentPos;
      SText := RemoveComments(GetTextRange(Range));

      Strings1 := RemoveStringsAboveStartProc(SText);
      try
        Strings1.Text := RemoveComments(Strings1.Text);
        Strings1 := RemoveNoVarString(Strings1);

        for i := 0 to Strings.Count - 1 do
        begin
          S0 := format(cnstBSL_P_Empty,[Strings[i]]);
          for j := 0 to Strings1.Count-1 do
          begin
            iPos := Pos(Strings[i]+' ',Strings1[j]);
            if iPos = 1 then
            begin
              SText := WholeWord(Trim(Copy(Strings1[j],Length(Strings[i])+1,MaxInt)),1);
//              iPos := Pos(',',SText);
//              if iPos>0 then SText := Copy(SText,1,iPos-1);
//              iPos := Pos('=',SText);
//              if iPos>0 then SText := Copy(SText,1,iPos-1);
              S0 := format(cnstBSL_P,[Strings[i],SText,GetType(SText)]);
              break;
            end;
          end;
          Strings[i] := S0;
        end;

        FuncInsertText(Strings.Text);
      finally
        Strings1.Free;
      end;
    finally
      Strings.Free;
    end;
  end;
end;
{$ENDIF}

end.
