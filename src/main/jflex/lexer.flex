package lyc.compiler;

import java_cup.runtime.Symbol;
import lyc.compiler.ParserSym;
import lyc.compiler.files.SymbolTableGenerator;import lyc.compiler.model.*;
import javax.xml.transform.stream.StreamSource;
import static lyc.compiler.constants.Constants.*;
import lyc.compiler.files.SymbolTableGenerator.*;

%%

%public
%class Lexer
%unicode
%cup
%line
%column
%throws CompilerException
%eofval{
  return symbol(ParserSym.EOF);
%eofval}


%{
            private void validateIntegerLength() throws InvalidIntegerException, InvalidLengthException {
                System.out.println("Validacion entero");
                long value =  Long.valueOf(Long.parseLong(yytext()));
                if ( value < MIN_INTEGER_LENGTH  || value > MAX_INTEGER_LENGTH )
                {
                    throw new InvalidIntegerException("Constante entera fuera de rango en la linea" + yyline + "\n");
                }
                if ( yytext().length() > MAX_STRING_LENGTH )
                {
                    throw new InvalidLengthException("Capacidad maxima de caracteres asignados superada en la linea" + yyline + "\n");
                }
                //yyparser.yylval = new parserval(value);
            }
            private void validateFloatLength() throws InvalidFloatException, InvalidLengthException {
                System.out.println("Validacion flotante");
                float value =  Float.valueOf(Float.parseFloat(yytext()));
                if ( value < MIN_FLOAT_LENGTH  || value > MAX_FLOAT_LENGTH )
                {
                    throw new InvalidFloatException("Constante flotante fuera de rango en la linea" + yyline + "\n");
                }
                if ( yytext().length() > MAX_STRING_LENGTH )
                {
                    throw new InvalidLengthException("Capacidad maxima de caracteres asignados superada en la linea" + yyline + "\n");
                }
                //yyparser.yylval = new parserval(value);
            }
            private void validateStringLength() throws InvalidLengthException {
                String value = String.valueOf(yytext());
                if ( value.length() > MAX_STRING_LENGTH )
                {
                    throw new InvalidLengthException("Capacidad maxima de caracteres asignados superada en la linea" + yyline + "\n");
                }
                //yyparser.yylval = new parserval(value);
            }
            private void validateIdLength() throws InvalidLengthException {
                String value = String.valueOf(yytext());
                if ( value.length() > MAX_ID_LENGTH )
                {
                    throw new InvalidLengthException("Capacidad maxima de caracteres para un id superada en la linea" + yyline + "\n");
                }
                //yyparser.yylval = new parserval(value);
            }
            private Symbol symbol(int type) {
                return new Symbol(type, yyline, yycolumn);
            }
            private Symbol symbol(int type, Object value) {
                return new Symbol(type, yyline, yycolumn, value);
            }
%}


LineTerminator = \r|\n|\r\n
//InputCharacter = [^\r\n]
Indentation =  [ \t\f]

Letter = [a-zA-Z]
Digit = [0-9]

//OPERATORS
Plus = "+"
Mult = "*"
Sub = "-"
Div = "/"
Assig = "="
GreaterThan = ">"
GreaterOrEqualThan = ">="
LowerThan = "<"
LowerOrEqualThan = "<="
Equals = "=="
NotEquals = "!="

OpenBracket = "("
CloseBracket = ")"
OpenSquareBracket = "["
CloseSquareBracket = "]"
OpenCurlyBraces = "{"
CloseCurlyBraces = "}"
Colon = ":"
SemiColon = ";"
Comma = ","

If = "if"
Else = "else"
While = "while"
Init = "init"
Write = "write"
Read = "read"
Not = "👎"|"not"
And = "&&"
Or = "||"

//Do-Case-EndDo
Do = "do"
Case = "case"
Default = "default"
Iguales = "#Iguales"

//Comment = \/\*.*\*\/

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}
TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
EndOfLineComment     = "//" .* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent       = ( [^*] | \*+ [^/*] )*

Space = " "
Float = "Float"
Int = "Int"
String = "String"

WhiteSpace = {LineTerminator} | {Indentation}
Identifier = {Letter}({Letter}|{Digit})*
IntegerConstant = -?{Digit}+
ConstString = \"[^\"]*\"
//-9999999999999.999999
//NUM = [0-9]+ ("." [0-9]+)
//              .25 | 25.0                  25.
FloatConstant = -?{Digit}*("." {Digit}+) | -?{Digit}+ ("." {Digit}*)
%%


/* keywords */

<YYINITIAL> {

  /* operators */
  {Plus}                                    { System.out.println("Signo Mas: " + yytext()); return symbol(ParserSym.PLUS); }
  {Mult}                                    { System.out.println("Signo Multiplicación: " + yytext()); return symbol(ParserSym.MULT); }
  {Sub}                                     { System.out.println("Signo Menos: " + yytext()); return symbol(ParserSym.SUB); }
  {Div}                                     { System.out.println("Signo Division: " + yytext()); return symbol(ParserSym.DIV); }
  {Assig}                                   { System.out.println("Asignación: " + yytext()); return symbol(ParserSym.ASSIG, yytext()); } // Pusimos que deveuvla yytext porque si no el valor del token era nulo.
  {GreaterThan}                             { System.out.println("Mayor a: " + yytext()); return symbol(ParserSym.GREATER_THAN); }
  {GreaterOrEqualThan}                      { System.out.println("Mayor o igual a: " + yytext()); return symbol(ParserSym.GREATER_OR_EQUAL_THAN); }
  {LowerThan}                            	{ System.out.println("Menor a: " + yytext()); return symbol(ParserSym.LOWER_THAN); }
  {LowerOrEqualThan}                        { System.out.println("Menor o igual a: " + yytext()); return symbol(ParserSym.LOWER_OR_EQUAL_THAN); }
  {Equals}                                  { System.out.println("Igual a: " + yytext()); return symbol(ParserSym.EQUALS); }
  {NotEquals}                               { System.out.println("No igual a: " + yytext()); return symbol(ParserSym.NOT_EQUALS); }
  {OpenBracket}                             { System.out.println("Parentesis de apertura: " + yytext()); return symbol(ParserSym.OPEN_BRACKET); }
  {CloseBracket}                            { System.out.println("Parentesis de Cierre: " + yytext()); return symbol(ParserSym.CLOSE_BRACKET); }
  {OpenSquareBracket}                       { System.out.println("Corchete de Apertura: " + yytext()); return symbol(ParserSym.OPEN_SQUARE_BRACKET); }
  {CloseSquareBracket}                      { System.out.println("Corchete de Cierre: " + yytext()); return symbol(ParserSym.CLOSE_SQUARE_BRACKET); }
  //{InputCharacter}                          { System.out.println("Caracter de ingreso: " + yytext()); return symbol(ParserSym.INPUT_CHARACTER); }
  {OpenCurlyBraces}                         { System.out.println("Caracter {: " + yytext()); return symbol(ParserSym.OPEN_CURLY_BRACES); }
  {CloseCurlyBraces}                        { System.out.println("Caracter }: " + yytext()); return symbol(ParserSym.CLOSE_CURLY_BRACES); }
  {SemiColon}                               { System.out.println("Punto y coma: " + yytext()); return symbol(ParserSym.SEMI_COLON); }
  {Comma}                                   { System.out.println("Coma: " + yytext()); return symbol(ParserSym.COMMA); }
  {Colon}                                   { System.out.println("Dos puntos: " + yytext()); return symbol(ParserSym.COLON); }
  {If}                                      { System.out.println("If: " + yytext()); return symbol(ParserSym.IF); }
  {While}                                   { System.out.println("While: " + yytext()); return symbol(ParserSym.WHILE); }
  {Else}                                    { System.out.println("Else: " + yytext()); return symbol(ParserSym.ELSE); }
  {Not}                                     { System.out.println("Not: " + yytext()); return symbol(ParserSym.NOT); }
  {And}                                     { System.out.println("And:" + yytext()); return symbol(ParserSym.AND); }
  {Or}                                      { System.out.println("Or: " + yytext()); return symbol(ParserSym.OR); }
  {Init}                                    { System.out.println("Init: " + yytext()); return symbol(ParserSym.INIT); }
  {Read}                                    { System.out.println("Read: " + yytext()); return symbol(ParserSym.READ); }
  {Write}                                   { System.out.println("Write: " + yytext()); return symbol(ParserSym.WRITE); }
  {Do}                                      { System.out.println("Do: " + yytext()); return symbol(ParserSym.DO); }
  {Default}                                 { System.out.println("Default: " + yytext()); return symbol(ParserSym.DEFAULT); }
  {Iguales}                                 { System.out.println("Iguales: " + yytext()); return symbol(ParserSym.IGUALES); }
  {Case}                                    { System.out.println("Case: " + yytext()); return symbol(ParserSym.CASE); }

  /* Types */
  {Int}                                     { System.out.println("Palabra Reservada Int: " + yytext()); return symbol(ParserSym.INT); }
  {Float}                                   { System.out.println("Palabra Reservada Float: " + yytext()); return symbol(ParserSym.FLOAT); }
  {String}                                  { System.out.println("Palabra Reservada String: " + yytext()); return symbol(ParserSym.STRING); }
  /* identifiers */
  {Identifier}                              {
                                                validateIdLength();
                                                System.out.println("Identificador: " + yytext());
                                                new SymbolTableGenerator().addToSymbolTable(yytext(),TIPO_DATO.EMPTY,"","");
                                                return symbol(ParserSym.IDENTIFIER, yytext());
                                            }
  /* Constants */
  {IntegerConstant}                         {
                                                  validateIntegerLength();
                                                  System.out.println("Constante Entera: " + yytext());
                                                  new SymbolTableGenerator().addToSymbolTable("_"+yytext(),TIPO_DATO.INT,yytext(),"");
                                                  return symbol(ParserSym.INTEGER_CONSTANT, yytext());
                                              }
  {ConstString}                             {
                                                validateStringLength();
                                                System.out.println("Constante String: " + yytext());
                                                new SymbolTableGenerator().addToSymbolTable("_"+yytext().replace("\"",""),TIPO_DATO.STRING,yytext().replace("\"",""),String.valueOf(yytext().length() - 2));
                                                return symbol(ParserSym.CONST_STRING, yytext());
                                            }
  {FloatConstant}                           {
                                                validateFloatLength();
                                                System.out.println("Constante Flotante: " + yytext());
                                                new SymbolTableGenerator().addToSymbolTable("_"+yytext(),TIPO_DATO.FLOAT,yytext(),"");
                                                return symbol(ParserSym.FLOAT_CONSTANT, yytext());
                                            }

  /* whitespace */
  {WhiteSpace}                              { /* ignore */ }
  {Comment}                                 { /* ignore */ }
  {Space}                                   { return symbol(ParserSym.SPACE); }
}


/* error fallback */
.|\n                              { throw new UnknownCharacterException(yytext()); }
