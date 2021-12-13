#ifndef HASHTABLE_H_
#define HASHTABLE_H_

#include<stdlib.h>
#include"hashlist.h"

typedef struct hashtable Hashtable;

struct hashtable
{
    int size; 
    List** table; 
};

int hash(Hashtable* table, char* key)
{
    int i; 
    int total = 0;
    for (i = 0; key[i] != '\0'; i++)
        total = total + key[i];
    
    return total % table->size;
}

Hashtable* createhashtable(int size)
{
    List** hasharray = malloc(sizeof(List) * size);
    Hashtable* hashtable = (Hashtable*) malloc(sizeof(Hashtable));

    int i;
    for (i = 0; i<size; i++) {
        hasharray[i] = createlist();
    }

    hashtable->size = size;
    hashtable->table = hasharray;

    return hashtable;
}

void inserthashtable(Hashtable* hashtable, char* key, Variable* var)
{
    int h = hash(hashtable, key);
    List* list = hashtable->table[h];
    insertlist(list, createNo(key, var));
}

double searchkeyhashtable(Hashtable* hashtable, char* key)
{
    int h = hash(hashtable, key);
    List* list = hashtable->table[h];
    return searchkeylist(list, key);
}

void removeitemhashtable(Hashtable* hashtab, char* key)
{
    int h = hash(hashtab, key);
    List* list = hashtab->table[h];
    removelist(list, key);
}

int updateitemhashtable(Hashtable* hashtable, char* key, double value)
{
    int h = hash(hashtable, key);
    List* list = hashtable->table[h];
    return updatelist(list, key, value);
}

void destroyhashtable(Hashtable* oldtable)
{
    int i;
    for (i = 0; i < oldtable->size; i++) {
        destroylist(oldtable->table[i]);
    }
    free(oldtable);
}

void printhashtable(Hashtable* hashtable)
{
    int i;
    for (i = 0; i<hashtable->size; i++) {
        List* list = hashtable->table[i];
        printf("List %d\n", i + 1);
        printlist(list);
    }
}

#endif