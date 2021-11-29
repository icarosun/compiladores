#include<stdio.h>
#include<stdlib.h>
#include<string.h>

typedef struct variable Variable;
typedef struct no No;
typedef struct list List;

struct variable {
    char *name;
    char *type;
    int value;
    int scope;
};

struct no {
    Variable* var;
    char* key;
    No* next; 
};

No* createNo(char* key, Variable* var)
{
    No* newNo = (No*) malloc(sizeof(No));
    if (newNo == NULL)
    {
        printf("No memory!\n");
        exit(1);
    }

    newNo->key = key;
    newNo->var = var;

    return newNo;
}

Variable* createVariable (char* name, char* type, int value, int scope) 
{
    Variable* var = (Variable*) malloc(sizeof(Variable));
    if (var == NULL)
    {
        printf("No memory!\n");
        exit(1);
    }

    var->name = name;
    var->type = type;
    var->value = value;
    var->scope = scope;

    return var; 
}

void printVariable(Variable *var)
{
    printf("Variável: %s\nvalue: %d\ntype: %s \nscope: %d\n\n", var->name, var->value, var->type, var->scope);
}

struct list {
    No* first;
    No* last;
};

List* createList()
{
    List* newList = (List*) malloc(sizeof(List));
    No* sentinel = (No*) malloc(sizeof(No));

    if (sentinel == NULL || newList == NULL) {
        printf("No memory!\n");
        exit(1);
    }

    sentinel->key = '\0';
    sentinel->var = NULL;
    sentinel->next = NULL;

    newList->first = sentinel;
    newList->last = newList->first;

    return newList;
}

void insertlist(List* l, No* toinsert)
{
    l->last->next = toinsert;
    l->last = l->last->next;
    l->last->next = NULL;
}

int emptylist(List* l)
{
    if (l->first == l->last)
        return 1;
    else
        return 0;
}

void removelist(List* toremove, char* key)
{
    No* beforenode = NULL;
    No* iternode = toremove->first->next;

    if (emptylist(toremove)) {
        printf("Empty list\n");
    } else {
        while (iternode != NULL && strcmp(iternode->key, key) != 0) {
            printf("Entrouu\n");
            beforenode = iternode;
            //printf("before=> %s\n", beforenode->key);
            //printf("iternode=> %s\n", iternode->key);
            iternode = iternode->next;
        }

        if (iternode == NULL)
            printf("Key not find!\n");
        
        if (beforenode == NULL) {
            toremove->first->next = iternode->next;
        } else {
            printf("LOCAL ERRADOO\n");
            beforenode->next = iternode->next;
        }
    }
    free(iternode);
}

//busca feita para retornar o valor
int searchkeylist(List* tosearch, char* key)
{
    No* iternode;
    
    if (emptylist(tosearch)) {
        printf("Empty list\n");
    } else {
        for (iternode = tosearch->first->next; iternode != NULL; iternode=iternode->next) {
            if (strcmp(iternode->key, key) == 0)
                return iternode->var->value;
        
        }
    }

   return -1;
}

void printlist(List* toprint)
{
    No* iternode;
    
    if (emptylist(toprint)) {
        printf("Empty list\n");
    } else {
        for (iternode= toprint->first->next; iternode != NULL; iternode=iternode->next) {
            printf("key %s\n------------\n", iternode->key);
            printVariable(iternode->var);
        }
    }
}

void destroylist(List* oldlist)
{
    No* sentinel = oldlist->last;
    No* iternode = oldlist->first;
    No* next;

    while (sentinel != iternode) {
        next = iternode->next; 
        free(iternode);
        iternode = next;
    }

    free(sentinel);
    free(oldlist);
}

int main()
{
    List* linked_list;

    linked_list = createList();
    
    insertlist(linked_list, createNo("x", createVariable("x", "int", 1, 0)));

    if (emptylist(linked_list))
        printf("Vazia\n");
    else
        printf("No\n");

    insertlist(linked_list, createNo("y", createVariable("y", "int", 12, 0)));

    printlist(linked_list);
    removelist(linked_list, "x");

    printlist(linked_list);
    printf("valor de y:%d\n", searchkeylist(linked_list, "y"));
    destroylist(linked_list);
    return 0;
}