/*

    error quado o texto vem com uma palavra que é uma tag:

    ex: <p> a a </p> 

"<"                 { return LESS; }
">"                 { return GREATER; }
"\/"                 { return BAR; }
"="                 { return EQUAL; }

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

...
*/

%{
    #define YYSTYPE double
    #include "html.tab.h"
    #include <stdlib.h> 

    void yyerror(char *s);
%}

%%

"<!DOCTYPE html>"       { return DOCTYPE; }
"<html>"                { return HTML; }
"</html>"               { return CLOSE_HTML; }
"<body>"                { return BODY; }
"</body>"               { return CLOSE_BODY; }
"<h1>"                  { return H1; }
"</h1>"                 { return CLOSE_H1; }
"<h2>"                  { return H2; }
"</h2>"                 { return CLOSE_H2; }
"<h3>"                  { return H3; }
"</h3>"                 { return CLOSE_H3; }
"<h4>"                  { return H4; }
"</h4>"                 { return CLOSE_H4; }
"<h5>"                  { return H5; }
"</h5>"                 { return CLOSE_H5; }
"<h6>"                  { return H6; }
"</h6>"                 { return CLOSE_H6; }
"<p>"                   { return P; }
"</p>"                  { return CLOSE_P; }
"<a"                    { return A; }
"</a>"                  { return CLOSE_A; }
"<img"                  { return IMG; }
"<button>"              { return BUTTON; }
"</button>"             { return CLOSE_BUTTON; }
"<li>"                  { return LI; }
"</li>"                 { return CLOSE_LI; }
"<ol>"                  { return OL; }
"</ol>"                 { return CLOSE_OL; }
"<ul>"                  { return UL; }
"</ul>"                 { return CLOSE_UL; }

"href="
" href="                { return ATRIBUTE_LINK; }
"src="
" src="                 { return ATRIBUTE_SRC; }
"alt="
" alt="                 { return ATRIBUTE_ALT; }
"width="
" width="               { return ATRIBUTE_WIDTH; }
"height="
" height="              { return ATRIBUTE_HEIGHT; }
">"                     { return GREATER; }

\"([^"\n]|\"\")+\"      { return STRING; }

[[:space:]]             ;
.                       ;

%%

int yywrapp()
{
    return 1;
}