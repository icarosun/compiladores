PALAVRA			[a-zA-Z]+
DIGITO			[0-9]

%% 

int | /*palavra chave*/
return	printf("Encontramos uma palavra chave: \"%s\"\n", yytext);

^"#"[ \t]*include[ \t]*	printf("Encontramos uma chamada de biblioteca: \"%s\"\n", yytext);

\<([^\.]+\.h)\>	printf("Encontramos uma biblioteca: \"%s\"\n", yytext);

["|'](.+)["|']	printf("Encontramos uma String: \"%s\"\n", yytext);

";"	printf("Encontramos um ponto-e-vírgula: \"%s\"\n", yytext); /*ponto-e-vírgula, parênteses, chaves, \n, \t, espaço */

"(" |
")"	printf("Encontramos um parênteses: \"%s\"\n", yytext);

"{" |
"}"	printf("Encontramos uma chave: \"%s\"\n", yytext);

"#"	printf("Encontramos um jogo da velha: \"%s\"\n", yytext); 

"<" |
">"	printf("Encontramos um (maior | menor): \"%s\"\n", yytext); 

{PALAVRA}+\(	printf("Encontramos uma função: \"%s\"\n", yytext); 

{DIGITO}	printf("Encontramos um digito: \"%s\"\n", yytext);

[ \t\n]+	printf("Encontramos um espaço branco: \"%s\"\n", yytext); 

.	printf( "Não identificado: %s\n", yytext );
%%

int main(int argc, char *argv[])
{
	if (argc < 2)
	{
		printf("Missing input file \n");
		exit(-1);
	}
	
	yyin = fopen(argv[1], "r");
	yylex();
}
