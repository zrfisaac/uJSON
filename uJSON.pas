{
  Copyright (C) 2005 Fabio Almeida
  fabiorecife@yahoo.com.br

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

  Autor : Jose Fabio Nascimento de Almeida
  Data : 7/11/2005

}
unit uJSON;

interface
uses
  Windows,SysUtils, Classes,  TypInfo;

Type
    TZAbstractObject = class
      function equals(const Value: TZAbstractObject): Boolean; virtual;
      function hash: LongInt;
      function Clone: TZAbstractObject; virtual;
      function toString: string; virtual;
      function instanceOf(const Value: TZAbstractObject): Boolean;
    end;
    
    ClassCastException = class (Exception) end;
    NoSuchElementException = class (Exception) end;
    NumberFormatException = class (Exception) end;
    NullPointerException = class (Exception) end;
    NotImplmentedFeature = class (Exception) end;
    JSONArray = class ;
    _Number =  class ;
    _String = class;
    _Double = class;
    NULL = class ;


    ParseException = class (Exception)
       constructor create (_message : string ; index : integer);
    end;
    JSONTokener = class  (TZAbstractObject)
     public
       constructor create (s: string) ;
       procedure back();
       class function dehexchar(c : char) :integer;
       function more :boolean;
       function next() : char; overload ;
       function next (c:char ) : char; overload ;
       function next (n:integer) : string; overload ;
       function nextClean () : char;
       function nextString (quote : char) : string;
       function nextTo (d : char) : string;  overload ;
       function nextTo (delimiters : string) : char;   overload ;
       function nextValue () : TZAbstractObject ;
       procedure skipPast (_to : string ) ;
       function skipTo (_to : char ): char;
       function syntaxError (_message : string) : ParseException;
       function toString : string;  override;
       function unescape (s : string): string;
    private
      myIndex : integer;
      mySource : string;
    end;


  JSONObject = class (TZAbstractObject)
  private
    myHashMap : TStringList;
  public
    constructor create;  overload;
    constructor create  (jo : JSONObject; sa : array of string); overload;
    constructor create (x : JSONTokener); overload;
    constructor create (map : TStringList); overload;
    constructor create (s : string); overload;

    procedure clean;
    function clone : TZAbstractObject; override;
    function accumulate (key : string; value : TZAbstractObject): JSONObject;
    function get (key : string) : TZAbstractObject;
    function getBoolean (key : string): boolean;
    function getDouble (key : string): double;
    function getInt (key : string): integer;
    function getJSONArray (key : string) :JSONArray;
    function getJSONObject (key : string) : JSONObject;
    function getString (key : string): string;
    function has (key : string) : boolean;
    function isNull (key : string) : boolean;
    function keys : TStringList ;
    function length : integer;
    function names : JSONArray;
    class function numberToString (n: _Number): string;
    class function valueToString(value : TZAbstractObject) : string; overload;
    class function valueToString(value : TZAbstractObject; indentFactor
    , indent : integer) : string; overload;

    function opt (key : string) : TZAbstractObject;
    function optBoolean (key : string): boolean; overload;
    function optBoolean (key : string; defaultValue : boolean): boolean; overload;
    function optDouble (key : string): double; overload;
    function optDouble (key : string; defaultValue : double): double; overload;
    function optInt (key : string): integer; overload;
    function optInt (key : string; defaultValue : integer): integer; overload;
    function optString (key : string): string; overload;
    function optString (key : string; defaultValue : string): string; overload;

    function optJSONArray (key : string): JSONArray; overload;
    function optJSONObject (key : string): JSONObject; overload;

    function put (key : string; value : boolean): JSONObject; overload;
    function put (key : string; value : double): JSONObject; overload;
    function put (key : string; value : integer): JSONObject; overload;
    function put (key : string; value : string): JSONObject; overload;
    function put (key : string; value : TZAbstractObject): JSONObject; overload;

    function putOpt (key : string; value : TZAbstractObject): JSONObject;
    class function quote (s : string): string;
    function remove (key : string): TZAbstractObject;
    procedure assignTo(json: JSONObject);

    function toJSONArray (names : JSONArray) : JSONArray;
    function toString (): string ;  overload; override;
    function toString (indentFactor : integer): string; overload;
    function toString (indentFactor, indent : integer): string; overload;

    destructor destroy;override;
    class function NULL : NULL;
  end;

  JSONArray = class (TZAbstractObject)
  public
    destructor destroy ; override;
    constructor create ; overload;
    constructor create (collection : TList); overload;
    constructor create (x : JSONTokener); overload;
    constructor create (s : string);  overload;
    function get (index : integer) : TZAbstractObject;
    function getBoolean (index : integer) : boolean;
    function getDouble (index : integer) : double;
    function getInt (index : integer): integer;
    function getJSONArray (index : integer) : JSONArray;
    function getJSONObject (index : integer) : JSONObject;
    function getString (index : integer) : string;
    function isNull (index : integer): boolean;
    function join (separator : string) : string;
    function length : integer;
    function opt (index : integer) : TZAbstractObject;
    function optBoolean ( index : integer) : boolean; overload;
    function optBoolean ( index : integer; defaultValue : boolean) : boolean; overload;
    function optDouble (index : integer) : double; overload;
    function optDouble (index : integer; defaultValue :double ) : double ; overload;
    function optInt (index : integer) : integer; overload;
    function optInt (index : integer; defaultValue : integer) : integer; overload;
    function optJSONArray (index : integer) : JSONArray ; overload;
    function optJSONObject (index : integer) : JSONObject ; overload;
    function optString (index : integer) : string; overload;
    function optString (index : integer; defaultValue : string) : string; overload;
    function put ( value : boolean) : JSONArray; overload ;
    function put ( value : double ) : JSONArray;   overload ;
    function put ( value : integer) : JSONArray;   overload ;
    function put ( value : TZAbstractObject) : JSONArray;  overload ;
    function put ( value: string): JSONArray; overload;
    function put ( index : integer ; value : boolean): JSONArray;  overload ;
    function put ( index : integer ; value : double) : JSONArray;  overload ;
    function put ( index : integer ; value : integer) : JSONArray;  overload ;
    function put ( index : integer ; value : TZAbstractObject) : JSONArray;  overload ;
    function put ( index: integer; value: string): JSONArray; overload;
    function toJSONObject (names  :JSONArray ) : JSONObject ;  overload ;
    function toString : string; overload; override;
    function toString (indentFactor : integer) : string; overload;
    function toString (indentFactor, indent : integer) : string; overload;
    function toList () : TList;
  private
    myArrayList : TList;
  end;


  _Number =  class (TZAbstractObject)
     function doubleValue : double; virtual; abstract;
     function intValue : integer; virtual; abstract;
  end;

  _Boolean = class (TZAbstractObject)
    class function _TRUE () : _Boolean;
    class function _FALSE () : _Boolean;
    class function valueOf (b : boolean) : _Boolean;
    constructor create (b : boolean);
    function toString () : string; override;
    function clone :TZAbstractObject;  override;
  private
    fvalue : boolean;
  end;

  _Double = class (_Number)
     constructor create (s : string); overload;
     constructor create (s : _String); overload;
     constructor create (d : double); overload;
     function doubleValue : double; override;
     function intValue : integer;  override;
     function toString () : string ; override;
     class function NaN : double;
     function clone :TZAbstractObject; override;
  private
    fvalue : double;
  end;


  _Integer = class (_Number)
    class function parseInt (s : string; i : integer): integer; overload;
    class function parseInt (s : _String): integer; overload;
    class function toHexString (c : char) : string;
    constructor create (i : integer); overload;
    constructor create (s : string); overload;
    function doubleValue : double; override;
    function intValue : integer;  override;
    function toString () : string; override;
     function clone :TZAbstractObject; override;
  private
    fvalue : integer;
  end;

  _String = class (TZAbstractObject)
   constructor create (s : string);
   function equalsIgnoreCase (s: string) : boolean;
   function Equals(const Value: TZAbstractObject): Boolean; override; 
   function toString() : string; override;
   function clone :TZAbstractObject; override;
  private
     fvalue : string;
  end;

  NULL = class (TZAbstractObject)
     function Equals(const Value: TZAbstractObject): Boolean; override;
     function toString() : string; override;
  end;


var
  gcLista : TList;
  CNULL : NULL;

implementation

const
  CROTINA_NAO_IMPLEMENTADA :string = 'Rotina Não Implementada';

procedure newNotImplmentedFeature () ;
begin
  raise NotImplmentedFeature.create (CROTINA_NAO_IMPLEMENTADA);
end;

function getFormatSettings : TFormatSettings ;
var
  f : TFormatSettings;
begin
 {$IFDEF MSWINDOWS}
  SysUtils.GetLocaleFormatSettings (Windows.GetThreadLocale,f);
 {$ELSE}
    newNotImplmentedFeature();
 {$ENDIF}
  result := f;
  result.DecimalSeparator := '.';
  result.ThousandSeparator := ',';
end;


function HexToInt(S: String): Integer;
var
  I, E, F, G: Integer;

  function DigitValue(C: Char): Integer;
  begin
    case C of
      'A': Result := 10;
      'B': Result := 11;
      'C': Result := 12;
      'D': Result := 13;
      'E': Result := 14;
      'F': Result := 15;
    else
      Result := StrToInt(C);
    end;
  end;

begin
  S := UpperCase(S);
  if S[1] = '$' then Delete(S, 1, 1);
  if S[2] = 'X' then Delete(S, 1, 2);
  E := -1; Result := 0;
  for I := Length(S) downto 1 do begin
    G := 1; for F := 0 to E do G := G*16;
    Result := Result+(DigitValue(S[I])*G);
    Inc(E);
  end;
end;



{ JSONTokener }

(**
     * Construct a JSONTokener from a string.
     *
     * @param s     A source string.
     *)
constructor JSONTokener.create(s: string);
begin
  self.myIndex := 1;
  self.mySource := s;
end;


(**
     * Back up one character. This provides a sort of lookahead capability,
     * so that you can test for a digit or letter before attempting to parse
     * the next number or identifier.
*)
procedure JSONTokener.back;
begin
  if (self.myIndex > 1) then begin
            self.myIndex := self.myIndex - 1;
  end;
end;


(**
     * Get the hex value of a character (base16).
     * @param c A character between '0' and '9' or between 'A' and 'F' or
     * between 'a' and 'f'.
     * @return  An int between 0 and 15, or -1 if c was not a hex digit.
     *)
class function JSONTokener.dehexchar(c: char): integer;
begin
  if ((c >= '0') and (c <= '9')) then begin
      result :=  (ord(c) - ord('0'));
      exit;
  end;
  if ((c >= 'A') and (c <= 'F')) then begin
      result :=  (ord(c) + 10 - ord('A'));
      exit;
  end;
  if ((c >= 'a') and (c <= 'f')) then begin
      result := ord(c) + 10 - ord('a');
      exit;
  end;
  result := -1;
end;


(**
     * Determine if the source string still contains characters that next()
     * can consume.
     * @return true if not yet at the end of the source.
*)
function JSONTokener.more: boolean;
begin
  result := self.myIndex <= System.length(self.mySource)+1;
end;

function JSONTokener.next: char;
begin
   if (more()) then begin
	        result := self.mySource[self.myIndex];
	        self.myIndex := self.myIndex + 1;
          exit;
    end;
		result := chr(0);
end;


 (**
     * Consume the next character, and check that it matches a specified
     * character.
     * @param c The character to match.
     * @return The character.
     * @throws ParseException if the character does not match.
     *)
function JSONTokener.next(c: char): char;
begin
  result := next();
  if (result <> c) then begin
      raise syntaxError('Expected ' + c + ' and instead saw ' +
              result + '.');
  end;
end;


(**
     * Get the next n characters.
     *
     * @param n     The number of characters to take.
     * @return      A string of n characters.
     * @exception ParseException
     *   Substring bounds error if there are not
     *   n characters remaining in the source string.
     *)
function JSONTokener.next(n: integer): string;
var
 i,j : integer;
begin
   i := self.myIndex;
   j := i + n;
   if (j > System.length(self.mySource)) then begin
      raise syntaxError('Substring bounds error');
   end;
   self.myIndex := self.myIndex + n;
   result := copy (self.mySource,i,n); //substring(i, j)
end;

 (**
     * Get the next char in the string, skipping whitespace
     * and comments (slashslash, slashstar, and hash).
     * @throws ParseException
     * @return  A character, or 0 if there are no more characters.
     *)
function JSONTokener.nextClean: char;
var
  c: char;

begin
  while (true) do begin
            c := next();
            if (c = '/') then begin
                case (next()) of
                '/': begin
                    repeat
                        c := next();
                    until (not ((c <> #10) and (c <> #13) and (c <> #0)));
                end ;
                '*': begin
                    while (true) do begin
                        c := next();
                        if (c = #0) then begin
                            raise syntaxError('Unclosed comment.');
                        end;
                        if (c = '*') then begin
                            if (next() = '/') then begin
                                break;
                            end;
                            back();
                        end;
                    end;
                end
                else begin
                    back();
                    result := '/';
                    exit;
                end;
            end;
            end else if (c = '#') then begin
                repeat
                    c := next();
                until (not ((c <> #10) and (c <> #13) and (c <> #0)));
            end else if ((c = #0) or (c > ' ')) then begin
                result := c;
                exit;
            end;
  end; //while
end;


(**
     * Return the characters up to the next close quote character.
     * Backslash processing is done. The formal JSON format does not
     * allow strings in single quotes, but an implementation is allowed to
     * accept them.
     * @param quote The quoting character, either
     *      <code>"</code>&nbsp;<small>(double quote)</small> or
     *      <code>'</code>&nbsp;<small>(single quote)</small>.
     * @return      A String.
     * @exception ParseException Unterminated string.
     *)
function JSONTokener.nextString (quote : char): string;
var
  c : char;
  sb : string;
begin
        sb := '';
        while (true) do begin
            c := next();
            case (c) of
            #0, #10, #13: begin
                raise syntaxError('Unterminated string');
            end;
            '\': begin
                c := next();
                case (c) of
                {'b': // é o backspace = #8
                    sb.append('\b');
                    break;}
                't':
                    sb := sb + #9;
                'n':
                    sb := sb + #10;
                'f':
                    sb := sb + #12;
                'r':
                    sb := sb + #13;
                {case 'u':
                    sb.append((char)Integer.parseInt(next(4), 16));
                    break;
                case 'x' :  \cx  	The control character corresponding to x
                    sb.append((char) Integer.parseInt(next(2), 16));
                    break;}
                  else   sb := sb + c
                end;
            end
            else  begin
                if (c = quote) then begin
                    result := sb;
                    exit;
                end;
                sb := sb + c
            end;
            end;
        end;
end;

(**
     * Get the text up but not including the specified character or the
     * end of line, whichever comes first.
     * @param  d A delimiter character.
     * @return   A string.
     *)
function JSONTokener.nextTo(d: char): string;
var
  sb : string;
  c : char;
begin
  c := #0;
  sb := '';
  while (true) do begin
            c := next();
            if ((c = d) or (c = #0) or (c = #10) or (c = #13)) then begin
                if (c <> #0) then begin
                    back();
                end;
                result := trim (sb);
                exit;
            end;
            sb := sb + c;
  end;
end;

(**
     * Get the text up but not including one of the specified delimeter
     * characters or the end of line, whichever comes first.
     * @param delimiters A set of delimiter characters.
     * @return A string, trimmed.
*)
function JSONTokener.nextTo(delimiters: string): char;
var
  c : char;
  sb : string;
begin
        c := #0;
        sb := '';
        while (true) do begin
            c := next();
            if ((pos (c,delimiters) > 0) or (c = #0) or
                    (c = #10) or (c = #13)) then begin
                if (c <> #0) then begin
                    back();
                end;
                sb := trim(sb);
                if (System.length(sb) > 0) then result := sb[1];
                exit;
            end;
            sb := sb + c;
        end;
end;

(**
     * Get the next value. The value can be a Boolean, Double, Integer,
     * JSONArray, JSONObject, or String, or the JSONObject.NULL object.
     * @exception ParseException The source does not conform to JSON syntax.
     *
     * @return An object.
*)
function JSONTokener.nextValue: TZAbstractObject;
var
  c, b : char;
  s , sb: string;
begin
  c := nextClean();

        case (c) of
            '"', #39: begin
                result := _String.create (nextString(c));
                exit;
            end;
            '{': begin
                back();
                result := JSONObject.create(self);
                exit;
            end;
            '[': begin
                back();
                result := JSONArray.create(self);
                exit;
            end;
        end;

        (*
         * Handle unquoted text. This could be the values true, false, or
         * null, or it can be a number. An implementation (such as this one)
         * is allowed to also accept non-standard forms.
         *
         * Accumulate characters until we reach the end of the text or a
         * formatting character.
         *)

        sb := '';
        b := c;
        while ((ord(c) >= ord(' ')) and (pos (c,',:]}/\\\"[{;=#') = 0)) do begin
            sb := sb + c;
            c := next();
        end;
        back();

        (*
         * If it is true, false, or null, return the proper value.
         *)

        s := trim (sb);
        if (s = '') then begin
            raise syntaxError('Missing value.');
        end;
        if (AnsiLowerCase (s) = 'true') then begin
            result :=  _Boolean._TRUE;
            exit;
        end;

        if (AnsiLowerCase (s) = 'false') then begin
            result := _Boolean._FALSE;
            exit;
        end;
        if (AnsiLowerCase (s) = 'null') then begin
            result := JSONObject.NULL;
            exit;
        end;

        (*
         * If it might be a number, try converting it. We support the 0- and 0x-
         * conventions. If a number cannot be produced, then the value will just
         * be a string. Note that the 0-, 0x-, plus, and implied string
         * conventions are non-standard. A JSON parser is free to accept
         * non-JSON forms as long as it accepts all correct JSON forms.
         *)

        if ( ((b >= '0') and (b <= '9')) or (b = '.')
                          or (b = '-') or (b = '+')) then begin
            if (b = '0') then begin
                if ( (System.length(s) > 2) and
                        ((s[2] = 'x') or (s[2] = 'X') ) ) then begin
                    try
                        result := _Integer.create(_Integer.parseInt(copy(s,3,System.length(s)),
                                                            16));
                        exit;
                    Except
                      on e:Exception do begin
                        ///* Ignore the error */
                      end;
                    end;
                end else begin
                    try
                        result := _Integer.create(_Integer.parseInt(s,
                                                            8));
                        exit;
                    Except
                      on e:Exception do begin
                        ///* Ignore the error */
                      end;
                    end;
                end;
            end;
            try
                result := _Integer.create(s);
                exit;
            Except
                    on e:Exception do begin
                      ///* Ignore the error */
                    end;
            end;

            try
                result := _Double.create(s);
                exit;
            Except
                    on e:Exception do begin
                      ///* Ignore the error */
                    end;
            end;
        end;
        result := _String.create(s);
end;

(**
     * Skip characters until the next character is the requested character.
     * If the requested character is not found, no characters are skipped.
     * @param to A character to skip to.
     * @return The requested character, or zero if the requested character
     * is not found.
     *)
function JSONTokener.skipTo(_to: char): char;
var
  c : char;
  index : integer;
begin
   c := #0;
        index := self.myIndex;
        repeat
            c := next();
            if (c = #0) then begin
                self.myIndex := index;
                result := c;
                exit;
           end;
        until (not (c <> _to));
        back();
        result := c;
        exit;
end;

(**
     * Skip characters until past the requested string.
     * If it is not found, we are left at the end of the source.
     * @param to A string to skip past.
     *)
procedure JSONTokener.skipPast(_to: string);
begin
   self.myIndex := pos (_to, copy(mySource, self.myIndex, System.length(mySource)));
        if (self.myIndex < 0) then begin
            self.myIndex := System.length(self.mySource)+1;
        end else begin
            self.myIndex := self.myIndex + System.length(_to);
        end;
end;



(**
     * Make a ParseException to signal a syntax error.
     *
     * @param message The error message.
     * @return  A ParseException object, suitable for throwing
     *)
function JSONTokener.syntaxError(_message: string): ParseException;
begin
 result := ParseException.create (_message + toString()+' próximo a : '
 + copy (toString(),self.myIndex,10), self.myIndex);
end;


(**
     * Make a printable string of this JSONTokener.
     *
     * @return " at character [this.myIndex] of [this.mySource]"
     *)
function JSONTokener.toString: string;
begin
  result := ' at character ' + intToStr(self.myIndex) + ' of ' + self.mySource;
end;


(**
     * Convert <code>%</code><i>hh</i> sequences to single characters, and
     * convert plus to space.
     * @param s A string that may contain
     *      <code>+</code>&nbsp;<small>(plus)</small> and
     *      <code>%</code><i>hh</i> sequences.
     * @return The unescaped string.
     *)
function JSONTokener.unescape(s: string): string;
var
  len, i,d,e : integer;
  b : string;
  c : char;
begin
  len := System.length(s);
  b := '';
  i := 1;
        while ( i <= len ) do begin
            c := s[i];
            if (c = '+') then begin
                c := ' ';
            end else if ((c = '%') and ((i + 2) <= len)) then begin
                d := dehexchar(s[i + 1]);
                e := dehexchar(s[i + 2]);
                if ((d >= 0) and (e >= 0)) then begin
                    c := chr(d * 16 + e);
                    i := i + 2;
                end;
            end;
            b := b + c;
            i := i + 1;
        end;
        result := b ;
end;

{ JSONObject }




(**
* Construct an empty JSONObject.
*)
constructor JSONObject.create;
begin
  myHashMap := TStringList.create;
end;


(**
     * Construct a JSONObject from a subset of another JSONObject.
     * An array of strings is used to identify the keys that should be copied.
     * Missing keys are ignored.
     * @param jo A JSONObject.
     * @param sa An array of strings.
     *)
constructor JSONObject.create(jo: JSONObject; sa: array of string);
var
 i : integer;
begin
  create();
  for i :=low(sa) to high(sa)  do begin
            putOpt(sa[i], jo.opt(sa[i]).Clone);
  end;
end;

(**
     * Construct a JSONObject from a JSONTokener.
     * @param x A JSONTokener object containing the source string.
     * @throws ParseException if there is a syntax error in the source string.
     *)
constructor JSONObject.create(x: JSONTokener);
var
 c : char;
 key : string;
begin
  create ;
  c := #0;
  key := '';

  if (x.nextClean() <> '{') then begin
      raise x.syntaxError('A JSONObject must begin with "{"');
  end;
  while (true) do begin
      c := x.nextClean();
      case (c) of
      #0:
          raise x.syntaxError('A JSONObject must end with "}"');
      '}': begin
          exit;
      end
      else begin
          x.back();
          key := x.nextValue().toString();
      end
      end; //fim do case

      (*
       * The key is followed by ':'. We will also tolerate '=' or '=>'.
       *)

      c := x.nextClean();
      if (c = '=') then begin
          if (x.next() <> '>') then begin
              x.back();
          end;
      end else if (c <> ':') then begin
          raise x.syntaxError('Expected a ":" after a key');
      end;
      self.myHashMap.AddObject(key, x.nextValue());

      (*
       * Pairs are separated by ','. We will also tolerate ';'.
       *)

      case (x.nextClean()) of
      ';', ',': begin
          if (x.nextClean() = '}') then begin
              exit;
          end;
          x.back();
      end;
      '}': begin
          exit;
      end
      else begin
          raise x.syntaxError('Expected a "," or "}"');
      end
      end;
  end; //while

end;

(**
     * Construct a JSONObject from a Map.
     * @param map A map object that can be used to initialize the contents of
     *  the JSONObject.
     *)
constructor JSONObject.create(map: TStringList);
var
 i : integer;
begin
  self.myHashMap := TStringlist.create;
  for i := 0 to map.Count -1 do begin
    self.myHashMap.AddObject(map[i],map.Objects[i]);
  end;
end;

(**
     * Construct a JSONObject from a string.
     * This is the most commonly used JSONObject constructor.
     * @param string    A string beginning
     *  with <code>{</code>&nbsp;<small>(left brace)</small> and ending
     *  with <code>}</code>&nbsp;<small>(right brace)</small>.
     * @exception ParseException The string must be properly formatted.
     *)
constructor JSONObject.create(s: string);
var
  token : JSOnTokener;
begin
  token :=  JSONTokener.create(s);
  create (token);
  token.free;
end;


(**
     * Accumulate values under a key. It is similar to the put method except
     * that if there is already an object stored under the key then a
     * JSONArray is stored under the key to hold all of the accumulated values.
     * If there is already a JSONArray, then the new value is appended to it.
     * In contrast, the put method replaces the previous value.
     * @param key   A key string.
     * @param value An object to be accumulated under the key.
     * @return this.
     * @throws NullPointerException if the key is null
     *)
function JSONObject.accumulate(key: string; value: TZAbstractObject): JSONObject;
var
 a : JSONArray;
 o : TZAbstractObject;
begin
  a := nil;
  o := opt(key);
  if (o = nil) then begin
      put(key, value);
  end else if (o is JSONArray) then begin
      a := JSONArray(o);
      a.put(value);
  end else  begin
      a := JSONArray.create;
      a.put(o.clone);
      a.put(value);
      put(key, a);
  end;
  result := self;
end;


(**
     * Get the value object associated with a key.
     *
     * @param key   A key string.
     * @return      The object associated with the key.
     * @exception NoSuchElementException if the key is not found.
     *)
function JSONObject.get(key: string): TZAbstractObject;
var
 o : TZAbstractObject;
begin
  o := opt(key);
  if (o = nil) then begin
      raise NoSuchElementException.create('JSONObject[' +
          quote(key) + '] not found.');
  end;
  result := o;
end;


(**
     * Get the boolean value associated with a key.
     *
     * @param key   A key string.
     * @return      The truth.
     * @exception NoSuchElementException if the key is not found.
     * @exception ClassCastException
     *  if the value is not a Boolean or the String "true" or "false".
     *)
function JSONObject.getBoolean(key: string): boolean;
var
 o : TZAbstractObject;
begin
    o := get(key);
    if (o.equals(_Boolean._FALSE) or
            ((o is _String) and
            (_String(o)).equalsIgnoreCase('false'))) then begin
        result := false;
        exit;
    end else if (o.equals(_Boolean._TRUE) or
            ((o is _String) and
            (_String(o)).equalsIgnoreCase('true'))) then begin
        result := true;
        exit;
    end;
    raise ClassCastException.create('JSONObject[' +
        quote(key) + '] is not a Boolean.');
end;

function JSONObject.getDouble(key: string): double;
var
  o : TZAbstractObject;
begin
        o := get(key);
        if (o is _Number) then begin
            result := _Number (o).doubleValue();
            exit;
        end ;
        if (o is _String) then begin
            result := StrToFloat (_String(o).toString(), getFormatSettings());
            exit;
        end;
        raise NumberFormatException.create('JSONObject[' +
            quote(key) + '] is not a number.');
end;


(**
     * Get the int value associated with a key.
     *
     * @param key   A key string.
     * @return      The integer value.
     * @exception NoSuchElementException if the key is not found
     * @exception NumberFormatException
     *  if the value cannot be converted to a number.
     *)
function JSONObject.getInt(key: string): integer;
var
  o : TZAbstractObject;
begin
        o := get(key);
        if (o is _Number) then begin
           result :=  _Number(o).intValue();
        end else begin
           result :=  Round(getDouble(key));
        end;
       
end;


(**
     * Get the JSONArray value associated with a key.
     *
     * @param key   A key string.
     * @return      A JSONArray which is the value.
     * @exception NoSuchElementException if the key is not found or
     *  if the value is not a JSONArray.
     *)
function JSONObject.getJSONArray(key: string): JSONArray;
var
 o : TZAbstractObject;
begin
  o := get(key);
  if (o is JSONArray) then begin
      result := JSONArray(o);
  end else begin
    raise  NoSuchElementException.create('JSONObject[' +
        quote(key) + '] is not a JSONArray.');
  end;
end;


(**
     * Get the JSONObject value associated with a key.
     *
     * @param key   A key string.
     * @return      A JSONObject which is the value.
     * @exception NoSuchElementException if the key is not found or
     *  if the value is not a JSONObject.
     *)
function JSONObject.getJSONObject(key: string): JSONObject;
var
 o : TZAbstractObject;
begin
  o := get(key);
  if (o is JSONObject) then begin
      result := JSONObject(o);
  end else begin
    raise NoSuchElementException.create('JSONObject[' +
        quote(key) + '] is not a JSONObject.');
  end;
end;


(**
     * Get the string associated with a key.
     *
     * @param key   A key string.
     * @return      A string which is the value.
     * @exception NoSuchElementException if the key is not found.
*)
function JSONObject.getString(key: string): string;
begin
  result := get(key).toString();
end;


(**
     * Determine if the JSONObject contains a specific key.
     * @param key   A key string.
     * @return      true if the key exists in the JSONObject.
     *)
function JSONObject.has(key: string): boolean;
begin
   result := self.myHashMap.IndexOf(key) >= 0;
end;


(**
     * Determine if the value associated with the key is null or if there is
     *  no value.
     * @param key   A key string.
     * @return      true if there is no value associated with the key or if
     *  the value is the JSONObject.NULL object.
     *)
function JSONObject.isNull(key: string): boolean;
begin
   result := NULL.equals(opt(key));
end;

function JSONObject.keys: TStringList;
var
 i : integer;
begin
  result := TStringList.Create;
  for i := 0 to myHashMap.Count -1 do begin
    result.add (myHashMap[i]);
  end;
end;

function JSONObject.length: integer;
begin
   result := myHashMap.Count;
end;


(**
     * Produce a JSONArray containing the names of the elements of this
     * JSONObject.
     * @return A JSONArray containing the key strings, or null if the JSONObject
     * is empty.
     *)
function JSONObject.names: JSONArray;
var
  ja :JSONArray;
  i : integer;
  k : TStringList;
begin
    ja := JSONArray.create;
    k := keys;
    try
      for i := 0 to k.Count -1 do begin
        ja.put (_String.create (k[i]));
      end;
      if (ja.length = 0) then begin
         result := nil;
      end else begin
         result := ja;
      end;
    finally
      k.free;
    end;
end;

class function JSONObject.numberToString(n: _Number): string;
begin
   if (n = nil) then begin
     result := '';
   end else if (n is _Integer) then begin
     result := IntToStr(n.intValue)
   end else begin
     result := FloatToStr (n.doubleValue, getFormatSettings());
   end; 
end;


(**
     * Get an optional value associated with a key.
     * @param key   A key string.
     * @return      An object which is the value, or null if there is no value.
     * @exception NullPointerException  The key must not be null.
     *)
function JSONObject.opt(key: string): TZAbstractObject;
begin
   if (key = '') then begin
            raise NullPointerException.create('Null key');
   end else begin
        if myHashMap.IndexOf(key) < 0 then begin
          result := nil;
        end else begin
         result :=  TZAbstractObject (myHashMap.Objects [myHashMap.IndexOf(key)]);
        end;
   end;
end;


(**
     * Get an optional boolean associated with a key.
     * It returns false if there is no such key, or if the value is not
     * Boolean.TRUE or the String "true".
     *
     * @param key   A key string.
     * @return      The truth.
     *)
function JSONObject.optBoolean(key: string): boolean;
begin
  result := optBoolean (key, false);
end;


(**
     * Get an optional boolean associated with a key.
     * It returns the defaultValue if there is no such key, or if it is not
     * a Boolean or the String "true" or "false" (case insensitive).
     *
     * @param key              A key string.
     * @param defaultValue     The default.
     * @return      The truth.
     *)
function JSONObject.optBoolean(key: string;
  defaultValue: boolean): boolean;
var
  o : TZAbstractObject;
begin
        o := opt(key);
        if (o <> nil) then begin
            if (o.equals(_Boolean._FALSE) or
                    ((o is _String) and
                    (_String(o).equalsIgnoreCase('false')))) then begin
                result := false;
                exit;
            end else if (o.equals(_Boolean._TRUE) or
                    ((o is _String) and
                    (_String(o).equalsIgnoreCase('true')))) then begin
                result := true;
                exit;
            end;
        end;
        result := defaultValue;
end;


(**
     * Get an optional double associated with a key,
     * or NaN if there is no such key or if its value is not a number.
     * If the value is a string, an attempt will be made to evaluate it as
     * a number.
     *
     * @param key   A string which is the key.
     * @return      An object which is the value.
     *)
function JSONObject.optDouble(key: string): double;
begin
  result := optDouble(key, _Double.NaN);
end;


(**
     * Get an optional double associated with a key, or the
     * defaultValue if there is no such key or if its value is not a number.
     * If the value is a string, an attempt will be made to evaluate it as
     * a number.
     *
     * @param key   A key string.
     * @param defaultValue     The default.
     * @return      An object which is the value.
     *)
function JSONObject.optDouble(key: string; defaultValue: double): double;
var
 o : TZAbstractObject;
begin
    o := opt(key);
    if (o <> nil) then begin
        if (o is _Number) then begin
            result := (_Number(o)).doubleValue();
            exit;
        end  ;
        try
            result := _Double.create(_String(o)).doubleValue();
            exit;
          except on e:Exception  do begin
            result := defaultValue;
            exit;
          end;
        end;
    end;
    result := defaultValue;
end;

(**
     * Get an optional int value associated with a key,
     * or zero if there is no such key or if the value is not a number.
     * If the value is a string, an attempt will be made to evaluate it as
     * a number.
     *
     * @param key   A key string.
     * @return      An object which is the value.
     *)
function JSONObject.optInt(key: string): integer;
begin
  result := optInt (key, 0);
end;


(**
     * Get an optional int value associated with a key,
     * or the default if there is no such key or if the value is not a number.
     * If the value is a string, an attempt will be made to evaluate it as
     * a number.
     *
     * @param key   A key string.
     * @param defaultValue     The default.
     * @return      An object which is the value.
     *)
function JSONObject.optInt(key: string; defaultValue: integer): integer;
var
  o : TZAbstractObject;
begin
  o := opt(key);
  if (o <> null) then begin
      if (o is _Number) then begin
          result :=  (_Number(o)).intValue();
          exit;
      end;
      try
          result := _Integer.parseInt(_String(o));
        except on e:Exception  do begin
          result := defaultValue;
          exit;
        end;
      end;
  end;
  result := defaultValue;
end;




(**
     * Get an optional JSONArray associated with a key.
     * It returns null if there is no such key, or if its value is not a
     * JSONArray.
     *
     * @param key   A key string.
     * @return      A JSONArray which is the value.
     *)
function JSONObject.optJSONArray(key: string): JSONArray;
var
 o : TZAbstractObject ;
begin
    o := opt(key);
    if (o is JSONArray) then begin
      result := JSONArray(o);
    end else begin
      result := nil;
    end;
end;


(**
     * Get an optional JSONObject associated with a key.
     * It returns null if there is no such key, or if its value is not a
     * JSONObject.
     *
     * @param key   A key string.
     * @return      A JSONObject which is the value.
     *)
function JSONObject.optJSONObject(key: string): JSONObject;
var
 o : TZAbstractObject ;
begin
  o := opt(key);
  if (o is JSONObject) then begin
      result := JSONObject(o);
    end else begin
      result := nil;
    end;
end;

(**
     * Get an optional string associated with a key.
     * It returns an empty string if there is no such key. If the value is not
     * a string and is not null, then it is coverted to a string.
     *
     * @param key   A key string.
     * @return      A string which is the value.
     *)
function JSONObject.optString(key: string): string;
begin
  result := optString(key, '');
end;

(**
     * Get an optional string associated with a key.
     * It returns the defaultValue if there is no such key.
     *
     * @param key   A key string.
     * @param defaultValue     The default.
     * @return      A string which is the value.
     *)
function JSONObject.optString(key, defaultValue: string): string;
var
 o : TZAbstractObject ;
begin
  o := opt(key);
  if (o <> nil) then begin
      result := o.toString();
    end else begin
      result := defaultValue;
    end;
end;

(**
     * Put a key/boolean pair in the JSONObject.
     *
     * @param key   A key string.
     * @param value A boolean which is the value.
     * @return this.
     *)
function JSONObject.put(key: string; value: boolean): JSONObject;
begin
   put(key, _Boolean.valueOf(value));
   result := self;
end;

(**
     * Put a key/double pair in the JSONObject.
     *
     * @param key   A key string.
     * @param value A double which is the value.
     * @return this.
     *)
function JSONObject.put(key: string; value: double): JSONObject;
begin
   put(key, _Double.create(value));
   result := self;
end;


(**
     * Put a key/int pair in the JSONObject.
     *
     * @param key   A key string.
     * @param value An int which is the value.
     * @return this.
     *)
function JSONObject.put(key: string; value: integer): JSONObject;
begin
   put(key, _Integer.create(value));
   result := self;
end;


(**
     * Put a key/value pair in the JSONObject. If the value is null,
     * then the key will be removed from the JSONObject if it is present.
     * @param key   A key string.
     * @param value An object which is the value. It should be of one of these
     *  types: Boolean, Double, Integer, JSONArray, JSONObject, String, or the
     *  JSONObject.NULL object.
     * @return this.
     * @exception NullPointerException The key must be non-null.
     *)
function JSONObject.put(key: string; value: TZAbstractObject): JSONObject;
var
  temp : TObject;
  i : integer;
begin
    if (key = '') then begin
            raise NullPointerException.create('Null key.');
    end ;
    if (value <> nil) then begin
        i := self.myHashMap.IndexOf(key);
        if ( i >= 0) then begin
          temp := self.myHashMap.Objects [i];
          self.myHashMap.Objects[i]  := value;
          temp.free;
        end else begin
        self.myHashMap.AddObject(key, value);
        end;
    end else begin
        temp := remove(key);
        if (temp <> nil) then  begin
          temp.free;
        end;
    end;
    result := self;
end;

function JSONObject.put(key, value: string): JSONObject;
begin
   put(key, _String.create(value));
   result := self;
end;
(**
     * Put a key/value pair in the JSONObject, but only if the
     * value is non-null.
     * @param key   A key string.
     * @param value An object which is the value. It should be of one of these
     *  types: Boolean, Double, Integer, JSONArray, JSONObject, String, or the
     *  JSONObject.NULL object.
     * @return this.
     * @exception NullPointerException The key must be non-null.
     *)
function JSONObject.putOpt(key: string; value: TZAbstractObject): JSONObject;
begin
   if (value <> nil) then begin
    put(key, value);
   end;
   result := self;
end;


(**
     * Produce a string in double quotes with backslash sequences in all the
     * right places.
     * @param string A String
     * @return  A String correctly formatted for insertion in a JSON message.
     *)
class function JSONObject.quote(s: string): string;
var
   b,c : char;
   i, len : integer;
   sb, t : string;
begin
        if ((s = '') or (System.Length(s) = 0)) then begin
            result :=  '""';
        end;

        b := #0;
        c := #0;
        i := 0;
        len := System.length(s);
        //SetLength (s, len+4);
        t := '';

        sb := sb +'"';
        for i := 1 to len do begin
            b := c;
            c := s[i];
            case (c) of
            '\', '"': begin
                sb := sb + '\';
                sb := sb + c;
            end;
            '/': begin
                if (b = '<') then begin
                    sb := sb + '\';
                end;
                sb := sb + c;
            end;
            #8, #9, #10, #12, #13:  begin
                sb := sb + c;
            end;
            else begin
                if (c < ' ') then begin
                    t := '000' + _Integer.toHexString(c);
                    sb := sb + '\u' + copy (t,System.length(t)-3,4);
                end else begin
                    sb := sb + c;
                end;
            end;
            end;
        end;
        sb := sb + '"';
        result := sb;
end;

(**
     * Remove a name and its value, if present.
     * @param key The name to be removed.
     * @return The value that was associated with the name,
     * or null if there was no value.
     *)
function JSONObject.remove(key: string): TZAbstractObject;
begin
  if ( myHashMap.IndexOf(key) < 0) then begin
    result := nil
  end else begin
   result := TZAbstractObject(myHashMap.Objects [myHashMap.IndexOf(key)]);
   self.myHashMap.delete (myHashMap.IndexOf(key));
  end;
end;

(**
     * Produce a JSONArray containing the values of the members of this
     * JSONObject.
     * @param names A JSONArray containing a list of key strings. This
     * determines the sequence of the values in the result.
     * @return A JSONArray of values.
     *)
function JSONObject.toJSONArray(names: JSONArray): JSONArray;
var
 i : integer;
 ja : JSONArray ;
begin
  if ((names = nil) or (names.length() = 0)) then begin
      result := nil;
      exit;
  end;
   ja := JSONArray.create;
  for i := 0 to names.length -1 {; i < names.length(); i += 1)} do begin
      ja.put(self.opt(names.getString(i)));
  end;
  result := ja;
end;


(**
     * Make an JSON external form string of this JSONObject. For compactness, no
     * unnecessary whitespace is added.
     * <p>
     * Warning: This method assumes that the data structure is acyclical.
     *
     * @return a printable, displayable, portable, transmittable
     *  representation of the object, beginning
     *  with <code>{</code>&nbsp;<small>(left brace)</small> and ending
     *  with <code>}</code>&nbsp;<small>(right brace)</small>.
     *)
function JSONObject.toString: string;
var
 _keys : TStringList;
 sb : string;
 o : string;
 i :integer;
begin
      _keys := keys();
      try
      sb := '{';

      for i := 0 to _keys.count -1 do begin
          if (System.length(sb) > 1) then begin
              sb:= sb + ',';
          end;
          o := _keys[i];
          sb := sb + quote(o);
          sb := sb + ':';
          sb:= sb + valueToString(TZAbstractObject(myHashMap.Objects[myHashMap.IndexOf(o)]));
      end;
      sb := sb + '}';
      result := sb;
      finally
        _keys.free;
      end;
end;


(**
     * Make a prettyprinted JSON external form string of this JSONObject.
     * <p>
     * Warning: This method assumes that the data structure is acyclical.
     * @param indentFactor The number of spaces to add to each level of
     *  indentation.
     * @return a printable, displayable, portable, transmittable
     *  representation of the object, beginning
     *  with <code>{</code>&nbsp;<small>(left brace)</small> and ending
     *  with <code>}</code>&nbsp;<small>(right brace)</small>.
     *)
function JSONObject.toString(indentFactor: integer): string;
begin
  result := toString(indentFactor, 0);
end;

(**
     * Make a prettyprinted JSON string of this JSONObject.
     * <p>
     * Warning: This method assumes that the data structure is acyclical.
     * @param indentFactor The number of spaces to add to each level of
     *  indentation.
     * @param indent The indentation of the top level.
     * @return a printable, displayable, transmittable
     *  representation of the object, beginning
     *  with <code>{</code>&nbsp;<small>(left brace)</small> and ending
     *  with <code>}</code>&nbsp;<small>(right brace)</small>.
     *)
function JSONObject.toString(indentFactor, indent: integer): string;
var
 j , i , n , newindent: integer;
 _keys : TStringList;
 o, sb : string;
begin
        i := 0;
        n := length();
        if (n = 0) then begin
            result := '{}';
            exit;
        end;
        _keys := keys();
        sb := sb + '{';
        newindent := indent + indentFactor;
        if (n = 1) then begin
            o := _keys[0];
            sb:= sb + quote(o);
            sb:= sb + ': ';
            sb:= sb + valueToString(TZAbstractObject(myHashMap
            .Objects[myHashMap.IndexOf(o)])
            , indentFactor, indent);
        end else begin
            for j := 0 to _keys.count -1 do begin
                o := _keys[j];
                if (System.length(sb) > 1) then begin
                    sb := sb + ','+ #10;
                end else begin
                    sb:= sb + #10;
                end;
                for i := 0 to newindent -1  do begin
                    sb:= sb + ' ';
                end;
                sb:= sb + quote(o);
                sb:= sb + ': ';
                sb:= sb + valueToString(TZAbstractObject(myHashMap
                .Objects[myHashMap.IndexOf(o)])
                , indentFactor, newindent);
            end;
            if (System.length(sb) > 1) then begin
                sb := sb + #10;
                for i := 0 to indent -1 do begin
                    sb:= sb + ' ';
                end;
            end;
        end;
        sb:= sb + '}';
        result :=  sb;
end;

class function JSONObject.NULL: NULL;
begin
  result := CNULL;
end;

(**
     * Make JSON string of an object value.
     * <p>
     * Warning: This method assumes that the data structure is acyclical.
     * @param value The value to be serialized.
     * @return a printable, displayable, transmittable
     *  representation of the object, beginning
     *  with <code>{</code>&nbsp;<small>(left brace)</small> and ending
     *  with <code>}</code>&nbsp;<small>(right brace)</small>.
     *)
class function JSONObject.valueToString(value: TZAbstractObject): string;
begin
  if ((value = nil) or (value.equals(null))) then begin
      result := 'null';
      exit;
  end;
  if (value is _Number) then begin
      result := numberToString(_Number(value));
      exit;
  end;
  if ((value is _Boolean) or (value is JSONObject) or
          (value is JSONArray)) then begin
      result := value.toString();
      exit;
  end;
  result := quote(value.toString());
end;


(**
     * Make a prettyprinted JSON string of an object value.
     * <p>
     * Warning: This method assumes that the data structure is acyclical.
     * @param value The value to be serialized.
     * @param indentFactor The number of spaces to add to each level of
     *  indentation.
     * @param indent The indentation of the top level.
     * @return a printable, displayable, transmittable
     *  representation of the object, beginning
     *  with <code>{</code>&nbsp;<small>(left brace)</small> and ending
     *  with <code>}</code>&nbsp;<small>(right brace)</small>.
     *)
class function JSONObject.valueToString(value: TZAbstractObject;
  indentFactor, indent: integer): string;
begin
   if ((value = nil) or (value.equals(nil))) then begin
        result := 'null';
        exit;
    end;
    if (value is _Number) then begin
        result := numberToString(_Number(value));
        exit;
    end;
    if (value is _Boolean) then begin
        result :=  value.toString();
        exit;
    end;
    if (value is JSONObject) then begin
        result := ((JSONObject(value)).toString(indentFactor, indent));
        exit;
    end;
    if (value is JSONArray) then begin
        result := ((JSONArray(value)).toString(indentFactor, indent));
        exit;
    end;
    result := quote(value.toString());
end;

{ _Boolean }

function _Boolean.clone: TZAbstractObject;
begin
  result := _Boolean.create(Self.fvalue);
end;

constructor _Boolean.create(b: boolean);
begin
   fvalue := b;
end;


var
  CONST_FALSE : _Boolean ;
  CONST_TRUE : _Boolean;
function _Boolean.toString: string;
begin
  if fvalue then begin
    result := 'true';
  end else begin
    result := 'false';
  end;
end;

class function _Boolean.valueOf(b: boolean): _Boolean;
begin
 if (b) then begin
    result := _TRUE;
 end else begin
    result := _FALSE;
 end;
end;

class function _Boolean._FALSE: _Boolean;
begin
  result := CONST_FALSE;
end;

class function _Boolean._TRUE: _Boolean;
begin
  result := CONST_TRUE;
end;

{ _String }

function _String.clone: TZAbstractObject;
begin
  result := _String.create (self.fvalue);
end;

constructor _String.create(s: string);
begin
  fvalue := s;
end;


function _String.equals(const Value: TZAbstractObject): Boolean;
begin
    result := (value is _String) and (_String (value).fvalue = fvalue);
end;

function _String.equalsIgnoreCase(s: string): boolean;
begin
   result := AnsiLowerCase (s) = AnsiLowerCase (fvalue);
end;

function _String.toString: string;
begin
  result := fvalue;
end;

{ ParseException }

constructor ParseException.create(_message: string; index: integer);
begin
   inherited createFmt(_message+#10#13' erro no caracter : %d',[index]);
end;

{ _Integer }

constructor _Integer.create(i: integer);
begin
  fvalue := i;
end;

function _Integer.clone: TZAbstractObject;
begin
  result := _Integer.create (self.fvalue);
end;

constructor _Integer.create(s: string);
begin
  fvalue := strToInt (s);
end;

function _Integer.doubleValue: double;
begin
  result := fvalue;
end;

function _Integer.intValue: integer;
begin
  result := fvalue;
end;



class function _Integer.parseInt(s: string; i: integer): integer;
begin
  case i of
  10: begin
    result := strToInt (s);
  end;
  16: begin
   result := hexToInt (s);
  end;
  8: begin
      newNotImplmentedFeature () ;
  end;
  end;
end;



class function _Integer.parseInt(s: _String): integer;
begin
  result := _Integer.parseInt (s.toString, 10);
end;

class function _Integer.toHexString(c: char): string;
begin
  result := IntToHex(ord(c),2);
end;

function _Integer.toString: string;
begin
  result := intToStr (fvalue);
end;


{ _Double }

constructor _Double.create(s: string);
begin
  fvalue := StrToFloat (s, getFormatSettings);
end;

constructor _Double.create(s: _String);
begin
  create (s.toString);
end;


function _Double.clone: TZAbstractObject;
begin
  result := _Double.create (Self.fvalue);
end;

constructor _Double.create(d: double);
begin
  fvalue := d;
end;

function _Double.doubleValue: double;
begin
  result := fvalue;
end;

function _Double.intValue: integer;
begin
  result := trunc (fvalue);
end;

class function _Double.NaN: double;
begin
  result := 3.6e-4951;
end;

function _Double.toString: string;
begin
  result := floatToStr (fvalue, getFormatSettings);
end;

{ JSONArray }

(**
     * Construct a JSONArray from a JSONTokener.
     * @param x A JSONTokener
     * @exception ParseException A JSONArray must start with '['
     * @exception ParseException Expected a ',' or ']'
     *)
constructor JSONArray.create(x: JSONTokener);
begin
  create;
  if (x.nextClean() <> '[') then begin
      raise x.syntaxError('A JSONArray must start with "["');
  end;
  if (x.nextClean() = ']') then begin
      exit;
  end;
  x.back();
  while (true) do begin
      if (x.nextClean() = ',') then begin
          x.back();
          myArrayList.add(nil);
      end else begin
          x.back();
          myArrayList.add(x.nextValue());
      end;
      case (x.nextClean()) of
      ';',',': begin
          if (x.nextClean() = ']') then begin
              exit;
          end;
          x.back();
      end;
      ']': begin
          exit;
      end else begin
         raise x.syntaxError('Expected a "," or "]"');
      end
      end;
  end;
end;

destructor JSONObject.destroy;
var
 i :integer;
begin
    while myHashMap.Count > 0 do begin
      if (myHashMap.Objects [0] <> CONST_FALSE)
        and (myHashMap.Objects [0] <> CONST_TRUE)
        and (myHashMap.Objects [0] <> CNULL) then begin
        myHashMap.Objects [0].Free;
      end;
      myHashMap.Objects [0] := nil;
      myHashMap.Delete(0);
    end;
  myHashMap.Free;
  inherited;
end;

(**
     * Construct a JSONArray from a Collection.
     * @param collection     A Collection.
     *)
constructor JSONArray.create(collection: TList);
var
  i : integer;
begin
  myArrayList := TList.create ();
  for i := 0 to collection.count -1 do begin
     myArrayList.add (collection[i]);
  end;
end;

(**
 * Construct an empty JSONArray.
*)
constructor JSONArray.create;
begin
   myArrayList := TList.create;
end;


(**
     * Construct a JSONArray from a source string.
     * @param string     A string that begins with
     * <code>[</code>&nbsp;<small>(left bracket)</small>
     *  and ends with <code>]</code>&nbsp;<small>(right bracket)</small>.
     *  @exception ParseException The string must conform to JSON syntax.
     *)
constructor JSONArray.create(s: string);
begin
  create (JSONTokener.create(s));
end;

destructor JSONArray.destroy;
var
 i : integer;
 obj : TObject;
begin
  while myArrayList.Count > 0 do begin
    obj := myArrayList [0];
    myArrayList [0] := nil;
    if (obj <> CONST_FALSE)
      and (obj <> CONST_TRUE)
      and (obj <> CNULL) then begin
        obj.Free;
    end;
    myArrayList.Delete(0);
  end;
  myArrayList.Free;
  inherited;
end;


(**
     * Get the object value associated with an index.
     * @param index
     *  The index must be between 0 and length() - 1.
     * @return An object value.
     * @exception NoSuchElementException
     *)
function JSONArray.get(index: integer): TZAbstractObject;
var
  o : TZAbstractObject;
begin
  o := opt(index);
  if (o = nil) then begin
      raise NoSuchElementException.create('JSONArray[' + intToStr(index)
        + '] not found.');
  end ;
  result := o;
end;


(**
     * Get the boolean value associated with an index.
     * The string values "true" and "false" are converted to boolean.
     *
     * @param index The index must be between 0 and length() - 1.
     * @return      The truth.
     * @exception NoSuchElementException if the index is not found
     * @exception ClassCastException
     *)
function JSONArray.getBoolean(index: integer): boolean;
var
  o : TZAbstractObject;
begin
  o := get(index);
  if ((o.equals(_Boolean._FALSE) or
          ((o is _String) and
          (_String(o)).equalsIgnoreCase('false')))) then begin
      result := false;
      exit;
  end else if ((o.equals(_Boolean._TRUE) or
          ((o is _String) and
          (_String(o)).equalsIgnoreCase('true')))) then begin
      result := true;
      exit;
  end;
  raise ClassCastException.create('JSONArray[' + intToStr(index) +
      '] not a Boolean.');
end;

(**
     * Get the double value associated with an index.
     *
     * @param index The index must be between 0 and length() - 1.
     * @return      The value.
     * @exception NoSuchElementException if the key is not found
     * @exception NumberFormatException
     *  if the value cannot be converted to a number.
     *)
function JSONArray.getDouble(index: integer): double;
var
  o : TZAbstractObject;
  d : _Double;
begin
  o := get(index);
  if (o is _Number) then begin
      result := (_Number(o)).doubleValue();
      exit;
  end;
  if (o is _String) then begin
      d :=  _Double.create(_String(o));
      try
       result := d.doubleValue();
       exit;
      finally
       d.Free;
      end; 
  end;
  raise NumberFormatException.create('JSONObject['
     + intToStr(index) + '] is not a number.');
end;


(**
     * Get the int value associated with an index.
     *
     * @param index The index must be between 0 and length() - 1.
     * @return      The value.
     * @exception NoSuchElementException if the key is not found
     * @exception NumberFormatException
     *  if the value cannot be converted to a number.
     *)
function JSONArray.getInt(index: integer): integer;
var
  o : TZAbstractObject;
begin
  o := get(index);
  if (o is _Number) then begin
    result := _Number(o).intValue();
  end else begin
    result := trunc (getDouble (index));
  end;
end;


(**
     * Get the JSONArray associated with an index.
     * @param index The index must be between 0 and length() - 1.
     * @return      A JSONArray value.
     * @exception NoSuchElementException if the index is not found or if the
     * value is not a JSONArray
     *)
function JSONArray.getJSONArray(index: integer): JSONArray;
var
 o : TZAbstractObject;
begin
  o := get(index);
  if (o is JSONArray) then begin
      result := JSONArray(o);
      exit;
  end;
  raise NoSuchElementException.create('JSONArray[' + intToStr(index) +
          '] is not a JSONArray.');
end;


(**
     * Get the JSONObject associated with an index.
     * @param index subscript
     * @return      A JSONObject value.
     * @exception NoSuchElementException if the index is not found or if the
     * value is not a JSONObject
     *)
function JSONArray.getJSONObject(index: integer): JSONObject;
var
  o : TZAbstractObject;
  s : string;
begin
  o := get(index);
  if (o is JSONObject) then begin
      result := JSONObject(o);
  end else begin
      if o <> nil then begin
        s := o.ClassName;
      end else begin
        s := 'nil';
      end;
      raise NoSuchElementException.create('JSONArray[' + intToStr(index) +
        '] is not a JSONObject is ' + s);
  end;
end;

(**
     * Get the string associated with an index.
     * @param index The index must be between 0 and length() - 1.
     * @return      A string value.
     * @exception NoSuchElementException
     *)
function JSONArray.getString(index: integer): string;
begin
  result := get(index).toString();
end;

(**
 * Determine if the value is null.
 * @param index The index must be between 0 and length() - 1.
 * @return true if the value at the index is null, or if there is no value.
 *)

function JSONArray.isNull(index: integer): boolean;
var
 o : TZAbstractObject;
begin
    o := opt(index);
    result := (o = nil) or (o.equals(nil));
end;

(**
 * Make a string from the contents of this JSONArray. The separator string
 * is inserted between each element.
 * Warning: This method assumes that the data structure is acyclical.
 * @param separator A string that will be inserted between the elements.
 * @return a string.
 *)
function JSONArray.join(separator: string): string;
var
  len, i : integer;
  sb : string ;
begin
		len := length();
    sb := '';
    for i := 0 to len -1 do begin
        if (i > 0) then begin
            sb := sb + separator;
        end;
        sb:= sb + JSONObject.valueToString(TZAbstractObject( myArrayList[i]));
    end;
    result := sb;
end;

(**
 * Get the length of the JSONArray.
 *
 * @return The length (or size).
 *)
function JSONArray.length: integer;
begin
  result := myArrayList.Count ;
end;

 (**
     * Get the optional object value associated with an index.
     * @param index The index must be between 0 and length() - 1.
     * @return      An object value, or null if there is no
     *              object at that index.
     *)
function JSONArray.opt(index: integer): TZAbstractObject;
begin
    if ((index < 0) or (index >= length()) ) then begin
       result := nil;
    end else begin
      result := TZAbstractObject (myArrayList[index]);
    end;
end;

(**
     * Get the optional boolean value associated with an index.
     * It returns false if there is no value at that index,
     * or if the value is not Boolean.TRUE or the String "true".
     *
     * @param index The index must be between 0 and length() - 1.
     * @return      The truth.
     *)
function JSONArray.optBoolean(index: integer): boolean;
begin
  result := optBoolean(index, false);
end;

(**
     * Get the optional boolean value associated with an index.
     * It returns the defaultValue if there is no value at that index or if it is not
     * a Boolean or the String "true" or "false" (case insensitive).
     *
     * @param index The index must be between 0 and length() - 1.
     * @param defaultValue     A boolean default.
     * @return      The truth.
     *)
function JSONArray.optBoolean(index: integer;
  defaultValue: boolean): boolean;
var
 o : TZAbstractObject;
begin
  o := opt(index);
  if (o <> nil) then begin
      if ((o.equals(_Boolean._FALSE) or
              ((o is _String) and
              (_String(o)).equalsIgnoreCase('false')))) then begin
          result := false;
          exit;
      end else if ((o.equals(_Boolean._TRUE) or
              ((o is _String) and
              (_String(o)).equalsIgnoreCase('true')))) then begin
          result := true;
          exit;
      end;
  end;
  result := defaultValue;
end;


(**
 * Get the optional double value associated with an index.
 * NaN is returned if the index is not found,
 * or if the value is not a number and cannot be converted to a number.
 *
 * @param index The index must be between 0 and length() - 1.
 * @return      The value.
 *)
function JSONArray.optDouble(index: integer): double;
begin
   result := optDouble(index, _Double.NaN);
end;

(**
 * Get the optional double value associated with an index.
 * The defaultValue is returned if the index is not found,
 * or if the value is not a number and cannot be converted to a number.
 *
 * @param index subscript
 * @param defaultValue     The default value.
 * @return      The value.
 *)
function JSONArray.optDouble(index: integer; defaultValue :double): double;
var
 o : TZAbstractObject;
 d : _Double;
begin
  o := opt(index);
  if (o <> nil) then begin
      if (o is _Number) then begin
          result := (_Number(o)).doubleValue();
          exit;
      end;
      try
          d := _Double.create (_String (o));
          result := d.doubleValue ;
          d.Free;
	  exit;
      except
        on e:Exception  do begin
          result := defaultValue;
        end;
      end;
  end;
  result := defaultValue;
end;

(**
 * Get the optional int value associated with an index.
 * Zero is returned if the index is not found,
 * or if the value is not a number and cannot be converted to a number.
 *
 * @param index The index must be between 0 and length() - 1.
 * @return      The value.
 *)
function JSONArray.optInt(index: integer): integer;
begin
  result := optInt(index, 0);
end;


(**
 * Get the optional int value associated with an index.
 * The defaultValue is returned if the index is not found,
 * or if the value is not a number and cannot be converted to a number.
 * @param index The index must be between 0 and length() - 1.
 * @param defaultValue     The default value.
 * @return      The value.
 *)
function JSONArray.optInt(index, defaultValue: integer): integer;
var
  o : TZAbstractObject;
begin
  o := opt(index);
  if (o <> nil) then begin
      if (o is _Number) then begin
          result :=  (_Number(o)).intValue();
      end;
      try
        result := _Integer.parseInt(_String(o));
        exit;
      except on e: exception do begin
        result := defaultValue;
      end;
      end;
  end;
  result := defaultValue;
end;


(**
 * Get the optional JSONArray associated with an index.
 * @param index subscript
 * @return      A JSONArray value, or null if the index has no value,
 * or if the value is not a JSONArray.
 *)
function JSONArray.optJSONArray(index: integer): JSONArray;
var
 o : TZAbstractObject;
begin
  o := opt(index);
  if (o is JSONArray) then begin
    result := JSONArray (o) ;
  end else begin
    result := nil;
  end;
end;

(**
 * Get the optional JSONObject associated with an index.
 * Null is returned if the key is not found, or null if the index has
 * no value, or if the value is not a JSONObject.
 *
 * @param index The index must be between 0 and length() - 1.
 * @return      A JSONObject value.
 *)
function JSONArray.optJSONObject(index: integer): JSONObject;
var
  o : TZAbstractObject;
begin
  o := opt(index);
  if (o is JSONObject) then begin
      result := JSONObject (o);
  end else begin
      result := nil;
  end;
end;


(**
 * Get the optional string value associated with an index. It returns an
 * empty string if there is no value at that index. If the value
 * is not a string and is not null, then it is coverted to a string.
 *
 * @param index The index must be between 0 and length() - 1.
 * @return      A String value.
 *)
function JSONArray.optString(index: integer): string;
begin
  result := optString(index, '');
end;

(**
 * Get the optional string associated with an index.
 * The defaultValue is returned if the key is not found.
 *
 * @param index The index must be between 0 and length() - 1.
 * @param defaultValue     The default value.
 * @return      A String value.
 *)
function JSONArray.optString(index: integer; defaultValue: string): string;
var
  o : TZAbstractObject;
begin
  o := opt(index);
  if (o <> nil) then begin
     result := o.toString();
  end else begin
     result := defaultValue;
  end;
end;



(**
 * Append a boolean value.
 *
 * @param value A boolean value.
 * @return this.
 *)
function JSONArray.put(value: boolean): JSONArray;
begin
  put(_Boolean.valueOf(value));
  result :=  self;
end;

(**
 * Append a double value.
 *
 * @param value A double value.
 * @return this.
 *)
function JSONArray.put(value: double): JSONArray;
begin
    put(_Double.create(value));
    result := self;
end;

(**
 * Append an int value.
 *
 * @param value An int value.
 * @return this.
 *)
function JSONArray.put(value: integer): JSONArray;
begin
  put(_Integer.create(value));
  result := self;
end;


function JSONArray.put(value: string): JSONArray;
begin
    put (_String.create (value));
    result := self;
end;


(**
 * Append an object value.
 * @param value An object value.  The value should be a
 *  Boolean, Double, Integer, JSONArray, JSObject, or String, or the
 *  JSONObject.NULL object.
 * @return this.
 *)
function JSONArray.put(value: TZAbstractObject): JSONArray;
begin
    myArrayList.add(value);
    result := self;
end;

(**
 * Put or replace a boolean value in the JSONArray.
 * @param index subscript The subscript. If the index is greater than the length of
 *  the JSONArray, then null elements will be added as necessary to pad
 *  it out.
 * @param value A boolean value.
 * @return this.
 * @exception NoSuchElementException The index must not be negative.
 *)
function JSONArray.put(index: integer; value: boolean): JSONArray;
begin
  put(index, _Boolean.valueOf(value));
  result := self;
end;

function JSONArray.put(index, value: integer): JSONArray;
begin
  put(index, _Integer.create(value));
  result := self;
end;


function JSONArray.put(index: integer; value: double): JSONArray;
begin
  put(index, _Double.create(value));
  result := self;
end;

function JSONArray.put(index: integer; value: string): JSONArray;
begin
  put (index,_String.create (value));
  result := self;
end;

(**
     * Put or replace an object value in the JSONArray.
     * @param index The subscript. If the index is greater than the length of
     *  the JSONArray, then null elements will be added as necessary to pad
     *  it out.
     * @param value An object value.
     * @return this.
     * @exception NoSuchElementException The index must not be negative.
     * @exception NullPointerException   The index must not be null.
     *)
function JSONArray.put(index: integer; value: TZAbstractObject): JSONArray;
begin
    if (index < 0) then begin
        raise NoSuchElementException.create('JSONArray['
          + intToStr(index) + '] not found.');
    end else if (value = nil) then begin
        raise NullPointerException.create('');
    end else if (index < length()) then begin
        myArrayList[index] := value;
    end else begin
        while (index <> length()) do begin
            put(nil);
        end;
        put(value);
    end;
    result := self;
end;

(**
 * Produce a JSONObject by combining a JSONArray of names with the values
 * of this JSONArray.
 * @param names A JSONArray containing a list of key strings. These will be
 * paired with the values.
 * @return A JSONObject, or null if there are no names or if this JSONArray
 * has no values.
 *)
function JSONArray.toJSONObject(names :JSONArray): JSONObject;
var
  jo : JSONObject ;
  i : integer;
begin
  if ((names = nil) or (names.length() = 0) or (length() = 0)) then begin
      result := nil;
  end;
  jo := JSONObject.create();
  for i := 0 to names.length() do begin
      jo.put(names.getString(i), self.opt(i));
  end;
  result := jo;
end;


(**
 * Make an JSON external form string of this JSONArray. For compactness, no
 * unnecessary whitespace is added.
 * Warning: This method assumes that the data structure is acyclical.
 *
 * @return a printable, displayable, transmittable
 *  representation of the array.
 *)
function JSONArray.toString: string;
begin
   result := '[' + join(',') + ']';
end;

(**
     * Make a prettyprinted JSON string of this JSONArray.
     * Warning: This method assumes that the data structure is non-cyclical.
     * @param indentFactor The number of spaces to add to each level of
     *  indentation.
     * @return a printable, displayable, transmittable
     *  representation of the object, beginning
     *  with <code>[</code>&nbsp;<small>(left bracket)</small> and ending
     *  with <code>]</code>&nbsp;<small>(right bracket)</small>.
     *)
function JSONArray.toString(indentFactor: integer): string;
begin
  result := toString(indentFactor, 0);
end;

(**
     * Make a prettyprinted string of this JSONArray.
     * Warning: This method assumes that the data structure is non-cyclical.
     * @param indentFactor The number of spaces to add to each level of
     *  indentation.
     * @param indent The indention of the top level.
     * @return a printable, displayable, transmittable
     *  representation of the array.
     *)
function JSONArray.toList: TList;
begin
  result := TList.create ;
  result.Assign(myArrayList,laCopy);
end;

function JSONArray.toString(indentFactor, indent: integer): string;
var
  len, i,j, newindent : integer;
  sb : string;
begin
    len := length();
    if (len = 0) then begin
        result := '[]';
        exit;
    end;
    i := 0;
    sb := '[';
    if (len = 1) then begin
        sb := sb + JSONObject
        .valueToString(TZAbstractObject( myArrayList[0]),indentFactor, indent);
    end else begin
        newindent := indent + indentFactor;
        sb := sb + #10 ;
        for i := 0 to len -1 do begin
            if (i > 0) then begin
                sb := sb +',' + #10;
            end;
            for j := 0 to newindent-1 do begin
                sb := sb + ' ';
            end;
            sb := sb + (JSONObject
              .valueToString(TZAbstractObject(myArrayList[i]),
                    indentFactor, newindent));
        end;
        sb := sb + #10;
        for i := 0 to indent-1 do begin
            sb := sb + ' ';
        end;
    end;
    sb := sb + ']';
    result := sb;
end;


{ _NULL }

function NULL.Equals(const Value: TZAbstractObject): Boolean;
begin
  if (value = nil) then begin
    result := true;
  end else begin
    result := (value is NULL) ;
  end;
end;

function NULL.toString: string;
begin
  result := 'null';
end;


{ TZAbstractObject }

function TZAbstractObject.Clone: TZAbstractObject;
begin
  newNotImplmentedFeature();
end;

function TZAbstractObject.Equals(const Value: TZAbstractObject): Boolean;
begin
  result := (value <> nil) and (value = self);
end;

function TZAbstractObject.Hash: LongInt;
begin
  result := integer(addr(self));
end;

function TZAbstractObject.InstanceOf(
  const Value: TZAbstractObject): Boolean;
begin
  result := value is TZAbstractObject;
end;

function TZAbstractObject.ToString: string;
begin
 result := Format('%s <%p>', [ClassName, addr(Self)]);
end;

procedure JSONObject.clean;
var
  sl : TStringList;
  i : integer;
  obj : TObject;
begin
    sl := keys;
    for i := 0 to sl.count -1 do begin
      obj := remove(sl[i]);
      if (obj <> nil) then begin
        FreeAndNil (obj);
      end;
    end;
    sl.free;
end;


(**
* Assign the values to other json Object.
* @param JSONObject  objeto to assign Values
*)
procedure JSONObject.assignTo (json : JSONObject) ;
var
 _keys : TStringList;
 i : integer;
begin
  _keys := keys;
  try
    for i := 0 to _keys.Count -1 do begin
      json.put (_keys[i],get(_keys[i]).clone);
    end;
  finally
   _keys.free;
  end;
end;

function JSONObject.clone: TZAbstractObject;
var
 json : JSONObject;
begin
  json := JSONOBject.create (self.toString());
end;


{ _Number }


initialization
  CONST_FALSE :=  _Boolean.create (false);
  CONST_TRUE :=  _Boolean.create (true);
  CNULL := NULL.create;

finalization
  CONST_FALSE.free;
  CONST_TRUE.Free;
  CNULL.free;
end.
