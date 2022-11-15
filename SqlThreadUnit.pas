unit SqlThreadUnit;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.StrUtils,
  System.Win.ComObj, Data.DB, Data.Win.ADODB, WinApi.ADOInt, Vcl.Dialogs,
  Vcl.ComCtrls, ConstUnit, Variants, ThreadUnit, StringGridsUnit, StringGridExUnit,
  ExtScrollingWinControlUnit;

type
  TSqlThreadObject = class(TThreadExecObject)
  private
    FSql: TStringList;
    FConnectionString: string;
    FCacheSize: integer;
    FCommandTimeOut: integer;
    FBdType: TBdType;
    procedure SetConnectionString(const Value: string);
    procedure SetCacheSize(const Value: integer);
    procedure SetCommandTimeOut(const Value: integer);
    function GetLogin: string;

    const cnstUserID = 'User ID=';

  public
    constructor Create;
    destructor Destroy; override;
    property SQL: TStringList read FSql;
    property BdType: TBdType read FBdType write FBdType;
    property Login: string read GetLogin;
    property CacheSize: integer read FCacheSize write SetCacheSize;
    property CommandTimeOut: integer read FCommandTimeOut write SetCommandTimeOut;
    property ConnectionString: string read FConnectionString write SetConnectionString;
  end;

  TSqlQueryObject = class(TSqlThreadObject)
  private
    FQuery: TAdoQuery;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
    property Query: TAdoQuery read FQuery;
  end;

  TSqlExecutorObject = class(TSqlThreadObject)
  private
    FGrids: TStringGrids;
    FScrollBox: TExScrollBox;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
    property Grids: TStringGrids read FGrids;
    property ScrollBox: TExScrollBox read FScrollBox write FScrollBox;
  end;

  TSqlSilenceObject = class(TSqlThreadObject)
  private
    FAnswer: string;
  protected
    procedure Execute; override;
  public
    property Answer: string read FAnswer write FAnswer;
  end;

  TSqlIndexObject = class(TSqlThreadObject)
  private
    FIndexes: TStringList;
    const cnstIndexTemplate = '%s(%s)';
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
    property Indexes: TStringList read FIndexes;
  end;

  TTableListObject = class(TSqlThreadObject)
  private
    FTableList: TStringList;
    FTreeNode: TTreeNode;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
    property TableList: TStringList read FTableList;
    property Node: TTreeNode read FTreeNode write FTreeNode;
  end;

  TFieldListObject = class(TSqlThreadObject)
  private
    FFieldList: TStringList;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
    property FieldList: TStringList read FFieldList;
  end;

implementation

uses
  {$IFNDEF NPPCONNECTIONS}diaConstUnit,{$ENDIF}
  System.Math;

procedure MoveStrings(StringSource,StringsTarget: TStringList);
var S0: string;
    i : integer;
begin
  StringsTarget.Clear;
  while StringSource.Count > 0 do
  begin
    for i := 0 to StringSource.Count-1 do
    begin
      S0 := Trim(StringSource[i]);
      StringSource[i] := '';
      if LowerCase(S0) = cnstGo then Break;
      StringsTarget.Add(S0);
    end;
    while (StringSource.Count > 0) and (StringSource[0] = '') do StringSource.Delete(0);
    if StringsTarget.Count > 0 then Exit;
  end;
end;

{ TSqlThreadObject }

constructor TSqlThreadObject.Create;
begin
  inherited;
  FSql := TStringList.Create;
  FCacheSize := 20;
  FCommandTimeOut := 0;
end;

destructor TSqlThreadObject.Destroy;
begin
  FreeAndNil(FSql);
  inherited;
end;

function TSqlThreadObject.GetLogin: string;
var
  i,j: Integer;
begin
  Result := '';
  i := FConnectionString.IndexOf(cnstUserID);
  if i>=0 then
  begin
    j := FConnectionString.IndexOf(';',i+1);
    Result := FConnectionString.Substring(i+cnstUserID.Length,j-i-cnstUserID.Length).Trim;
  end;
end;

procedure TSqlThreadObject.SetCacheSize(const Value: integer);
begin
  FCacheSize := Value;
end;

procedure TSqlThreadObject.SetCommandTimeOut(const Value: integer);
begin
  FCommandTimeOut := Value;
end;

procedure TSqlThreadObject.SetConnectionString(const Value: string);
begin
  FConnectionString := Value;
end;

{ TSqlQueryObject }

constructor TSqlQueryObject.Create;
begin
  inherited;
  FQuery := nil;
end;

destructor TSqlQueryObject.Destroy;
begin
  if Assigned(FQuery) then FQuery.Free;
  inherited;
end;

procedure TSqlQueryObject.Execute;
begin
  FQuery := TADOQuery.Create(nil);
  with FQuery do
  begin
    AutoCalcFields := False;
    ExecuteOptions := [];
    CacheSize := FCacheSize;
    CommandTimeout := FCommandTimeout;
    ConnectionString := FConnectionString;
  end;
  if Length(FQuery.ConnectionString)>0 then
  begin
    if Sql.Count > 0 then
    begin
      FQuery.SQL.Clear;
      FQuery.SQL.AddStrings(Self.Sql);
      FQuery.Prepared := True;
      if not FThread.Terminated then FQuery.Open;
    end;
  end;
end;

{ TSqlExecutorObject }

constructor TSqlExecutorObject.Create;
begin
  inherited;
  FGrids := nil;
end;

destructor TSqlExecutorObject.Destroy;
begin
  if Assigned(FGrids) then FGrids.Free;
  inherited;
end;

procedure TSqlExecutorObject.Execute;

  procedure PostGridMessage(const S: string);
  var
    Grid  : TStringGridEx;
  begin
    Grid := FGrids.Add;
    Grid.RowCount := 1;
    Grid.ColCount := 1;
    Grid.ColWidths[0] := Length(S);
    Grid.Cells[0,0] := S;
  end;

  function GetDots(const S: string): string;
  begin
    if length(S) > 150 then
      Result := '...'
    else
      Result := '';
  end;

var
  cmd  : _Command;
  Conn : _Connection;
  rs   : _RecordSet;
  RA   : OleVariant;
  n,i,j: Integer;
  Grid : TStringGridEx;
  S    : string;
  V    : OleVariant;
  PlanOnly: boolean;
  Strings: TStringList;
begin
  Conn := CreateComObject(CLASS_Connection) as _Connection;
  Conn.ConnectionString := FConnectionString;
  Conn.Open(Conn.ConnectionString,'','',Integer(adConnectUnspecified));
  try
    PlanOnly := (Pos(cnstShowPlan,Sql[0])=1);

    {$IFNDEF NPPCONNECTIONS}
    if FBdType in [bdMSSQL,bdSybase] then ConvertSqlText(FBdType=bdSybase,Sql);
    {$ENDIF}

    FGrids        := TStringGrids.Create;
    FGrids.Name   := Name;
    FGrids.Description := Sql.Text;
    FGrids.ConnectionString := ConnectionString;

    if PlanOnly then
    begin
      if FBdType in [bdODBC] then
      begin
        PostGridMessage(cnstSqlNoPossible);
        Exit;
      end;

      Sql[0] := Copy(Sql[0],Length(cnstShowPlan)+1,MaxInt);

      if FBdType in [bdMSSQL,bdSybase] then
      begin
        cmd := CreateComObject(CLASS_Command) as _Command;
        try
          cmd.CommandType := adCmdUnknown;
          cmd.Set_ActiveConnection(Conn);

          if FBdType=bdSybase then
            cmd.CommandText := cnstShowPlan_ON
          else
            cmd.CommandText := cnstShowPlanXML_ON;

          cmd.Execute(RA,EmptyParam,Integer(adCmdUnknown));
        finally
          cmd.Set_ActiveConnection(nil);
          cmd  := nil;
        end;
      end
      else
      if FBdType in [bdPostgreSQL] then
        Sql[0] := cnstShowPlan_PostgreSQL + Sql[0];
    end;

    Strings := TStringList.Create;
    try
      MoveStrings(Sql,Strings);

      while Strings.Count > 0 do
      begin
        cmd := CreateComObject(CLASS_Command) as _Command;
        cmd.CommandType := adCmdUnknown;
        cmd.Set_ActiveConnection(Conn);
        cmd.CommandText := Strings.Text;
        cmd.CommandTimeout := FCommandTimeout;
        try
          try
            rs := cmd.Execute(RA,EmptyParam,Integer(adCmdUnknown));
          except
            on E: Exception do
            begin
              PostGridMessage(E.Message);
              Exit;
            end;
          end;

          while not FThread.Terminated do
          begin
            if rs.State = adStateOpen then
            begin

              Grid := FGrids.Add;
              Grid.ColCount := rs.Fields.Count;
              Grid.RowCount := 1;
              for i := 0 to rs.Fields.Count -1 do
                Grid.Cells[i,0] := rs.Fields[i].Name;

              if not (rs.EOF and rs.BOF) then
              begin
                while not rs.EOF do
                begin
                  if FThread.Terminated then Exit;

                  Grid.RowCount := Grid.RowCount + 1;

                  for i := 0 to rs.Fields.Count -1 do
                  begin
                    S := '<NULL>';
                    V := rs.Fields[i].Value;
                    if not VarIsNull(V) then
                      case rs.Fields[i].Type_ of
                        7,133,134,135: S := FormatDateTime('dd.mm.yyyy hh:nn:ss.zzz',VarToDateTime(V))
                      else
                        S := VarToStr(V);
                      end;

                    if PlanOnly and (FBdType=bdMSSQL) then
                    begin
                      Grid.Hint := S;
                      S := Copy(Strings.Text,1,150) + GetDots(Strings.Text);
                      //S := Copy(S,1,150) + GetDots(S);
                    end;

                    Grid.ColWidths[i] := Max(Grid.ColWidths[i],Length(S));
                    Grid.Cells[i,Grid.RowCount-1] := S;

                  end;

                  rs.MoveNext;
                end;
              end;

            end;

            if Conn.Errors.Count > 0 then
            begin
              for n:=Conn.Errors.Count-1 downto 0 do
                if Trim(Conn.Errors.Item[n].Description) <> '' then
                begin
                  if FThread.Terminated then Exit;

                  S := Trim(Conn.Errors.Item[n].Description);

                  if PlanOnly and (FBdType=bdSybase) then
                  begin
                    j := Pos(cnstAseOleDB,S);
                    if j > 0 then
                    S := Copy(S,j + Length(cnstAseOleDB), MaxInt);
                  end;

                  if S <> '' then
                  begin
                    Grid := FGrids.Add;
                    Grid.RowCount := 1;
                    Grid.ColCount := 1;
                    Grid.ColWidths[0] := Length(S);
                    Grid.Cells[0,0] := S;
                  end;
                end;
            end;

            rs := rs.NextRecordset(RA);
            if (rs=nil) then break;
          end;
        finally
          cmd.Set_ActiveConnection(nil);
          cmd  := nil;
          rs   := nil;
        end;

        MoveStrings(Sql,Strings);
      end;

      if FGrids.Count = 0 then  //Empty result
      begin
        if FThread.Terminated then Exit;

        S := cnstSqlNoResults;

        Grid := FGrids.Add;
        Grid.RowCount := 1;
        Grid.ColCount := 1;
        Grid.ColWidths[0] := Length(S);
        Grid.Cells[0,0] := S;
      end;

      if FThread.Terminated then
      begin
        FGrids.Clear;
        Exit;
      end
    finally
      Strings.Free;
    end;

    if PlanOnly and (FBdType in [bdMSSQL,bdSybase]) then
    begin
      cmd := CreateComObject(CLASS_Command) as _Command;
      try
        cmd.CommandType := adCmdUnknown;
        cmd.Set_ActiveConnection(Conn);

        if FBdType=bdSybase then
          cmd.CommandText := cnstShowPlan_OFF
        else
          cmd.CommandText := cnstShowPlanXML_OFF;

        cmd.Execute(RA,EmptyParam,Integer(adCmdUnknown));
      finally
        cmd.Set_ActiveConnection(nil);
        cmd  := nil;
      end;
    end;
  finally
    Conn.Close;
    Conn := nil;
  end;
end;

{ TSqlIndexObject }

constructor TSqlIndexObject.Create;
begin
  inherited;
  FIndexes := nil;
end;

destructor TSqlIndexObject.Destroy;
begin
  if Assigned(FIndexes) then FIndexes.Free;
  inherited;
end;

procedure TSqlIndexObject.Execute;
var
  cmd  : _Command;
  Conn : _Connection;
  rs   : _RecordSet;
  RA   : OleVariant;
  i    : Integer;
  S,Sk : string;
  V    : OleVariant;
begin
  Conn := CreateComObject(CLASS_Connection) as _Connection;
  try
    Conn.ConnectionString := FConnectionString;
    Conn.Open(Conn.ConnectionString,'','',Integer(adConnectUnspecified));
    cmd := CreateComObject(CLASS_Command) as _Command;
    try
      cmd.CommandType := adCmdUnknown;
      cmd.Set_ActiveConnection(Conn);
      cmd.CommandText := 'sp_helpindex ' + SQL.Text;

      try
        rs := cmd.Execute(RA,EmptyParam,Integer(adCmdUnknown));
      except
        on E: Exception do
        begin
          ErrMessage := E.Message;
          Exit;
        end;
      end;

      FIndexes := TStringList.Create;
      if not FThread.Terminated then
        if rs.State = adStateOpen then
          if not (rs.EOF and rs.BOF) then
            while not rs.EOF do
            begin
              if FThread.Terminated then Exit;

              for i := 0 to rs.Fields.Count -1 do
              begin
                if rs.Fields[i].Name = 'index_name' then
                begin
                  V := rs.Fields[i].Value;
                  S := VarToStr(V);
                end
                else
                if rs.Fields[i].Name = 'index_keys' then
                begin
                  V := rs.Fields[i].Value;
                  Sk := VarToStr(V);
                end;
              end;
              FIndexes.Add(Format(cnstIndexTemplate,[StringReplace(S,' ','',[rfReplaceAll]),StringReplace(Sk,' ','',[rfReplaceAll])]));
              rs.MoveNext;
            end;
    finally
      cmd.Set_ActiveConnection(nil);
      cmd  := nil;
    end;
  finally
    Conn.Close;
    Conn := nil;
  end;
end;

{ TSqlSilenceObject }

procedure TSqlSilenceObject.Execute;
var
  cmd  : _Command;
  Conn : _Connection;
  rs   : _RecordSet;
  RA   : OleVariant;
  n,i,j: Integer;
  Grid : TStringGridEx;
  S    : string;
  V    : OleVariant;
  Strings: TStringList;
begin
  Conn := CreateComObject(CLASS_Connection) as _Connection;
  Conn.ConnectionString := FConnectionString;
  Conn.Open(Conn.ConnectionString,'','',Integer(adConnectUnspecified));
  try
    {$IFNDEF NPPCONNECTIONS}
    if FBdType in [bdMSSQL,bdSybase] then ConvertSqlText(FBdType=bdSybase,Sql);
    {$ENDIF}

    Strings := TStringList.Create;
    try
      MoveStrings(Sql,Strings);

      while Strings.Count > 0 do
      begin
        cmd := CreateComObject(CLASS_Command) as _Command;
        cmd.CommandType := adCmdUnknown;
        cmd.Set_ActiveConnection(Conn);
        cmd.CommandText := Strings.Text;
        cmd.CommandTimeout := FCommandTimeout;
        try
          try
            rs := cmd.Execute(RA,EmptyParam,Integer(adCmdUnknown));
          except
            on E: Exception do
            begin
              Self.ErrMessage := E.Message;
              Exit;
            end;
          end;

          FAnswer := '';
          while not FThread.Terminated do
          begin
            if rs.State = adStateOpen then
            begin
              if not (rs.EOF and rs.BOF) then
              begin
                if FThread.Terminated then Exit;
                if rs.Fields.Count > 0 then
                begin
                  if FAnswer = '' then
                    FAnswer := rs.Fields[0].Value
                  else
                    FAnswer := FAnswer + sLineBreak + rs.Fields[0].Value;
                end
              end;
            end;

            if Conn.Errors.Count > 0 then
            begin
              for n:=Conn.Errors.Count-1 downto 0 do
                if Trim(Conn.Errors.Item[n].Description) <> '' then
                begin
                  if FThread.Terminated then Exit;

                  S := Trim(Conn.Errors.Item[n].Description);

                  if S <> '' then
                  begin
                    if Self.ErrMessage = '' then
                      Self.ErrMessage := S
                    else
                      Self.ErrMessage := Self.ErrMessage + sLineBreak + S;
                  end;
                end;
            end;

            rs := rs.NextRecordset(RA);
            if (rs=nil) then break;
          end;
        finally
          cmd.Set_ActiveConnection(nil);
          cmd  := nil;
          rs   := nil;
        end;

        MoveStrings(Sql,Strings);
      end;

      if FThread.Terminated then Exit;
    finally
      Strings.Free;
    end;
  finally
    Conn.Close;
    Conn := nil;
  end;
end;

{ TTableListObject }

constructor TTableListObject.Create;
begin
  inherited;
  FTableList := nil;
end;

destructor TTableListObject.Destroy;
begin
  if Assigned(FTableList) then FTableList.Free;
  inherited;
end;

procedure TTableListObject.Execute;
var
  cmd  : _Command;
  Conn : _Connection;
  rs   : _RecordSet;
  RA   : OleVariant;
  V    : OleVariant;
begin
  Conn := CreateComObject(CLASS_Connection) as _Connection;
  try
    Conn.ConnectionString := FConnectionString;
    Conn.CommandTimeout := 600;
    Conn.Open(Conn.ConnectionString,'','',Integer(adConnectUnspecified));
    cmd := CreateComObject(CLASS_Command) as _Command;
    try
      cmd.CommandType := adCmdUnknown;
      cmd.Set_ActiveConnection(Conn);
      cmd.CommandText := cnstGetTablesArray[BdType];
      cmd.CommandTimeout := 600;

      try
        rs := cmd.Execute(RA,EmptyParam,Integer(adCmdUnknown));
      except
        on E: Exception do
        begin
          ErrMessage := E.Message;
          Exit;
        end;
      end;

      FTableList := TStringList.Create;
      if not FThread.Terminated then
        if (rs.State = adStateOpen) and (rs.Fields.Count>0) then
          if not (rs.EOF and rs.BOF) then
            while not rs.EOF do
            begin
              if FThread.Terminated then Exit;
              V := rs.Fields[0].Value;
              FTableList.Add(Trim(VarToStr(V)));
              rs.MoveNext;
            end;
    finally
      cmd.Set_ActiveConnection(nil);
      cmd  := nil;
    end;
  finally
    Conn.Close;
    Conn := nil;
  end;
end;

{ TFieldListObject }

constructor TFieldListObject.Create;
begin
  inherited;
  FFieldList := nil;
end;

destructor TFieldListObject.Destroy;
begin
  if Assigned(FFieldList) then FFieldList.Free;
  inherited;
end;

procedure TFieldListObject.Execute;
var
  cmd  : _Command;
  Conn : _Connection;
  rs   : _RecordSet;
  RA   : OleVariant;
  i    : Integer;
begin
  Conn := CreateComObject(CLASS_Connection) as _Connection;
  try
    Conn.ConnectionString := FConnectionString;
    Conn.Open(Conn.ConnectionString,'','',Integer(adConnectUnspecified));
    cmd := CreateComObject(CLASS_Command) as _Command;
    try
      cmd.CommandType := adCmdUnknown;
      cmd.Set_ActiveConnection(Conn);
      cmd.CommandText := Format(cnstGetFieldsSQL,[SQL[0]]);

      try
        rs := cmd.Execute(RA,EmptyParam,Integer(adCmdUnknown));
      except
        on E: Exception do
        begin
          ErrMessage := E.Message;
          Exit;
        end;
      end;

      FFieldList := TStringList.Create;
      FFieldList.CaseSensitive := False;
      if not FThread.Terminated then
        if (rs.State = adStateOpen) then
          for i := 0 to rs.Fields.Count-1 do
              FFieldList.Add(rs.Fields[i].Name);
      FFieldList.Sort;
    finally
      cmd.Set_ActiveConnection(nil);
      cmd  := nil;
    end;
  finally
    Conn.Close;
    Conn := nil;
  end;
end;

end.
