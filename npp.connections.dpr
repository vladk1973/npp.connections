library npp.connections;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

{$R *.dres}

uses
  Windows,
  Messages,
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  System.SysUtils,
  System.Classes,
  ConstUnit in 'ConstUnit.pas',
  Easy.diaplugin in 'Easy.diaplugin.pas',
  ThreadUnit in 'ThreadUnit.pas',
  logFormUnit in 'logFormUnit.pas' {logForm},
  SqlThreadUnit in 'SqlThreadUnit.pas',
  StringGridsUnit in 'StringGridsUnit.pas',
  StringGridExUnit in 'StringGridExUnit.pas',
  ExtScrollingWinControlUnit in 'ExtScrollingWinControlUnit.pas',
  BDLoginUnit in 'BDLoginUnit.pas' {BDLoginForm},
  LogFormHelpersUnit in 'LogFormHelpersUnit.pas',
  TreeViewExUnit in 'TreeViewExUnit.pas',
  NppDockingForms in 'lib\NppDockingForms.pas' {NppDockingForm},
  NppForms in 'lib\NppForms.pas' {NppForm},
  nppplugin in 'lib\nppplugin.pas',
  SciSupport in 'lib\SciSupport.pas',
  regUnit in 'regUnit.pas',
  CustomDialogUnit in 'CustomDialogUnit.pas' {CustomDialogForm},
  TranslateComponentsUnit in 'TranslateComponentsUnit.pas';

{$R *.res}

{$Include 'NppPluginInclude.pas'}

begin
  { First, assign the procedure to the DLLProc variable }
  DllProc := @DLLEntryPoint;
  { Now invoke the procedure to reflect that the DLL is attaching to the process }
  DLLEntryPoint(DLL_PROCESS_ATTACH);
end.

