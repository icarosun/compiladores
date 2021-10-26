%{ 
    #define YYSTYPE double
    #include <stdio.h>
    extern FILE* yyin;

    void yyerror(char *s);
    int yylex(void);
    int yyparse();
%}

%token INSERT INTO VALUES
%token UPDATE SET DELETE
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
        | SELECT LISTATRIBUTE FROM LISTATRIBUTE WHERE LISTATRIBUTE
        | UPDATE LISTATRIBUTE SET LISTATRIBUTE WHERE LISTATRIBUTE
        | DELETE FROM LISTATRIBUTE
        | DELETE FROM LISTATRIBUTE WHERE LISTATRIBUTE
        | INSERT INTO LISTATRIBUTE VALUES LISTATRIBUTE
        ;

LISTATRIBUTE:
        ATRIBUTE
        | STRING
        | NUMBER
        | ATRIBUTE LISTATRIBUTE
        | LISTATRIBUTE COMMA LISTATRIBUTE
        | OPERATIONS COMMA OPERATIONS
        | OPERATIONS AND OPERATIONS
        | OPERATIONS AND LISTATRIBUTE
        | OPERATIONS OR OPERATIONS
        | OPERATIONS OR LISTATRIBUTE
        | P_LEFT OPERATIONS P_RIGHT
        | P_LEFT LISTATRIBUTE P_RIGHT
        | OPERATIONS
        ;

OPERATIONS:
        ATRIBUTE EQUAL STRING
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