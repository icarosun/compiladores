%{
    #define YYSTYPE double
    #include <stdio.h>
    extern FILE* yyin;

    void yyerror(char *s);
    int yylex(void);
    int yyparse();
%}

%token LESS GREATER BAR
%token DOCTYPE HTML BODY
%token H1 H2 H3 H4 H5 H6 P
%token LINK EQUAL STRING
%token NUMBER EOL WORD TAB

%%

STATEMENT:
        STATEMENT FILE_HTML { printf("CORRETO\n"); }
        |
        ;

FILE_HTML:
        INIT_HTML MORE_DATA
        ;

INIT_HTML:
        LESS DOCTYPE HTML GREATER
        ;

MORE_DATA: 
        OPEN_TAG MORE_DATA
        | CLOSE_TAG MORE_DATA
        | EOL MORE_DATA
        | TAB MORE_DATA
        | WORD MORE_DATA
        | NUMBER MORE_DATA
        | 
        ;

OPEN_TAG:
        LESS TAGS GREATER
        ;

CLOSE_TAG:
        LESS BAR TAGS GREATER
        ;

TAGS:
        HTML
        | BODY
        | H1
        | H2
        | H3
        | H4
        | H5
        | H6
        | P
        | LINK ATRIBUTE
        ;

ATRIBUTE: WORD EQUAL STRING
        ;

%%

void yyerror(char *s)
{
    printf("Error: %s\n", s);
}

int main(int argc, char *argv[])
{
    yydebug = 1;

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