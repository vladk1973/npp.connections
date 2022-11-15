procedure DLLEntryPoint(dwReason: Integer);
begin
  case dwReason of
    DLL_PROCESS_ATTACH:
    begin
      // create the main object
      Easy.diaplugin.Npp := TdiaPlugin.Create;
    end;
    DLL_PROCESS_DETACH:
    begin
      if (Assigned(Easy.diaplugin.Npp)) then Easy.diaplugin.Npp.Destroy;
    end;
  end;
end;

procedure setInfo(NppData: TNppData); cdecl; export;
begin
  Easy.diaplugin.Npp.SetInfo(NppData);
end;

function getName: nppPchar; cdecl; export;
begin
  Result := Easy.diaplugin.Npp.GetName;
end;

function getFuncsArray(var nFuncs:integer):Pointer;cdecl; export;
begin
  Result := Easy.diaplugin.Npp.GetFuncsArray(nFuncs);
end;

procedure beNotified(sn: PSCNotification); cdecl; export;
begin
  Easy.diaplugin.Npp.BeNotified(sn);
end;

function messageProc(msg: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; cdecl; export;
var
  Message:TMessage;
begin
  Message.Msg := msg;
  Message.WParam := wParam;
  Message.LParam := lParam;
  Message.Result := 0;
  Easy.diaplugin.Npp.MessageProc(Message);
  Result := Message.Result;
end;

{$IFDEF NPPUNICODE}
function isUnicode : Boolean; cdecl; export;
begin
  Result := true;
end;
{$ENDIF}

exports
  setInfo, getName, getFuncsArray, beNotified, messageProc;
{$IFDEF NPPUNICODE}
exports
  isUnicode;
{$ENDIF}

