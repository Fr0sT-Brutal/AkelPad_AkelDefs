(*************************************************************************

=========  AkelPad text editor plugin API ===========
=========    Akel API version : 2.0.0.2   ===========

** Origin: AkelDLL.h located at
   http://akelpad.cvs.sourceforge.net/viewvc/akelpad/akelpad_4/AkelFiles/Plugs/AkelDLL/AkelDLL.h
** Converted with C to Pascal Converter 2.0
** Release: 2.20.11.2011
** Email: al_gun@ncable.net.au
** Updates: http://cc.codegear.com/Author/302259
** Blogs: http://delphiprogrammingwithalgun.blogspot.com/
** Copyright (c) 2005, 2011 Ural Gunaydin (a.k.a. Al Gun)

===========           Edited by Fr0sT           ===========
= Tested on RAD Studio XE2 but compiles on D7 and should =
= work on other versions also.                            =
= All RegExp defines were excluded (they are in separate file RegExpFunc.h now)

**************************************************************************)

unit AkelDLL;

interface

uses
  Windows, Messages;

//// Version
function MakeIdentifier(a, b, c, d: ShortInt): DWORD;
function AkelDLLVer: DWORD;

const AkelDLLVerArr: array[1..4] of Byte = (2, 0, 0, 2);

$$$ DEFINES1 $$$

////
type
  PHWND = ^HWND;
  // Fr0sT: these WinAPI types aren't defined in RTL until D2009 (?)
  {$IF CompilerVersion < 20}
    INT_PTR = Integer;
    LONG_PTR = Integer;
    UINT_PTR = Cardinal;
    ULONG_PTR = LongWord;
    DWORD_PTR = ULONG_PTR;
    HANDLE_PTR = type LongWord;
  {$IFEND}

//// Structures

type
  PHSTACK = ^THSTACK;
  _HSTACK = record
    first: INT_PTR;
    last: INT_PTR;
  end;
  THSTACK = _HSTACK;

type
  PAELINEDATA = ^TAELINEDATA;
  _AELINEDATA = record
    next: PAELINEDATA;          //Pointer to the next AELINEDATA structure.
    prev: PAELINEDATA;          //Pointer to the previous AELINEDATA structure.
    wpLine: PWideChar;          //Text of the line, terminated with NULL character.
    nLineLen: Integer;          //Length of the wpLine, not including the terminating NULL character.
    nLineBreak: BYTE;           //New line: AELB_EOF, AELB_R, AELB_N, AELB_RN, AELB_RRN or AELB_WRAP.
    nLineFlags: BYTE;           //Reserved.
    nReserved: WORD;            //Reserved.
    nLineWidth: Integer;        //Width of the line in pixels.
    nSelStart: Integer;         //Selection start character position in line.
    nSelEnd: Integer;           //Selection end character position in line.
  end;
  TAELINEDATA = _AELINEDATA;


type
  _AELINEINDEX = record
    nLine: Integer;
    lpLine: PAELINEDATA;
  end;
  TAELINEINDEX = _AELINEINDEX;

type
  PAECHARINDEX = ^TAECHARINDEX;
  _AECHARINDEX = record
    nLine: Integer;
    lpLine: PAELINEDATA;
    nCharInLine: Integer;
  end;
  TAECHARINDEX = _AECHARINDEX;

  PAECHARRANGE = ^TAECHARRANGE;
  _AECHARRANGE = record
    ciMin : TAECHARINDEX;
    ciMax : TAECHARINDEX;
  end;
  TAECHARRANGE = _AECHARRANGE;

  _AECOLORS = record
    dwFlags : DWORD;
    crCaret : TCOLORREF;
    crBasicText : TCOLORREF;
    crBasicBk : TCOLORREF;
    crSelText : TCOLORREF;
    crSelBk : TCOLORREF;
    crActiveLineText : TCOLORREF;
    crActiveLineBk : TCOLORREF;
    crUrlText : TCOLORREF;
    crActiveColumn : TCOLORREF;
    crColumnMarker : TCOLORREF;
    crUrlCursorText : TCOLORREF;
    crUrlVisitText : TCOLORREF;
    crActiveLineBorder : TCOLORREF;
    crAltLineText : TCOLORREF;
    crAltLineBk : TCOLORREF;
    crAltLineBorder : TCOLORREF;
  end;
  TAECOLORS = _AECOLORS;

type
  AEHDOC = THandle;

type
  // hDoc        Document handle returned by AEM_GETDOCUMENT or AEM_CREATEDOCUMENT.
  // uMsg        Message ID for example EM_SETSEL.
  // lParam      Additional parameter.
  // wParam      Additional parameter.
  //
  // Return Value
  //   Depends on message.
  TAEEditProc = function (hDoc: AEHDOC; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
  TWndProc = function (hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;

type
  HINIFILE = THandle;
type
  HINISECTION = THandle;
type
  HINIKEY = THandle;

type
  TPluginProc = function(): BOOL; stdcall;
  TWndProcRet = procedure(lpWNDProcRet: PCWPRETSTRUCT); stdcall;


type
  _EDITINFO = record
    hWndEdit: HWND;           //Edit window.
    hDocEdit: AEHDOC;         //Edit document.
    pFile: PBYTE;             //Current editing cFile.
    szFile: PAnsiChar;        //Current editing cFile (Ansi).
    wszFile: PWideChar;       //Current editing cFile (Unicode).
    nCodePage: Integer;       //Current code page.
    bBOM: BOOL;               //Current BOM.
    nNewLine: Integer;        //Current new line format, see NEWLINE_* defines.
    bModified: BOOL;          //File has been modified.
    bReadOnly: BOOL;          //Read only.
    bWordWrap: BOOL;          //Word wrap.
    bOvertypeMode: BOOL;      //Overtype mode.
    hWndMaster: HWND;         //Master window.
    hDocMaster: AEHDOC;       //Master document.
    hWndClone1: HWND;         //First clone window.
    hDocClone1: AEHDOC;       //First clone document.
    hWndClone2: HWND;         //Second clone window.
    hDocClone2: AEHDOC;       //Second clone document.
    hWndClone3: HWND;         //Third clone window.
    hDocClone3: AEHDOC;       //Third clone document.
  end;
  TEDITINFO = _EDITINFO;


type
  PRECENTCARETITEM = ^TRECENTCARETITEM;
  _RECENTCARETITEM = record
    next: PRECENTCARETITEM;
    prev: PRECENTCARETITEM;
    nCaretOffset: INT_PTR;
  end;
  TRECENTCARETITEM = _RECENTCARETITEM;


type
  _STACKRECENTCARET = record
    first: PRECENTCARETITEM;
    last: PRECENTCARETITEM;
  end;
  TSTACKRECENTCARET = _STACKRECENTCARET;


type
  PFRAMEDATA = ^TFRAMEDATA;
  _FRAMEDATA = record
    next: PFRAMEDATA;
    prev: PFRAMEDATA;
    //Edit state external
    hWndEditParent : HWND;                                 //Edit parent window.
    ei : TEDITINFO;                                        //Edit info.
    szFile : array[0..MAX_PATH-1] of AnsiChar;             //Frame cFile (Ansi).
    wszFile : array[0..MAX_PATH-1] of WideChar;            //Frame cFile (Unicode).
    nFileLen : Integer;                                    //Frame cFile length.
    nStreamOffset: Integer;                                //":" symbol offset in FRAMEDATA.wszFile.
    hIcon : HICON;                                         //Frame icon.
    nIconIndex : Integer;                                  //Frame ImageList icon index.
    rcEditWindow : TRECT;                                  //Edit TRect. rcEditWindow.right - is width and rcEditWindow.bottom is height.
    rcMasterWindow : TRECT;                                //Master window TRect. rcMasterWindow.right - is width and rcMasterWindow.bottom is height.
    //Edit settings (AkelPad)
    dwLockInherit: DWORD;                                  //See LI_* defines.
    lf : LOGFONTW;                                         //Edit font.
    bTabStopAsSpaces : BOOL;                               //Insert tab stop as spaces.
    dwCaretOptions : DWORD;                                //See CO_* defines.
    dwMouseOptions : DWORD;                                //See MO_* defines.
    nClickURL : Integer;                                   //Number of clicks to open URL.
    bUrlPrefixesEnable : BOOL;                             //URL prefixes enable.
    bUrlDelimitersEnable : BOOL;                           //URL delimiters enable.
    bWordDelimitersEnable : BOOL;                          //Word delimiters enabled.
    bWrapDelimitersEnable : BOOL;                          //Wrap delimiters enabled.
    dwMappedPrintWidth : DWORD;                            //Mapped print page width.
    //Edit settings (AkelPad)
    rcEditMargins : TRECT;                                 //Edit margins.
    nTabStopSize : Integer;                                //Tab stop size.
    nUndoLimit : Integer;                                  //Undo limit.
    bDetailedUndo : BOOL;                                  //Detailed undo.
    dwWrapType : DWORD;                                    //Wrap cType AEWW_WORD or AEWW_SYMBOL.
    dwWrapLimit : DWORD;                                   //Wrap characters limit, zero if wrap by window edge.
    dwMarker : DWORD;                                      //Vertical marker, zero if no marker set.
    nCaretWidth : Integer;                                 //Caret width.
    dwAltLineFill : DWORD;                                 //Alternating lines fill interval.
    dwAltLineSkip : DWORD;                                 //Alternating lines skip interval.
    bAltLineBorder : BOOL;                                 //Draw alternating lines border.
    dwLineGap : DWORD;                                     //Line gap.
    bShowURL : BOOL;                                       //Show URL.
    wszUrlPrefixes : array[0..URL_PREFIXES_SIZE-1] of WideChar;          //URL prefixes.
    wszUrlLeftDelimiters : array[0..URL_DELIMITERS_SIZE-1] of WideChar;  //URL left delimiters.
    wszUrlRightDelimiters : array[0..URL_DELIMITERS_SIZE-1] of WideChar; //URL right delimiters.
    wszWordDelimiters : array[0..WORD_DELIMITERS_SIZE-1] of WideChar;    //Word delimiters.
    wszWrapDelimiters : array[0..WRAP_DELIMITERS_SIZE-1] of WideChar;    //Wrap delimiters.
    wszBkImageFile: array[0..MAX_PATH-1] of WideChar;                   //Background image file.
    nBkImageAlpha: Integer;                                  //Alpha transparency value that ranges from 0 to 255.
    hBkImageBitmap: HBITMAP;                             //Background image handle.
    aec : TAECOLORS;                                        //Edit colors.
    //Edit state internal. AKD_FRAMEINIT not copy data below.
    lpEditProc : TAEEditProc;                              //Edit window procedure.
    ft : FILETIME;                                         //cFile time.
    dwInputLocale : HKL;                                   //Keyboard layout.
    hRecentCaretStack: TSTACKRECENTCARET;                 //Recent caret stack.
    lpCurRecentCaret: PRECENTCARETITEM;                  //Current recent caret position.
    //Find/Replace
    nCompileErrorOffset: INT_PTR;                        //Contain pattern offset, if error occurred during compile pattern.
    bCompileErrorReplace: BOOL;                          //TRUE - error in "ReplaceWith" complitaion, FALSE - error in "FindIt" complitaion.
  
    //Statusbar
    crPrevSel : TAECHARRANGE;
    nSelSubtract : INT_PTR;
    nCaretRichOffset : INT_PTR;
    nCaretByteOffset : INT_PTR;
    nCaretChar : Integer;
    nCaretLine: Integer;
    nCaretColumn: Integer;
    nLineCountAll: Integer;
    nLineCountSel: Integer;
    nLineSelBegin: Integer;
    nLineSelEnd: Integer;
    nRichCount : INT_PTR;
    nFontPoint : Integer;
    bCapsLock : BOOL;
    bNumLock : BOOL;
    bReachedEOF : BOOL;
    nReplaceCount : INT_PTR;
  end;
  TFRAMEDATA = _FRAMEDATA;

type
  _PLUGINVERSION = record
    cb: DWORD;                   //Size of the structure.
    hMainWnd: HWND;              //Main window.
    dwAkelDllVersion: DWORD;     //Current AkelDLL version. Set it to AKELDLL.
    dwExeMinVersion3x: DWORD;    //Required minimum AkelPad 3.x version.
    dwExeMinVersion4x: DWORD;    //Required minimum AkelPad 4.x version.
    pPluginName: PAnsiChar;      //Plugin unique name.
  end;
  TPLUGINVERSION = _PLUGINVERSION;


type
  PPLUGINFUNCTION = ^TPLUGINFUNCTION;
  _PLUGINFUNCTION = record
    next: PPLUGINFUNCTION;
    prev: PPLUGINFUNCTION;
    pFunction: PBYTE;               //Function name, format "Plugin::Function".
                                    //  const char *pFunction      if bOldWindows == TRUE
                                    //  const wchar_t *pFunction   if bOldWindows == FALSE
    szFunction : array[0..MAX_PATH-1] of AnsiChar;      //cFunction name (Ansi).
    wszFunction : array[0..MAX_PATH-1] of WideChar;     //cFunction name (Unicode).
    nFunctionLen: Integer;          //Function name length.
    wHotkey: WORD;                  //Function hotkey. See HKM_GETHOTKEY message return value (MSDN).
    bAutoLoad: BOOL;                //TRUE  if function has autoload flag.
                                    //FALSE if function has no autoload flag.
    bRunning: BOOL;                 //Function is running.
    PluginProc: TPLUGINPROC;        //Function procedure.
    lpParameter: Pointer;           //Procedure parameter.
    nRefCount: Integer;             //Internal.
  end;
  TPLUGINFUNCTION = _PLUGINFUNCTION;


type
  _PLUGINDATA = record
    cb: DWORD;                         //Size of the structure.
    dwSupport: DWORD;                  //If (dwSupport & PDS_GETSUPPORT) != 0, then caller wants to get PDS_* flags without function execution.
    pFunction: PBYTE;                  //Called cFunction name, format "Plugin::cFunction".
                                       //  const char *pFunction     if bOldWindows == TRUE
                                       //  const wchar_t *pFunction  if bOldWindows == FALSE
    szFunction: PAnsiChar;             //Called cFunction name (Ansi).
    wszFunction: PWideChar;            //Called cFunction name (Unicode).
    hInstanceDLL: HINST;               //DLL instance.
    lpPluginFunction: PPLUGINFUNCTION; //Pointer to a PLUGINFUNCTION structure.
    nUnload: Integer;                  //See UD_* defines.
    bInMemory: BOOL;                   //Plugin already loaded.
    bOnStart: BOOL;                    //Indicates when function has been called:
                                       //  TRUE  if function called on start-up.
                                       //  FALSE if function called manually.
    lParam: LPARAM;                    //Input data.
    pAkelDir: PBYTE;                   //AkelPad directory.
                                       //  const char *pAkelDir      if bOldWindows == TRUE
                                       //  const wchar_t *pAkelDir   if bOldWindows == FALSE
    szAkelDir: PAnsiChar;              //AkelPad directory (Ansi).
    wszAkelDir: PWideChar;             //AkelPad directory (Unicode).
    hInstanceEXE: HINST;               //EXE instance.
    hPluginsStack: PHSTACK;            //Pointer to a plugins stack with PLUGINFUNCTION elements.
    nSaveSettings: Integer;            //See SS_* defines.
    hMainWnd: HWND;                    //Main window.
    lpFrameData: PFRAMEDATA;           //Pointer to a current FRAMEDATA structure.
    hWndEdit: HWND;                    //Edit window.
    hDocEdit: AEHDOC;                  //Edit document.
    hStatus: HWND;                     //StatusBar window.
    hMdiClient: HWND;                  //MDI client window (if nMDI == WMD_MDI).
    hTab: HWND;                        //Tab window        (if nMDI == WMD_MDI || nMDI == WMD_PMDI).
    hMainMenu: HMENU;                  //Main menu.
    hMenuRecentFiles: HMENU;           //Recent files menu.
    hMenuLanguage: HMENU;              //Language menu.
    hPopupMenu: HMENU;                 //Right click menu.
    hMainIcon: HICON;                  //Main window icon handle.
    hGlobalAccel: HACCEL;              //Global accelerator table (highest priority).
    hMainAccel: HACCEL;                //Main accelerator table (lowest priority).
    bOldWindows: BOOL;                 //Non-Unicode Windows.
    bOldRichEdit: BOOL;                //Riched20.dll lower then 5.30 (v3.0).
    bOldComctl32: BOOL;                //Comctl32.dll lower then 4.71.
    bAkelEdit: BOOL;                   //AkelEdit control is used.
    nMDI: Integer;                     //Window mode, see WMD_* defines.
    pLangModule: PBYTE;                //Language module.
                                       //  const char *pLangModule      if bOldWindows == TRUE
                                       //  const wchar_t *pLangModule   if bOldWindows == FALSE
    szLangModule: PAnsiChar;           //Language module (Ansi).
    wszLangModule: PWideChar;          //Language module (Unicode).
    wLangSystem: LANGID;               //System language ID.
    wLangModule: LANGID;               //Language module language ID.
  end;
  TPLUGINDATA = _PLUGINDATA;


type
  _UNISTRING = record
    pString: PBYTE;         //Depend on Windows. Win9x or WinNT.
    szString: PAnsiChar;    //Ansi cString.
    wszString: PWideChar;   //Unicode cString.
  end;
  TUNISTRING = _UNISTRING;


type
  _DETECTANSITEXT = record
    dwLangID: DWORD;         //Codepage recognition language defined as LANGID. If -1, then use current settings.
    pText: PAnsiChar;        //Ansi text.
    nTextLen: INT_PTR;       //Text length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
    nMinChars: INT_PTR;      //Minimum detect characters representation. If zero, default number is used.
    nCodePage: Integer;      //Result: detected Ansi codepage.
  end;
  TDETECTANSITEXT = _DETECTANSITEXT;


type
  _DETECTUNITEXT = record
    dwLangID: DWORD;         //Codepage recognition language defined as LANGID. If -1, then use current settings.
    wpText: PWideChar;       //Unicode text.
    nTextLen: INT_PTR;       //Text length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
    nMinChars: INT_PTR;      //Minimum detect characters representation. If zero, default number is used.
    nCodePageFrom: Integer;  //Result: codepage that converts text to Ansi without character lost.
    nCodePageTo: Integer;    //Result: detected Ansi codepage.
  end;
  TDETECTUNITEXT = _DETECTUNITEXT;


type
  _CONVERTANSITEXT = record
    pInput: PAnsiChar;       //Ansi text.
    nInputLen: INT_PTR;      //Text length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
    nCodePageFrom: Integer;  //Codepage for Ansi to Unicode conversion.
    nCodePageTo: Integer;    //Codepage for Unicode to Ansi conversion.
    szOutput: PAnsiChar;     //Result: pointer that receive allocated text. Must be deallocated with AKD_FREETEXT message.
    nOutputLen: INT_PTR;     //Result: text length.
  end;
  TCONVERTANSITEXT = _CONVERTANSITEXT;


type
  _CONVERTUNITEXT = record
    wpInput: PWideChar;      //Unicode text.
    nInputLen: INT_PTR;      //Text length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
    nCodePageFrom: Integer;  //Codepage for Unicode to Ansi conversion.
    nCodePageTo: Integer;    //Codepage for Ansi to Unicode conversion.
    wszOutput: PWideChar;    //Result: pointer that receive allocated text. Must be deallocated with AKD_FREETEXT message.
    nOutputLen: INT_PTR;     //Result: text length.
  end;
  TCONVERTUNITEXT = _CONVERTUNITEXT;


type
  _DETECTFILEA = record
    pFile: PAnsiChar;       //cFile to detect.
    dwBytesToCheck: DWORD;  //How many bytes will be checked.
    dwFlags: DWORD;         //See ADT_* defines.
    nCodePage: Integer;     //Detected codepage.
    bBOM: BOOL;             //Detected BOM.
  end;
  TDETECTFILEA = _DETECTFILEA;


type
  _DETECTFILEW = record
    pFile: PWideChar;       //cFile to detect.
    dwBytesToCheck: DWORD;  //How many bytes will be checked.
    dwFlags: DWORD;         //See ADT_* defines.
    nCodePage: Integer;     //Detected codepage.
    bBOM: BOOL;             //Detected BOM.
  end;
  TDETECTFILEW = _DETECTFILEW;


type
  _FILECONTENT = record
    hFile: THandle;         //cFile handle, returned by CreateFile function.
    dwMax: UINT_PTR;        //AKD_READFILECONTENT: maximum bytes to read, if -1 read entire file.
                            //AKD_WRITEFILECONTENT: wpContent length in characters. If this value is -1, the wpContent is assumed to be null-terminated and the length is calculated automatically.
    nCodePage: Integer;     //File codepage.
    bBOM: BOOL;             //File BOM.
    wpContent: PWideChar;   //AKD_READFILECONTENT: returned file contents.
                            //AKD_WRITEFILECONTENT: text to save.
  end;
  TFILECONTENT = _FILECONTENT;


type
  _OPENDOCUMENTA = record
    pFile: PAnsiChar;       //cFile to open.
    pWorkDir: PAnsiChar;    //Set working directory before open, if NULL then don't set.
    dwFlags: DWORD;         //Open flags. See OD_* defines.
    nCodePage: Integer;     //File code page, ignored if (dwFlags & OD_ADT_DETECT_CODEPAGE).
    bBOM: BOOL;             //File BOM, ignored if (dwFlags & OD_ADT_DETECT_BOM).
  end;
  TOPENDOCUMENTA = _OPENDOCUMENTA;


type
  _OPENDOCUMENTW = record
    pFile: PWideChar;       //cFile to open.
    pWorkDir: PWideChar;    //Set working directory before open, if NULL then don't set.
    dwFlags: DWORD;         //Open flags. See OD_* defines.
    nCodePage: Integer;     //File code page, ignored if (dwFlags & OD_ADT_DETECT_CODEPAGE).
    bBOM: BOOL;             //File BOM, ignored if (dwFlags & OD_ADT_DETECT_BOM).
  end;
  TOPENDOCUMENTW = _OPENDOCUMENTW;


type
  _OPENDOCUMENTPOSTA = record
    hWnd: HWND;             //Window to fill in, NULL for current edit window.
    dwFlags: DWORD;         //Open flags. See OD_* defines.
    nCodePage: Integer;     //File code page, ignored if (dwFlags & OD_ADT_DETECT_CODEPAGE).
    bBOM: BOOL;             //File BOM, ignored if (dwFlags & OD_ADT_DETECT_BOM).
    szFile : array[0..MAX_PATH-1] of AnsiChar;     //cFile to open.
    szWorkDir : array[0..MAX_PATH-1] of AnsiChar;  //Set working directory before open;
  end;
  TOPENDOCUMENTPOSTA = _OPENDOCUMENTPOSTA;


type
  _OPENDOCUMENTPOSTW = record
    hWnd: HWND;             //Window to fill in, NULL for current edit window.
    dwFlags: DWORD;         //Open flags. See OD_* defines.
    nCodePage: Integer;     //File code page, ignored if (dwFlags & OD_ADT_DETECT_CODEPAGE).
    bBOM: BOOL;             //File BOM, ignored if (dwFlags & OD_ADT_DETECT_BOM).
    szFile : array[0..MAX_PATH-1] of  WideChar;     //cFile to open.
    szWorkDir : array[0..MAX_PATH-1] of  WideChar;  //Set working directory before open;
  end;
  TOPENDOCUMENTPOSTW = _OPENDOCUMENTPOSTW;


type
  _SAVEDOCUMENTA = record
    pFile: PAnsiChar;       //cFile to save.
    nCodePage: Integer;     //File code page.
    bBOM: BOOL;             //File BOM.
    dwFlags: DWORD;         //See SD_* defines.
  end;
  TSAVEDOCUMENTA = _SAVEDOCUMENTA;


type
  _SAVEDOCUMENTW = record
    pFile: PWideChar;       //cFile to save.
    nCodePage: Integer;     //File code page.
    bBOM: BOOL;             //File BOM.
    dwFlags: DWORD;         //See SD_* defines.
  end;
  TSAVEDOCUMENTW = _SAVEDOCUMENTW;


//AKD_SETFRAMEINFO
type
  _FRAMEINFO = record
    nType: Integer;        //See FIS_* defines.
    dwData: UINT_PTR;  //Depend on FIS_* define.
  end;
  TFRAMEINFO = _FRAMEINFO;


type
  _BKIMAGE = record
    wpFile: PWideChar; //Background image file.
    nAlpha: Integer;   //Alpha transparency value that ranges from 0 to 255.
  end;
  TBKIMAGE = _BKIMAGE;


type
  PWNDPROCDATA = ^TWNDPROCDATA;
  _WNDPROCDATA = record
    next: PWNDPROCDATA;
    prev: PWNDPROCDATA;
    CurProc  : TWndProc;
    NextProc : TWndProc;
    PrevProc : TWndProc;
  end;
  TWNDPROCDATA = _WNDPROCDATA;


type
  PWNDPROCRETDATA = ^TWNDPROCRETDATA;
  _WNDPROCRETDATA = record
    next: PWNDPROCRETDATA;
    prev: PWNDPROCRETDATA;
    CurProc  : TWndProcRet;
    NextProc : TWndProcRet;
    PrevProc : TWndProcRet;
  end;
  TWNDPROCRETDATA = _WNDPROCRETDATA;


type
  _PLUGINADDA = record
    pFunction: PAnsiChar;      //cFunction name, format "Plugin::cFunction".
    wHotkey: WORD;               //Function hotkey. See HKM_GETHOTKEY message return value (MSDN).
    bAutoLoad: BOOL;             //TRUE  if function has autoload flag.
    PluginProc: TPluginProc;      //Function procedure.
    lpParameter: Pointer;          //Procedure parameter.
  end;
  TPLUGINADDA = _PLUGINADDA;


type
  _PLUGINADDW = record
    pFunction: PWideChar;   //cFunction name, format "Plugin::cFunction".
    wHotkey: WORD;               //Function hotkey. See HKM_GETHOTKEY message return value (MSDN).
    bAutoLoad: BOOL;             //TRUE  if function has autoload flag.
    PluginProc: TPLUGINPROC;      //Function procedure.
    lpParameter: Pointer;          //Procedure parameter.
  end;
  TPLUGINADDW = _PLUGINADDW;


type
  _PLUGINCALLSENDA = record
    pFunction: PAnsiChar;      //cFunction name, format "Plugin::cFunction".
    lParam: LPARAM;              //Input data.
    dwSupport: DWORD;            //See PDS_* defines.
  end;
  TPLUGINCALLSENDA = _PLUGINCALLSENDA;


type
  _PLUGINCALLSENDW = record
    pFunction: PWideChar;   //cFunction name, format L"Plugin::cFunction".
    lParam: LPARAM;              //Input data.
    dwSupport: DWORD;            //See PDS_* defines.
  end;
  TPLUGINCALLSENDW = _PLUGINCALLSENDW;


type
  _PLUGINCALLPOSTA = record
    lParam: LPARAM;              //Input data.
    szFunction : array[0..MAX_PATH-1] of AnsiChar;  //cFunction name;
    dwSupport: DWORD;            //See PDS_* defines.
  end;
  TPLUGINCALLPOSTA = _PLUGINCALLPOSTA;


type
  _PLUGINCALLPOSTW = record
    lParam: LPARAM;                  //Input data.
    szFunction : array[0..MAX_PATH-1] of  WideChar;   //cFunction name;
    dwSupport: DWORD;            //See PDS_* defines.
  end;
  TPLUGINCALLPOSTW = _PLUGINCALLPOSTW;


type
  _PLUGINOPTIONA = record
    pOptionName: PAnsiChar;       //Option name.
    dwType: DWORD;                  //Data cType: see PO_* defines.
    lpData: PBYTE;                  //Data pointer. If NULL, AKD_OPTION returns required buffer size in bytes.
    dwData: DWORD;                  //Data size in bytes.
  end;
  TPLUGINOPTIONA = _PLUGINOPTIONA;


type
  _PLUGINOPTIONW = record
    pOptionName: PWideChar;    //Option name.
    dwType: DWORD;                  //Data cType: see PO_* defines.
    lpData: PBYTE;                  //Data pointer. If NULL, AKD_OPTION returns required buffer size in bytes.
    dwData: DWORD;                  //Data size in bytes.
  end;
  TPLUGINOPTIONW = _PLUGINOPTIONW;


type
  _INIVALUEA = record
    pSection: PAnsiChar;          //Section name.
    pKey: PAnsiChar;              //Key name.
    dwType: DWORD;                  //Data cType: see INI_* defines.
    lpData: PBYTE;                  //Data pointer. If NULL, AKD_INIGETVALUE returns required buffer size in bytes.
    dwData: DWORD;                  //Data size in bytes.
  end;
  TINIVALUEA = _INIVALUEA;


type
  _INIVALUEW = record
    pSection: PWideChar;       //Section name.
    pKey: PWideChar;           //Key name.
    dwType: DWORD;                  //Data cType: see INI_* defines.
    lpData: PBYTE;                  //Data pointer. If NULL, AKD_INIGETVALUE returns required buffer size in bytes.
    dwData: DWORD;                  //Data size in bytes.
  end;
  TINIVALUEW = _INIVALUEW;


type
  PINIKEY = ^TINIKEY;
  _INIKEY = record
    next: PINIKEY;
    prev: PINIKEY;
    wszKey: PWideChar;
    nKeyBytes: Integer;
    wszString: PWideChar;
    nStringBytes: Integer;
  end;
  TINIKEY = _INIKEY;


type
  PINISECTION = ^TINISECTION;
  _INISECTION = record
    next: PINISECTION;
    prev: PINISECTION;
    hIniFile: THandle;
    wszSection: PWideChar;
    nSectionBytes: Integer;
    first: PINIKEY;
    las: PINIKEY;
  end;
  TINISECTION = _INISECTION;


type
  _INIFILE = record
    first: PINISECTION;
    last: PINISECTION;
    bModified: BOOL;
  end;
  TINIFILE = _INIFILE;


type
  _GETTEXTRANGE = record
    cpMin: INT_PTR;              //First character in the range. First char of text: 0.
    cpMax: INT_PTR;              //Last character in the range. Last char of text: -1.
    pText: PByte;       //Pointer that receive allocated text, new lines are forced to "\r". Must be deallocated with AKD_FREETEXT message.
  end;
  TGETTEXTRANGE = _GETTEXTRANGE;


type
  _EXGETTEXTRANGE = record
    cr: TAECHARRANGE;             //Characters range to retrieve.
    bColumnSel: BOOL;            //Column selection. If this value is –1, active column selection mode is used.
    pText: PByte;       //Pointer that receive allocated text.
    nNewLine: Integer;               //See AELB_* defines.
    nCodePage: Integer;              //Valid if bOldWindows == TRUE. Code page identifier (any available in the system). You can also specify one of the following values: CP_ACP - ANSI code page, CP_OEMCP - OEM code page, CP_UTF8 - UTF-8 code page.
    lpDefaultChar: PAnsiChar;  //Valid if bOldWindows == TRUE. Points to the character used if a wide character cannot be represented in the specified code page. If this member is NULL, a system default value is used.
    lpUsedDefChar: PBOOL;        //Valid if bOldWindows == TRUE. Points to a flag that indicates whether a default character was used. The flag is set to TRUE if one or more wide characters in the source string cannot be represented in the specified code page. Otherwise, the flag is set to FALSE. This member may be NULL.
  end;
  TEXGETTEXTRANGE = _EXGETTEXTRANGE;


type
  PRECENTFILE = ^TRECENTFILE;
  _RECENTFILE = record
    next: PRECENTFILE;
    prev: PRECENTFILE;
    wszFile : array[0..MAX_PATH-1] of WideChar;  //Recent cFile name.
    nFileLen: Integer;               //Recent cFile name length.
    nCodePage: Integer;              //Recent file codepages.
    cpMin: INT_PTR;              //First character in selection range.
    cpMax: INT_PTR;              //Last character in selection range.
    lpParamsStack: THSTACK;       //Additional parameters storage (RECENTFILEPARAMSTACK structure).
  end;
  TRECENTFILE = _RECENTFILE;


type
  _RECENTFILESTACK = record
    first: PRECENTFILE;          //Pointer to the first RECENTFILE structure.
    last: PRECENTFILE;           //Pointer to the last RECENTFILE structure.
    nElements: Integer;              //Items in stack.
    dwSaveTime: DWORD;           //GetTickCount() for the last recent files save operation.
  end;
  TRECENTFILESTACK = _RECENTFILESTACK;


type
  PRECENTFILEPARAM = ^TRECENTFILEPARAM;
  _RECENTFILEPARAM = record
    next: PRECENTFILEPARAM;
    prev: PRECENTFILEPARAM;
    pFile: PRECENTFILE;
    pParamName: PWideChar;
    pParamValue: PWideChar;
  end;
  TRECENTFILEPARAM = _RECENTFILEPARAM;

type
  _RECENTFILEPARAMSTACK = record
    first: PRECENTFILEPARAM;
    last: PRECENTFILEPARAM;
  end;
  TRECENTFILEPARAMSTACK = _RECENTFILEPARAMSTACK;


type
  _TEXTFINDA = record
    dwFlags: DWORD;            //See FRF_* defines.
    pFindIt: PAnsiChar;      //Find string.
    nFindItLen: Integer;           //Find string length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
  end;
  TTEXTFINDA = _TEXTFINDA;


type
  _TEXTFINDW = record
    dwFlags: DWORD;            //See FRF_* defines.
    pFindIt: PWideChar;   //Find string.
    nFindItLen: Integer;           //Find string length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
  end;
  TTEXTFINDW = _TEXTFINDW;


type
  _TEXTREPLACEA = record
    dwFlags: DWORD;               //See FRF_* defines.
    pFindIt: PAnsiChar;         //Find string.
    nFindItLen: Integer;              //Find string length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
    pReplaceWith: PAnsiChar;    //Replace string.
    nReplaceWithLen: Integer;         //Replace string length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
    bAll: BOOL;                   //Replace all.
    nChanges: INT_PTR;            //Count of changes.
  end;
  TTEXTREPLACEA = _TEXTREPLACEA;


type
  _TEXTREPLACEW = record
    dwFlags: DWORD;               //See FRF_* defines.
    pFindIt: PWideChar;      //Find string.
    nFindItLen: Integer;              //Find string length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
    pReplaceWith: PWideChar; //Replace string.
    nReplaceWithLen: Integer;         //Replace string length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
    bAll: BOOL;                   //Replace all.
    nChanges: INT_PTR;            //Count of changes.
  end;
  TTEXTREPLACEW = _TEXTREPLACEW;


type
  _TEXTRECODE = record
    nCodePageFrom: Integer;        //Source code page.
    nCodePageTo: Integer;          //Target code page.
    dwFlags: DWORD;            //See RCS_* defines.
  end;
  TTEXTRECODE = _TEXTRECODE;



type
  _CREATEWINDOWA = record
    szClassName : array[0..MAX_PATH-1] of AnsiChar;   //Window class name.
    szWindowName : array[0..MAX_PATH-1] of AnsiChar;  //Window caption.
    dwStyle: DWORD;            //Window style.
    x: Integer;                //X position.
    y: Integer;                //Y position.
    nWidth: Integer;           //X size.
    nHeight: Integer;          //Y size.
    hWndParent: HWND;          //Parent window handle.
    hMenu: HMENU;              //Window menu handle.
    hInstance: HINST;          //Program instance handle.
    lpPar: Pointer;            //Creation parameters.
  end;
  TCREATEWINDOWA = _CREATEWINDOWA;


type
  _CREATEWINDOWW = record
    szClassName : array[0..MAX_PATH-1] of  WideChar;    //Window class name.
    szWindowName : array[0..MAX_PATH-1] of  WideChar;   //Window caption.
    dwStyle: DWORD;            //Window style.
    x: Integer;                //X position.
    y: Integer;                //Y position.
    nWidth: Integer;           //X size.
    nHeight: Integer;          //Y size.
    hWndParent: HWND;          //Parent window handle.
    hMenu: HMENU;              //Window menu handle.
    hInstance: HINST;          //Program instance handle.
    lpPar: Pointer;            //Creation parameters.
  end;
  TCREATEWINDOWW = _CREATEWINDOWW;


type
  PDIALOGRESIZE = ^TDIALOGRESIZE;
  _DIALOGRESIZE = record
    lpWnd: PHWND;              //Control window.
    dwType: DWORD;             //See DRS_* defines.
    nOffset: Integer;          //Control offset, set it to zero.
  end;
  TDIALOGRESIZE = _DIALOGRESIZE;


type
  _DIALOGRESIZEMSG = record
    drs: PDIALOGRESIZE;  //Pointer to a first DIALOGRESIZE element in array.
    rcMinMax: PRect;     //Pointer to a min/max sizes. Each member is valid if not equal to zero. Can be NULL.
    rcCurrent: PRect;    //Pointer to a current rectangle. Set all members of TRect to zero at first call.
    dwFlags: DWORD;      //See DRM_* defines.
    hDlg: HWND;          //Dialog handle.
    uMsg: UINT;          //Dialog message.
    wParam: WPARAM;      //First message parameter.
    lParam: LPARAM;      //Second message parameter.
  end;
  TDIALOGRESIZEMSG = _DIALOGRESIZEMSG;


type
  PDOCK = ^TDOCK;
  _DOCK = record
    next: PDOCK;
    prev: PDOCK;
    dwFlags: DWORD;          //Dock flags: see DKF_* defines.
    hWnd: HWND;              //Dock window handle.
    nSide: Integer;              //Dock side: DKS_LEFT, DKS_TOP, DKS_RIGHT or DKS_BOTTOM.
    rcSize: TRect;            //Dock window client TRect.
    rcDragDrop: TRect;        //Drag-and-drop client TRect.
    lpOldDockProc: TWndProc;  //Procedure address before subclassing.
  end;
  TDOCK = _DOCK;


type
  _BUTTONDRAW = record
    dwFlags: DWORD;          //See BIF_* defines.
    hImage: THandle;          //Bitmap handle if BIF_BITMAP specified or icon handle if BIF_ICON specified.
    nImageWidth: Integer;        //Image width.
    nImageHeight: Integer;       //Image height.
  end;
  TBUTTONDRAW = _BUTTONDRAW;

  PBUTTONMESSAGEBOX = ^TBUTTONMESSAGEBOX;
  _BUTTONMESSAGEBOX  = record
    nButtonControlID: Integer;     //ID of the button that returned in result
    wpButtonStr: PWideChar;        //Pointer to Unicode text or ID of the string resource in current language module.
    dwFlags: DWORD;                //See BMB_* defines.
  end;
  TBUTTONMESSAGEBOX = _BUTTONMESSAGEBOX;


type
  _DIALOGMESSAGEBOX = record
    hWndParent: HWND;           //Handle to the owner window.
    wpText: PWideChar;          //Pointer to a null-terminated string that contains the message to be displayed.
    wpCaption: PWideChar;       //Pointer to a null-terminated string that contains the dialog box title.
    uType: UINT;                //Specifies the standard message box icon. See MSDN for MB_ICON* defines of the MessageBox function.
    hIcon: HICON;               //Custom icon.
    bmb: PBUTTONMESSAGEBOX;     //Array of the BUTTONMESSAGEBOX structures. Each element specified one message box button. Last item in the array should contain all zeros in members.
  end;
  TDIALOGMESSAGEBOX = _DIALOGMESSAGEBOX;


type
  _POSTMESSAGE = record
    hWnd: HWND;           //Window handle.
    uMsg: UINT;           //Specifies the message to be sent.
    wParam: WPARAM;       //Specifies additional message-specific information.
    lParam: LPARAM;       //Specifies additional message-specific information.
  end;
  TPOSTMESSAGE = _POSTMESSAGE;


type
  _PARSECMDLINESENDW = record
    pCmdLine: PWideChar; //Command line string. On return contain pointer to a unprocessed string.
    pWorkDir: PWideChar; //Command line string.
  end;
  TPARSECMDLINESENDW = _PARSECMDLINESENDW;


type
  _PARSECMDLINEPOSTW = record
    bPostMessage: BOOL;                   //FALSE for sending message (wait for return).
    szCmdLine : array[0..COMMANDLINE_SIZE-1] of WideChar; //Command line string.
    nCmdLineLen: Integer;                     //Command line length, not including the terminating null character.
    szWorkDir : array[0..MAX_PATH-1] of WideChar;         //Working directory string.
    nWorkDirLen: Integer;                     //Working directory length, not including the terminating null character.
    bQuitAsEnd: BOOL;                     //Internal variable - "/quit" stops parsing command line parameters, but not closes program.
  end;
  TPARSECMDLINEPOSTW = _PARSECMDLINEPOSTW;


type
  _PRINTINFO = record
    hDevMode: HGLOBAL;
    hDevNames: HGLOBAL;
    hDC: HDC;
    dwPrintFlags: DWORD;
    nFromPage: WORD;
    nToPage: WORD;
    nCopies: WORD;
    dwPageFlags: DWORD;
    rtMargin: TRect;
  end;
  TPRINTINFO = _PRINTINFO;


type
  _CHARCOLOR = record
    nCharPos: INT_PTR;       //Char position.
    crText: COLORREF;        //Text color.
    crBk: COLORREF;          //Background color.
  end;
  TCHARCOLOR = _CHARCOLOR;


type
  _NOPENDOCUMENT = record
    pFile: PBYTE;      //Opening cFile.
    szFile: PAnsiChar;     //Opening cFile (Ansi).
    wszFile: PWideChar; //Opening cFile (Unicode).
    nCodePage: PInteger;         //Pointer to a code page variable.
    bBOM: PBOOL;             //Pointer to a BOM variable.
    dwFlags: PDWORD;         //Pointer to a open flags variable. See OD_* defines.
    bProcess: BOOL;          //TRUE   open file.
  end;
  TNOPENDOCUMENT = _NOPENDOCUMENT;


type
  _NSAVEDOCUMENT = record
    pFile: PBYTE;      //Saving cFile.
    szFile: PAnsiChar;     //Saving cFile (Ansi).
    wszFile: PWideChar; //Saving cFile (Unicode).
    nCodePage: PInteger;         //Pointer to a code page variable.
    bBOM: PBOOL;             //Pointer to a BOM variable.
    dwFlags: DWORD;          //See SD_* defines.
    bProcess: BOOL;          //TRUE   save file.
  end;
  TNSAVEDOCUMENT = _NSAVEDOCUMENT;


type
  _NMAINSHOW = record
    dwStyle: PDWORD;         //Pointer to a maximized state variable (WS_MAXIMIZE or zero).
    dwShow: PDWORD;          //Pointer to a SW_ constants combination variable.
    bProcess: BOOL;          //TRUE   show main window.
  end;
  TNMAINSHOW = _NMAINSHOW;


type
  _NCONTEXTMENU = record
    hWnd: HWND;              //Context menu window.
    uType: UINT;             //cType:    NCM_EDIT, NCM_TAB or NCM_STATUS.
    pt: TPoint;               //Context menu coordiates.
    bMouse: BOOL;            //Context menu is requested with mouse.
    bProcess: BOOL;          //TRUE   show context menu.
  end;
  TNCONTEXTMENU = _NCONTEXTMENU;


type
  _NSIZE = record
    rcInitial: TRect;         //Initial client TRect (read-only).
    rcCurrent: TRect;         //Current client TRect (writeable).
  end;
  TNSIZE = _NSIZE;

$$$ DEFINES2 $$$


// Messages manual: look AkelDLL.h

//// UNICODE define
type
{$ifndef UNICODE}
  TDETECTFILE = TDETECTFILEA;
  TOPENDOCUMENT = TOPENDOCUMENTA;
  TOPENDOCUMENTPOST = TOPENDOCUMENTPOSTA;
  TSAVEDOCUMENT = TSAVEDOCUMENTA;
  TPLUGINADD = TPLUGINADDA;
  TPLUGINCALLSEND = TPLUGINCALLSENDA;
  TPLUGINCALLPOST = TPLUGINCALLPOSTA;
  TPLUGINOPTION = TPLUGINOPTIONA;
  TINIVALUE = TINIVALUEA;
  TTEXTFIND = TTEXTFINDA;
  TTEXTREPLACE = TTEXTREPLACEA;
  TCREATEWINDOW = TCREATEWINDOWA;
{$else}
  TDETECTFILE = TDETECTFILEW;
  TOPENDOCUMENT = TOPENDOCUMENTW;
  TOPENDOCUMENTPOST = TOPENDOCUMENTPOSTW;
  TSAVEDOCUMENT = TSAVEDOCUMENTW;
  TPLUGINADD = TPLUGINADDW;
  TPLUGINCALLSEND = TPLUGINCALLSENDW;
  TPLUGINCALLPOST = TPLUGINCALLPOSTW;
  TPLUGINOPTION = TPLUGINOPTIONW;
  TINIVALUE = TINIVALUEW;
  TTEXTFIND = TTEXTFINDW;
  TTEXTREPLACE = TTEXTREPLACEW;
  TCREATEWINDOW = TCREATEWINDOWW;
{$endif}

// Parameters for current call are kept in the following form:
//   pd.lParam - pointer to array of INT_PTR (let's call it Params)
//   Params[0] = size of the whole array in bytes including the 0-th element itself.
//               So Length(Params) = Params[0] div SizeOf(INT_PTR), ParamCount = Length(Params) - 1
//   Params[1] = pointer to parameter string OR the value of numerical parameter
//   ...
// WARNING. There's no way to distinguish what kind of parameter is passed so be careful

{$IF CompilerVersion < 20} // ?
  {*****************************************************************************
    Usage for Delphi versions earlier than D2009
    procedure Init(var pd: TPLUGINDATA);
    var
      AkelParams: PAkelParamArr;
    begin
      AkelParams := PAkelParamArr(pd.lParam);
      if AkelParams_Count(AkelParams) > 0 then
        sParam := AkelParams_ParamStr(AkelParams, 0); // returns empty string if parameter is NULL
        ...
    end;
  *****************************************************************************}

type
  TAkelParamArr = array[0..$FFFF] of INT_PTR;
  PAkelParamArr = ^TAkelParamArr;

function AkelParams_Count(Params: PAkelParamArr): Integer;
function AkelParams_ParamInt(Params: PAkelParamArr; Idx: Integer): INT_PTR;
function AkelParams_ParamStr(Params: PAkelParamArr; Idx: Integer): string;

{$ELSE}
  {*****************************************************************************
    Usage for Delphi versions D2009 and later
    procedure Init(var pd: TPLUGINDATA);
    var
      AkelParams: TAkelParams;
    begin
      AkelParams.Init(Pointer(pd.lParam));
      if AkelParams.Count > 0 then
      begin
        sParam := AkelParams.ParamStr(0); // returns empty string if parameter is NULL
        ...
    end;
  *****************************************************************************}

type
  TAkelParams = record
  strict private
    type
      TAkelParamArr = array[0..$FFFF] of INT_PTR;
      PAkelParamArr = ^TAkelParamArr;
    var
      FParamArr: PAkelParamArr;
  public
    procedure Init(ParamArr: Pointer);
    function Count: Integer;
    function ParamStr(Idx: Integer): string;
    function ParamInt(Idx: Integer): INT_PTR;
  end;
{$IFEND}

implementation

function MakeIdentifier(a, b, c, d: ShortInt): DWORD;
begin
  Result := DWORD(MAKELONG(MAKEWORD(Byte(a), Byte(b)), MAKEWORD(Byte(c), Byte(d))));
end;

function AkelDLLVer: DWORD;
begin
  Result := MakeIdentifier(AkelDLLVerArr[1], AkelDLLVerArr[2], AkelDLLVerArr[3], AkelDLLVerArr[4]);
end;

{$IF CompilerVersion < 20}

function AkelParams_Count(Params: PAkelParamArr): Integer;
begin
  if Params = nil then
    Result := 0
  else
    Result := Params^[0] div SizeOf(INT_PTR) - 1;
end;

function AkelParams_ParamInt(Params: PAkelParamArr; Idx: Integer): INT_PTR;
begin
  if (Idx >= AkelParams_Count(Params)) or (Idx < 0) then
    Result := 0
  else
    Result := Params^[Idx + 1];
end;

function AkelParams_ParamStr(Params: PAkelParamArr; Idx: Integer): string;
begin
  Result := string(PChar(AkelParams_ParamInt(Params, Idx)));
end;

{$ELSE}

procedure TAkelParams.Init(ParamArr: Pointer);
begin
  FParamArr := PAkelParamArr(ParamArr);
end;

function TAkelParams.Count: Integer;
begin
  if FParamArr = nil then
    Result := 0
  else
    Result := FParamArr^[0] div SizeOf(INT_PTR) - 1;
end;

function TAkelParams.ParamInt(Idx: Integer): INT_PTR;
begin
  if (Idx >= Count) or (Idx < 0) then
    Result := 0
  else
    Result := FParamArr^[Idx + 1];
end;

function TAkelParams.ParamStr(Idx: Integer): string;
begin
  Result := string(PChar(ParamInt(Idx)));
end;

{$IFEND}

end.
