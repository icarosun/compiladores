#ifndef ASTGEN_H_
#define ASTGEN_H_

#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include"hashtable.h"
void yyerror(char *s);

#define MAX 1000

struct ast
{
    int nodetype;
    struct ast *l;
    struct ast *r;
};

struct numval
{
    int nodetype;
    double number;
};

struct newref
{
    int nodetype;
    char *name; 
};

struct symref
{
    int nodetype;
    char *name;
    struct ast *val;
};

struct flow 
{
    int nodetype;
    struct ast *cond;
    struct ast *tl;
    struct ast *el;
};

struct ast *newast(int nodetype, struct ast *l, struct ast *r);
struct ast *newnum (double d);
struct ast *newdeclaration (char *name);
struct ast *newprintref (char *name);
struct ast *newprintstring (char *name);
struct ast *newval(char *name);
struct ast *newasgn(char *name, struct ast *val);
struct ast *newname(char *name);
struct ast *newcmp(int cmtype, struct ast *l, struct ast *r);
struct ast *newflow(int nodetype, struct ast *cond, struct ast *tl, struct ast *el);

static void eval (Hashtable *hashtable, struct ast *a);
double evalExpression(Hashtable *hashtable, struct ast *a);
void treefree (struct ast *a);

struct ast *
newast (int nodetype, struct ast *l, struct ast *r) 
{
    struct ast *a = malloc(sizeof(struct ast));

    if(!a) {
        yyerror("out of space");
        exit(0);
    }
    a->nodetype = nodetype;
    a->l = l;
    a->r = r;

    return a;
}

struct ast *
newnum (double d)
{
    struct numval *a = malloc(sizeof(struct numval));
    
    if(!a) {
        yyerror("out of space a");
        exit(0);
    }

    a->nodetype = 'K';
    a->number = d;

    return (struct ast*)a;
}

struct ast *
newdeclaration (char *name)
{
    struct newref *a = malloc(sizeof(struct newref));

    if(!a) 
    {
        yyerror("out of space a");
        exit(0);
    }

    a->nodetype = 'D';
    a->name = name;

    return (struct ast*)a;
}

struct ast *
newprintref (char *name)
{
    struct newref *a = malloc(sizeof(struct newref));

    if(!a) 
    {
        yyerror("out of space a");
        exit(0);
    }

    a->nodetype = 'P';
    a->name = name;

    return (struct ast*)a;
}

struct ast *
newprintstring (char *name)
{
    struct newref *a = malloc(sizeof(struct newref));

    if(!a) 
    {
        yyerror("out of space a");
        exit(0);
    }

    a->nodetype = 'p';
    a->name = name;

    return (struct ast*)a;
}

struct ast *
newval (char *name)
{
    struct newref *a = malloc(sizeof(struct newref));

    if(!a) 
    {
        yyerror("out of space a");
        exit(0);
    }

    a->nodetype = 'R';
    a->name = name;

    return (struct ast*)a;
}

struct ast *
newasgn (char *name, struct ast *val)
{
    struct symref *a = malloc(sizeof(struct symref));

    if(!a) 
    {
        yyerror("out of space a");
        exit(0);
    }

    a->nodetype = '=';
    a->name = name;
    a->val = val;

    return (struct ast*)a;
}

struct ast *
newrefname (char *name)
{
    struct newref *a = malloc(sizeof(struct newref));

    if(!a) 
    {
        yyerror("out of space a");
        exit(0);
    }

    a->nodetype = 'N';
    a->name = name;

    return (struct ast*)a;
}

struct ast *
newcmp (int cmtype, struct ast *l, struct ast *r)
{
    struct ast *a = malloc(sizeof(struct ast));

    if(!a)
    {
        yyerror("out of space a");
        exit(0);
    }

    a->nodetype = '0' + cmtype;
    a->l = l;
    a->r = r;

    return a;
}

struct ast *
newflow (int nodetype, struct ast *cond, struct ast *tl, struct ast *el)
{
    struct flow *a = malloc(sizeof(struct flow));

    if(!a) 
    {
        yyerror("out of space a");
        exit(0);
    }

    a->nodetype = nodetype;
    a->cond = cond;
    a->tl = tl;
    a->el = el;

    return (struct ast*)a;
}

static void 
eval (Hashtable *hashtable, struct ast *a)
{
    //printf("Dentro do eval: %c\n ", a->nodetype);

    /*
    if (a->nodetype == 'L') {
        printf("Left side: %c\n", a->l->nodetype);
        printf("Right side: %c\n", a->r->nodetype);
    }*/


    double v;
    char *identify; 

    switch(a->nodetype) {
        case '=':
            v = evalExpression(hashtable, ((struct symref *)a)->val);
            identify = ((struct symref *)a)->name;
            updateitemhashtable(hashtable, identify, v);
            break;

        case 'p':
            identify = ((struct newref *) a)->name;
            
            char newString[MAX];
            int j = 0;
            for(int i=0; identify[i] != '\0'; i++){
                if (identify[i] != '"'){
                    newString[j] = identify[i];
                    j++;
                }
            }
            newString[j] = '\0';

            printf("><> %s\n", newString);
            break;
        
        case 'D': 
            identify = ((struct newref *) a)->name;
            inserthashtable(hashtable, identify, createVariable(identify, "double", 0, 0));
            break;

        case 'P':
            identify = ((struct newref *) a)->name;
            //printf("print %s: %lf\n", identify, searchkeyhashtable(hashtable, identify));
            printf("><> %.1lf\n", searchkeyhashtable(hashtable, identify));
            break;

        case 'R': 
            identify = ((struct newref *) a)->name;
            printf("... ");
            scanf("%lf", &v);
            updateitemhashtable(hashtable, identify, v);
            break;

        case 'L': 
            eval(hashtable, a->l);
            eval(hashtable, a->r);
            break;

        case 'I':
            v = evalExpression(hashtable, ((struct flow *)a)->cond);
            ///printf("Dentro do if %lf\n", v);
            if ( v != 0) {
                if ( ((struct flow *)a)->tl )  {
                    //printf("Aquele if maroto Central %c\n", ((struct flow *)a)->tl->nodetype);
                    eval(hashtable, ((struct flow *)a)->tl);
                    //printf("Aquele if maroto Right %c\n", ((struct flow *)a)->tl->r->nodetype);
                    //printf("Aquele if maroto Left %c\n", ((struct flow *)a)->tl->l->nodetype);
                    //printf("Aquele if maroto Left do Right %c\n", ((struct flow *)a)->tl->l->r->nodetype);
                    //printf("Aquele if maroto Left do Left %c\n", ((struct flow *)a)->tl->l->l->nodetype);
                    break;
                } else {
                    yyerror("block if is null");
                    exit(0);
                }
            } else {
                if ( ((struct flow *)a)->el )  {
                    eval(hashtable, ((struct flow *)a)->el);
                } /*else {
                    yyerror("block if is null");
                    exit(0);
                }*/
                //printf("Aquele else maroto Central %c\n", ((struct flow *)a)->el->nodetype);
                //printf("Aquele else maroto Right %c\n", ((struct flow *)a)->el->r->nodetype);
                //printf("Aquele else maroto Left %c\n", ((struct flow *)a)->el->l->nodetype);
                //printf("Aquele else maroto Left do Right %c\n", ((struct flow *)a)->el->l->r->nodetype);
                //printf("Aquele else maroto Left do Left %c\n", ((struct flow *)a)->el->l->l->nodetype);
                break;
            }

        default: printf("internal error: bad node %c\n", a->nodetype);
    }
}

double 
evalExpression (Hashtable *hashtable, struct ast *a)
{
    double v;
    char *identify;
    int div = 0, divisor = 0; 

    switch(a->nodetype)
    {
        case '1': v = (evalExpression(hashtable, a->l) > evalExpression(hashtable, a->r)) ? 1 : 0; break;
        case '2': v = (evalExpression(hashtable, a->l) < evalExpression(hashtable, a->r)) ? 1 : 0; break;
        case '3': v = (evalExpression(hashtable, a->l) != evalExpression(hashtable, a->r)) ? 1 : 0; break;
        case '4': v = (evalExpression(hashtable, a->l) == evalExpression(hashtable, a->r)) ? 1 : 0; break;
        case '5': v = (evalExpression(hashtable, a->l) >= evalExpression(hashtable, a->r)) ? 1 : 0; break;
        case '6': v = (evalExpression(hashtable, a->l) <= evalExpression(hashtable, a->r)) ? 1 : 0; break;
        case '7': v = (evalExpression(hashtable, a->l) && evalExpression(hashtable, a->r)) ? 1 : 0; break;
        case '8': v = (evalExpression(hashtable, a->l) || evalExpression(hashtable, a->r)) ? 1 : 0; break;
        case '9': v = !evalExpression(hashtable, a->l); break;

        case '+': v = evalExpression(hashtable, a->l) + evalExpression(hashtable, a->r); break;         
        case '-': v = evalExpression(hashtable, a->l) - evalExpression(hashtable, a->r); break;       
        case '/': v = evalExpression(hashtable, a->l) / evalExpression(hashtable, a->r); break;       
        case '*': v = evalExpression(hashtable, a->l) * evalExpression(hashtable, a->r); break;       
        case 'M': v = -evalExpression(hashtable, a->l); break;       
        case '@': v = sqrt(evalExpression(hashtable, a->l)); break;       
        case '%':
            div = (int) evalExpression(hashtable, a->l); 
            divisor = (int) evalExpression(hashtable, a->r);                         

            v = div % divisor;
            break;
        case '#':
            div = (int) evalExpression(hashtable, a->l); 
            divisor = (int) evalExpression(hashtable, a->r);                         

            v = div / divisor;
            break;

        case 'K': v = ((struct numval *) a)->number; break;
        
        case 'N': 
            identify = ((struct newref *) a)->name;
            v = searchkeyhashtable(hashtable, identify);
            break;
            
        default: printf("Expression -- internal error: bad node %c\n", a->nodetype);
    }

    return v;
}

void 
treefree (struct ast *a)
{
    switch(a->nodetype) {
        case '+': case '-': case '*': case '/': case '#': case '%':
        case '1': case '2': case '3': case '4': case '5': case '6': case '7': case '8':
            treefree(a->r);

        case 'L': case 'M': case '9': case '@':
            treefree(a->l);

        case 'p': case 'P': case 'D': case 'K': case 'N':
            break;
        
        case 'I': case 'W':
            free( ((struct flow *)a)->cond);
            if( ((struct flow *)a)->tl) treefree( ((struct flow *)a)->tl);
            if( ((struct flow *)a)->el) treefree( ((struct flow *)a)->el);
            break;

        case '=':
            free(((struct symref *)a)->val);
            break;
    
        default: printf("Treefree -- internal error: bad node %c\n", a->nodetype);
    }

    free(a);
}

#endif