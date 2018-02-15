unit ThreadUnit;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.ActnList;


type

  TSimpleThread = class;

  TThreadExecObject = class
  private
    FName: string;
    FDescription: string;
    FErrMessage: string;
    FWinHandle: THandle;
    FMsg: UINT;
    FOnBeforeAction: TAction;
    FOnAfterAction: TAction;
    FUserObject: TPersistent;
    FUserTree: TPersistent;
    FUserTag: NativeInt;
    procedure SendNotification;
  protected
    FThread: TSimpleThread;
    procedure Execute; virtual; abstract;
  public
    constructor Create;

    procedure Start;
    procedure Finish;
    property UserTree: TPersistent read FUserTree write FUserTree;
    property UserObject: TPersistent read FUserObject write FUserObject;
    property UserTag: NativeInt read FUserTag write FUserTag;
    property ErrMessage: string read FErrMessage write FErrMessage;
    property Name: string read FName write FName;
    property WinHandle: THandle read FWinHandle write FWinHandle;
    property Description: string read FDescription write FDescription;
    property Msg: UINT read FMsg write FMsg;
    property OnBeforeAction: TAction read FOnBeforeAction write FOnBeforeAction;
    property OnAfterAction: TAction read FOnAfterAction write FOnAfterAction;
  end;
  TExecObject = TThreadExecObject;

  TSimpleThread = class(TThread)
  private
    { Private declarations }
    FExecObject: TThreadExecObject;
  protected
    procedure Execute; override;
  public
    { Public declarations }
    property ExecObject: TThreadExecObject read FExecObject write FExecObject;
    property Terminated;
  end;

implementation

uses Winapi.ActiveX, plugin;

{ TSimpleThread }

procedure TSimpleThread.Execute;
begin
  Priority := tpLower;
  CoInitialize(nil);
  try
    if not Terminated then
    try
      FExecObject.Execute;
    except
      on E: Exception do
        FExecObject.ErrMessage := E.Message;
    end;
  finally
    Terminate;
    FExecObject.SendNotification;
    CoUnInitialize;
  end;
end;

{ TThreadExecObject }

constructor TThreadExecObject.Create;
begin
  inherited;
  FMsg := WM_USER_MESSAGE_FROM_THREAD;
end;

procedure TThreadExecObject.Finish;
begin
  if Assigned(FOnAfterAction) then
  begin
    FOnAfterAction.Tag := NativeInt(Self);
    FOnAfterAction.Execute;
  end;
end;

procedure TThreadExecObject.SendNotification;
begin
  SendMessage(FWinHandle,FMsg,0,LPARAM(Self));
end;

procedure TThreadExecObject.Start;
begin
  if Assigned(FOnBeforeAction) then
  begin
    FOnBeforeAction.Tag := NativeInt(Self);
    FOnBeforeAction.Execute;
  end;

  FThread := TSimpleThread.Create(True);
  FThread.FreeOnTerminate := True;
  with TSimpleThread(FThread) do
  begin
    ExecObject := Self;
    FThread.Start;
  end;
end;

end.
