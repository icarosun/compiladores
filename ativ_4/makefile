all: scannerC

helloC: 
	flex -o part1/compc.lex.c part1/helloC.lex
	gcc -o hello part1/compc.lex.c -lfl
	cat part1/helloWorld.c
	./hello part1/helloWorld.c
	
helloJava:
	flex -o part1/compjava.lex.c part1/helloJava.lex
	gcc -o hello part1/compjava.lex.c -lfl
	clear
	cat part1/helloWorld.java
	./hello part1/helloWorld.java
	
helloPascal:
	flex -o part1/comppascal.lex.c part1/helloPascal.lex
	gcc -o hello part1/comppascal.lex.c -lfl
	clear
	cat part1/helloWorld.pas
	./hello part1/helloWorld.pas	
	
somaC:
	flex -o part2/compc.lex.c part2/somaC.lex
	gcc -o soma part2/compc.lex.c -lfl
	clear
	cat part2/soma.c
	./soma part2/soma.c
	
somaJava:
	flex -o part2/compjava.lex.c part2/somaJava.lex
	gcc -o soma part2/compjava.lex.c -lfl
	clear
	cat part2/soma.java
	./soma part2/soma.java
	
somaPascal:
	flex -o part2/comppascal.lex.c part2/somaPascal.lex
	gcc -o soma part2/comppascal.lex.c -lfl
	clear
	cat part2/soma.pas
	./soma part2/soma.pas	

