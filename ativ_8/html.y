/*

versão 2: error => button pode chamar button e body 

TAG_BUTTON:
        BUTTON MORE_TAGS CLOSE_BUTTON
        | BUTTON MORE_TAGS CLOSE_BUTTON MORE_TAGS
        |
        ;

*/

%{
    #define YYSTYPE double
    #include <stdio.h>
    extern FILE* yyin;

    void yyerror(char *s);
    int yylex(void);
    int yyparse();
%}

%token DOCTYPE HTML CLOSE_HTML BODY CLOSE_BODY
%token H1 CLOSE_H1 H2 CLOSE_H2 H3 CLOSE_H3 
%token H4 CLOSE_H4 H5 CLOSE_H5 H6 CLOSE_H6 
%token P CLOSE_P A CLOSE_A IMG
%token STRING
%token ATRIBUTE_LINK GREATER 
%token ATRIBUTE_SRC ATRIBUTE_ALT ATRIBUTE_WIDTH ATRIBUTE_HEIGHT
%token BUTTON CLOSE_BUTTON 
%token LI CLOSE_LI OL CLOSE_OL UL CLOSE_UL

%%

STATEMENT:
        STATEMENT FILE_HTML { printf("CORRETO\n"); }
        |
        ;

FILE_HTML:
        DOCTYPE INIT_HTML
        ;

INIT_HTML:
        HTML TAG_BODY CLOSE_HTML
        ;

TAG_BODY:
        BODY MORE_TAGS CLOSE_BODY
        | BODY CLOSE_BODY
        ; 

MORE_TAGS: 
        LIST_TAGS
        | LIST_TAGS MORE_TAGS
        ;

LIST_TAGS:
        HEADINGS
        | TAG_P
        | TAG_LINK
        | TAG_IMG
        | TAG_BUTTON
        | TAG_OL
        | TAG_UL
        ;

TAG_P:
        P CLOSE_P
        | P MORE_TAGS CLOSE_P
        ;

TAG_LINK:
        A ATRIBUTE_HREF GREATER CLOSE_A
        | A ATRIBUTE_HREF GREATER MORE_TAGS CLOSE_A
        ;

ATRIBUTE_HREF: ATRIBUTE_LINK STRING;

TAG_IMG: IMG ATRIBUTE_IMG GREATER;

ATRIBUTE_IMG:
        LIST_ATRIBUTES_IMG 
        | LIST_ATRIBUTES_IMG ATRIBUTE_IMG
        ;

LIST_ATRIBUTES_IMG: 
        ATRIBUTE_SRC STRING 
        | ATRIBUTE_ALT STRING 
        | ATRIBUTE_WIDTH STRING 
        | ATRIBUTE_HEIGHT STRING 
        ;

TAG_BUTTON:
        BUTTON CLOSE_BUTTON
        | BUTTON MORE_TAGS CLOSE_BUTTON
        ;

TAG_OL: 
        OL CLOSE_OL
        | OL LIST_LI CLOSE_OL
        ;

TAG_UL: 
        UL CLOSE_UL
        | UL LIST_LI CLOSE_UL
        ;

LIST_LI:
        TAG_LI
        | TAG_LI LIST_LI
        ;

TAG_LI:
        LI CLOSE_LI
        | LI MORE_TAGS CLOSE_LI 
        ;

HEADINGS:
        TAG_H1
        | TAG_H2
        | TAG_H3
        | TAG_H4
        | TAG_H5
        | TAG_H6
        ;

TAG_H1:
        H1 CLOSE_H1
        | H1 MORE_TAGS CLOSE_H1 
        ;

TAG_H2:
        H2 CLOSE_H2
        | H2 MORE_TAGS CLOSE_H2
        ;

TAG_H3:
        H3 CLOSE_H3
        | H3 MORE_TAGS CLOSE_H3
        ;

TAG_H4:
        H4 CLOSE_H4 
        | H4 MORE_TAGS CLOSE_H4
        ;

TAG_H5:
        H5 CLOSE_H5
        | H5 MORE_TAGS CLOSE_H5
        ;

TAG_H6:
        H6 CLOSE_H6
        | H6 MORE_TAGS CLOSE_H6
        ;

%%

void yyerror(char *s)
{
    printf("Error: %s\n", s);
}

int main(int argc, char *argv[])
{
    yydebug = 0;

    if (argc == 1)
    {
        yyparse();
    }

    if (argc == 2)
    {
        yyin = fopen(argv[1], "r");
        yyparse();
    }

    return 0;
}