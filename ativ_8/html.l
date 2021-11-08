%option caseless
%{
    #define YYSTYPE double
    #include "html.tab.h"
    #include <stdlib.h> 

    void yyerror(char *s);
}

%%

"<"                 { return BIGGER; }
">"                 { return LESSER; }
"/"                 { return BAR; }

!DOCTYPE            { return DOCTYPE; }
html                { return HTML; }
body                { return BODY; }
h1                  { return H1; }
p                   { return P; }

[0-9]+("."[0-9]+)?      { return NUMBER; }
\'([^'\n]|\'\')+\'      { return STRING; }

[[:space:]]         ;
.                   { yyerror("Palavra indefinida\n"); }

%%

int yywrapp()
{
    return 1;
}