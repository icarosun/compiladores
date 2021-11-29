#include<stdio.h>
#include"hashtable.h"

int main()
{
    Hashtable* hash;

    hash = createhashtable(7);
    
    inserthashtable(hash, "x", createVariable("x", "int", 12, 0));
    inserthashtable(hash, "z", createVariable("z", "int", 13, 0));
    inserthashtable(hash, "y", createVariable("y", "int", 20, 0));
    inserthashtable(hash, "a", createVariable("a", "int", 14, 0));
    inserthashtable(hash, "ab", createVariable("ab", "int", 14, 0));
    
    removeitemhashtable(hash, "a");
    printhashtable(hash);

    printf("item y: %d\n", searchkeyhashtable(hash, "x"));

    destroyhashtable(hash);
    return 0;
}