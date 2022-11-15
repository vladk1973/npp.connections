unit ConstUnit;

interface

uses Winapi.Windows, Winapi.Messages, System.StrUtils,
     Vcl.Controls, System.Classes, System.SysUtils,
     System.Math;

type
  TCommand = string;
  TPathName = string;
  TFileName = string;

  TModalResultArray = array[False..True] of TModalResult;
  TGarbageArray   = array[0..9] of string;
  TBeginProcArray = array[0..4] of string;
  TBeginAlignArray = array[0..9] of string;
  TOperatorsArray = array[0..3] of string;

  TShowMode = (shSql,shPr,shCI);
  TCursorMode = (crNormal,crWait);

  TBdType = (bdMSSQL, bdSybase, bdPostgreSQL, bdODBC);
  TBdTypeStringArray = array [TBdType] of string;

  //TItemType - the order of the types must match TBdType
  TItemType = (itServerMS,itServerSYB,itServerPostgreSQL,itODBC,itBase,itBaseRTI,itLogin);

  THelpType = (spHelp, spHelpindex, spHelpText);
  THelpArray = array[TBdType,THelpType] of string;

  TStringProcedure = procedure(const SqlText: string) of object;

const

  WM_USER_MESSAGE_FROM_THREAD =  WM_USER + 1;
  cnstModalResultArray: TModalResultArray = (mrCancel,mrOk);

  constDBList = 'SELECT name FROM master..sysdatabases ORDER BY name';
  constPostgreDBList = 'SELECT datname FROM pg_database;';

{$IFNDEF NPPCONNECTIONS}
  cnstDllKey = 'Software\dia2notepad';
  constDSBDCaptionArray: TBdTypeStringArray = ('Сервер','Сервер','Сервер','Источник');
  cnstErroCaption = 'Ошибка';
  cnstNoBaseSelected = 'Чтобы выполнить SQL запрос, необходимо выбрать сервер и базу!';
  cnstConfirm = 'Подтверждение';
  cnstSqlNoPossible = 'Выполнение команды невозможно';
  cnstSqlNoResults = 'Команда выполнена';
  constLoginBDCaption  = 'Подключение к ';
  cnstSqlExec = 'Результаты: %s\%s (%s)';
  cnstOpenPlanMessage = 'Открыть план запроса?';
{$ELSE}
  cnstDllKey = 'Software\nppconnections';
  constDSBDCaptionArray: TBdTypeStringArray = ('Server','Server','Server','Source');
  cnstErroCaption = 'Error';
  cnstNoBaseSelected = 'Please select Server and Base before before execution!';
  cnstConfirm = 'Confirm';
  cnstSqlNoPossible = 'Command execution is not possible';
  cnstSqlNoResults = 'The command is executed';
  constLoginBDCaption  = 'Connect to ';
  cnstSqlExec = 'Results: %s\%s (%s)';
  cnstOpenPlanMessage = 'Open a query plan?';
{$ENDIF}

  cnstNumbers = '0123456789';
  cnstAlphabet = '0123456789abcdefghijklmnopqrstuvwxyz_()';
  cnstAlphabetStartWord = 'abcdefghijklmnopqrstuvwxyz';

  cnstGarbageArray: TGarbageArray =(
    '--',
    '/*',
    '(',
    ')',
    '\',
    ' ',
    #09,
    #13#10,
    #13,
    #10
    );

  cnstBeginProcArray: TBeginProcArray =(
    'create proc ',
    'create procedure ',
    'dcl_proc_begin(',
    'api_create_proc(',
    'create or replace '
    {'create trigger',
    'create view ',
    'create table ',
    '#include ',
    '#define '}
    );

  cnstAlignStartWords: TBeginAlignArray = (
    'declare',
    'execute',
    'exec'   ,
    '@',
    'select',
    'if',
    'begin',
    'insert',
    'delete',
    'while'
    );

  cnstShowPlanXML_ON = 'SET SHOWPLAN_XML ON';
  cnstShowPlanXML_OFF = 'SET SHOWPLAN_XML OFF';
  cnstShowPlan_ON = 'SET SHOWPLAN ON';
  cnstShowPlan_OFF = 'SET SHOWPLAN OFF';

  cnstShowSpHelp = 'SP_HELP %s';
  cnstShowSpHelpIndex = 'SP_HELPINDEX %s';
  cnstShowSpHelpText = 'SP_HELPTEXT %s';


  cnstShowPlan_PostgreSQL = 'EXPLAIN ';
  cnstShowSpHelp_PostgreSQL = 'SELECT ''%s'' AS name;'+sLineBreak+
                              'SELECT * FROM information_schema.columns WHERE table_name = ''%0:s'';'+sLineBreak+
                              'SELECT * FROM pg_indexes WHERE tablename = ''%0:s'';';
  cnstShowSpHelpIndex_PostgreSQL = 'SELECT * FROM pg_indexes WHERE tablename = ''%s'';';
  cnstShowSpHelpText_PostgreSQL = 'SELECT'+sLineBreak+
                                    'pg_get_functiondef(('+sLineBreak+
                                                        'SELECT'+sLineBreak+
                                                        'oid FROM pg_proc'+sLineBreak+
                                                        'WHERE'+sLineBreak+
                                                        'proname = ''%s''));';

  cnstHelpArray: THelpArray = ((cnstShowSpHelp,cnstShowSpHelpIndex,cnstShowSpHelpText),
                               (cnstShowSpHelp,cnstShowSpHelpIndex,cnstShowSpHelpText),
                               (cnstShowSpHelp_PostgreSQL,cnstShowSpHelpIndex_PostgreSQL,cnstShowSpHelpText_PostgreSQL),
                               ('%s','%s','%s')
                              );

{$IFNDEF NPPCONNECTIONS}
  cnstGetTables_MsSql = 'SELECT name FROM sys.tables WHERE name LIKE ''[t,p]%'' ORDER BY name';
  cnstGetTables_Sybase = 'SELECT name FROM sysobjects WHERE type = ''U'' AND name LIKE ''[t,p]%'' ORDER BY name';
  cnstGetTables_PostgreSQL = 'SELECT tablename FROM pg_catalog.pg_tables WHERE tablename SIMILAR TO ''[p|t]%'' ORDER BY tablename;';
{$ELSE}
  cnstGetTables_MsSql = 'SELECT name FROM sys.tables ORDER BY name';
  cnstGetTables_Sybase = 'SELECT name FROM sysobjects WHERE type = ''U'' ORDER BY name';
  cnstGetTables_PostgreSQL = 'SELECT tablename FROM pg_catalog.pg_tables ORDER BY tablename;';
{$ENDIF}

  cnstGetTablesArray: TBdTypeStringArray = (cnstGetTables_MsSql,cnstGetTables_Sybase,cnstGetTables_PostgreSQL,'');

  cnstGetFieldsSQL = 'select * from %s where 1=0';

  cnstAseOleDB = '[ASEOLEDB]';
  cnstShowPlan = 'PLAN:';
  cnstShowIndx = 'INDX:';

  cnstSqlplanExt = '.sqlplan';
  cnstGo = 'go';

  cnstT1 = 'join ';
  cnstT2 = 'from ';

  cnstOperator1 = 'select ';
  cnstOperator2 = 'insert ';
  cnstOperator3 = 'update ';
  cnstOperator4 = 'delete ';
  cnstOperators: TOperatorsArray = (cnstOperator1,cnstOperator2,cnstOperator3,cnstOperator4);


  cnstTracingChar = 40;
  cnstTracingFieldChar = 46;

  constConnectionMSSQL =  'Provider=SQLOLEDB.1;Password=%s;Persist Security Info=True;User ID=%s;%sData Source=%s';
  constConnectionSybase = 'Provider=ASEOLEDB.1;Password=%s;Persist Security Info=True;User ID=%s;Data Source=%s:%s;%sExtended Properties="LANGUAGE=us_english";Connect Timeout=3';
  constConnectionPostgre = 'Provider=MSDASQL.1;Password=%s;Persist Security Info=True;User ID=%s;Extended Properties="DRIVER={PostgreSQL Unicode};SERVER=%s;PORT=%s;%s"';
  constConnectionODBC = 'Provider=MSDASQL.1;Persist Security Info=False;Data Source=%s';
  constConnectionStringArray: TBdTypeStringArray = (constConnectionMSSQL,
                                                    constConnectionSybase,
                                                    constConnectionPostgre,
                                                    constConnectionODBC);

  constLoginBDCaptionArray: TBdTypeStringArray = ('MSSQL','Sybase','PostgreSQL','ODBC');
  constLoginBDArray: TBdTypeStringArray = ('sa','sa','postgres','admin');

function RemoveGarbage(const S: string): string;
function RemoveCarriageReturn(const S: string): string;
function ItIsAWord(Txt: AnsiString): boolean;
function WholeWords(Txt: AnsiString; const NoDuplacates: boolean = False): TStringList;
function WholeWord(const Txt: AnsiString; const WordIndex: Integer): AnsiString;
function WordBefore(const Searched,Txt: AnsiString): AnsiString;
function RemoveComments(S: string): string;
function FindOperator(const S: string): boolean;
function TempPath: string;

implementation

function FindOperator(const S: string): boolean;
var
  S0: string;
  iPos: integer;
begin
  iPos := -1;
  for S0 in cnstOperators do
  begin
    iPos := Max(iPos,S.IndexOf(' ' + S0));
    iPos := Max(iPos,S.IndexOf(sLineBreak + S0));
    iPos := Max(iPos,S.IndexOf('(' + S0));
    if (iPos<0) and ((S.StartsWith(S0)) or (S.Trim = S0.Trim)) then
    begin
      iPos := 0;
      Break;
    end;
  end;
  Result := iPos>=0;
end;

function RemoveGarbage(const S: string): string;
var
  j: Longint;
  S0: string;
begin
  Result := Trim(S);
  for S0 in cnstGarbageArray do
  begin
    j := Result.IndexOf(S0);
    if j >= 0 then Result := Copy(Result,1,j);
  end;
end;

function RemoveCarriageReturn(const S: string): string;
begin
  Result := StringReplace(S,#13#10,'',[rfReplaceAll]);
end;

function ItIsAWord(Txt: AnsiString): boolean;
var i: Longint;
    S0,S: string;
begin
  S := Trim(string(Txt));
  S0 := '';
  for i := 1 to Length(S) do
  begin
    if i = 1 then
    begin
      if pos(LowerCase(S[i]),cnstAlphabetStartWord) > 0 then
        S0 := S0 + S[i];
    end
    else
      if pos(LowerCase(S[i]),cnstAlphabet) > 0 then
        S0 := S0 + S[i];
  end;
  Result := S = S0;
end;

function WholeWords(Txt: AnsiString; const NoDuplacates: boolean = False): TStringList;
var i: Longint;
    S0,S: string;
begin
  Result := nil;
  S := Trim(string(Txt));
  S0 := '';
  for i := 1 to Length(S) do
  begin
    if pos(LowerCase(S[i]),'@'+cnstAlphabet) > 0 then
      S0 := S0 + S[i]
    else
    begin
      if Length(S0)>0 then
      begin
        if not Assigned(Result) then
        begin
          Result := TStringList.Create;
          if NoDuplacates then Result.Duplicates := dupIgnore;
        end;
        Result.Add(S0);
      end;
      S0 := '';
    end;
  end;

  if Length(S0)>0 then
  begin
    if not Assigned(Result) then Result := TStringList.Create;
    Result.Add(S0);
  end;
end;

function WholeWord(const Txt: AnsiString; const WordIndex: Integer): AnsiString;
var
  Strings: TStringList;
begin
  Result := '';
  Strings := WholeWords(Txt);
  if Assigned(Strings) then
  begin
    try
      if WordIndex <= Strings.Count then
        Result := Strings[WordIndex-1]
      else
        if (Strings.Count>0) then
          Result := Strings[Strings.Count-1]
    finally
      FreeAndNil(Strings);
    end;
  end;
end;

function WordBefore(const Searched,Txt: AnsiString): AnsiString;
var
  Strings: TStringList;
  i: Integer;
begin
  Result := '';
  Strings := WholeWords(Txt);
  if Assigned(Strings) then
  begin
    try
      for i := Strings.Count-1 downto 0 do
      begin
        if Strings[i] = string(Searched) then
        begin
          if i>0 then Result := Strings[i-1];
          break;
        end;
      end;
    finally
      FreeAndNil(Strings);
    end;
  end;
end;

function RemoveComments(S: string): string;
var
  i,ipos, ipos1: Integer;
  Strings: TStringList;
begin
  S := StringReplace(S,#9,' ',[rfReplaceAll]);
  while true do
  begin
    ipos := pos('/*',S);
    ipos1:= pos('*/',S);

    if (ipos = 0) and (ipos1 = 0) then break;
    if (ipos = 0) and (ipos1 > 0) then S := Copy(S,ipos1+2,MaxInt);
    if (ipos > 0) and (ipos1 = 0) then S := Copy(S,1,ipos-1);
    if (ipos > 0) and (ipos1 > 0) then
    begin
      if ipos > ipos1 then S := Copy(S,ipos1+2,MaxInt);
      if ipos < ipos1 then S := Copy(S,1,ipos-1) + #13#10 + Copy(S,ipos1+2,MaxInt);
    end;
  end;

  Strings := TStringList.Create;
  try
    Strings.Text := S;
    for i := Strings.Count - 1 downto 0 do
    begin
      S := Strings[i];
      ipos := pos('--',S);
      if ipos > 0 then S := Copy(S,1,ipos-1);
      S := Trim(S);
      if S = '' then
        Strings.Delete(i)
      else
        Strings[i] := S;
    end;
    S := Strings.Text;
  finally
    Strings.Free;
  end;

  Result := S;
end;

function TempPath: string;
var
	i: integer;
begin
  SetLength(Result, MAX_PATH);
	i := GetTempPath(Length(Result), PChar(Result));
	SetLength(Result, i);
  IncludeTrailingPathDelimiter(Result);
end;

end.
