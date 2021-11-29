calc: paku.y paku.l
	bison -d paku.y --debug
	flex -o paku.l.c paku.l
	gcc -o paku paku.l.c paku.tab.c -lfl

clean:
	rm -f *.c *.h paku