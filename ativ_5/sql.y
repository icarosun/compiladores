%{ 
    #define YYSTYPE double
    #include <stdio.h>
    extern FILE* yyin;

    void yyerror(char *s);
    int yylex(void);
    int yyparse();
%}

%token SELECT FROM WHERE ALL
%token COMMA DOT AND OR
%token NUMBER ATRIBUTE STRING
%token P_LEFT P_RIGHT
%token DIFFERENT BIGGER BIGGER_EQUAL 
%token EQUAL LESSER LESSER_EQUAL

%%

STATEMENT:
        STATEMENT QUERY DOT { printf("Consulta correta\n"); }
        |
        ;

QUERY:
        SELECT LISTATRIBUTE FROM LISTATRIBUTE
        | SELECT ALL FROM LISTATRIBUTE
        | SELECT LISTATRIBUTE FROM LISTATRIBUTE WHERE OPERATIONS
        ;

LISTATRIBUTE:
        ATRIBUTE
        | ATRIBUTE COMMA ATRIBUTE
        ;

OPERATIONS:
        | ATRIBUTE
        | ATRIBUTE EQUAL STRING
        | ATRIBUTE EQUAL NUMBER
        | ATRIBUTE EQUAL ATRIBUTE
        | ATRIBUTE BIGGER ATRIBUTE
        | ATRIBUTE BIGGER NUMBER
        | ATRIBUTE BIGGER_EQUAL ATRIBUTE
        | ATRIBUTE BIGGER_EQUAL NUMBER
        | ATRIBUTE LESSER ATRIBUTE 
        | ATRIBUTE LESSER NUMBER
        | ATRIBUTE LESSER_EQUAL ATRIBUTE
        | ATRIBUTE LESSER_EQUAL NUMBER
        | ATRIBUTE DIFFERENT ATRIBUTE
        | ATRIBUTE DIFFERENT NUMBER
        | ATRIBUTE DIFFERENT STRING
        | OPERATIONS AND OPERATIONS
        | OPERATIONS OR OPERATIONS
        | P_LEFT OPERATIONS P_RIGHT
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