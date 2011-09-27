import java_cup.*;
import java_cup.runtime.*;

%%
%class LuaLexer
%line
%column
%cup
   
%{   
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
// EQATT			= \=

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
ARITOP			= {PLUS} | {MINUS} | {MULT} | {DIVIDE} | {EXP} | {MOD}

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
   
"local" { return symbol(LuaSym.LOCAL); }

/* Funções */
"function" { return symbol(LuaSym.FUNCTION); }
"return" { return symbol(LuaSym.RETURN); }

/* Comandos Iterativos */
"for" { return symbol(LuaSym.FOR); }
"repeat" { return symbol(LuaSym.REPEAT); }
"until" { return symbol(LuaSym.UNTIL); }
"while" { return symbol(LuaSym.WHILE); }
"do" { return symbol(LuaSym.DO); }
"in" { return symbol(LuaSym.IN); }
"break" { return symbol(LuaSym.BREAK); }

/* Operadores Lógicos */
"or" { return symbol(LuaSym.OR); }
"and" { return symbol(LuaSym.AND); }
"not" { return symbol(LuaSym.NOT); }

/* Comando condicional */
"if" { return symbol(LuaSym.IF); }
"then" { return symbol(LuaSym.THEN); }
"else" { return symbol(LuaSym.ELSE); }
"elseif" { return symbol(LuaSym.ELSEIF); }
"end" { return symbol(LuaSym.END); }

/* Mais Alguns Literais */
"true" { return symbol(LuaSym.TRUE); }
"false" { return symbol(LuaSym.FALSE); }
"nil" { return symbol(LuaSym.NIL); }

{RELOP} { return symbol(LuaSym.RELOP, yytext()); }
{ARITOP} { return symbol(LuaSym.ARITOP, yytext()); }

/* {PLUS} { return symbol(LuaSym.PLUS); }
{MULT} { return symbol(LuaSym.MULT); }
{DIVIDE} { return symbol(LuaSym.DIVIDE); }
{MINUS} { return symbol(LuaSym.MINUS); } */

{LPAREN} { return symbol(LuaSym.LPAREN); }
{RPAREN} { return symbol(LuaSym.RPAREN); }
{LBRACK} { return symbol(LuaSym.LBRACK); }
{RBRACK} { return symbol(LuaSym.RBRACK); }
{LCURLY} { return symbol(LuaSym.LCURLY); }
{RCURLY} { return symbol(LuaSym.RCURLY); }
{COLON} { return symbol(LuaSym.COLON); }
{SEMICOL} { return symbol(LuaSym.SEMICOL); }
{COMMA} { return symbol(LuaSym.COMMA); }
{DOT} { return symbol(LuaSym.DOT); }
{POUND} { return symbol(LuaSym.POUND); }
{CONCAT} { return symbol(LuaSym.CONCAT); }

// {EQATT} { return symbol(LuaSym.EQATT); }

{ID} { return symbol(LuaSym.ID, yytext()); }
{STRING} { return symbol(LuaSym.STRING, yytext()); }
{NUMERO} { return symbol(LuaSym.NUMERO, yytext());}

{WhiteSpace} { }
{LineTerminator} { }