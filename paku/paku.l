%option caseless
%option yylineno
%{

#include "paku.tab.h" 
#include <stdlib.h>

void yyerror(char *s); 
%}

%%

"><>"													{return PAKU;}
"..."													{return END;}

"int" |													
"float"													{return TYPE;}
"if"													{return IF;}
"else"													{return ELSE;}
"/"														{return DIV;}
"#"														{return DIV_INT;}
"@"														{return SQRT;}
"*"														{return MULT;}
"+"														{return PLUS;}
"-"														{return MINUS;}
"%"														{return MODULO;}

">" 													{yylval.fn = 1; return CMP;}
"<"														{yylval.fn = 2; return CMP;}
"!=" 													{yylval.fn = 3; return CMP;}
"==" 													{yylval.fn = 4; return CMP;}
">=" 													{yylval.fn = 5; return CMP;}
"<=" 													{yylval.fn = 6; return CMP;}
"and"													{yylval.fn = 7; return CMP;}
"or" 													{yylval.fn = 8; return CMP;}
"!"														{yylval.fn = 9; return CMP;}

"="														{return ATRIBUITION;}
"{"														{return O_KEY;}
"}"														{return C_KEY;}
"read"													{return READ; }
"print"													{return PRINT;}
[A-Za-z][A-Za-z0-9]*|[_][A-Za-z0-9]+					{yylval.name = strdup(yytext); return IDENTIFIER;}
[0-9]+("."[0-9]+)? 										{yylval.value = atof(yytext); return NUMBER; }
\n													{ return EOL; }
[(]														{ return P_LEFT;}
[)]														{ return P_RIGHT;}
\"([^"\n]|\"\")+\"      								{ yylval.name = strdup(yytext); return STRING; }
[\t]													{ /* ignore */}
[[:space:]]												;
.														{ yyerror("Undefined token\n"); }

%%

int yywrap()
{
	return 1;
}