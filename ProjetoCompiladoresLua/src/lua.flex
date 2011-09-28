import java_cup.*;
import java_cup.runtime.*;

%%
%class LuaLexer
%line
%column
%cup
   
%{

	public static void main(String[] args) {
		
	}

    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
	
	public int getLine() {
		return yyline;
	}
	
	public int getColumn() {
		return yycolumn;
	}
%}



LineTerminator = \r | \n | \r\n
LPAREN			= \(
RPAREN			= \)
LBRACK			= \[
RBRACK			= \]
LCURLY			= \{
RCURLY			= \}
COLON			= :
SEMICOL			= ;
COMMA			= ,
DOT				= \.
POUND			= #
CONCAT			= \.\.
ATT				= \=

/* VARARG			= ... */

/* Operadores Relacionais */
LT				= <
GT				= >
LE				= <=
GE				= >=
NEQUAL          = ~=
EQUAL			= ==
RELOP           = {LT} | {GT} | {LE} | {GE} | {NEQUAL} | {EQUAL}

/* Operadores Aritiméticos*/
PLUS			= \+
MINUS			= \-
MULT			= \*
DIVIDE			= \/
EXP				= \^
MOD				= \%

LETRA 			= [a-zA-Z]
LETRA_			= {LETRA} | _
DIGITO 			= [0-9]
HEXADIGITO 		= [0-9a-fA-F]
EXPONENT 		= [eE] [+-]? {DIGITO}+
HEXALITERAL		= 0 [Xx] {HEXADIGITO}+
INTEIRO			= {DIGITO}+
REALLIT			= DOT {INTEIRO} | {INTEIRO} DOT | {INTEIRO} DOT {INTEIRO}
REALEXPLIT		= ({INTEIRO} | {REALLIT}) EXPONENT
NUMERO          = {INTEIRO} | {REALLIT} | {HEXALITERAL} | REALEXPLIT
ID		 		= {LETRA_} ({LETRA_} | {NUMERO})*
STRING          = \" ({LETRA_} | {NUMERO})* \" | \' ({LETRA_} | {NUMERO})* \'
WhiteSpace      = {LineTerminator} | [ \t\f]



%%
/* ------------------------Regras Léxicas---------------------- */
   
"local" { return symbol(sym.LOCAL); }

/* Funções */
"function" { return symbol(sym.FUNCTION); }
"return" { return symbol(sym.RETURN); }

/* Comandos Iterativos */
"for" { return symbol(sym.FOR); }
"repeat" { return symbol(sym.REPEAT); }
"until" { return symbol(sym.UNTIL); }
"while" { return symbol(sym.WHILE); }
"do" { return symbol(sym.DO); }
"in" { return symbol(sym.IN); }
"break" { return symbol(sym.BREAK); }

/* Operadores Lógicos */
"or" { return symbol(sym.OR); }
"and" { return symbol(sym.AND); }
"not" { return symbol(sym.NOT); }

/* Comando condicional */
"if" { return symbol(sym.IF); }
"then" { return symbol(sym.THEN); }
"else" { return symbol(sym.ELSE); }
"elseif" { return symbol(sym.ELSEIF); }
"end" { return symbol(sym.END); }

/* Mais Alguns Literais */
"true" { return symbol(sym.TRUE); }
"false" { return symbol(sym.FALSE); }
"nil" { return symbol(sym.NIL); }

{ATT} { return symbol(sym.ATT); }
{RELOP} { return symbol(sym.RELOP, yytext()); }
{PLUS} { return symbol(sym.PLUS); }
{MULT} { return symbol(sym.MULT); }
{DIVIDE} { return symbol(sym.DIVIDE); }
{MINUS} { return symbol(sym.MINUS); }
{EXP} { return symbol(sym.EXP); }
{MOD} { return symbol(sym.MOD); }

{LPAREN} { return symbol(sym.LPAREN); }
{RPAREN} { return symbol(sym.RPAREN); }
{LBRACK} { return symbol(sym.LBRACK); }
{RBRACK} { return symbol(sym.RBRACK); }
{LCURLY} { return symbol(sym.LCURLY); }
{RCURLY} { return symbol(sym.RCURLY); }
{COLON} { return symbol(sym.COLON); }
{SEMICOL} { return symbol(sym.SEMICOL); }
{COMMA} { return symbol(sym.COMMA); }
{DOT} { return symbol(sym.DOT); }
{POUND} { return symbol(sym.POUND); }
{CONCAT} { return symbol(sym.CONCAT); }

{ID} { return symbol(sym.ID, yytext()); }
{STRING} { return symbol(sym.STRING, yytext()); }
{NUMERO} { return symbol(sym.NUMERO, yytext());}

{WhiteSpace} { }
{LineTerminator} { }