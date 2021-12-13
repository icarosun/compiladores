paku: paku.l paku.y astgen.h hashtable.h
	bison -d -v paku.y --debug
	flex -o paku.l.c paku.l
	gcc -o paku paku.l.c paku.tab.c -lfl -lm

test1: paku
	./paku tests/equacao_2_grau.pk

test2: paku
	./paku tests/ano_bissexto.pk

test3: paku
	./paku tests/data_valida.pk

test4: paku
	./paku tests/unidades_valor.pk

test5: paku
	./paku tests/caixa_eletronico.pk

make clean:
	rm -f paku paku.lex.c paku.l.c paku.tab.c paku.tab.h paku.output
	rm -f hash

runHash: hashlist.h hashtable.h
	gcc -o hash main.c
	./hash



