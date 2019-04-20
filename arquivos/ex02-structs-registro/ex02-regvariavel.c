//#include <Victor Henrique de Souza Rodrigues - 9791027> 
#include <stdlib.h>
#include <stdio.h>

#define ENTER 10

///////////////////////////////////////////////////////////////////////
typedef struct PERSON PERSON;

struct PERSON{
		char *nome, *endereco, *complemento, *numero;
		int nome_len, endereco_len, complemento_len, numero_len, size_reg;
};

//////////////////////////////////////////////////////////////////////////
void imprime_reg (PERSON *person){
	
		printf("Nome: %s\n", person->nome);
		printf("Endereco: %s\n", person->endereco);
		printf("Numero: %s\n", person->numero);
		printf("Nome: %s\n", person->complemento);
		printf("\n");
}

////////////////////////////////////////////////////////////////////////////
void leitura(char *filename){
	
	FILE *fp = NULL;
	PERSON *person = NULL;
	int byte_offset = 0, arquivo_size;
	
	fp = fopen(filename, "r");
	fseek(fp, 0, SEEK_END);
	arquivo_size = ftell(fp);
	rewind(fp);

	while(arquivo_size > byte_offset){

		person = (PERSON *) calloc(1, sizeof(PERSON));

		fread(&(person->size_reg), sizeof(int), 1, fp);

		fread(&(person->nome_len), sizeof(int), 1, fp);
		person->nome = (char *) malloc(sizeof(char)*(person->nome_len));
		fread(person->nome, sizeof(char), person->nome_len, fp);

		fread(&(person->endereco_len), sizeof(int), 1, fp);
		person->endereco = (char *) malloc(sizeof(char)*(person->endereco_len));
		fread(person->endereco, sizeof(char), person->endereco_len, fp);

		fread(&(person->numero_len), sizeof(int), 1, fp);
		person->numero = (char *) malloc(sizeof(char)*(person->numero_len));
		fread(person->numero, sizeof(char), person->numero_len, fp);

		fread(&(person->complemento_len), sizeof(int),1, fp);
		person->complemento = (char *) malloc(sizeof(char)*(person->complemento_len));
		fread(person->complemento, sizeof(char), person->complemento_len, fp);

		imprime_reg(person);
		byte_offset += person->size_reg;

		free(person->nome);
		free(person->endereco);
		free(person->numero);
		free(person->complemento);
		free(person);
	}

	fclose(fp);
}
///////////////////////////////////////////////////////////////////////////
void escreve(PERSON *person, char *filename){
	
	FILE *fp = NULL;

		fp = fopen(filename, "a");

		fwrite(&(person->size_reg), sizeof(int), 1, fp); 						// tamanho do registro

		fwrite(&(person->nome_len), sizeof(int), 1, fp); 						// tamanho do nome
		fwrite(person->nome, sizeof(char), person->nome_len, fp); 				// nome
		free(person->nome);

		fwrite(&(person->endereco_len), sizeof(int), 1, fp); 					// tamanho do endereco
		fwrite(person->endereco, sizeof(char), person->endereco_len, fp); 		// endereco
		free(person->endereco);

		fwrite(&(person->numero_len), sizeof(int),1, fp); 						// tamanho do numero
		fwrite(person->numero, sizeof(char), person->numero_len, fp); 			// numero
		free(person->numero);

		fwrite(&(person->complemento_len), sizeof(int), 1, fp); 				// tamanho do complemento
		fwrite(person->complemento, sizeof(char), person->complemento_len, fp); // complemento
		free(person->complemento);

		free(person);
		fclose(fp);			
}
///////////////////////////////////////////////////////////////////////////
int getsize(PERSON *person){

	int size = 0;

	size = person->nome_len + person->endereco_len + person->complemento_len + person->numero_len;	// tamanho dos campos
	size += 5*sizeof(int);																			// tamanho dos indicadores de campos								

}
///////////////////////////////////////////////////////////////////////////
char *readline(int *str_len){

	char *string = NULL;
	char charac;
	int counter = 0;

	do{
		charac = fgetc(stdin);
		string = realloc(string, sizeof(char)*(counter+1));
		string[counter++] = charac;
	}while(charac != ENTER);

	string[counter-1] = '\0';
	*str_len = counter;

return string;
}
///////////////////////////////////////////////////////////////////////
int main(int argc, char *argv[]){
	
	int option = 0, str_len = 0;
	char *filename = NULL;
	PERSON *person = NULL;

	
	printf("Digite o nome do arquivo que deseja utilizar: ");
	filename = readline(&str_len);

	while(option != 3){
		printf("Digite uma opção: 1 para inserir um registro, 2 para recuperar todos os registros, 3 para sair: ");
		scanf("%d%*c", &option);
		printf("\n");
		
		switch(option){
			case 1:
				printf("Inserção - Insira os dados:\n");
				person = (PERSON *) calloc(1, sizeof(PERSON));

				printf("Nome: "); 
				person->nome = readline(&str_len);
				person->nome_len = str_len;

				printf("Endereço: ");
				person->endereco = readline(&str_len);
				person->endereco_len = str_len;
			
				printf("Numero: ");
				person->numero = readline(&str_len);
				person->numero_len = str_len;
				
				printf("Complemento: ");
				person->complemento = readline(&str_len);
				person->complemento_len = str_len;
				
				person->size_reg = getsize(person);
				escreve(person, filename);
				printf("\n");
				break;
				
			
			case 2:
				printf("Busca - Recuperando registros...\n\n");
				leitura(filename);
				printf("Registros recuperados\n\n");	
				break;
			
		}
	}

	free(filename);

return 0;	
}