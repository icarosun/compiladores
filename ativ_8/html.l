/*

    error quado o texto vem com uma palavra que parece uma tag:

    ex: <p> ppp </p> 
    
!DOCTYPE            { return DOCTYPE; }
html                { return HTML; }
body                { return BODY; }
h1                  { return H1; }
h2                  { return H2; }
h3                  { return H3; }
h4                  { return H4; }
h5                  { return H5; }
h6                  { return H6; }
p                   { return P; }
a                   { return LINK; }
*/


%option caseless
%{
    #define YYSTYPE double
    #include "html.tab.h"
    #include <stdlib.h> 

    void yyerror(char *s);
%}

%%

"<"                 { return LESS; }
">"                 { return GREATER; }
"\/"                 { return BAR; }
"="                 { return EQUAL; }


[0-9]+("."[0-9]+)?      { return NUMBER; }
[a-zA-Z]+"."?":"?           { return WORD; }
\'([^'\n]|\'\')+\'    { return STRING; }

[\t]+               { return TAB; }
[\n]                { return EOL; }
[[:space:]]         ;
.                   { yyerror("Palavra indefinida\n"); }

%%

int yywrapp()
{
    return 1;
}