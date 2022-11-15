{
    This file is part of DBGP Plugin for Notepad++
    Copyright (C) 2007  Damjan Zobo Cvetko

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
}

unit nppplugin;

interface

uses
  Winapi.Windows,Winapi.Messages,System.SysUtils,  System.UITypes, Dialogs,
  Vcl.Forms, Classes, SciSupport;

const
  FuncItemNameLen=64;
  MaxFuncs = 11;

  { Most of this defs are outdated... But there is no consistant N++ doc... }
  NOTEPADPLUS_USER = (WM_USER + 1000);
  NPPM_GETCURRENTSCINTILLA = (NOTEPADPLUS_USER + 4);
  NPPM_GETCURRENTLANGTYPE = (NOTEPADPLUS_USER + 5);
  NPPM_SETCURRENTLANGTYPE = (NOTEPADPLUS_USER + 6);
  NPPM_GETNBOPENFILES = (NOTEPADPLUS_USER + 7);
    ALL_OPEN_FILES = 0;
    PRIMARY_VIEW = 1;
    SECOND_VIEW	= 2;
  NPPM_GETOPENFILENAMES = (NOTEPADPLUS_USER + 8);
  WM_CANCEL_SCINTILLAKEY = (NOTEPADPLUS_USER + 9);
  WM_BIND_SCINTILLAKEY = (NOTEPADPLUS_USER + 10);
  WM_SCINTILLAKEY_MODIFIED = (NOTEPADPLUS_USER + 11);
  NPPM_MODELESSDIALOG = (NOTEPADPLUS_USER + 12);
    MODELESSDIALOGADD = 0;
    MODELESSDIALOGREMOVE = 1;

  NPPM_GETNBSESSIONFILES = (NOTEPADPLUS_USER + 13);
  NPPM_GETSESSIONFILES = (NOTEPADPLUS_USER + 14);
  NPPM_SAVESESSION = (NOTEPADPLUS_USER + 15);
  NPPM_SAVECURRENTSESSION  =(NOTEPADPLUS_USER + 16);  // see TSessionInfo
  NPPM_GETOPENFILENAMESPRIMARY = (NOTEPADPLUS_USER + 17);
  NPPM_GETOPENFILENAMESSECOND = (NOTEPADPLUS_USER + 18);
  WM_GETPARENTOF = (NOTEPADPLUS_USER + 19);
  NPPM_CREATESCINTILLAHANDLE = (NOTEPADPLUS_USER + 20);
  NPPM_DESTROYSCINTILLAHANDLE = (NOTEPADPLUS_USER + 21);
  NPPM_GETNBUSERLANG = (NOTEPADPLUS_USER + 22);
  NPPM_GETCURRENTDOCINDEX = (NOTEPADPLUS_USER + 23);
    MAIN_VIEW = 0;
    SUB_VIEW = 1;

  NPPM_SETSTATUSBAR = (NOTEPADPLUS_USER + 24);
    STATUSBAR_DOC_TYPE = 0;
    STATUSBAR_DOC_SIZE = 1;
    STATUSBAR_CUR_POS = 2;
    STATUSBAR_EOF_FORMAT = 3;
    STATUSBAR_UNICODE_TYPE = 4;
    STATUSBAR_TYPING_MODE = 5;

  NPPM_GETMENUHANDLE = (NOTEPADPLUS_USER + 25);
    NPPPLUGINMENU = 0;

  NPPM_ENCODESCI = (NOTEPADPLUS_USER + 26);
  //ascii file to unicode
  //int WM_ENCODE_SCI(MAIN_VIEW/SUB_VIEW, 0)
  //return new unicodeMode

  NPPM_DECODESCI = (NOTEPADPLUS_USER + 27);
  //unicode file to ascii
  //int WM_DECODE_SCI(MAIN_VIEW/SUB_VIEW, 0)
  //return old unicodeMode

  NPPM_ACTIVATEDOC = (NOTEPADPLUS_USER + 28);
  //void WM_ACTIVATE_DOC(int index2Activate, int view)

  NPPM_LAUNCHFINDINFILESDLG = (NOTEPADPLUS_USER + 29);
  //void WM_LAUNCH_FINDINFILESDLG(char * dir2Search, char * filtre)

  NPPM_DMMSHOW = (NOTEPADPLUS_USER + 30);
  NPPM_DMMHIDE	= (NOTEPADPLUS_USER + 31);
  NPPM_DMMUPDATEDISPINFO = (NOTEPADPLUS_USER + 32);
  //void WM_DMM_xxx(0, tTbData->hClient)

  NPPM_DMMREGASDCKDLG = (NOTEPADPLUS_USER + 33);
  //void WM_DMM_REGASDCKDLG(0, &tTbData)

  NPPM_LOADSESSION = (NOTEPADPLUS_USER + 34);
  //void WM_LOADSESSION(0, const char* file name)
  NPPM_DMMVIEWOTHERTAB = (NOTEPADPLUS_USER + 35);
  //void WM_DMM_VIEWOTHERTAB(0, tTbData->hClient)
  NPPM_RELOADFILE = (NOTEPADPLUS_USER + 36);
  //BOOL WM_RELOADFILE(BOOL withAlert, char *filePathName2Reload)
  NPPM_SWITCHTOFILE = (NOTEPADPLUS_USER + 37);
  //BOOL WM_SWITCHTOFILE(0, char *filePathName2switch)
  NPPM_SAVECURRENTFILE = (NOTEPADPLUS_USER + 38);
  //BOOL WM_SWITCHTOFILE(0, 0)
  NPPM_SAVEALLFILES	= (NOTEPADPLUS_USER + 39);
  //BOOL WM_SAVEALLFILES(0, 0)
  NPPM_SETMENUITEMCHECK	= (NOTEPADPLUS_USER + 40);
  //void WM_PIMENU_CHECK(UINT	funcItem[X]._cmdID, TRUE/FALSE)
  NPPM_ADDTOOLBARICON = (NOTEPADPLUS_USER + 41); // see TToolbarIcons
  //void WM_ADDTOOLBARICON(UINT funcItem[X]._cmdID, toolbarIcons icon)
  NPPM_GETWINDOWSVERSION = (NOTEPADPLUS_USER + 42);
  //winVer WM_GETWINDOWSVERSION(0, 0)
  NPPM_DMMGETPLUGINHWNDBYNAME = (NOTEPADPLUS_USER + 43);
  //HWND WM_DMM_GETPLUGINHWNDBYNAME(const char *windowName, const char *moduleName)
  // if moduleName is NULL, then return value is NULL
  // if windowName is NULL, then the first found window handle which matches with the moduleName will be returned
  NPPM_MAKECURRENTBUFFERDIRTY = (NOTEPADPLUS_USER + 44);
  //BOOL NPPM_MAKECURRENTBUFFERDIRTY(0, 0)
  NPPM_GETENABLETHEMETEXTUREFUNC = (NOTEPADPLUS_USER + 45);
  //BOOL NPPM_GETENABLETHEMETEXTUREFUNC(0, 0)
  NPPM_GETPLUGINSCONFIGDIR = (NOTEPADPLUS_USER + 46);
  //void NPPM_GETPLUGINSCONFIGDIR(int strLen, char *str)

  // new
  NPPM_MSGTOPLUGIN = (NOTEPADPLUS_USER + 47); // see TCommunicationInfo
	//BOOL NPPM_MSGTOPLUGIN(TCHAR *destModuleName, CommunicationInfo *info)
	// return value is TRUE when the message arrive to the destination plugins.
	// if destModule or info is NULL, then return value is FALSE
//		struct CommunicationInfo {
//			long internalMsg;
//			const TCHAR * srcModuleName;
//			void * info; // defined by plugin
//		};

	NPPM_MENUCOMMAND = (NOTEPADPLUS_USER + 48);
	//void NPPM_MENUCOMMAND(0, int cmdID)
	// uncomment //#include "menuCmdID.h"
	// in the beginning of this file then use the command symbols defined in "menuCmdID.h" file
	// to access all the Notepad++ menu command items

	NPPM_TRIGGERTABBARCONTEXTMENU = (NOTEPADPLUS_USER + 49);
	//void NPPM_TRIGGERTABBARCONTEXTMENU(int view, int index2Activate)

	NPPM_GETNPPVERSION = (NOTEPADPLUS_USER + 50);
	// int NPPM_GETNPPVERSION(0, 0)
	// return version
	// ex : v4.6
	// HIWORD(version) == 4
	// LOWORD(version) == 6

	NPPM_HIDETABBAR = (NOTEPADPLUS_USER + 51);
	// BOOL NPPM_HIDETABBAR(0, BOOL hideOrNot)
	// if hideOrNot is set as TRUE then tab bar will be hidden
	// otherwise it'll be shown.
	// return value : the old status value

	NPPM_ISTABBARHIDE = (NOTEPADPLUS_USER + 52);
	// BOOL NPPM_ISTABBARHIDE(0, 0)
	// returned value : TRUE if tab bar is hidden, otherwise FALSE

	NPPM_CHECKDOCSTATUS = (NOTEPADPLUS_USER + 53);
	// VOID NPPM_CHECKDOCSTATUS(BOOL, 0)

	NPPM_ENABLECHECKDOCOPT = (NOTEPADPLUS_USER + 54);
	// VOID NPPM_ENABLECHECKDOCOPT(OPT, 0)
		// where OPT is :
		CHECKDOCOPT_NONE = 0;
		CHECKDOCOPT_UPDATESILENTLY = 1;
		CHECKDOCOPT_UPDATEGO2END = 2;

	NPPM_GETCHECKDOCOPT = (NOTEPADPLUS_USER + 55);
	// INT NPPM_GETCHECKDOCOPT(0, 0)
	NPPM_SETCHECKDOCOPT = (NOTEPADPLUS_USER + 56);
	// INT NPPM_SETCHECKDOCOPT(OPT, 0)

	NPPM_GETPOSFROMBUFFERID = (NOTEPADPLUS_USER + 57);
	// INT NPPM_GETPOSFROMBUFFERID(INT bufferID, 0)
	// Return VIEW|INDEX from a buffer ID. -1 if the bufferID non existing
	//
	// VIEW takes 2 highest bits and INDEX (0 based) takes the rest (30 bits)
	// Here's the values for the view :
	//  MAIN_VIEW 0
	//  SUB_VIEW  1

	NPPM_GETFULLPATHFROMBUFFERID = (NOTEPADPLUS_USER + 58);
	// INT NPPM_GETFULLPATHFROMBUFFERID(INT bufferID, CHAR *fullFilePath)
	// Get full path file name from a bufferID.
	// Return -1 if the bufferID non existing, otherwise the number of TCHAR copied/to copy
	// User should call it with fullFilePath be NULL to get the number of TCHAR (not including the nul character),
	// allocate fullFilePath with the return values + 1, then call it again to get  full path file name

	NPPM_GETBUFFERIDFROMPOS = (NOTEPADPLUS_USER + 59);
	//wParam: Position of document
	//lParam: View to use, 0 = Main, 1 = Secondary
	//Returns 0 if invalid

	NPPM_GETCURRENTBUFFERID = (NOTEPADPLUS_USER + 60);
	//Returns active Buffer

	NPPM_RELOADBUFFERID = (NOTEPADPLUS_USER + 61);
	//Reloads Buffer
	//wParam: Buffer to reload
	//lParam: 0 if no alert, else alert

	NPPM_SETFILENAME = (NOTEPADPLUS_USER + 63);
	//wParam: BufferID to rename
	//lParam: name to set (TCHAR*)
	//Buffer must have been previously unnamed (eg "new 1" document types)

	NPPM_GETBUFFERLANGTYPE = (NOTEPADPLUS_USER + 64);
	//wParam: BufferID to get LangType from
	//lParam: 0
	//Returns as int, see LangType. -1 on error

	NPPM_SETBUFFERLANGTYPE = (NOTEPADPLUS_USER + 65);
	//wParam: BufferID to set LangType of
	//lParam: LangType
	//Returns TRUE on success, FALSE otherwise
	//use int, see LangType for possible values
	//L_USER and L_EXTERNAL are not supported

	NPPM_GETBUFFERENCODING = (NOTEPADPLUS_USER + 66);
	//wParam: BufferID to get encoding from
	//lParam: 0
	//returns as int, see UniMode. -1 on error

	NPPM_SETBUFFERENCODING = (NOTEPADPLUS_USER + 67);
	//wParam: BufferID to set encoding of
	//lParam: format
	//Returns TRUE on success, FALSE otherwise
	//use int, see UniMode
	//Can only be done on new, unedited files

	NPPM_GETBUFFERFORMAT = (NOTEPADPLUS_USER + 68);
	//wParam: BufferID to get format from
	//lParam: 0
	//returns as int, see formatType. -1 on error

	NPPM_SETBUFFERFORMAT = (NOTEPADPLUS_USER + 69);
	//wParam: BufferID to set format of
	//lParam: format
	//Returns TRUE on success, FALSE otherwise
	//use int, see formatType

	NPPM_GETCURRENTVIEW = (NOTEPADPLUS_USER + 88);
	// INT NPPM_GETCURRENTVIEW(0, 0)
	// Return: current edit view of Notepad++. Only 2 possible values: 0 = Main, 1 = Secondary


  NPPM_DOCLISTDISABLEEXTCOLUMN = (NOTEPADPLUS_USER + 89);
  // VOID NPPM_DOCLISTDISABLEEXTCOLUMN(0, BOOL disableOrNot);
  // Disable or enable extension column of Document List
  NPPM_DOCLISTDISABLEPATHCOLUMN = (NOTEPADPLUS_USER + 102);
  // VOID NPPM_DOCLISTDISABLEPATHCOLUMN(0, BOOL disableOrNot);
  // Disable or enable path column of Document List
  NPPM_GETEDITORDEFAULTFOREGROUNDCOLOR = (NOTEPADPLUS_USER + 90);
  // INT NPPM_GETEDITORDEFAULTFOREGROUNDCOLOR(0, 0);
  // Return: current editor default foreground color. You should convert the returned value in COLORREF
  NPPM_GETEDITORDEFAULTBACKGROUNDCOLOR = (NOTEPADPLUS_USER + 91);
  // INT NPPM_GETEDITORDEFAULTBACKGROUNDCOLOR(0, 0);
  // Return: current editor default background color. You should convert the returned value in COLORREF
  NPPM_SETSMOOTHFONT = (NOTEPADPLUS_USER + 92);
  // VOID NPPM_SETSMOOTHFONT(0, BOOL setSmoothFontOrNot);
  NPPM_SETEDITORBORDEREDGE = (NOTEPADPLUS_USER + 93);
  // VOID NPPM_SETEDITORBORDEREDGE(0, BOOL withEditorBorderEdgeOrNot);
  NPPM_SAVEFILE = (NOTEPADPLUS_USER + 94);
  // VOID NPPM_SAVEFILE(0, const TCHAR *fileNameToSave);
  NPPM_DISABLEAUTOUPDATE = (NOTEPADPLUS_USER + 95); // 2119 in decimal
  // VOID NPPM_DISABLEAUTOUPDATE(0, 0);
  NPPM_REMOVESHORTCUTBYCMDID = (NOTEPADPLUS_USER + 96); // 2120 in decimal
  // BOOL NPPM_REMOVESHORTCUTASSIGNMENT(int cmdID);
  // removes the assigned shortcut mapped to cmdID
  // returned value : TRUE if function call is successful, otherwise FALSE
  NPPM_GETPLUGINHOMEPATH = (NOTEPADPLUS_USER + 97);
  // INT NPPM_GETPLUGINHOMEPATH(size_t strLen, TCHAR *pluginRootPath);
  // Get plugin home root path. It's useful if plugins want to get its own path
  // by appending <pluginFolderName> which is the name of plugin without extension part.
  // Returns the number of TCHAR copied/to copy.
  // Users should call it with pluginRootPath be NULL to get the required number of TCHAR = (not including the terminating nul character);,
  // allocate pluginRootPath buffer with the return value + 1, then call it again to get the path.
  NPPM_GETSETTINGSONCLOUDPATH = (NOTEPADPLUS_USER + 98);
  // INT NPPM_GETSETTINGSCLOUDPATH(size_t strLen, TCHAR *settingsOnCloudPath);
  // Get settings on cloud path. It's useful if plugins want to store its settings on Cloud, if this path is set.
  // Returns the number of TCHAR copied/to copy. If the return value is 0, then this path is not set, or the "strLen" is not enough to copy the path.
  // Users should call it with settingsCloudPath be NULL to get the required number of TCHAR = (not including the terminating nul character);,
  // allocate settingsCloudPath buffer with the return value + 1, then call it again to get the path.
  NPPM_SETLINENUMBERWIDTHMODE = (NOTEPADPLUS_USER + 99);
  LINENUMWIDTH_DYNAMIC     = 0;
  LINENUMWIDTH_CONSTANT    = 1;
  // BOOL NPPM_SETLINENUMBERWIDTHMODE(0, INT widthMode);
  // Set line number margin width in dynamic width mode = (LINENUMWIDTH_DYNAMIC); or constant width mode = (LINENUMWIDTH_CONSTANT);
  // It may help some plugins to disable non-dynamic line number margins width to have a smoothly visual effect while vertical scrolling the content in Notepad++
  // If calling is successful return TRUE, otherwise return FALSE.
  NPPM_GETLINENUMBERWIDTHMODE = (NOTEPADPLUS_USER + 100);
  // INT NPPM_GETLINENUMBERWIDTHMODE(0, 0);
  // Get line number margin width in dynamic width mode = (LINENUMWIDTH_DYNAMIC); or constant width mode = (LINENUMWIDTH_CONSTANT);
  NPPM_ADDTOOLBARICON_FORDARKMODE = (NOTEPADPLUS_USER + 101);
  // VOID NPPM_ADDTOOLBARICON_FORDARKMODE(UINT funcItem[X]._cmdID, toolbarIconsWithDarkMode iconHandles);
  // Use NPPM_ADDTOOLBARICON_FORDARKMODE instead obsolete NPPM_ADDTOOLBARICON which doesn't support the dark mode
  // since 8.0
  // https://community.notepad-plus-plus.org/topic/21652/add-new-api-nppm_addtoolbaricon_fordarkmode-for-dark-mode
  NPPM_GETEXTERNALLEXERAUTOINDENTMODE = (NOTEPADPLUS_USER + 103);
  // BOOL NPPM_GETEXTERNALLEXERAUTOINDENTMODE(const TCHAR *languageName, ExternalLexerAutoIndentMode &autoIndentMode);
  // Get ExternalLexerAutoIndentMode for an installed external programming language.
  // - Standard means Notepad++ will keep the same TAB indentation between lines;
  // - C_Like means Notepad++ will perform a C-Language style indentation for the selected external language;
  // - Custom means a Plugin will be controlling auto-indentation for the current language.
  // returned values: TRUE for successful searches, otherwise FALSE.
  NPPM_SETEXTERNALLEXERAUTOINDENTMODE = (NOTEPADPLUS_USER + 104);
  // BOOL NPPM_SETEXTERNALLEXERAUTOINDENTMODE(const TCHAR *languageName, ExternalLexerAutoIndentMode autoIndentMode);
  // Set ExternalLexerAutoIndentMode for an installed external programming language.
  // - Standard means Notepad++ will keep the same TAB indentation between lines;
  // - C_Like means Notepad++ will perform a C-Language style indentation for the selected external language;
  // - Custom means a Plugin will be controlling auto-indentation for the current language.
  // returned value: TRUE if function call was successful, otherwise FALSE.
  NPPM_ISAUTOINDENTON = (NOTEPADPLUS_USER + 105);
  // BOOL NPPM_ISAUTOINDENTON(0, 0);
  // Returns the current Use Auto-Indentation setting in Notepad++ Preferences.
  NPPM_GETCURRENTMACROSTATUS = (NOTEPADPLUS_USER + 106);
  // MacroStatus NPPM_GETCURRENTMACROSTATUS(0, 0);
  // Gets current enum class MacroStatus { Idle - means macro is not in use and it's empty, RecordInProgress, RecordingStopped, PlayingBack }
  NPPM_ISDARKMODEENABLED = (NOTEPADPLUS_USER + 107);
  // bool NPPM_ISDARKMODEENABLED(0, 0)
  // Returns true when Notepad++ Dark Mode is enable, false when it is not.
  // since 8.4.1
  // https://github.com/notepad-plus-plus/notepad-plus-plus/commit/1eb5b10e41d7ab92b60aa32b28d4fe7739d15b53
  NPPM_GETDARKMODECOLORS = (NOTEPADPLUS_USER + 108);
  // bool NPPM_GETDARKMODECOLORS (size_t cbSize, NppDarkMode::Colors* returnColors)
  // - cbSize must be filled with sizeof(NppDarkMode::Colors).
  // - returnColors must be a pre-allocated NppDarkMode::Colors struct.
  // Returns true when successful, false otherwise.
  // You need to uncomment the following code to use NppDarkMode::Colors structure:
  //
  // namespace NppDarkMode
  // {
  //  struct Colors
  //  {
  //    COLORREF background = 0;
  //    COLORREF softerBackground = 0;
  //    COLORREF hotBackground = 0;
  //    COLORREF pureBackground = 0;
  //    COLORREF errorBackground = 0;
  //    COLORREF text = 0;
  //    COLORREF darkerText = 0;
  //    COLORREF disabledText = 0;
  //    COLORREF linkText = 0;
  //    COLORREF edge = 0;
  //    COLORREF hotEdge = 0;
  //    COLORREF disabledEdge = 0;
  //  };
  // }
  //


  // Note: in the case of calling failure ("false" is returned), you may need to change NppDarkMode::Colors structure to:
  // https://github.com/notepad-plus-plus/notepad-plus-plus/blob/master/PowerEditor/src/NppDarkMode.h#L32
  // since 8.4.1
  // https://github.com/notepad-plus-plus/notepad-plus-plus/commit/1eb5b10e41d7ab92b60aa32b28d4fe7739d15b53
  NPPM_GETCURRENTCMDLINE = (NOTEPADPLUS_USER + 109);
  // INT NPPM_GETCURRENTCMDLINE(size_t strLen, TCHAR *commandLineStr)
  // Get the Current Command Line string.
  // Returns the number of TCHAR copied/to copy.
  // Users should call it with commandLineStr as NULL to get the required number of TCHAR (not including the terminating nul character),
  // allocate commandLineStr buffer with the return value + 1, then call it again to get the current command line string.
  // since 8.4.2
  // https://github.com/notepad-plus-plus/notepad-plus-plus/commit/0f8d5724afb0a540e8b4024252945ab60bc88c71
  NPPM_CREATELEXER = (NOTEPADPLUS_USER + 110);
  // void* NPPN_CREATELEXER(0, const TCHAR *lexer_name)
  // Returns the ILexer pointer created by Lexilla
  // since 8.4.3
  // https://github.com/notepad-plus-plus/notepad-plus-plus/commit/f1ed4de78dbe8f5d85f4d199bae2970148cca8ed

  // Notification code
  NPPN_FIRST = 1000;
  NPPN_READY = (NPPN_FIRST + 1);
  // To notify plugins that all the procedures of launchment of notepad++ are done.
  //scnNotification->nmhdr.code = NPPN_READY;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = 0;

  NPPN_TB_MODIFICATION = (NPPN_FIRST + 2);
  // To notify plugins that toolbar icons can be registered
  //scnNotification->nmhdr.code = NPPN_TB_MODIFICATION;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = 0;

  NPPN_FILEBEFORECLOSE = (NPPN_FIRST + 3);
  // To notify plugins that the current file is about to be closed
  //scnNotification->nmhdr.code = NPPN_FILEBEFORECLOSE;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = 0;

  NPPN_FILEOPENED = (NPPN_FIRST + 4);
  // To notify plugins that the current file is just opened
  //scnNotification->nmhdr.code = NPPN_FILEOPENED;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = 0;

  NPPN_FILECLOSED = (NPPN_FIRST + 5);
  // To notify plugins that the current file is just closed
  //scnNotification->nmhdr.code = NPPN_FILECLOSED;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = 0;

  NPPN_FILEBEFOREOPEN = (NPPN_FIRST + 6);
  // To notify plugins that the current file is about to be opened
  //scnNotification->nmhdr.code = NPPN_FILEBEFOREOPEN;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = 0;

  NPPN_FILEBEFORESAVE = (NPPN_FIRST + 7);
  // To notify plugins that the current file is about to be saved
  //scnNotification->nmhdr.code = NPPN_FILEBEFOREOPEN;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = 0;

  NPPN_FILESAVED = (NPPN_FIRST + 8);
  // To notify plugins that the current file is just saved
  //scnNotification->nmhdr.code = NPPN_FILECLOSED;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = 0;

  NPPN_SHUTDOWN = (NPPN_FIRST + 9);
  // To notify plugins that Notepad++ is about to be shutdowned.
  //scnNotification->nmhdr.code = NPPN_SHOUTDOWN;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = 0;

  NPPN_BUFFERACTIVATED = (NPPN_FIRST + 10);
  // To notify plugins that a buffer was activated (put to foreground).
	//scnNotification->nmhdr.code = NPPN_BUFFERACTIVATED;
	//scnNotification->nmhdr.hwndFrom = hwndNpp;
	//scnNotification->nmhdr.idFrom = activatedBufferID;

	NPPN_LANGCHANGED = (NPPN_FIRST + 11);
  // To notify plugins that the language in the current doc is just changed.
	//scnNotification->nmhdr.code = NPPN_LANGCHANGED;
	//scnNotification->nmhdr.hwndFrom = hwndNpp;
	//scnNotification->nmhdr.idFrom = currentBufferID;

	NPPN_WORDSTYLESUPDATED = (NPPN_FIRST + 12);
  // To notify plugins that user initiated a WordStyleDlg change.
	//scnNotification->nmhdr.code = NPPN_WORDSTYLESUPDATED;
	//scnNotification->nmhdr.hwndFrom = hwndNpp;
	//scnNotification->nmhdr.idFrom = currentBufferID;

	NPPN_SHORTCUTREMAPPED = (NPPN_FIRST + 13);
  // To notify plugins that plugin command shortcut is remapped.
	//scnNotification->nmhdr.code = NPPN_SHORTCUTSREMAPPED;
	//scnNotification->nmhdr.hwndFrom = ShortcutKeyStructurePointer;
	//scnNotification->nmhdr.idFrom = cmdID;
		//where ShortcutKeyStructurePointer is pointer of struct ShortcutKey:
		//struct ShortcutKey {
		//	bool _isCtrl;
		//	bool _isAlt;
		//	bool _isShift;
		//	UCHAR _key;
		//};

	NPPN_FILEBEFORELOAD = (NPPN_FIRST + 14);
  // To notify plugins that the current file is about to be loaded
	//scnNotification->nmhdr.code = NPPN_FILEBEFOREOPEN;
	//scnNotification->nmhdr.hwndFrom = hwndNpp;
	//scnNotification->nmhdr.idFrom = NULL;

	NPPN_FILELOADFAILED = (NPPN_FIRST + 15);
  // To notify plugins that file open operation failed
	//scnNotification->nmhdr.code = NPPN_FILEOPENFAILED;
	//scnNotification->nmhdr.hwndFrom = hwndNpp;
	//scnNotification->nmhdr.idFrom = BufferID;

	NPPN_READONLYCHANGED = (NPPN_FIRST + 16);
  // To notify plugins that current document change the readonly status,
	//scnNotification->nmhdr.code = NPPN_READONLYCHANGED;
	//scnNotification->nmhdr.hwndFrom = bufferID;
	//scnNotification->nmhdr.idFrom = docStatus;
		// where bufferID is BufferID
		//       docStatus can be combined by DOCSTAUS_READONLY and DOCSTAUS_BUFFERDIRTY

  DOCSTATUS_READONLY = 1;
  DOCSTATUS_BUFFERDIRTY = 2;
  NPPN_DOCORDERCHANGED = (NPPN_FIRST + 17);  // To notify plugins that document order is changed
  //scnNotification->nmhdr.code = NPPN_DOCORDERCHANGED;
  //scnNotification->nmhdr.hwndFrom = newIndex;
  //scnNotification->nmhdr.idFrom = BufferID;

  NPPN_SNAPSHOTDIRTYFILELOADED = (NPPN_FIRST + 18);  // To notify plugins that a snapshot dirty file is loaded on startup
  //scnNotification->nmhdr.code = NPPN_SNAPSHOTDIRTYFILELOADED;
  //scnNotification->nmhdr.hwndFrom = NULL;
  //scnNotification->nmhdr.idFrom = BufferID;
  NPPN_BEFORESHUTDOWN = (NPPN_FIRST + 19);  // To notify plugins that Npp shutdown has been triggered, files have not been closed yet
  //scnNotification->nmhdr.code = NPPN_BEFORESHUTDOWN;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = 0;
  NPPN_CANCELSHUTDOWN = (NPPN_FIRST + 20);  // To notify plugins that Npp shutdown has been cancelled
  //scnNotification->nmhdr.code = NPPN_CANCELSHUTDOWN;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = 0;
  NPPN_FILEBEFORERENAME = (NPPN_FIRST + 21);  // To notify plugins that file is to be renamed
  //scnNotification->nmhdr.code = NPPN_FILEBEFORERENAME;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = BufferID;
  NPPN_FILERENAMECANCEL = (NPPN_FIRST + 22);  // To notify plugins that file rename has been cancelled
  //scnNotification->nmhdr.code = NPPN_FILERENAMECANCEL;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = BufferID;
  NPPN_FILERENAMED = (NPPN_FIRST + 23);  // To notify plugins that file has been renamed
  //scnNotification->nmhdr.code = NPPN_FILERENAMED;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = BufferID;
  NPPN_FILEBEFOREDELETE = (NPPN_FIRST + 24);  // To notify plugins that file is to be deleted
  //scnNotification->nmhdr.code = NPPN_FILEBEFOREDELETE;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = BufferID;
  NPPN_FILEDELETEFAILED = (NPPN_FIRST + 25);  // To notify plugins that file deletion has failed
  //scnNotification->nmhdr.code = NPPN_FILEDELETEFAILED;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = BufferID;
  NPPN_FILEDELETED = (NPPN_FIRST + 26);  // To notify plugins that file has been deleted
  //scnNotification->nmhdr.code = NPPN_FILEDELETED;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = BufferID;
  NPPN_DARKMODECHANGED = (NPPN_FIRST + 27); // To notify plugins that Dark Mode was enabled/disabled
  //scnNotification->nmhdr.code = NPPN_DARKMODECHANGED;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = 0;
  NPPN_CMDLINEPLUGINMSG = (NPPN_FIRST + 28);  // To notify plugins that the new argument for plugins (via '-pluginMessage="YOUR_PLUGIN_ARGUMENT"' in command line) is available
  //scnNotification->nmhdr.code = NPPN_CMDLINEPLUGINMSG;
  //scnNotification->nmhdr.hwndFrom = hwndNpp;
  //scnNotification->nmhdr.idFrom = pluginMessage; //where pluginMessage is pointer of type wchar_t

	DOCSTAUS_READONLY = 1;
	DOCSTAUS_BUFFERDIRTY = 2;

  VAR_NOT_RECOGNIZED = 0;
  FULL_CURRENT_PATH = 1;
  CURRENT_DIRECTORY = 2;
  FILE_NAME = 3;
  NAME_PART = 4;
  EXT_PART = 5;
  CURRENT_WORD = 6;
  NPP_DIRECTORY = 7;
  CURRENT_LINE = 8;
  CURRENT_COLUMN = 9;
  NPP_FULL_FILE_PATH = 10;
  GETFILENAMEATCURSOR = 11;
  CURRENT_LINESTR = 12;
  RUNCOMMAND_USER = (WM_USER + 3000);
  NPPM_GETFULLCURRENTPATH = (RUNCOMMAND_USER + FULL_CURRENT_PATH);
  NPPM_GETCURRENTDIRECTORY = (RUNCOMMAND_USER + CURRENT_DIRECTORY);
  NPPM_GETFILENAME = (RUNCOMMAND_USER + FILE_NAME);
  NPPM_GETNAMEPART = (RUNCOMMAND_USER + NAME_PART);
  NPPM_GETEXTPART = (RUNCOMMAND_USER + EXT_PART);
  NPPM_GETCURRENTWORD = (RUNCOMMAND_USER + CURRENT_WORD);
  NPPM_GETNPPDIRECTORY = (RUNCOMMAND_USER + NPP_DIRECTORY);
  NPPM_GETFILENAMEATCURSOR = (RUNCOMMAND_USER + GETFILENAMEATCURSOR);
  NPPM_GETCURRENTLINESTR = (RUNCOMMAND_USER + CURRENT_LINESTR);
  // BOOL NPPM_GETXXXXXXXXXXXXXXXX(size_t strLen, TCHAR *str);
  // where str is the allocated TCHAR array,
  //       strLen is the allocated array size
  // The return value is TRUE when get generic_string operation success
  // Otherwise = (allocated array size is too small); FALSE
  NPPM_GETCURRENTLINE = (RUNCOMMAND_USER + CURRENT_LINE);
  // INT NPPM_GETCURRENTLINE(0, 0);
  // return the caret current position line
  NPPM_GETCURRENTCOLUMN = (RUNCOMMAND_USER + CURRENT_COLUMN);
  // INT NPPM_GETCURRENTCOLUMN(0, 0);
  // return the caret current position column
  NPPM_GETNPPFULLFILEPATH = (RUNCOMMAND_USER + NPP_FULL_FILE_PATH);

  MACRO_USER    = (WM_USER + 4000);
  WM_ISCURRENTMACRORECORDED = (MACRO_USER + 01);
  WM_MACRODLGRUNMACRO       = (MACRO_USER + 02);

{ Humm.. is tis npp specific? }
  SCINTILLA_USER = (WM_USER + 2000);
{
#define WM_DOCK_USERDEFINE_DLG      (SCINTILLA_USER + 1)
#define WM_UNDOCK_USERDEFINE_DLG    (SCINTILLA_USER + 2)
#define WM_CLOSE_USERDEFINE_DLG		(SCINTILLA_USER + 3)
#define WM_REMOVE_USERLANG		    (SCINTILLA_USER + 4)
#define WM_RENAME_USERLANG			(SCINTILLA_USER + 5)
#define WM_REPLACEALL_INOPENEDDOC	(SCINTILLA_USER + 6)
#define WM_FINDALL_INOPENEDDOC  	(SCINTILLA_USER + 7)
}
  WM_DOOPEN = (SCINTILLA_USER + 8);
{
#define WM_FINDINFILES			  	(SCINTILLA_USER + 9)
}

{ docking.h }
//   defines for docking manager
  CONT_LEFT = 0;
  CONT_RIGHT = 1;
  CONT_TOP = 2;
  CONT_BOTTOM = 3;
  DOCKCONT_MAX = 4;

// mask params for plugins of internal dialogs
  DWS_ICONTAB = 1; // Icon for tabs are available
  DWS_ICONBAR = 2; // Icon for icon bar are available (currently not supported)
  DWS_ADDINFO = 4; // Additional information are in use

// default docking values for first call of plugin
  DWS_DF_CONT_LEFT = CONT_LEFT shl 28;	        // default docking on left
  DWS_DF_CONT_RIGHT = CONT_RIGHT shl 28;	// default docking on right
  DWS_DF_CONT_TOP = CONT_TOP shl 28;	        // default docking on top
  DWS_DF_CONT_BOTTOM = CONT_BOTTOM shl 28;	// default docking on bottom
  DWS_DF_FLOATING = $80000000;			// default state is floating

{ dockingResource.h }
  DMN_FIRST = 1050;
  DMN_CLOSE = (DMN_FIRST + 1); //nmhdr.code = DWORD(DMN_CLOSE, 0)); //nmhdr.hwndFrom = hwndNpp; //nmhdr.idFrom = ctrlIdNpp;
  DMN_DOCK = (DMN_FIRST + 2);
  DMN_FLOAT = (DMN_FIRST + 3); //nmhdr.code = DWORD(DMN_XXX, int newContainer);	//nmhdr.hwndFrom = hwndNpp; //nmhdr.idFrom = ctrlIdNpp;


type
{$IFDEF NPPUNICODE}
  nppString = WideString;
  nppChar = WChar;
  nppPChar = PWChar;
{$ELSE}
  nppString = AnsiString;
  nppChar = AnsiChar;
  nppPChar = PAnsiChar;
{$ENDIF}

  TNppLang = (L_TXT, L_PHP , L_C, L_CPP, L_CS, L_OBJC, L_JAVA, L_RC,
              L_HTML, L_XML, L_MAKEFILE, L_PASCAL, L_BATCH, L_INI, L_NFO, L_USER,
              L_ASP, L_SQL, L_VB, L_JS, L_CSS, L_PERL, L_PYTHON, L_LUA,
              L_TEX, L_FORTRAN, L_BASH, L_FLASH, L_NSIS, L_TCL, L_LISP, L_SCHEME,
              L_ASM, L_DIFF, L_PROPS, L_PS, L_RUBY, L_SMALLTALK, L_VHDL, L_KIX, L_AU3,
              L_CAML, L_ADA, L_VERILOG, L_MATLAB, L_HASKELL, L_INNO,
              // The end of enumated language type, so it should be always at the end
              L_END);

  TSessionInfo = record
    SessionFilePathName: nppPChar;
    NumFiles: Integer;
    Files: array of nppPChar;
  end;

  TToolbarIcons = record
    ToolbarBmp: HBITMAP;
    ToolbarIcon: HICON;
  end;

  // 2 formats / 3 icons are needed:  1 * BMP + 2 * ICO
  // All 3 handles below should be set so the icon will be displayed correctly if toolbar icon sets are changed by users, also in dark mode
  TTbIconsDarkMode = record
    ToolbarBmp: HBITMAP;
    ToolbarIcon: HICON;
    ToolbarIconDarkMode: HICON;
  end;


  TNppDarkModeColors_ver8 = record
    background: COLORREF;
    softerBackground: COLORREF;
    hotBackground: COLORREF;
    pureBackground: COLORREF;
    errorBackground: COLORREF;
    text: COLORREF;
    darkerText: COLORREF;
    disabledText: COLORREF;
    linkText: COLORREF;
    edge: COLORREF;
  end;

  TNppDarkModeColors = record
    background: COLORREF;
    softerBackground: COLORREF;
    hotBackground: COLORREF;
    pureBackground: COLORREF;
    errorBackground: COLORREF;
    text: COLORREF;
    darkerText: COLORREF;
    disabledText: COLORREF;
    linkText: COLORREF;
    edge: COLORREF;
    hotEdge: COLORREF;
    disabledEdge: COLORREF;
  end;

  TCommunicationInfo = record
    internalMsg: NativeUInt;
    srcModuleName: nppPChar;
    info: Pointer;
  end;

  TNppData = record
    NppHandle: HWND;
    ScintillaMainHandle: HWND;
    ScintillaSecondHandle: HWND;
  end;

  TShortcutKey = record
    IsCtrl: Boolean;
    IsAlt: Boolean;
    IsShift: Boolean;
    Key: UCHAR;
  end;
  PShortcutKey = ^TShortcutKey;

  PFUNCPLUGINCMD = procedure; cdecl;

  _TFuncItem = record
    ItemName: Array[0..FuncItemNameLen-1] of nppChar;
    Func: PFUNCPLUGINCMD;
    CmdID: Integer;
    Checked: Boolean;
    ShortcutKey: PShortcutKey;
  end;

  TToolbarData = record
    ClientHandle: HWND;
    Title: nppPChar;
    DlgId: Integer;
    Mask: Cardinal;
    IconTab: HICON; // still dont know how to use this...
    AdditionalInfo: nppPChar;
    FloatRect: TRect;  // internal
    PrevContainer: Cardinal; // internal
    ModuleName:nppPChar; // name of module GetModuleFileName(0...)
  end;

  TNppPlugin = class(TObject)
  private
    FMainViewDefClientProc: LONG_PTR;
    FSubViewDefClientProc: LONG_PTR;
    FMainViewClientInstance: LONG_PTR;
    FSubViewClientInstance: LONG_PTR;
    FuncArray: array of _TFuncItem;

    function GetPluginsConfigDir: string;

    procedure RegisterWindowProcedure;
    procedure UnRegisterWindowProcedure;
    procedure ClientWndProcMainView(var Message: TMessage);
    procedure ClientWndProcSubView(var Message: TMessage);

  protected
    function GetNppVersion: Cardinal;
    function AddFuncItem(Name: nppString; Func: PFUNCPLUGINCMD): Integer; overload;
    function AddFuncItem(Name: nppString; Func: PFUNCPLUGINCMD; ShortcutKey: TShortcutKey): Integer; overload;

    procedure ClientWndProc(var Message: TMessage);virtual;
    procedure DoNppnToolbarModification; virtual;

  public
    PluginName: nppString;

    NppData: TNppData;
    constructor Create;
    destructor Destroy; override;
    procedure BeforeDestruction; override;

    function CurrentLine: LRESULT;
    function CurrentPos: LRESULT;
    function SelectedText: AnsiString;
    function GetText: AnsiString;
    function GetTextLength: Integer;
    function GetLineCount: Integer;
    function GetLine(const Line: Integer): AnsiString;

    function CmdIdFromDlgId(DlgId: Integer): Integer;
    function Sci_Send(Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
    function Npp_Send(Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;

    function GetTextRange(Range: TCharacterRange): AnsiString;
    procedure FuncInsertText(const S: AnsiString);

    // needed for DLL export.. wrappers are in the main dll file.
    procedure SetInfo(NppData: TNppData); virtual;
    function GetName: nppPChar;
    function GetFuncsArray(var FuncsCount: Integer): Pointer;
    procedure BeNotified(sn: PSCNotification); virtual;
    procedure MessageProc(var Msg: TMessage); virtual;

    // hooks
    procedure DoNppnShutdown; virtual;
    procedure DoNppnModified(sn: PSCNotification); virtual;
    procedure DoNppnFileOpened(sn: PSCNotification); virtual;
    procedure DoNppnUpdateContent; virtual;
    procedure DoNppnUpdateSelection; virtual;
    procedure DoNppnUpdateVScroll; virtual;
    procedure DoNppnUpdateHScroll; virtual;
    procedure DoNppnCharAdded(const ASCIIKey: Integer); virtual;
    procedure DoNppnUpdateAutoSelection(P: PAnsiChar);virtual;
    procedure DoChangePluginTheme; virtual;
    // df
    function DoOpen(filename: string): boolean; overload;
    function DoOpen(filename: string; Line: Integer): boolean; overload;
    procedure GetFileLine(var filename: nppString; var Line: Integer);
    procedure GetFileName(var filename: string);
    procedure GetFullFileName(var filename: string);
    procedure SaveCurrentFile;
    function GetWord: string;
    function CheckDocStatus: string;

    function RegisterAsDialog(WindowHandle: HWND): Integer;
    function UnRegisterAsDialog(WindowHandle: HWND): Integer;

    function ScintillaHandle: HWND;
    function HasV5Apis: Boolean; // needs N++ 8.4 or later

    property PluginsConfigDir: string read GetPluginsConfigDir;
  end;

implementation

function CharToString(var s: nppString): nppString;
begin
{$IFDEF NPPUNICODE}
  Result := WideCharToString(nppPChar(s));
{$ELSE}
  SetLength(s, StrLen(nppPChar(s)));
  Result := s;
{$ENDIF}
end;

{ TNppPlugin }

{ This is hacking for troubble...
  We need to unset the Application handler so that the forms
  don't get berserk and start throwing OS error 1004.
  This happens because the main NPP HWND is already lost when the
  DLL_PROCESS_DETACH gets called, and the form tries to allocate a new
  handler for sending the "close" windows message...
}
procedure TNppPlugin.BeforeDestruction;
begin
  UnRegisterWindowProcedure;
  Application.Handle := 0;
  Application.Terminate;
  inherited;
end;

constructor TNppPlugin.Create;
begin
  inherited;
end;

destructor TNppPlugin.Destroy;
var i: Integer;
begin
  for i:=0 to Length(self.FuncArray)-1 do
  begin
    if (self.FuncArray[i].ShortcutKey <> nil) then
    begin
      Dispose(self.FuncArray[i].ShortcutKey);
    end;
  end;
  inherited;
end;

function TNppPlugin.AddFuncItem(Name: nppString; Func: PFUNCPLUGINCMD): Integer;
var
  i: Integer;
begin
  i := Length(self.FuncArray);
  SetLength(Self.FuncArray,i+1);
{$IFDEF NPPUNICODE}
  StringToWideChar(Name, self.FuncArray[i].ItemName,MAX_PATH);
{$ELSE}
  StrCopy(self.FuncArray[i].ItemName, PChar(Name));
{$ENDIF}
  self.FuncArray[i].Func := Func;
  self.FuncArray[i].ShortcutKey := nil;
  Result := i;
end;

function TNppPlugin.AddFuncItem(Name: nppString; Func: PFUNCPLUGINCMD;
  ShortcutKey: TShortcutKey): Integer;
var
  i: Integer;
begin
  i := self.AddFuncItem(Name, Func);
  New(self.FuncArray[i].ShortcutKey);
  self.FuncArray[i].ShortcutKey.IsCtrl := ShortcutKey.IsCtrl;
  self.FuncArray[i].ShortcutKey.IsAlt := ShortcutKey.IsAlt;
  self.FuncArray[i].ShortcutKey.IsShift := ShortcutKey.IsShift;
  self.FuncArray[i].ShortcutKey.Key := ShortcutKey.Key; // need widechar ??
  Result := i;
end;

procedure TNppPlugin.GetFileLine(var filename: nppString; var Line: Integer);
var
  s: nppString;
  r: LRESULT;
begin
  SetLength(s, MAX_PATH);
  Npp_Send(NPPM_GETFULLCURRENTPATH,0, LPARAM(nppPChar(s)));
  filename := CharToString(s);
  r := Sci_Send(SciSupport.SCI_GETCURRENTPOS, 0, 0);
  Line := Sci_Send(SciSupport.SCI_LINEFROMPOSITION, WPARAM(r), 0);
end;

procedure TNppPlugin.GetFileName(var filename: string);
var
  s: nppString;
begin
  SetLength(s, MAX_PATH);
  Npp_Send(NPPM_GETFILENAME,0, LPARAM(nppPChar(s)));
  filename := CharToString(s);
end;

procedure TNppPlugin.GetFullFileName(var filename: string);
var
  s: nppString;
begin
  SetLength(s, MAX_PATH);
  Npp_Send(NPPM_GETFULLCURRENTPATH,0, LPARAM(nppPChar(s)));
  filename := CharToString(s);
end;

function TNppPlugin.GetFuncsArray(var FuncsCount: Integer): Pointer;
begin
  FuncsCount := Length(self.FuncArray);
  Result := FuncArray;
end;

function TNppPlugin.GetName: nppPChar;
begin
  Result := nppPChar(self.PluginName);
end;

function TNppPlugin.GetPluginsConfigDir: string;
var
  s: nppString;
begin
  SetLength(s, MAX_PATH);
  Npp_Send(NPPM_GETPLUGINSCONFIGDIR, MAX_PATH, LPARAM(nppPChar(s)));
  Result := CharToString(s);
end;

procedure TNppPlugin.BeNotified(sn: PSCNotification);
begin
  if (HWND(sn^.nmhdr.hwndFrom) = self.NppData.NppHandle) and (sn^.nmhdr.code = NPPN_SHUTDOWN) then
  begin
    self.DoNppnShutdown;
    Exit;
  end;

  if (HWND(sn^.nmhdr.hwndFrom) = self.NppData.NppHandle) and (sn^.nmhdr.code = NPPN_TB_MODIFICATION) then
  begin
    self.DoNppnToolbarModification;
  end;

  if (HWND(sn^.nmhdr.hwndFrom) = self.NppData.NppHandle) and (sn^.nmhdr.code = NPPN_DARKMODECHANGED) then
  begin
    self.DoChangePluginTheme;
  end;

  if (HWND(sn^.nmhdr.hwndFrom) = self.NppData.NppHandle)
    and (sn^.nmhdr.code = NPPN_BUFFERACTIVATED) then
  begin
    self.DoNppnFileOpened(sn);
  end;

  if (HWND(sn^.nmhdr.hwndFrom) = ScintillaHandle)
    and (sn^.nmhdr.code = SCN_MODIFIED) then
  begin
    self.DoNppnModified(sn);
  end;

  if (HWND(sn^.nmhdr.hwndFrom) = ScintillaHandle)
    and (sn^.nmhdr.code = SCN_UPDATEUI) then
  begin
    if (SC_UPDATE_CONTENT and sn^.updated)  > 0 then self.DoNppnUpdateContent;

    if (SC_UPDATE_SELECTION and sn^.updated)> 0 then self.DoNppnUpdateSelection;

    if (SC_UPDATE_V_SCROLL and sn^.updated) > 0 then self.DoNppnUpdateVScroll;
  end;

  if (HWND(sn^.nmhdr.hwndFrom) = ScintillaHandle)
    and (sn^.nmhdr.code = SCN_CHARADDED) then
  begin
    if sn^.ch <> 0 then DoNppnCharAdded(sn^.ch)
    else
    if sn^.modifiers <> 0 then DoNppnCharAdded(sn^.modifiers)
  end;

  if (HWND(sn^.nmhdr.hwndFrom) = ScintillaHandle)
    and (sn^.nmhdr.code = SCN_AUTOCSELECTION) then
      DoNppnUpdateAutoSelection(sn^.text);

end;

procedure TNppPlugin.MessageProc(var Msg: TMessage);
var
  hm: HMENU;
  i: integer;
begin
  if Msg.Msg =28  then
  begin
    // Change - to separator items
    hm := GetMenu(self.NppData.NppHandle);
    for i:=0 to Length(self.FuncArray)-1 do
      if (self.FuncArray[i].ItemName[0] = '-') then
        ModifyMenu(hm, self.FuncArray[i].CmdID, MF_BYCOMMAND or MF_SEPARATOR, 0, nil);
  end;
  Dispatch(Msg);
end;

function TNppPlugin.Npp_Send(Msg: UINT; wParam: WPARAM;
  lParam: LPARAM): LRESULT;
begin
  Result := SendMessage(NppData.NppHandle, Msg, wParam, lParam);
end;

function TNppPlugin.Sci_Send(Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := SendMessage(ScintillaHandle, Msg, wParam, lParam);
end;

function TNppPlugin.GetLine(const Line: Integer): AnsiString;
var
  Size: Integer;
  S: AnsiString;
begin
  Size := Sci_Send(SCI_LINELENGTH,WPARAM(Line),0);
  if HasV5Apis then Inc(Size);
  SetLength(S,Size);
  try
    Size :=Sci_Send(SCI_GETLINE,WPARAM(Line),LPARAM(PAnsiChar(S)));
    Result := S;
  finally
    SetLength(S,0);
  end;
end;

function TNppPlugin.GetTextRange(Range: TCharacterRange): AnsiString;
var pt: PTextRange; //���������� ����� ������ ����������� ���������
    Size,StartSize: NativeInt;
    S: AnsiString;
begin
  StartSize := (Range.cpMax - Range.cpMin)+1;
  GetMem(pt,SizeOf(TTextRange));
  GetMem(pt^.lpstrText,StartSize);
  try
    pt^.chrg := Range;
    Size :=Sci_Send(SCI_GETTEXTRANGEFULL,0,LPARAM(pt));
    if HasV5Apis then Inc(Size);
    SetLength(S,Size);
    StrLCopy(PAnsiChar(S),pt^.lpstrText,Size);
  finally
    FreeMem(pt^.lpstrText,StartSize);
    FreeMem(pt,SizeOf(TTextRange));
    Result := S;
  end;
end;

procedure TNppPlugin.FuncInsertText(const S: AnsiString);
var
  S1: AnsiString;
  S2: AnsiString;
begin
  S1 := SelectedText;
  S2 := UTF8Encode(Format(S,[S1]));
  Sci_Send(SCI_REPLACESEL, 0, LPARAM(nppPChar(S2)));
end;

function TNppPlugin.SelectedText: AnsiString;
var Size: NativeInt;
    S: AnsiString;
begin
  Result := '';
  Size := Sci_Send(SCI_GETSELTEXT, 0, 0);
  if Size>0 then
  begin
    SetLength(S,Size);
    try
      Sci_Send(SCI_GETSELTEXT, 0, LPARAM(nppPChar(S)));
      if not HasV5Apis then
        SetLength(S,Size-1);
      Result := UTF8Decode(S);
    finally
      SetLength(S,0);
    end;
  end;
end;

function TNppPlugin.GetText: AnsiString;
var Size: NativeInt;
    S: AnsiString;
begin
  Result := '';
  Size := GetTextLength;
  if not HasV5Apis then
    Inc(Size);
  if Size>0 then
  begin
    SetLength(S,Size);
    try
      Sci_Send(SCI_GETTEXT, Size, LPARAM(PAnsiChar(S)));
      Result := UTF8Decode(S);
    finally
      SetLength(S,0);
    end;
  end;
end;

function TNppPlugin.CurrentLine: LRESULT;
var
  iPos: Integer;
begin
  iPos := CurrentPos;
  Result := Sci_Send(SCI_LINEFROMPOSITION, WPARAM(iPos), 0);
end;

function TNppPlugin.CurrentPos: LRESULT;
begin
  Result := Sci_Send(SCI_GETCURRENTPOS, 0, 0);
end;

function TNppPlugin.GetTextLength: Integer;
begin
  Result := Sci_Send(SCI_GETLENGTH, 0, 0);
end;

function TNppPlugin.GetLineCount: Integer;
begin
  Result := Sci_Send(SCI_GETLINECOUNT, 0, 0);
end;

procedure TNppPlugin.SetInfo(NppData: TNppData);
begin
  self.NppData := NppData;
  Application.Handle := NppData.NppHandle;
  RegisterWindowProcedure;
end;

// utils

function TNppPlugin.GetWord: string;
var
  s: nppString;
begin
  SetLength(s, MAX_PATH);
  Npp_Send(NPPM_GETCURRENTWORD,0,LPARAM(nppPChar(s)));
  Result := CharToString(s);
end;

function TNppPlugin.GetNppVersion: Cardinal;
var
  NppVersion: Cardinal;
begin
  NppVersion := Npp_Send(NPPM_GETNPPVERSION, 0, 0);
  // retrieve the zero-padded version, if available
  // https://github.com/notepad-plus-plus/notepad-plus-plus/commit/ef609c896f209ecffd8130c3e3327ca8a8157e72
  if ((HIWORD(NppVersion) > 8) or
      ((HIWORD(NppVersion) = 8) and
        (((LOWORD(NppVersion) >= 41) and (not (LOWORD(NppVersion) in [191, 192, 193]))) or
          (LOWORD(NppVersion) in [5, 6, 7, 8, 9])))) then
    NppVersion := Npp_Send(NPPM_GETNPPVERSION, 1, 0);

  Result := NppVersion;
end;

function TNppPlugin.HasV5Apis: Boolean;
var
  NppVersion: Cardinal;
begin
  NppVersion := GetNppVersion;
  Result :=
    (HIWORD(NppVersion) > 8) or
    ((HIWORD(NppVersion) = 8) and
        ((LOWORD(NppVersion) >= 4) and
           (not (LOWORD(NppVersion) in [11, 12, 13, 14, 15, 16, 17, 18, 19, 21, 31, 32, 33, 191, 192, 193]))));
end;

function TNppPlugin.CheckDocStatus: string;
begin
  Npp_Send(NPPM_CHECKDOCSTATUS,1,0);
  Result := '';
end;

function TNppPlugin.DoOpen(filename: string): boolean;
var
  c: array[0..MAX_PATH] of nppChar;
begin
{$IFDEF NPPUNICODE}
  StringToWideChar(filename,c,MAX_PATH);
{$ELSE}
  StrCopy(c, PChar(filename));
{$ENDIF}
  Npp_Send(WM_DOOPEN, 0, LPARAM(nppPChar(@c)));
  Result := True;
end;

function TNppPlugin.DoOpen(filename: string; Line: Integer): boolean;
var
  r: boolean;
begin
  r := self.DoOpen(filename);
  if r then
    Sci_Send(SciSupport.SCI_GOTOLINE, Line,0);
  Result := r;
end;

// overrides
procedure TNppPlugin.DoNppnShutdown;
begin
  //do nothing for this plugin
end;

procedure TNppPlugin.DoNppnToolbarModification;
begin
  //do nothing for this plugin
end;

function TNppPlugin.CmdIdFromDlgId(DlgId: Integer): Integer;
begin
  Result := self.FuncArray[DlgId].CmdId;
end;

procedure TNppPlugin.DoNppnModified(sn: PSCNotification);
begin
  //do nothing for this plugin
end;

procedure TNppPlugin.DoNppnFileOpened(sn: PSCNotification);
begin
  //do nothing for this plugin
end;

procedure TNppPlugin.DoNppnUpdateContent;
begin
  //do nothing for this plugin
end;

procedure TNppPlugin.DoNppnUpdateSelection;
begin
  //do nothing for this plugin
end;

procedure TNppPlugin.DoNppnUpdateHScroll;
begin
  //do nothing for this plugin
end;

procedure TNppPlugin.DoNppnUpdateVScroll;
begin
  //do nothing for this plugin
end;

procedure TNppPlugin.DoChangePluginTheme;
begin
  //do nothing for this plugin
end;

procedure TNppPlugin.DoNppnCharAdded(const ASCIIKey: Integer);
begin
  //do nothing for this plugin
end;

procedure TNppPlugin.SaveCurrentFile;
begin
  Npp_Send(NPPM_SAVECURRENTFILE,0,0);
end;

function TNppPlugin.ScintillaHandle: HWND;
  function GetCurrentView: Integer;
  begin
    Result := Npp_Send(NPPM_GETCURRENTVIEW,0,0);
  end;

begin
  if GetCurrentView = MAIN_VIEW then {Returns 0 when primary view is active, and 1 instead if secondary view is.}
    Result := self.NppData.ScintillaMainHandle
  else
    Result := self.NppData.ScintillaSecondHandle;
end;

function TNppPlugin.RegisterAsDialog(WindowHandle: HWND): Integer;
begin
  Result := Npp_Send(NPPM_MODELESSDIALOG, MODELESSDIALOGADD, WindowHandle);
end;

function TNppPlugin.UnRegisterAsDialog(WindowHandle: HWND): Integer;
begin
  Result := Npp_Send(NPPM_MODELESSDIALOG, MODELESSDIALOGREMOVE, WindowHandle);
end;

procedure TNppPlugin.ClientWndProcMainView(var Message: TMessage);
begin
  with Message do
  begin
    Result := CallWindowProc(TFNWndProc(FMainViewDefClientProc), NppData.ScintillaMainHandle, Msg, wParam, lParam);
    ClientWndProc(Message);
  end;
end;

procedure TNppPlugin.ClientWndProcSubView(var Message: TMessage);
begin
  with Message do
  begin
    Result := CallWindowProc(TFNWndProc(FSubViewDefClientProc), NppData.ScintillaSecondHandle, Msg, wParam, lParam);
    ClientWndProc(Message);
  end;
end;

procedure TNppPlugin.RegisterWindowProcedure;
var
  AHandle: THandle;
begin
  AHandle := self.NppData.ScintillaMainHandle;
  if AHandle <> 0 then
  begin
    FMainViewClientInstance := LONG_PTR(Classes.MakeObjectInstance(ClientWndProcMainView));
    FMainViewDefClientProc := GetWindowLong(AHandle,GWL_WNDPROC);
    SetWindowLongPtr(AHandle, GWLP_WNDPROC, FMainViewClientInstance);
  end;

  AHandle := self.NppData.ScintillaSecondHandle;
  if AHandle <> 0 then
  begin
    FSubViewClientInstance := LONG_PTR(Classes.MakeObjectInstance(ClientWndProcSubView));
    FSubViewDefClientProc := GetWindowLong(AHandle,GWL_WNDPROC);
    SetWindowLongPtr(AHandle, GWLP_WNDPROC, FSubViewClientInstance);
  end;
end;


procedure TNppPlugin.UnRegisterWindowProcedure;
var
  AHandle: THandle;
begin
  AHandle := self.NppData.ScintillaMainHandle;
  if AHandle <> 0 then
  begin
    SetWindowLongPtr(AHandle, GWLP_WNDPROC, FMainViewDefClientProc);
  end;

  AHandle := self.NppData.ScintillaSecondHandle;
  if AHandle <> 0 then
  begin
    SetWindowLongPtr(AHandle, GWLP_WNDPROC, FSubViewDefClientProc);
  end;
end;

procedure TNppPlugin.ClientWndProc(var Message: TMessage);
begin
  //do nothing for this plugin
end;

procedure TNppPlugin.DoNppnUpdateAutoSelection(P: PAnsiChar);
begin
  //do nothing for this plugin
end;

end.
