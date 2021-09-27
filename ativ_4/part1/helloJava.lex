PALAVRA			[a-zA-Z]+
DIGITO			[0-9]
NOMECLASS	[A-Z]
IDENTIFICADOR	[a-zA-Z][a-zA-Z0-9]+

%% 

int | /*palavra chave*/
String |
class |
public |
static |
void |
return	printf("Encontramos uma palavra chave: \"%s\"\n", yytext);

["|'](.+)["|']	printf("Encontramos uma String: \"%s\"\n", yytext); /*string entre aspas */

";"	printf("Encontramos um ponto-e-vírgula: \"%s\"\n", yytext); /*ponto-e-vírgula, parênteses, chaves, \n, \t, espaço */

"(" |
")"	printf("Encontramos um parêntese: \"%s\"\n", yytext);

"{" |
"}"	printf("Encontramos uma chave: \"%s\"\n", yytext);

"[" |
"]"	printf("Encontramos uma cochete: \"%s\"\n", yytext);

"#"	printf("Encontramos um jogo da velha: \"%s\"\n", yytext); 

"<" |
">"	printf("Encontramos um (maior | menor): \"%s\"\n", yytext); 

({PALAVRA}(\.*))+\(	printf("Encontramos uma função: \"%s\"\n", yytext); 

{DIGITO}	printf("Encontramos um digito: \"%s\"\n", yytext);

{NOMECLASS}{PALAVRA} printf("Encontramos o nome da classe: \"%s\"\n", yytext);

{IDENTIFICADOR} printf("Encontramos um Identificador: \"%s\"\n", yytext);

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
