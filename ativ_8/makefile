psql: html.y html.l
	bison -d html.y --debug
	flex -o html.l.c html.l
	gcc -o html_parser html.l.c html.tab.c -lfl
	./html_parser teste.txt

clean:
	rm -f *.c *.h html