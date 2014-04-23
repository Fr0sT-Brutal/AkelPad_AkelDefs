(*************************************************************************

=========  AkelPad text editor plugin API ===========

** Origin: AkelEdit.h located at
   http://akelpad.cvs.sourceforge.net/viewvc/akelpad/akelpad_4/AkelFiles/Plugs/AkelDLL/AkelEdit.h
** Converted with C to Pascal Converter 2.0
** Release: 2.20.11.2011
** Email: al_gun@ncable.net.au
** Updates: http://cc.codegear.com/Author/302259
** Blogs: http://delphiprogrammingwithalgun.blogspot.com/
** Copyright (c) 2005, 2011 Ural Gunaydin (a.k.a. Al Gun)

===========           Edited by Fr0sT           ===========
= Tested on RAD Studio XE2 but compiles on D7 and should =
= work on other versions also.                            =

**************************************************************************)

unit AkelEdit;

interface

uses
  Windows, Messages, RichEdit,
  AkelDLL;

//// Defines

const AES_AKELEDITA = AnsiString('AkelEditA');
const AES_AKELEDITA_UNICODE = WideString('AkelEditA');
const AES_AKELEDITW_ANSI = AnsiString('AkelEditW');
const AES_AKELEDITW = WideString('AkelEditW');
const AES_RICHEDIT20A = AnsiString('RichEdit20A');
const AES_RICHEDIT20A_UNICODE = WideString('RichEdit20A');
const AES_RICHEDIT20W_ANSI = AnsiString('RichEdit20W');
const AES_RICHEDIT20W = WideString('RichEdit20W');

// Fr0sT: these C types aren't defined in used units
type
  SIZE_T = INT_PTR;
  HDROP  = THandle;

//AEM_CONTROLCLASS
const AECLASS_AKELEDIT = 1;
const AECLASS_RICHEDIT = 2;

//Window styles
{
  Fr0sT: these constants are already defined in RTL since D7
  const ES_MULTILINE       = $00000004;  //See AECO_MULTILINE.
  const ES_NOHIDESEL       = $00000100;  //See AECO_NOHIDESEL.
  const ES_READONLY        = $00000800;  //See AECO_READONLY.
  const ES_WANTRETURN      = $00001000;  //See AECO_WANTRETURN.
  const ES_DISABLENOSCROLL = $00002000;  //See AECO_DISABLENOSCROLL.
}
const ES_GLOBALUNDO = $00004000;       //Use process heap for Undo/Redo instead of window heap. Required for AEM_DETACHUNDO and AEM_ATTACHUNDO.
                                       //Compatibility: define same as ES_SUNKEN.
const ES_HEAP_SERIALIZE = $00008000;   //Mutual exclusion will be used when the heap functions allocate and free memory from window heap. Serialization of heap access allows two or more threads to simultaneously allocate and free memory from the same heap.
                                       //Compatibility: define same as ES_SAVESEL.

const AES_WORDDELIMITERSW : WideString = ' '#9#13#10'''`\"\\|[](){}<>,.;:+-=~!@#$%^&*/?';
const AES_WRAPDELIMITERSW : WideString = ' '#9;
const AES_URLLEFTDELIMITERSW : WideString = ' '#9#13#10'''`\"(<{[=';
const AES_URLRIGHTDELIMITERSW  : WideString = ' '#9#13#10'''`\")>}]';
const AES_URLPREFIXESW : WideString = 'http:'#0'https:'#0'www.'#0'ftp:'#0'file:'#0'mailto:'#0#0;


$$$ DEFINES1 $$$

{
  Fr0sT: these constants are defined in AkelDLL.pas so do not redefine them here

const FR_DOWN = $00000001;
const FR_WHOLEWORD = $00000002;
}

const FR_MATCHCASE = $00000004;

{
  Fr0sT: these constants are defined in RTL since D7

const EC_LEFTMARGIN = $0001;
const EC_RIGHTMARGIN = $0002;
const SPI_GETWHEELSCROLLLINES = $0068;
const WM_MOUSEWHEEL = $020A;
const EN_DRAGDROPDONE = $070c;
const WC_NO_BEST_FIT_CHARS = $00000400;
const GT_SELECTION = $0002;
}


const EM_SHOWSCROLLBAR = (WM_USER + 96);
const EM_GETSCROLLPOS = (WM_USER + 221);
const EM_SETSCROLLPOS = (WM_USER + 222);
const EM_SETTEXTEX = (WM_USER + 97);

const ST_DEFAULT = $0000;
const ST_KEEPUNDO = $0001;
const ST_SELECTION = $0002;
const ST_NEWCHARS = $0004;

type
  SETTEXTEX = record
    flags: DWORD;
    codepage: UINT;
   end;

// Fr0sT: mod => Abs()
// #define mod(a)  (((a) < 0) ? (0 - (a)) : (a))

// Fr0sT: already defined in AkelDLL
//  AEHDOC = THandle;

type
  AEHPRINT = THandle;
type
  AEHTHEME = THandle;
type
  AEHDELIMITER = THandle;
type
  AEHWORD = THandle;
type
  AEHQUOTE = THandle;
type
  AEHMARKTEXT = THandle;
type
  AEHMARKRANGE = THandle;

// Fr0sT: already defined in AkelDLL
// hDoc        Document handle returned by AEM_GETDOCUMENT or AEM_CREATEDOCUMENT.
// uMsg        Message ID for example EM_SETSEL.
// lParam      Additional parameter.
// wParam      Additional parameter.
//
// Return Value
//   Depends on message.
//  AEEditProc = function(hDoc: AEHDOC; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;


//// Structures for x64 RichEdit support

type
  PCHARRANGE64 = ^TCHARRANGE64;
  _CHARRANGE64 = record
    cpMin: INT_PTR;
    cpMax: INT_PTR;
  end;
  TCHARRANGE64 = _CHARRANGE64;


type
  _TEXTRANGE64A = record
    chrg: TCHARRANGE64;
    lpstrText: LPSTR;
  end;
  TTEXTRANGE64A = _TEXTRANGE64A;


type
  _TEXTRANGE64W = record
    chrg: TCHARRANGE64;
    lpstrText: LPWSTR;
  end;
  TTEXTRANGE64W = _TEXTRANGE64W;


type
  _FINDTEXTEX64A = record
    chrg: TCHARRANGE64;
    lpstrText: LPCSTR;
    chrgText: TCHARRANGE64;
  end;
  TFINDTEXTEX64A = _FINDTEXTEX64A;


type
  _FINDTEXTEX64W = record
    chrg: TCHARRANGE64;
    lpstrText: LPCWSTR;
    chrgText: TCHARRANGE64;
  end;
  TFINDTEXTEX64W = _FINDTEXTEX64W;


type
  _GETTEXTEX64 = record
    cb: UINT_PTR;
    flags: DWORD;
    codepage: UINT;
    lpDefaultChar: LPCSTR;
    lpUsedDefChar: PBOOL;
  end;
  TGETTEXTEX64 = _GETTEXTEX64;


type
  _SELCHANGE64 = record
    nmhdr: NMHDR;
    chrg: TCHARRANGE;
    seltyp: WORD;
    chrg64: TCHARRANGE64;
  end;
  TSELCHANGE64 = _SELCHANGE64;


type
  _ENDROPFILES64 = record
    nmhdr: NMHDR;
    hDrop: THandle;
    cp: LongInt;
    fProtected: BOOL;
    cp64: INT_PTR;
  end;
  TENDROPFILES64 = _ENDROPFILES64;


type
  _ENLINK64 = record
    nmhdr: NMHDR;
    msg: UINT;
    wParam: WPARAM;
    lParam: LPARAM;
    chrg: TCHARRANGE;
    chrg64: TCHARRANGE64;
  end;
  TENLINK64 = _ENLINK64;


//// Structures for x64 support

type
  _POINT64 = record
    x: INT_PTR;
    y: INT_PTR;
  end;
  TPOINT64 = _POINT64;


type
  _SIZE64 = record
    cx: INT_PTR;
    cy: INT_PTR;
  end;
  TSIZE64 = _SIZE64;


//// Structures

// Fr0sT: already defined in AkelDLL
//   HSTACK

type
  PStack = ^TStack;
  TStack = record
    next: PStack;
    prev: PStack;
  end;

// Fr0sT: already defined in AkelDLL
//   AELINEDATA
//   AELINEINDEX
//   AECHARINDEX
//    AECHARRANGE


type
  _AESELECTION = record
    crSel: TAECHARRANGE;  //Characters range.
    dwFlags: DWORD;      //See AESELT_* defines.
    dwType: DWORD;       //See AESCT_* defines.
  end;
  TAESELECTION = _AESELECTION;


type
  PAEPOINT = ^TAEPOINT;
  _AEPOINT = record
    next: PAEPOINT;   //Pointer to the next AEPOINT structure.
    prev: PAEPOINT;   //Pointer to the previous AEPOINT structure.
    ciPoint: TAECHARINDEX;     //Read-only character index.
    nPointOffset: INT_PTR;    //Character RichEdit offset or one of the AEPTO_* define.
    nPointLen: Integer;           //Point length.
    dwFlags: DWORD;           //See AEPTF_* defines.
    dwUserData: UINT_PTR;     //User data.
    nTmpPointOffset: INT_PTR; //Don't use it. For internal code only.
    nTmpPointLen: Integer;        //Don't use it. For internal code only.
  end;
  TAEPOINT = _AEPOINT;


type
  PAEFOLD = ^TAEFOLD;
  _AEFOLD = record
    next: PAEFOLD;       //Pointer to the next AEFOLD structure.
    prev: PAEFOLD;       //Pointer to the previous AEFOLD structure.
    parent: PAEFOLD;     //Pointer to the parent AEFOLD structure.
    firstChild: PAEFOLD; //Pointer to the first child AEFOLD structure.
    lastChild: PAEFOLD;  //Pointer to the last child AEFOLD structure.
    lpMinPoint: PAEPOINT;        //Minimum line point.
    lpMaxPoint: PAEPOINT;        //Maximum line point.
    bCollapse: BOOL;             //Collapse state.
    dwFontStyle: DWORD;          //See AEHLS_* defines.
    crText: COLORREF;            //Text color. If -1, then don't set.
    crBk: COLORREF;              //Background color. If -1, then don't set.
    dwUserData: UINT_PTR;        //User data.
  end;
  TAEFOLD = _AEFOLD;


type
  _AEFINDFOLD = record
    dwFlags: DWORD;         //[in]  See AEFF_* defines.
    dwFindIt: UINT_PTR;     //[in]  Depend on AEFF_FIND* define.
    lpParent: PAEFOLD;      //[out] Parent fold.
    lpPrevSubling: PAEFOLD; //[out] Previous subling fold.
  end;
  TAEFINDFOLD = _AEFINDFOLD;


type
  _AESETTEXTA = record
    pText: PAnsiChar;     //[in] Text to append.
    dwTextLen: UINT_PTR;  //[in] Text length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
    nNewLine: Integer;    //[in] See AELB_* defines.
    nCodePage: Integer;   //[in] Code page identifier (any available in the system). You can also specify one of the following values: CP_ACP - ANSI code page, CP_OEMCP - OEM code page, CP_UTF8 - UTF-8 code page.
  end;
  TAESETTEXTA = _AESETTEXTA;


type
  _AESETTEXTW = record
    pText: PWideChar;     //[in] Text to append.
    dwTextLen: UINT_PTR;  //[in] Text length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
    nNewLine: Integer;    //[in] See AELB_* defines.
  end;
  TAESETTEXTW = _AESETTEXTW;


type
  _AEAPPENDTEXTA = record
    pText: PAnsiChar;     //[in] Text to append.
    dwTextLen: UINT_PTR;  //[in] Text length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
    nNewLine: Integer;    //[in] See AELB_* defines.
    nCodePage: Integer;   //[in] Code page identifier (any available in the system). You can also specify one of the following values: CP_ACP - ANSI code page, CP_OEMCP - OEM code page, CP_UTF8 - UTF-8 code page.
  end;
  TAEAPPENDTEXTA = _AEAPPENDTEXTA;


type
  _AEAPPENDTEXTW = record
    pText: PWideChar;             //[in] Text to append.
    dwTextLen: UINT_PTR;          //[in] Text length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
    nNewLine: Integer;            //[in] See AELB_* defines.
  end;
  TAEAPPENDTEXTW = _AEAPPENDTEXTW;


type
  _AEREPLACESELA = record
    pText: PAnsiChar;             //[in]  Text to replace with.
    dwTextLen: UINT_PTR;          //[in]  Text length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
    nNewLine: Integer;            //[in]  See AELB_* defines.
    dwFlags: DWORD;               //[in]  See AEREPT_* defines.
    ciInsertStart: PAECHARINDEX;  //[out] Insert "from" character index after replacement.
    ciInsertEnd: PAECHARINDEX;    //[out] Insert "to" character index after replacement.
    nCodePage: Integer;           //[in]  Code page identifier (any available in the system). You can also specify one of the following values: CP_ACP - ANSI code page, CP_OEMCP - OEM code page, CP_UTF8 - UTF-8 code page.
  end;
  TAEREPLACESELA = _AEREPLACESELA;


type
  _AEREPLACESELW = record
    pText: PWideChar;             //[in]  Text to replace with.
    dwTextLen: UINT_PTR;          //[in]  Text length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
    nNewLine: Integer;            //[in]  See AELB_* defines.
    dwFlags: DWORD;               //[in]  See AEREPT_* defines.
    ciInsertStart: PAECHARINDEX;  //[out] Insert "from" character index after replacement.
    ciInsertEnd: PAECHARINDEX;    //[out] Insert "to" character index after replacement.
  end;
  TAEREPLACESELW = _AEREPLACESELW;


type
  _AETEXTRANGEA = record
    cr: TAECHARRANGE;             //[in]  Characters range to retrieve.
    bColumnSel: BOOL;            //[in]  Column selection. If this value is -1, use current selection type.
    pBuffer: PAnsiChar;          //[out] Pointer to buffer that receives the text. If this value is NULL, the function returns the required buffer size in characters.
    dwBufferMax: UINT_PTR;       //[in]  Specifies the maximum number of characters to copy to the buffer, including the NULL character.
    nNewLine: Integer;           //[in]  See AELB_* defines.
    nCodePage: Integer;          //[in]  Code page identifier (any available in the system). You can also specify one of the following values: CP_ACP - ANSI code page, CP_OEMCP - OEM code page, CP_UTF8 - UTF-8 code page.
    lpDefaultChar: PAnsiChar;    //[in]  Points to the character used if a wide character cannot be represented in the specified code page. If this member is NULL, a system default value is used.
    lpUsedDefChar: PBOOL;        //[in]  Points to a flag that indicates whether a default character was used. The flag is set to TRUE if one or more wide characters in the source string cannot be represented in the specified code page. Otherwise, the flag is set to FALSE. This member may be NULL.
    bFillSpaces: BOOL;           //[in]  If bColumnSel is TRUE, fill empties with spaces.
  end;
  TAETEXTRANGEA = _AETEXTRANGEA;


type
  _AETEXTRANGEW = record
    cr: TAECHARRANGE;            //[in]  Characters range to retrieve.
    bColumnSel: BOOL;            //[in]  Column selection. If this value is -1, use current selection type. If bColumnSel is TRUE, then selection must be exist, otherwise it is not necessary.
    pBuffer: PWideChar;          //[out] Pointer to buffer that receives the text. If this value is NULL, the function returns the required buffer size in characters.
    dwBufferMax: UINT_PTR;       //[in]  Specifies the maximum number of characters to copy to the buffer, including the NULL character.
    nNewLine: Integer;           //[in]  See AELB_* defines.
    nCodePage: Integer;          //[in]  Ignored. Code page is always 1200 (UTF-16 LE).
    lpDefaultChar: PWideChar;    //[in]  Ignored.
    lpUsedDefChar: PBOOL;        //[in]  Ignored.
    bFillSpaces: BOOL;           //[in]  If bColumnSel is TRUE, fill empties with spaces.
  end;
  TAETEXTRANGEW = _AETEXTRANGEW;


type
  //dwCookie        Value of the dwCookie member of the AESTREAMIN or AESTREAMOUT structure. The application specifies this value when it sends the AEM_STREAMIN or AEM_STREAMOUT message.
  //wszBuf          Pointer to a buffer to read from or write to. For a stream-in (read) operation, the callback function fills this buffer with data to transfer into the edit control. For a stream-out (write) operation, the buffer contains data from the control that the callback function writes to some storage.
  //dwBufBytesSize  Number of bytes to read or write.
  //dwBufBytesDone  Pointer to a variable that the callback function sets to the number of bytes actually read or written.
  //
  //Return Value
  // The callback function returns zero to indicate success.
  //
  //Remarks
  // The control continues to call the callback function until one of the following conditions occurs:
  // * The callback function returns a nonzero value.
  // * The callback function returns zero in the *dwBufBytesDone parameter.
  TAEStreamCallback = function(dwCookie: UINT_PTR; var wszBuf: PWideChar; dwBufBytesSize: DWORD; var dwBufBytesDone: DWORD): DWORD; stdcall;

type
  _AESTREAMIN = record
    dwCookie: UINT_PTR;            //[in]  Specifies an application-defined value that the edit control passes to the AEStreamCallback function specified by the lpCallback member.
    dwError: DWORD;                //[out] Indicates the results of the stream-in (read) operation.
    lpCallback: TAEStreamCallback; //[in]  Pointer to an AEStreamCallback function, which is an application-defined function that the control calls to transfer data. The control calls the callback function repeatedly, transferring a portion of the data with each call.
    nNewLine: Integer;             //[in]  See AELB_* defines.
    dwTextLen: UINT_PTR;           //[in]  Text length. Need if using AEN_PROGRESS notification.
    nFirstNewLine: Integer;        //[out] Indicates first new line. See AELB_* defines.
  end;
  TAESTREAMIN = _AESTREAMIN;


type
  _AESTREAMOUT = record
    dwCookie: UINT_PTR;            //[in]  Specifies an application-defined value that the edit control passes to the AEStreamCallback function specified by the lpCallback member.
    dwError: DWORD;                //[out] Indicates the result of the stream-out (write) operation.
    lpCallback: TAEStreamCallback; //[in]  Pointer to an AEStreamCallback function, which is an application-defined function that the control calls to transfer data. The control calls the callback function repeatedly, transferring a portion of the data with each call.
    nNewLine: Integer;             //[in]  See AELB_* defines.
    bColumnSel: BOOL;              //[in]  Column selection. If this value is -1, use current selection type.
  end;
  TAESTREAMOUT = _AESTREAMOUT;


type
  _AEFINDTEXTA = record
    dwFlags: DWORD;               //[in]  See AEFR_* defines.
    pText: PAnsiChar;             //[in]  Text to find.
    dwTextLen: UINT_PTR;          //[in]  Text length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
    nNewLine: Integer;            //[in]  See AELB_* defines.
    crSearch: TAECHARRANGE;       //[in]  Range of characters to search.
    crFound: TAECHARRANGE;        //[out] Range of characters in which text is found.
    nCompileErrorOffset: INT_PTR; //[out] Contain pattern offset, if error occurred during compile pattern. Return when AEFR_REGEXP is set.
  end;
  TAEFINDTEXTA = _AEFINDTEXTA;


type
  _AEFINDTEXTW = record
    dwFlags: DWORD;               //[in]  See AEFR_* defines.
    pText: PWideChar;             //[in]  Text to find.
    dwTextLen: UINT_PTR;          //[in]  Text length. If this value is -1, the string is assumed to be null-terminated and the length is calculated automatically.
    nNewLine: Integer;            //[in]  See AELB_* defines.
    crSearch: TAECHARRANGE;       //[in]  Range of characters to search.
    crFound: TAECHARRANGE;        //[out] Range of characters in which text is found.
    nCompileErrorOffset: INT_PTR; //[out] Contain pattern offset, if error occurred during compile pattern. Return when AEFR_REGEXP is set.
  end;
  TAEFINDTEXTW = _AEFINDTEXTW;

// Fr0sT: already defined in AkelDLL
//   AECOLORS = record


type
  _AECHARCOLORS = record
    dwFlags: DWORD;           //[in] See AEGHF_* defines.
    dwFontStyle: DWORD;       //[Out] See AEHLS_* defines.
    crText: COLORREF;         //[Out] Text color in line.
    crBk: COLORREF;           //[Out] Background color in line.
    crBorderTop: COLORREF;    //[Out] Top border color of the line.
    crBorderBottom: COLORREF; //[Out] Bottom border color of the line.
  end;
  TAECHARCOLORS = _AECHARCOLORS;


type
  _AEINDEXOFFSET = record
    ciCharIn: PAECHARINDEX;   //[in]  Input character index.
    ciCharOut: PAECHARINDEX;  //[out] Output character index (result).
    nOffset: INT_PTR;         //[in]  Offset can be positive or negative. For example, +1 will return next character, -1 will return previous character.
    nNewLine: Integer;        //[in]  See AELB_* defines.
  end;
  TAEINDEXOFFSET = _AEINDEXOFFSET;


type
  _AEINDEXSUBTRACT = record
    ciChar1: PAECHARINDEX;   //[in] First character index. If NULL, first character is used.
    ciChar2: PAECHARINDEX;   //[in] Second character index. If NULL, last character is used.
    bColumnSel: BOOL;        //[in] Column selection. If this value is -1, use current selection type.
    nNewLine: Integer;       //[in] See AELB_* defines.
  end;
  TAEINDEXSUBTRACT = _AEINDEXSUBTRACT;


type
  _AESCROLLTOPOINT = record
    dwFlags: DWORD;      //[in]     See AESC_* defines.
    ptPos: TPOINT64;     //[in,out] Point to scroll to, ignored if AESC_POINTCARET flag specified.
    nOffsetX: Integer;   //[in]     Horizontal scroll offset.
    nOffsetY: Integer;   //[in]     Vertical scroll offset.
  end;
  TAESCROLLTOPOINT = _AESCROLLTOPOINT;

type
  _AESCROLLCARETOPTIONS = record
    dwFlags: DWORD;      //See AESC_OFFSET* defines.
    dwSelFlags: DWORD;   //See AESELT_* defines. Can be zero.
    dwSelType: DWORD;    //See AESCT_* defines.
    nOffsetX: Integer;   //Minimal number of characters to horizontal window edge.
    nOffsetY: Integer;   //Minimal number of lines to vertical window edge.
  end;
  TAESCROLLCARETOPTIONS = _AESCROLLCARETOPTIONS;


type
  _AESENDMESSAGE = record
    hDoc: AEHDOC;     //Document handle. See AEM_CREATEDOCUMENT message.
    uMsg: UINT;       //Window message.
    wParam: WPARAM;   //Window first additional parameter.
    lParam: LPARAM;   //Window second additional parameter.
    lResult: LRESULT; //cResult after window message returns.
  end;
  TAESENDMESSAGE = _AESENDMESSAGE;


type
  _AEPRINT = record
    dwFlags: DWORD;              //[in]     See AEPRN_* defines.
    hPrinterDC: HDC;             //[in]     Printer device context.
    hEditFont: HFONT;            //[in]     Edit font.
    hPrintFont: HFONT;           //[out]    Print font (mapped edit font).
    nCharHeight: Integer;        //[out]    Print character height.
    nAveCharWidth: Integer;      //[out]    Print character average width.
    nSpaceCharWidth: Integer;    //[out]    Print space width.
    nTabWidth: Integer;          //[out]    Print tabulation width.
    rcMargins: TRect;            //[in]     Specifies the widths of the left, top, right, and bottom margins. The AEPRN_INHUNDREDTHSOFMILLIMETERS or AEPRN_INTHOUSANDTHSOFINCHES flag indicates the units of measurement.
    rcPageFull: TRect;           //[out]    Complete page rectangle. Filled by AEM_STARTPRINTDOC message.
    rcPageIn: TRect;             //[in,out] Available page rectangle (minus margins). Filled by AEM_STARTPRINTDOC message and can be modified by user before AEM_PRINTPAGE call.
    rcPageOut: TRect;            //[out]    Filled page rectangle. Filled by AEM_PRINTPAGE message.
    crText: TAECHARRANGE;        //[in,out] Text range to print. Filled by user and changed after AEM_PRINTPAGE message.
  end;
  TAEPRINT = _AEPRINT;


type
  PAEDELIMITEMA = ^TAEDELIMITEMA;
  _AEDELIMITEMA = record
    next: PAEDELIMITEMA;
    prev: PAEDELIMITEMA;
    nIndex: Integer;            //Position of the element if positive inserts to begin of stack if negative to end.
    pDelimiter: PAnsiChar;      //Delimiter string.
    nDelimiterLen: Integer;     //Delimiter string length.
    dwFlags: DWORD;             //See AEHLF_* defines.
    dwFontStyle: DWORD;         //See AEHLS_* defines.
    crText: COLORREF;           //Delimiter text color. If -1, then don't set.
    crBk: COLORREF;             //Delimiter background color. If -1, then don't set.
  end;
  TAEDELIMITEMA = _AEDELIMITEMA;


type
  PAEDELIMITEMW = ^TAEDELIMITEMW;
  _AEDELIMITEMW = record
    next: PAEDELIMITEMW;
    prev: PAEDELIMITEMW;
    nIndex: Integer;            //Position of the element if positive inserts to begin of stack if negative to end.
    pDelimiter: PWideChar;      //Delimiter string.
    nDelimiterLen: Integer;     //Delimiter string length.
    dwFlags: DWORD;             //See AEHLF_* defines.
    dwFontStyle: DWORD;         //See AEHLS_* defines.
    crText: COLORREF;           //Delimiter text color. If -1, then don't set.
    crBk: COLORREF;             //Delimiter background color. If -1, then don't set.
  end;
  TAEDELIMITEMW = _AEDELIMITEMW;


type
  PAEWORDITEMA = ^TAEWORDITEMA;
  _AEWORDITEMA = record
    next: PAEWORDITEMA;
    prev: PAEWORDITEMA;
    nIndex: Integer;            //Reserved. Word items are automatically sorted.
    pWord: PAnsiChar;           //Word string.
    nWordLen: Integer;          //Word string length.
    dwFlags: DWORD;             //See AEHLF_* defines.
    dwFontStyle: DWORD;         //See AEHLS_* defines.
    crText: COLORREF;           //Word text color. If -1, then don't set.
    crBk: COLORREF;             //Word background color. If -1, then don't set.
  end;
  TAEWORDITEMA = _AEWORDITEMA;


type
  PAEWORDITEMW = ^TAEWORDITEMW;
  _AEWORDITEMW = record
    next: PAEWORDITEMW;
    prev: PAEWORDITEMW;
    nIndex: Integer;            //Reserved. Word items are automatically sorted.
    pWord: PWideChar;           //Word string.
    nWordLen: Integer;          //Word string length.
    dwFlags: DWORD;             //See AEHLF_* defines.
    dwFontStyle: DWORD;         //See AEHLS_* defines.
    crText: COLORREF;           //Word text color. If -1, then don't set.
    crBk: COLORREF;             //Word background color. If -1, then don't set.
  end;
  TAEWORDITEMW = _AEWORDITEMW;


type
  PAEQUOTEITEMA = ^TAEQUOTEITEMA;
  _AEQUOTEITEMA = record
    next: PAEQUOTEITEMA;
    prev: PAEQUOTEITEMA;
    nIndex: Integer;                //Reserved. Quote start items are automatically grouped in standalone stack, if following members are equal: pQuoteStart, chEscape and dwFlags with AEHLF_QUOTESTART_ISDELIMITER, AEHLF_ATLINESTART, AEHLF_QUOTESTART_ISWORD.
    pQuoteStart: PAnsiChar;   //Quote start string.
    nQuoteStartLen: Integer;        //Quote start string length.
    pQuoteEnd: PAnsiChar;     //Quote end string. If NULL, line end used as quote end.
    nQuoteEndLen: Integer;          //Quote end string length.
    chEscape: AnsiChar;             //Escape character. If it precedes quote string then quote ignored.
    pQuoteInclude: PAnsiChar; //Quote include string.
    nQuoteIncludeLen: Integer;      //Quote include string length.
    pQuoteExclude: PAnsiChar; //Quote exclude string.
    nQuoteExcludeLen: Integer;      //Quote exclude string length.
    dwFlags: DWORD;             //See AEHLF_* defines.
    dwFontStyle: DWORD;         //See AEHLS_* defines.
    crText: COLORREF;           //Quote text color. If -1, then don't set.
    crBk: COLORREF;             //Quote background color. If -1, then don't set.
    lpQuoteStart: Pointer;        //Don't use it. For internal code only.
    nCompileErrorOffset: INT_PTR;  //Contain pQuoteStart offset, if error occurred during compile regular exression pattern.
  end;
  TAEQUOTEITEMA = _AEQUOTEITEMA;


type
  PAEQUOTEITEMW = ^TAEQUOTEITEMW;
  _AEQUOTEITEMW = record
    next: PAEQUOTEITEMW;
    prev: PAEQUOTEITEMW;
    nIndex: Integer;               //Reserved. Quote start items are automatically grouped in standalone stack, if following members are equal: pQuoteStart, chEscape and dwFlags with AEHLF_QUOTESTART_ISDELIMITER, AEHLF_ATLINESTART, AEHLF_QUOTESTART_ISWORD.
    pQuoteStart: PWideChar;        //Quote start string.
    nQuoteStartLen: Integer;       //Quote start string length.
    pQuoteEnd: PWideChar;          //Quote end string. If NULL, line end used as quote end.
    nQuoteEndLen: Integer;         //Quote end string length.
    chEscape: WideChar;            //Escape character. If it precedes quote string then quote ignored.
    pQuoteInclude: PWideChar;      //Quote include string.
    nQuoteIncludeLen: Integer;     //Quote include string length.
    pQuoteExclude: PWideChar;      //Quote exclude string.
    nQuoteExcludeLen: Integer;     //Quote exclude string length.
    dwFlags: DWORD;                //See AEHLF_* defines.
    dwFontStyle: DWORD;            //See AEHLS_* defines.
    crText: COLORREF;              //Quote text color. If -1, then don't set.
    crBk: COLORREF;                //Quote background color. If -1, then don't set.
    lpQuoteStart: Pointer;         //Don't use it. For internal code only.
    nCompileErrorOffset: INT_PTR;  //Contain pQuoteStart offset, if error occurred during compile regular exression pattern.
    (* !! original:
      union {
        void *lpREGroupStack;        //Don't use it. For internal code only.
        INT_PTR nCompileErrorOffset; //Contain pQuoteStart offset, if error occurred during compile regular exression pattern.
      };
    *)
    {$IF SizeOf(INT_PTR) <> SizeOf(Pointer)}oops{$IFEND}
  end;
  TAEQUOTEITEMW = _AEQUOTEITEMW;

type
  _AEREGROUPCOLOR = record
    dwFlags: DWORD;                //See AEREGCF_* defines.
    dwFontStyle: DWORD;            //See AEHLS_* defines.
    crText: COLORREF;              //Quote text color. If -1, then don't set.
    crBk: COLORREF;                //Quote background color. If -1, then don't set.
  end;
  TAEREGROUPCOLOR = _AEREGROUPCOLOR;

type
  PAEMARKTEXTITEMA = ^TAEMARKTEXTITEMA;
  _AEMARKTEXTITEMA = record
    next: PAEMARKTEXTITEMA;
    prev: PAEMARKTEXTITEMA;
    nIndex: Integer;            //Position of the element if positive inserts to begin of stack if negative to end.
    pMarkText: PAnsiChar;       //Mark text.
    nMarkTextLen: Integer;      //Mark text length.
    dwFlags: DWORD;             //See AEHLF_* defines.
    dwFontStyle: DWORD;         //See AEHLS_* defines.
    crText: COLORREF;           //Mark text color. If -1, then don't set.
    crBk: COLORREF;             //Mark background color. If -1, then don't set.
    nCompileErrorOffset: INT_PTR; //Contain pMarkText offset, if error occurred during compile regular exression pattern.
  end;
  TAEMARKTEXTITEMA = _AEMARKTEXTITEMA;


type
  PAEMARKTEXTITEMW = ^TAEMARKTEXTITEMW;
  _AEMARKTEXTITEMW = record
    next: PAEMARKTEXTITEMW;
    prev: PAEMARKTEXTITEMW;
    nIndex: Integer;            //Position of the element if positive inserts to begin of stack if negative to end.
    pMarkText: PWideChar;       //Mark text.
    nMarkTextLen: Integer;      //Mark text length.
    dwFlags: DWORD;             //See AEHLF_* defines.
    dwFontStyle: DWORD;         //See AEHLS_* defines.
    crText: COLORREF;           //Mark text color. If -1, then don't set.
    crBk: COLORREF;             //Mark background color. If -1, then don't set.
    nCompileErrorOffset: INT_PTR;  //Contain pMarkText offset, if error occurred during compile regular exression pattern.
    (* !! original:
      union {
        void *lpREGroupStack;        //Don't use it. For internal code only.
        INT_PTR nCompileErrorOffset; //Contain pMarkText offset, if error occurred during compile regular exression pattern.
      };
    *)
    {$IF SizeOf(INT_PTR) <> SizeOf(Pointer)}oops{$IFEND}
  end;
  TAEMARKTEXTITEMW = _AEMARKTEXTITEMW;


type
  PAEMARKRANGEITEM = ^TAEMARKRANGEITEM;
  _AEMARKRANGEITEM = record
    next: PAEMARKRANGEITEM;
    prev: PAEMARKRANGEITEM;
    nIndex: Integer;          //Position of the element if positive inserts to begin of stack if negative to end.
    crMarkRange: TCHARRANGE64; //cpMin member is the first character in the range (RichEdit offset), cpMax member is the last character in the range (RichEdit offset).
    dwFlags: DWORD;           //Reserved.
    dwFontStyle: DWORD;       //See AEHLS_* defines.
    crText: COLORREF;         //Mark text color. If -1, then don't set.
    crBk: COLORREF;           //Mark background color. If -1, then don't set.
  end;
  TAEMARKRANGEITEM = _AEMARKRANGEITEM;



type
  _AEMARKTEXTMATCH = record
    lpMarkText: PAEMARKTEXTITEMW;
    crMarkText: TAECHARRANGE;
  end;
  TAEMARKTEXTMATCH = _AEMARKTEXTMATCH;


type
  _AEMARKRANGEMATCH = record
    lpMarkRange: PAEMARKRANGEITEM;
    crMarkRange: TCHARRANGE64;
  end;
  TAEMARKRANGEMATCH = _AEMARKRANGEMATCH;


type
  AEQUOTEMATCH = record
    lpQuote: PAEQUOTEITEMW;
    crQuoteStart: TAECHARRANGE;
    crQuoteEnd: TAECHARRANGE;
  end;
  TAEQUOTEMATCH = AEQUOTEMATCH;


type
  AEWORDMATCH = record 
    lpDelim1: PAEDELIMITEMW;
    crDelim1: TAECHARRANGE;
    lpWord: PAEWORDITEMW;
    crWord: TAECHARRANGE;
    lpDelim2: PAEDELIMITEMW;
    crDelim2: TAECHARRANGE;
  end;
  TAEWORDMATCH = AEWORDMATCH;


type
  AEFOLDMATCH = record 
    crFold: TCHARRANGE64;
    lpFold: PAEFOLD;
  end;
  TAEFOLDMATCH = AEFOLDMATCH;


type
  PAEHLPAINT = ^TAEHLPAINT;
  _AEHLPAINT = record
    dwDefaultText: DWORD;   //Text color without highlighting.
    dwDefaultBk: DWORD;     //Background color without highlighting.
    dwActiveText: DWORD;    //Text color with highlighting.
    dwActiveBk: DWORD;      //Background color with highlighting.
    dwFontStyle: DWORD;     //See AEHLS_* defines.
    dwPaintType: DWORD;     //See AEHPT_* defines.
    dwFindFirst: DWORD;     //Don't use it. For internal code only.
    wm: TAEWORDMATCH;        //Word or/and delimiters items are found, if AEWORDITEMW.lpDelim1 or AEWORDITEMW.lpWord or AEWORDITEMW.lpDelim2 aren't NULL.
    qm: TAEQUOTEMATCH;       //Quote item is found, if AEQUOTEMATCH.lpQuote isn't NULL.
    mrm: TAEMARKRANGEMATCH;  //Mark range item is found, if AEMARKRANGEMATCH.lpMarkRange isn't NULL.
    mtm: TAEMARKTEXTMATCH;   //Mark text item is found, if AEMARKTEXTMATCH.lpMarkText isn't NULL.
    fm: TAEFOLDMATCH;        //Fold item is found, if AEFOLDMATCH.lpFold isn't NULL.
    crLink: TAECHARRANGE;    //URL item is found, if AECHARRANGE.ciMin.lpLine and AECHARRANGE.ciMax.lpLine aren't NULL.
  end;
  TAEHLPAINT = _AEHLPAINT;


type
  //dwCookie        Value of the dwCookie member of the AEGETHIGHLIGHT structure. The application specifies this value when it sends the AEM_HLGETHIGHLIGHT message.
  //crAkelRange     Range of highlighted characters.
  //crRichRange     Range of highlighted characters (RichEdit offset).
  //hlp             Highlighted information.
  //
  //Return Value
  // To continue processing, the callback function must return zero; to stop processing, it must return nonzero.
  TAEGetHighLightCallback = function(dwCookie: UINT_PTR; crAkelRange: PAECHARRANGE; crRichRange: PCHARRANGE64; hlp: PAEHLPAINT): DWORD; stdcall;


type
  _AEGETHIGHLIGHT = record
    dwCookie: UINT_PTR;                  //[in]  Specifies an application-defined value that the edit control passes to the AEGetHighLightCallback function specified by the lpCallback member.
    dwError: DWORD;                      //[out] Indicates the result of the callback function.
    lpCallback: TAEGetHighLightCallback; //[in]  Pointer to an AEGetHighLightCallback function, which is an application-defined function that the control calls to pass highlighting information.
    crText: TAECHARRANGE;                //[in]  Range of characters to process.
    dwFlags: DWORD;                      //[in]  See AEGHF_* defines.
  end;
  TAEGETHIGHLIGHT = _AEGETHIGHLIGHT;


type
  _AENMHDR = record
    hwndFrom: HWND;
    idFrom: UINT_PTR;
    code: UINT;
    docFrom: AEHDOC;      //Document handle. See AEM_CREATEDOCUMENT message.
  end;
  TAENMHDR = _AENMHDR;


type
  _AENERRSPACE = record
    hdr: TAENMHDR;
    dwBytes: SIZE_T;      //Number of bytes that cannot be allocated.
  end;
  TAENERRSPACE = _AENERRSPACE;


type
  _AENFOCUS = record
    hdr: TAENMHDR;
    hWndChange: HWND;     //AEN_SETFOCUS - handle to the window that has lost the keyboard focus.
  end;
  TAENFOCUS = _AENFOCUS;


type
  _AENSCROLL = record
    hdr: TAENMHDR;
    nPosNew: INT_PTR;     //Current scroll position.
    nPosOld: INT_PTR;     //Previous scroll position.
    nPosMax: INT_PTR;     //Maximum scroll position.
  end;
  TAENSCROLL = _AENSCROLL;


type
  _AENSETRECT = record
    hdr: TAENMHDR;
    rcDraw: TRect;         //Draw rectangle.
    rcEdit: TRect;         //Edit client rectangle.
  end;
  TAENSETRECT = _AENSETRECT;


type
  _AENPAINT = record
    hdr: TAENMHDR;
    dwType: DWORD;            //See AEPNT_* defines.
    hDC: HDC;                 //Device context.
    ciMinDraw: TAECHARINDEX;  //First index in line to paint.
    ciMaxDraw: TAECHARINDEX;  //Last index in line to paint.
    nMinDrawOffset: INT_PTR;  //First character in line to paint (RichEdit offset).
    nMaxDrawOffset: INT_PTR;  //Last character in line to paint (RichEdit offset).
    ptMinDraw: TPoint;        //Left upper corner in client coordinates of first character in line to paint.
    ptMaxDraw: TPoint;        //Left upper corner in client coordinates of last character in line to paint.
  end;
  TAENPAINT = _AENPAINT;


type
  _AENMAXTEXT = record
    hdr: TAENMHDR;
    dwTextLimit: UINT_PTR;   //Current text limit.
  end;
  TAENMAXTEXT = _AENMAXTEXT;


type
  _AENPROGRESS = record
    hdr: TAENMHDR;
    dwType: DWORD;        //See AEPGS_* defines.
    dwTimeElapsed: DWORD; //Elapsed time since action was start.
    nCurrent: INT_PTR;    //Characters processed. Equal to zero, if first message.
    nMaximum: INT_PTR;    //Total number of characters. Equal to nCurrent member, if last message.
  end;
  TAENPROGRESS = _AENPROGRESS;


type
  _AENMODIFY = record
    hdr: TAENMHDR;
    bModified: BOOL;      //TRUE document state is set to modified, FALSE document state is set to unmodified.
  end;
  TAENMODIFY = _AENMODIFY;


type
  _AENSELCHANGE = record
    hdr: TAENMHDR;
    crSel: TAECHARRANGE;      //Current selection.
    ciCaret: TAECHARINDEX;  //Caret character index position.
    dwType: DWORD;         //See AESCT_* defines.
    bColumnSel: BOOL;       //Column selection.
    crRichSel: TCHARRANGE64; //Current selection (RichEdit offset).
  end;
  TAENSELCHANGE = _AENSELCHANGE;


type
  _AENTEXTCHANGE = record
    hdr: TAENMHDR;
    crSel: TAECHARRANGE;      //Current selection.
    ciCaret: TAECHARINDEX;  //Caret character index position.
    dwType: DWORD;         //See AETCT_* defines.
    bColumnSel: BOOL;       //Column selection.
    crRichSel: TCHARRANGE64; //Current selection (RichEdit offset).
  end;
  TAENTEXTCHANGE = _AENTEXTCHANGE;


type
  _AENTEXTINSERT = record
    hdr: TAENMHDR;
    crSel: TAECHARRANGE;       //Reserved.
    ciCaret: TAECHARINDEX;     //Reserved.
    dwType: DWORD;            //See AETCT_* defines.
    wpText: PWideChar;   //Text to insert.
    dwTextLen: UINT_PTR;      //Text length.
    nNewLine: Integer;            //See AELB_* defines.
    bColumnSel: BOOL;         //Column selection.
    dwInsertFlags: DWORD;     //See AEINST_* defines.
    crAkelRange: TAECHARRANGE; //AEN_TEXTINSERTBEGIN - text insert position or AEN_TEXTINSERTEND - text range after insertion.
    crRichRange: TCHARRANGE64; //AEN_TEXTINSERTBEGIN - text insert position or AEN_TEXTINSERTEND - text range after insertion (RichEdit offset).
  end;
  TAENTEXTINSERT = _AENTEXTINSERT;


type
  _AENTEXTDELETE = record
    hdr: TAENMHDR;
    crSel: TAECHARRANGE;       //Reserved.
    ciCaret: TAECHARINDEX;     //Reserved.
    dwType: DWORD;            //See AETCT_* defines.
    bColumnSel: BOOL;         //Column selection.
    dwDeleteFlags: DWORD;     //See AEDELT_* defines.
    crAkelRange: TAECHARRANGE; //AEN_TEXTDELETEBEGIN - text delete range or AEN_TEXTDELETEEND - text range after deletion.
    crRichRange: TCHARRANGE64; //AEN_TEXTDELETEBEGIN - text delete range or AEN_TEXTDELETEEND - text range after deletion (RichEdit offset).
  end;
  TAENTEXTDELETE = _AENTEXTDELETE;


type
  _AENPOINT = record
    hdr: TAENMHDR;
    dwType: DWORD;        //See AEPTT_* defines.
    lpPoint: PAEPOINT;    //Pointer to a AEPOINT structure. NULL if type is AEPTT_SETTEXT or AEPTT_STREAMIN.
  end;
  TAENPOINT = _AENPOINT;


type
  _AENDROPFILES = record
    hdr: TAENMHDR;
    hDrop: HDROP;         //Handle to the dropped files list (same as with WM_DROPFILES).
    ciChar: TAECHARINDEX;  //Character index at which the dropped files would be inserted.
  end;
  TAENDROPFILES = _AENDROPFILES;


type
  _AENDROPSOURCE = record
    hdr: TAENMHDR;
    nAction: Integer;         //See AEDS_* defines.
    dwEffect: DWORD;      //Cursor effect: DROPEFFECT_COPY, DROPEFFECT_MOVE or DROPEFFECT_NONE.
    dwDropResult: DWORD;  //Drop cResult. Valid if nAction equal to AEDS_SOURCEEND or AEDS_SOURCEDONE.
  end;
  TAENDROPSOURCE = _AENDROPSOURCE;


type
  _AENDROPTARGET = record
    hdr: TAENMHDR;
    nAction: Integer;         //See AEDT_* defines.
    pt: TPoint;            //Cursor position in screen coordinates.
    dwEffect: DWORD;      //Cursor effect: DROPEFFECT_COPY, DROPEFFECT_MOVE or DROPEFFECT_NONE.
  end;
  TAENDROPTARGET = _AENDROPTARGET;


type
  _AENLINK = record
    hdr: TAENMHDR;
    uMsg: UINT;           //Mouse message: WM_LBUTTONDBLCLK, WM_LBUTTONDOWN, WM_LBUTTONUP, WM_MOUSEMOVE, WM_RBUTTONDBLCLK, WM_RBUTTONDOWN, WM_RBUTTONUP, WM_SETCURSOR.
    wParam: WPARAM;       //First parameter of a message.
    lParam: LPARAM;       //Second parameter of a message.
    crLink: TAECHARRANGE;  //Range of characters which contain URL text.
    nVisitCount: Integer;     //URL visit count. Variable must be incremented, if URL is opened.
  end;
  TAENLINK = _AENLINK;


type
  _AENMARKER = record
    hdr: TAENMHDR;
    dwType: DWORD; //Column marker cType.
    dwPos: DWORD;  //Column marker position.
    bMouse: BOOL;  //Column marker position is changed with mouse.
  end;
  TAENMARKER = _AENMARKER;


$$$ DEFINES2 $$$

//// RichEdit messages

(*

//// RichEdit messages

AkelEdit can emulate RichEdit 3.0 and support the following messages:

EN_CHANGE
EN_DRAGDROPDONE
EN_DROPFILES
EN_ERRSPACE
EN_HSCROLL
EN_KILLFOCUS
EN_LINK
EN_MAXTEXT
EN_MSGFILTER
EN_SELCHANGE
EN_SETFOCUS
EN_VSCROLL

EM_AUTOURLDETECT
EM_CANPASTE
EM_CANREDO
EM_CANUNDO
EM_CHARFROMPOS
EM_EMPTYUNDOBUFFER
EM_EXGETSEL
EM_EXLIMITTEXT
EM_EXLINEFROMCHAR
EM_EXSETSEL
EM_FINDTEXT
EM_FINDTEXTEX
EM_FINDTEXTEXW
EM_FINDTEXTW
EM_FINDWORDBREAK
EM_GETAUTOURLDETECT
EM_GETEVENTMASK
EM_GETFIRSTVISIBLELINE
EM_GETLIMITTEXT
EM_GETLINE
EM_GETLINECOUNT
EM_GETMARGINS
EM_GETMODIFY
EM_GETOPTIONS
EM_GETRECT
EM_GETSCROLLPOS
EM_GETSEL
EM_GETSELTEXT
EM_GETTEXTEX
EM_GETTEXTLENGTHEX
EM_GETTEXTRANGE
EM_GETTHUMB
EM_HIDESELECTION
EM_LIMITTEXT
EM_LINEFROMCHAR
EM_LINEINDEX
EM_LINELENGTH
EM_LINESCROLL
EM_POSFROMCHAR
EM_REDO
EM_REPLACESEL
EM_SCROLL
EM_SCROLLCARET
EM_SELECTIONTYPE
EM_SETBKGNDCOLOR
EM_SETEVENTMASK
EM_SETLIMITTEXT
EM_SETMARGINS
EM_SETMODIFY
EM_SETOPTIONS
EM_SETREADONLY
EM_SETRECT
EM_SETRECTNP
EM_SETSCROLLPOS
EM_SETSEL
EM_SETTEXTEX
EM_SETUNDOLIMIT
EM_SHOWSCROLLBAR
EM_STOPGROUPTYPING
EM_STREAMIN
EM_STREAMOUT
EM_UNDO

Additional messages for Unicode support:
EM_REPLACESELA
EM_REPLACESELW
EM_GETTEXTRANGEA
EM_GETTEXTRANGEW
EM_GETSELTEXTA
EM_GETSELTEXTW
EM_GETLINEA
EM_GETLINEW

Additional messages for x64 support:
EM_GETSEL64
EM_EXGETSEL64
EM_EXSETSEL64
EM_FINDTEXTEX64
EM_FINDTEXTEX64A
EM_FINDTEXTEX64W
EM_GETTEXTRANGE64
EM_GETTEXTRANGE64A
EM_GETTEXTRANGE64W
EM_GETTEXTEX64

*)

// Messages manual: look AkelEdit.h

//// UNICODE define
{$ifndef UNICODE}
const
  AES_AKELEDIT = AES_AKELEDITA;
  AES_RICHEDIT20 = AES_RICHEDIT20A;

type
  TTEXTRANGE64 = TTEXTRANGE64A;
  TFINDTEXTEX64 = TFINDTEXTEX64A;

  TAEAPPENDTEXT = TAEAPPENDTEXTA;
  TAEREPLACESEL = TAEREPLACESELA;
  TAETEXTRANGE = TAETEXTRANGEA;
  TAEFINDTEXT = TAEFINDTEXTA;
  TAEDELIMITEM = TAEDELIMITEMA;
  TAEWORDITEM = TAEWORDITEMA;
  TAEQUOTEITEM = TAEQUOTEITEMA;
  TAEMARKTEXTITEM = TAEMARKTEXTITEMA;

const
  AEM_SETTEXT = AEM_SETTEXTA;
  AEM_APPENDTEXT = AEM_APPENDTEXTA;
  AEM_REPLACESEL = AEM_REPLACESELA;
  AEM_GETTEXTRANGE = AEM_GETTEXTRANGEA;
  AEM_FINDTEXT = AEM_FINDTEXTA;
  AEM_ISMATCH = AEM_ISMATCHA;
  AEM_HLCREATETHEME = AEM_HLCREATETHEMEA;
  AEM_HLGETTHEME = AEM_HLGETTHEMEA;
  AEM_HLGETTHEMENAME = AEM_HLGETTHEMENAMEA;
  AEM_HLADDDELIMITER = AEM_HLADDDELIMITERA;
  AEM_HLADDWORD = AEM_HLADDWORDA;
  AEM_HLADDQUOTE = AEM_HLADDQUOTEA;
  AEM_HLADDMARKTEXT = AEM_HLADDMARKTEXTA;
{$else}
const
  AES_AKELEDIT = AES_AKELEDITW;
  AES_RICHEDIT20 = AES_RICHEDIT20W;

type
  TTEXTRANGE64 = TTEXTRANGE64W;
  TFINDTEXTEX64 = TFINDTEXTEX64W;

  TAEAPPENDTEXT = TAEAPPENDTEXTW;
  TAEREPLACESEL = TAEREPLACESELW;
  TAETEXTRANGE = TAETEXTRANGEW;
  TAEFINDTEXT = TAEFINDTEXTW;
  TAEDELIMITEM = TAEDELIMITEMW;
  TAEWORDITEM = TAEWORDITEMW;
  TAEQUOTEITEM = TAEQUOTEITEMW;
  TAEMARKTEXTITEM = TAEMARKTEXTITEMW;

const
  AEM_SETTEXT = AEM_SETTEXTW;
  AEM_APPENDTEXT = AEM_APPENDTEXTW;
  AEM_REPLACESEL = AEM_REPLACESELW;
  AEM_GETTEXTRANGE = AEM_GETTEXTRANGEW;
  AEM_FINDTEXT = AEM_FINDTEXTW;
  AEM_ISMATCH = AEM_ISMATCHW;
  AEM_HLCREATETHEME = AEM_HLCREATETHEMEW;
  AEM_HLGETTHEME = AEM_HLGETTHEMEW;
  AEM_HLGETTHEMENAME = AEM_HLGETTHEMENAMEW;
  AEM_HLADDDELIMITER = AEM_HLADDDELIMITERW;
  AEM_HLADDWORD = AEM_HLADDWORDW;
  AEM_HLADDQUOTE = AEM_HLADDQUOTEW;
  AEM_HLADDMARKTEXT = AEM_HLADDMARKTEXTW;
{$endif}

// Fr0sT: inlines available since D2006
{$IF CompilerVersion >= 16}
  {$DEFINE INLINES}
{$IFEND}

function AEC_IsSurrogate(c: WideChar): Boolean;     {$IFDEF INLINES}inline;{$ENDIF}
function AEC_IsHighSurrogate(c: WideChar): Boolean; {$IFDEF INLINES}inline;{$ENDIF}
function AEC_IsLowSurrogate(c: WideChar): Boolean;  {$IFDEF INLINES}inline;{$ENDIF}
function AEC_ScalarFromSurrogate(high, low: WideChar): UCS4Char;
function AEC_HighSurrogateFromScalar(c: UCS4Char): WideChar;
function AEC_LowSurrogateFromScalar(c: UCS4Char): WideChar;

function AEC_CopyChar(wszTarget: PWideChar; dwTargetSize: DWORD; const wpSource: PWideChar): Integer;
function AEC_IndexInc(var ciChar: TAECHARINDEX): Integer;
function AEC_IndexDec(var ciChar: TAECHARINDEX): Integer;
function AEC_IndexLen(const ciChar: TAECHARINDEX): Integer;
function AEC_IndexCompare(const ciChar1, ciChar2: TAECHARINDEX): Integer;
function AEC_IndexCompareEx(const ciChar1, ciChar2: TAECHARINDEX): Integer;
function AEC_NextLine(var ciChar: TAECHARINDEX): PAELINEDATA;
function AEC_PrevLine(var ciChar: TAECHARINDEX): PAELINEDATA;
function AEC_NextLineEx(const ciIn: TAECHARINDEX; var ciOut: TAECHARINDEX): PAELINEDATA;
function AEC_PrevLineEx(const ciIn: TAECHARINDEX; var ciOut: TAECHARINDEX): PAELINEDATA;
function AEC_NextChar(var ciChar: TAECHARINDEX): PAELINEDATA;
function AEC_PrevChar(var ciChar: TAECHARINDEX): PAELINEDATA;
function AEC_NextCharEx(const ciIn: TAECHARINDEX; var ciOut: TAECHARINDEX): PAELINEDATA;
function AEC_PrevCharEx(const ciIn: TAECHARINDEX; var ciOut: TAECHARINDEX): PAELINEDATA;
function AEC_NextCharInLine(var ciChar: TAECHARINDEX): PAELINEDATA;
function AEC_PrevCharInLine(var ciChar: TAECHARINDEX): PAELINEDATA;
function AEC_NextCharInLineEx(const ciIn: TAECHARINDEX; var ciOut: TAECHARINDEX): PAELINEDATA;
function AEC_PrevCharInLineEx(const ciIn: TAECHARINDEX; var ciOut: TAECHARINDEX): PAELINEDATA;
function AEC_ValidCharInLine(var ciChar: TAECHARINDEX): PAELINEDATA;
function AEC_WrapLineBegin(var ciChar: TAECHARINDEX): Integer;
function AEC_WrapLineEnd(var ciChar: TAECHARINDEX): Integer;
function AEC_WrapLineBeginEx(const ciIn: TAECHARINDEX; var ciOut: TAECHARINDEX): Integer;
function AEC_WrapLineEndEx(const ciIn: TAECHARINDEX; var ciOut: TAECHARINDEX): Integer;
function AEC_CharAtIndex(var ciChar: TAECHARINDEX): Integer;
function AEC_IsCharInSelection(var ciChar: TAECHARINDEX): Boolean;
function AEC_IsFirstCharInLine(var ciChar: TAECHARINDEX): Boolean;
function AEC_IsLastCharInLine(var ciChar: TAECHARINDEX): Boolean;
function AEC_IsFirstCharInFile(var ciChar: TAECHARINDEX): Boolean;
function AEC_IsLastCharInFile(var ciChar: TAECHARINDEX): Boolean;
function AEC_NextFold(var lpFold: PAEFOLD; bRecursive: Boolean): PAEFOLD;
function AEC_PrevFold(var lpFold: PAEFOLD; bRecursive: Boolean): PAEFOLD;

implementation

//// AkelEdit functions

function AEC_IsSurrogate(c: WideChar): Boolean;
begin
  Result := (c >= #$D800) and (c <= #$DFFF);
end;

function AEC_IsHighSurrogate(c: WideChar): Boolean;
begin
  Result := (c >= #$D800) and (c <= #$DBFF);
end;

function AEC_IsLowSurrogate(c: WideChar): Boolean;
begin
  Result := (c >= #$DC00) and (c <= #$DFFF);
end;

function AEC_ScalarFromSurrogate(high, low: WideChar): UCS4Char;
begin
//  ((((high) - $D800) * $400) + ((low) - $DC00) + $10000)
  Result := (Word(high) - $D800)*$400 + (Word(low) - $DC00) + $10000;
end;

function AEC_HighSurrogateFromScalar(c: UCS4Char): WideChar;
begin
  Result := WideChar((c - $10000) div $400 + $D800);
end;

function AEC_LowSurrogateFromScalar(c: UCS4Char): WideChar;
begin
  Result := WideChar((c - $10000) mod $400 + $DC00);
end;

function AEC_CopyChar(wszTarget: PWideChar; dwTargetSize: DWORD; const wpSource: PWideChar): Integer;
begin
  Result := 0;
  if AEC_IsSurrogate(wpSource^) then
  begin
    if dwTargetSize >= 2 then
    begin
      if AEC_IsHighSurrogate(wpSource^) and AEC_IsLowSurrogate((wpSource + 1)^) then
      begin
        if wszTarget <> nil then
        begin
          wszTarget^ := wpSource^;
          (wszTarget + 1)^ := (wpSource + 1)^;
        end;
        Result := 2;
      end;
    end;
  end
  else
  begin
    if wszTarget <> nil then
      wszTarget^ := wpSource^;
    Result := 1;
  end;
end;

function AEC_IndexInc(var ciChar: TAECHARINDEX): Integer;
begin
  Result := 1;

  if (ciChar.nCharInLine >= 0) and (ciChar.nCharInLine + 1 < ciChar.lpLine.nLineLen) then
    if AEC_IsHighSurrogate(ciChar.lpLine.wpLine[ciChar.nCharInLine]) and
       AEC_IsLowSurrogate(ciChar.lpLine.wpLine[ciChar.nCharInLine + 1]) then
         Result := 2;

  Inc(ciChar.nCharInLine, Result);
end;

function AEC_IndexDec(var ciChar: TAECHARINDEX): Integer;
begin
  Result := 1;

  if (ciChar.nCharInLine - 2 >= 0) and (ciChar.nCharInLine - 1 < ciChar.lpLine.nLineLen) then
    if AEC_IsLowSurrogate(ciChar.lpLine.wpLine[ciChar.nCharInLine - 1]) and
       AEC_IsHighSurrogate(ciChar.lpLine.wpLine[ciChar.nCharInLine - 2]) then
         Result := 2;

  Dec(ciChar.nCharInLine, Result);
end;

function AEC_IndexLen(const ciChar: TAECHARINDEX): Integer;
begin
  Result := 1;
  if (ciChar.nCharInLine >= 0) and (ciChar.nCharInLine + 1 < ciChar.lpLine.nLineLen) then
    if AEC_IsHighSurrogate(ciChar.lpLine.wpLine[ciChar.nCharInLine]) and
       AEC_IsLowSurrogate(ciChar.lpLine.wpLine[ciChar.nCharInLine + 1]) then
         Result := 2;
end;

function AEC_IndexCompare(const ciChar1, ciChar2: TAECHARINDEX): Integer;
begin
  if (ciChar1.nLine = ciChar2.nLine) and
     (ciChar1.nCharInLine = ciChar2.nCharInLine) then
     Result := 0
  else
  if (ciChar1.nLine < ciChar2.nLine) or
     ((ciChar1.nLine = ciChar2.nLine) and (ciChar1.nCharInLine < ciChar2.nCharInLine)) then
    Result := -1
  else
    Result := 1;
end;

function AEC_IndexCompareEx(const ciChar1, ciChar2: TAECHARINDEX): Integer;
begin
  if
    ( (ciChar1.nLine = ciChar2.nLine) and (ciChar1.nCharInLine = ciChar2.nCharInLine) ) or
    (
      (ciChar1.lpLine <> nil) and (ciChar2.lpLine <> nil) and
      (
        ( (ciChar1.lpLine.next = ciChar2.lpLine) and (ciChar1.lpLine.nLineBreak = AELB_WRAP) and (ciChar1.nCharInLine = ciChar1.lpLine.nLineLen) and (ciChar2.nCharInLine = 0) ) or
        ( (ciChar2.lpLine.next = ciChar1.lpLine) and (ciChar2.lpLine.nLineBreak = AELB_WRAP) and (ciChar2.nCharInLine = ciChar2.lpLine.nLineLen) and (ciChar1.nCharInLine = 0) )
      ))
    then Result := 0
  else if
    (ciChar1.nLine < ciChar2.nLine) or
    ( (ciChar1.nLine = ciChar2.nLine) and (ciChar1.nCharInLine < ciChar2.nCharInLine) )
    then Result := -1
  else
    Result := 1;
end;

function AEC_NextLine(var ciChar: TAECHARINDEX): PAELINEDATA;
begin
  if ciChar.lpLine <> nil then
  begin
    Inc(ciChar.nLine);
    ciChar.lpLine := ciChar.lpLine.next;
    ciChar.nCharInLine :=0;
  end;
  Result := ciChar.lpLine;
end;

function AEC_PrevLine(var ciChar: TAECHARINDEX): PAELINEDATA;
begin
  if ciChar.lpLine <> nil then
  begin
    Dec(ciChar.nLine);
    ciChar.lpLine := ciChar.lpLine.prev;
    if ciChar.lpLine <> nil then
      ciChar.nCharInLine := ciChar.lpLine.nLineLen
    else
      ciChar.nCharInLine := 0;
  end;
  Result := ciChar.lpLine;
end;

function AEC_NextLineEx(const ciIn: TAECHARINDEX; var ciOut: TAECHARINDEX): PAELINEDATA;
var ciTmp: TAECHARINDEX;
begin
  ciTmp := ciIn;
  if AEC_NextLine(ciTmp) <> nil then
  begin
    ciOut := ciTmp;
    Result := ciOut.lpLine;
  end
  else
  begin
    ciOut := ciIn;
    Result := nil;
  end
end;

function AEC_PrevLineEx(const ciIn: TAECHARINDEX; var ciOut: TAECHARINDEX): PAELINEDATA;
var ciTmp: TAECHARINDEX;
begin
  ciTmp := ciIn;
  if AEC_PrevLine(ciTmp) <> nil then
  begin
    ciOut := ciTmp;
    Result := ciOut.lpLine;
  end
  else
  begin
    ciOut := ciIn;
    Result := nil;
  end
end;

function AEC_NextChar(var ciChar: TAECHARINDEX): PAELINEDATA;
begin
  AEC_IndexInc(ciChar);
  if ciChar.nCharInLine >= ciChar.lpLine.nLineLen then
    if (ciChar.nCharInLine > ciChar.lpLine.nLineLen) or
       (ciChar.lpLine.nLineBreak = AELB_WRAP) then
      AEC_NextLine(ciChar);
  Result := ciChar.lpLine;
end;

function AEC_PrevChar(var ciChar: TAECHARINDEX): PAELINEDATA;
begin
  AEC_IndexDec(ciChar);
  if ciChar.nCharInLine < 0 then
    if AEC_PrevLine(ciChar) <> nil then
      if ciChar.lpLine.nLineBreak = AELB_WRAP then
        AEC_IndexDec(ciChar);
  Result := ciChar.lpLine;
end;

function AEC_NextCharEx(const ciIn: TAECHARINDEX; var ciOut: TAECHARINDEX): PAELINEDATA;
var ciTmp: TAECHARINDEX;
begin
  ciTmp := ciIn;
  if AEC_NextChar(ciTmp) <> nil then
  begin
    ciOut := ciTmp;
    Result := ciOut.lpLine;
  end
  else
  begin
    ciOut := ciIn;
    Result := nil;
  end
end;

function AEC_PrevCharEx(const ciIn: TAECHARINDEX; var ciOut: TAECHARINDEX): PAELINEDATA;
var ciTmp: TAECHARINDEX;
begin
  ciTmp := ciIn;
  if AEC_PrevChar(ciTmp) <> nil then
  begin
    ciOut := ciTmp;
    Result := ciOut.lpLine;
  end
  else
  begin
    ciOut := ciIn;
    Result := nil;
  end
end;

function AEC_NextCharInLine(var ciChar: TAECHARINDEX): PAELINEDATA;
begin
  AEC_IndexInc(ciChar);
  if ciChar.nCharInLine >= ciChar.lpLine.nLineLen then
    if ciChar.lpLine.nLineBreak = AELB_WRAP then
      AEC_NextLine(ciChar)
    else
    begin
      Result := nil;
      Exit;
    end;
  Result := ciChar.lpLine;
end;

function AEC_PrevCharInLine(var ciChar: TAECHARINDEX): PAELINEDATA;
begin
  if ciChar.nCharInLine = 0 then
    if (ciChar.lpLine.prev = nil) or (ciChar.lpLine.prev.nLineBreak <> AELB_WRAP) then
    begin
      Result := nil;
      Exit;
    end;
  AEC_PrevChar(ciChar);
  Result := ciChar.lpLine;
end;

function AEC_NextCharInLineEx(const ciIn: TAECHARINDEX; var ciOut: TAECHARINDEX): PAELINEDATA;
var ciTmp: TAECHARINDEX;
begin
  ciTmp := ciIn;
  if AEC_NextCharInLine(ciTmp) <> nil then
  begin
    ciOut := ciTmp;
    Result := ciOut.lpLine;
  end
  else
  begin
    ciOut := ciIn;
    Result := nil;
  end
end;

function AEC_PrevCharInLineEx(const ciIn: TAECHARINDEX; var ciOut: TAECHARINDEX): PAELINEDATA;
var ciTmp: TAECHARINDEX;
begin
  ciTmp := ciIn;
  if AEC_PrevCharInLine(ciTmp) <> nil then
  begin
    ciOut := ciTmp;
    Result := ciOut.lpLine;
  end
  else
  begin
    ciOut := ciIn;
    Result := nil;
  end
end;

function AEC_ValidCharInLine(var ciChar: TAECHARINDEX): PAELINEDATA;
begin
  if ciChar.nCharInLine >= ciChar.lpLine.nLineLen then
    if ciChar.lpLine.nLineBreak = AELB_WRAP then
      AEC_NextLine(ciChar)
    else
      ciChar.nCharInLine := ciChar.lpLine.nLineLen
  else if ciChar.nCharInLine < 0 then
    ciChar.nCharInLine := 0;
  Result := ciChar.lpLine;
end;

function AEC_WrapLineBegin(var ciChar: TAECHARINDEX): Integer;
begin
  Result := ciChar.nCharInLine;
  if ciChar.lpLine <> nil then
  begin
    while ciChar.lpLine.prev <> nil do
    begin
      if ciChar.lpLine.prev.nLineBreak <> AELB_WRAP then
        Break;
      Dec(ciChar.nLine);
      ciChar.lpLine := ciChar.lpLine.prev;
      Inc(Result, ciChar.lpLine.nLineLen);
    end;
  end;
  ciChar.nCharInLine := 0;
end;

function AEC_WrapLineEnd(var ciChar: TAECHARINDEX): Integer;
begin
  Result := ciChar.lpLine.nLineLen - ciChar.nCharInLine;
  while ciChar.lpLine <> nil do
  begin
    if ciChar.lpLine.nLineBreak <> AELB_WRAP then
      Break;
    Inc(ciChar.nLine);
    ciChar.lpLine := ciChar.lpLine.next;
    Inc(Result, ciChar.lpLine.nLineLen);
  end;
  ciChar.nCharInLine := ciChar.lpLine.nLineLen;
end;

function AEC_WrapLineBeginEx(const ciIn: TAECHARINDEX; var ciOut: TAECHARINDEX): Integer;
begin
  ciOut := ciIn;
  Result := AEC_WrapLineBegin(ciOut);
end;

function AEC_WrapLineEndEx(const ciIn: TAECHARINDEX; var ciOut: TAECHARINDEX): Integer;
begin
  ciOut := ciIn;
  Result := AEC_WrapLineEnd(ciOut);
end;

// Fr0sT: Returns WideChar if >= 0 and line break type if < 0
function AEC_CharAtIndex(var ciChar: TAECHARINDEX): Integer;
begin
  if ciChar.nCharInLine >= ciChar.lpLine.nLineLen then
    if ciChar.lpLine.nLineBreak = AELB_WRAP then
    begin
      Result := Integer(ciChar.lpLine.next.wpLine^);
      if AEC_IsHighSurrogate(WideChar(Result)) then
        Result := AEC_ScalarFromSurrogate(WideChar(Result), (ciChar.lpLine.next.wpLine + 1)^);
      Exit;
    end
    else
      Result := -ciChar.lpLine.nLineBreak
  else
  begin
    Result := Integer( (ciChar.lpLine.wpLine + ciChar.nCharInLine)^ );
    if AEC_IsHighSurrogate(WideChar(Result)) then
      Result := AEC_ScalarFromSurrogate(WideChar(Result), (ciChar.lpLine.next.wpLine + ciChar.nCharInLine + 1)^);
    Exit;
  end;
end;

function AEC_IsCharInSelection(var ciChar: TAECHARINDEX): Boolean;
begin
  Result :=
    (ciChar.lpLine.nSelStart <= ciChar.nCharInLine) and
    (ciChar.nCharInLine < ciChar.lpLine.nSelEnd);
end;

function AEC_IsFirstCharInLine(var ciChar: TAECHARINDEX): Boolean;
begin
  Result :=
    (ciChar.nCharInLine = 0) and
    ((ciChar.lpLine.prev <> nil) or (ciChar.lpLine.prev.nLineBreak <> AELB_WRAP));
end;

function AEC_IsLastCharInLine(var ciChar: TAECHARINDEX): Boolean;
begin
  Result :=
    (ciChar.nCharInLine = ciChar.lpLine.nLineLen) and
    (ciChar.lpLine.nLineBreak <> AELB_WRAP);
end;

function AEC_IsFirstCharInFile(var ciChar: TAECHARINDEX): Boolean;
begin
  Result :=
    (ciChar.nCharInLine = 0) and
    (ciChar.lpLine.prev <> nil);
end;

function AEC_IsLastCharInFile(var ciChar: TAECHARINDEX): Boolean;
begin
  Result :=
    (ciChar.nCharInLine = ciChar.lpLine.nLineLen) and
    (ciChar.lpLine.next <> nil);
end;

function AEC_NextFold(var lpFold: PAEFOLD; bRecursive: Boolean): PAEFOLD;
begin
  if lpFold <> nil then
  begin
    if bRecursive then
      if lpFold.firstChild <> nil then
      begin
        Result := lpFold.firstChild;
        Exit;
      end;
    repeat
      if lpFold.next <> nil then
      begin
        Result := lpFold.next;
        Exit;
      end;
      lpFold := lpFold.parent;
    until lpFold = nil;
  end;
  Result := lpFold;
end;

function AEC_PrevFold(var lpFold: PAEFOLD; bRecursive: Boolean): PAEFOLD;
begin
  if lpFold <> nil then
  begin
    if bRecursive then
      if lpFold.lastChild <> nil then
      begin
        Result := lpFold.lastChild;
        Exit;
      end;
    repeat
      if lpFold.prev <> nil then
      begin
        Result := lpFold.prev;
        Exit;
      end;
      lpFold := lpFold.parent;
    until lpFold = nil;
  end;
  Result := lpFold;
end;

end.
