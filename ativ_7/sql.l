%option caseless
%{
#define YYSTYPE double
#include "sql.tab.h"
#include <stdlib.h>

void yyerror(char *s);
%}

PALAVRA             [a-zA-Z]+

%%

UPDATE              { return UPDATE; }
DELETE              { return DELETE; }
SET                 { return SET; }
INSERT              { return INSERT; }
INTO                { return INTO; }
VALUES              { return VALUES; }
SELECT              { return SELECT; }
FROM                { return FROM; }
WHERE               { return WHERE; }
AND                 { return AND; }
OR                  { return OR; }
[;]                 { return DOT; }
[*]					{ return ALL; }
[(]					{ return P_LEFT;}
[)]					{ return P_RIGHT;}
[,]                 { return COMMA; }


"="                 { return EQUAL; }
">"                 { return BIGGER; }
">="                { return BIGGER_EQUAL; }
"<"                 { return LESSER; }
"<="                { return LESSER_EQUAL; }
"<>" |
"!="                { return DIFFERENT; }

[0-9]+("."[0-9]+)?    { return NUMBER; }
\'([^'\n]|\'\')+\'    { return STRING; }
[a-zA-Z][a-zA-Z0-9]+  { return ATRIBUTE; }

[[:space:]]			;
.					{ yyerror("Palavra indefinida\n"); }


%% 

int yywrapp()
{
    return 1;
}
