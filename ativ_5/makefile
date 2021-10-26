psql: sql.y sql.l
	bison -d sql.y --debug
	flex -o sql.l.c sql.l
	gcc -o psql sql.l.c sql.tab.c -lfl
	./psql teste.sql

clean:
	rm -f *.c *.h sql