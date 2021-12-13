%{
#include<stdio.h>
#include<stdlib.h>
#include"astgen.h"
#include"hashtable.h"

extern FILE* yyin;
void yyerror(char *s);
int yyparse();
int yylex(void);
extern int yylineno;

Hashtable *htable;
%}

%union {
    double value;
    char *name;
    struct ast *a;
    int fn;
}

%locations

%token EOL PLUS MINUS PAKU END O_KEY C_KEY IF ELSE MODULO DIV_INT SQRT WHILE
%token TYPE DIV MULT ATRIBUITION PRINT P_LEFT P_RIGHT READ

%token <value> NUMBER
%token <name> IDENTIFIER STRING
%token <fn> CMP

%right ATRIBUITION
%left PLUS MINUS
%left DIV MULT DIV_INT
%nonassoc NOT UMINUS

%type <a> program statements statement declaration print_value read_value assignment expression block comparations if_stmt while_stmt

%% 

program: PAKU EOL statements END EOL {
        printf("><> Compilado com sucesso ... \n");
        eval(htable, $3);
        treefree($3);
        destroyhashtable(htable); 
    }
    | PAKU EOL statements END {
        printf("><> Compilado com sucesso ... \n");
        eval(htable, $3);
        treefree($3);
        destroyhashtable(htable); 
    }
    ; 

block: O_KEY statements C_KEY {$$ = $2;};

statements: statement {$$ = $1;}
    | statements statement {
        if ($2 == 0) { 
            $$ = $1;
        } else {
            if ($1 != NULL)
                $$ = newast('L', $1, $2);
            else 
                $$ = $2;
        }
            
    }
    ;

statement:
    assignment {$$ =  $1;}
    | declaration {$$ = $1;}
    | if_stmt {$$ = $1;}
    | while_stmt {$$ = $1;}
    | read_value {$$ = $1; }
    | print_value {$$ = $1;}
    | block {$$ = $1;}
    | EOL { $$ = 0; }
    ;

assignment: IDENTIFIER ATRIBUITION expression EOL {$$ = newasgn($1, $3);}; 

print_value: PRINT P_LEFT IDENTIFIER P_RIGHT EOL { $$ = newprintref($3); }
    | PRINT P_LEFT STRING P_RIGHT EOL {$$ = newprintstring($3);}
    ; 

read_value: READ P_LEFT IDENTIFIER P_RIGHT EOL { $$ = newval($3);}; 

comparations: 
    comparations CMP comparations { $$ = newcmp($2, $1, $3);}
    | CMP comparations %prec NOT {$$ = newcmp($1, $2, NULL);}
    | P_LEFT comparations P_RIGHT { $$ = $2;}
    | IDENTIFIER { $$ = newrefname($1);}
    | NUMBER { $$ = newnum($1);}
    ;

if_stmt: IF P_LEFT comparations P_RIGHT block EOL {$$ = newflow('I', $3, $5, NULL);}
    | IF P_LEFT comparations P_RIGHT block ELSE block EOL {$$ = newflow('I', $3, $5, $7);}
    ;

while_stmt: WHILE P_LEFT comparations P_RIGHT block EOL {$$ = newflow('W', $3, $5, NULL);};

expression:
    expression PLUS expression { $$ = newast('+', $1, $3);}
    | expression MINUS expression { $$ = newast('-', $1, $3);}
    | expression DIV expression { $$ = newast('/', $1, $3);}
    | expression DIV_INT expression { $$ = newast('#', $1, $3);}
    | expression MULT expression { $$ = newast('*', $1, $3);}
    | expression MODULO expression {$$ = newast('%', $1, $3);}
    | SQRT expression {$$ = newast('@', $2, NULL);}
    | MINUS expression %prec UMINUS { $$ = newast('M', $2, NULL);}
    | P_LEFT expression P_RIGHT { $$ = $2;}
    | IDENTIFIER { $$ = newrefname($1);}
    | NUMBER { $$ = newnum($1);}
    ;

declaration: TYPE IDENTIFIER EOL {$$ = newdeclaration($2);};

%%

void 
yyerror(char *s)
{
    printf("error: %s\n", s);
    printf("Line: %d\n", yylineno);
}

int 
main(int argc, char *argv[])
{
    yydebug = 0;

    htable = createhashtable(100);
    
    if (argc == 2)
    {
        yyin = fopen(argv[1], "r");
        yyparse();
    }   
    return 0;
}