//Victor Henrique de Souza Rodrigues - 9791027

#include <stdlib.h>
#include <stdio.h>

#define size_reg 772



typedef struct PERSON PERSON;

struct PERSON{
		char nome[256];
		char endereco[256];
		int numero;
		char complemento[256];
};

////////////////////////////////////////////////////////////////////////
void escreve(PERSON *person, char *filename){
	
	FILE *fp = NULL;
	
		fp = fopen(filename, "a");
		fwrite(person->nome, sizeof(char), 256, fp);
		fwrite(person->endereco, sizeof(char), 256, fp);
		fwrite(&(person->numero), sizeof(int),1, fp);
		fwrite(person->complemento, sizeof(char), 256, fp);
		fclose(fp);			
}

////////////////////////////////////////////////////////////////////////
PERSON *leitura (FILE *fp, int pos){
	
	
	PERSON *person = (PERSON *) calloc(1, sizeof(PERSON));
		
		fseek(fp, pos, SEEK_SET);
		fread(person->nome, sizeof(char), 256, fp);
		fread(person->endereco, sizeof(char), 256, fp);
		fread(&(person->numero), sizeof(int),1, fp);
		fread(person->complemento, sizeof(char), 256, fp);

return person;		
}

////////////////////////////////////////////////////////////////////////
void imprime_reg (PERSON *person){
	
		printf("Nome: %s\n", person->nome);
		printf("Endereco: %s\n", person->endereco);
		printf("Numero: %d\n", person->numero);
		printf("Nome: %s\n", person->complemento);
}

////////////////////////////////////////////////////////////////////////
void leitura_todos(char *filename){
	
	FILE *fp = NULL;
	int n_reg, i;
	PERSON *person = NULL;
	
	fp = fopen(filename, "r");
	fseek(fp, 0, SEEK_END);
	n_reg = ftell(fp)/size_reg;
	rewind(fp);
	
	for(i=0; i<n_reg; i++){
		person = leitura(fp, i*size_reg);
		imprime_reg(person);
		free(person);
	}

	fclose(fp);
}

////////////////////////////////////////////////////////////////////////
void leitura_RRN(char *filename, int RRN){
	
	FILE *fp = NULL;
	PERSON *person = NULL;
	
		fp = fopen(filename, "r");
		person = leitura(fp, RRN*size_reg);
		imprime_reg(person);
		free(person);
		fclose(fp);
}

////////////////////////////////////////////////////////////////////////
int main(int argc, char *argv[]){
	
	int option = 0;
	char filename[10];
	PERSON *person = (PERSON *) calloc(1, sizeof(PERSON));
	int RRN;
	
		printf("Digite o nome do arquivo que deseja utilizar (até 10 caracteres) \n");
		scanf("%s", filename);
		getchar();
		
	while(option != 4){
		printf("Digite uma opção: 1 para inserir um registro, 2 para recuperar todos os registros, 3 para pesquisar por RRN, 4 para sair\n");
		scanf("%d", &option);
	
		switch(option){
			case 1:
				printf("Nome: "); 
				scanf("%*[ \n]%[^\n]", person->nome);
				printf("%s\n", person->nome);
				
				printf("Endereço: ");
				scanf("%*[ \n]%[^\n]", person->endereco);
				printf("%s\n", person->endereco);
				
				printf("Numero: ");
				scanf("%*[ \n]%d", &person->numero);
				printf("%d\n", person->numero);
				
				printf("Complemento: ");
				scanf("%*[ \n]%[^\n]", person->complemento);
				printf("%s\n", person->complemento);
				
				escreve(person, filename);
				break;
				
			
			case 2:
				leitura_todos(filename);
				
				break;
			
			case 3:
				printf("Digite o RRN: ");
				scanf("%d", &RRN);
				leitura_RRN(filename, RRN);
				
				break;
		
		}
	}
return 0;	
}
