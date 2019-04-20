#include <stdio.h>
#include <stdlib.h>
#include <string.h>

////////////////////////////////////////////////////////////////////////
void matching(FILE *fp1, FILE *fp2, FILE *output){

	char *string1 = NULL, *string2 = NULL;
	int flag_read_file1 = 1;
	int flag_read_file2 = 1;
	int aux = 0;

	while(flag_read_file1 && flag_read_file2){

		if(flag_read_file1 && aux <= 0)
			if(fscanf(fp1, "%ms", &string1) == EOF) flag_read_file1 = 0;

		if(flag_read_file2 && aux >= 0)
				if(fscanf(fp2, "%ms", &string2) == EOF) flag_read_file2 = 0;

		if(string1 && string2) aux = strcmp(string1, string2);
		else if(string1) aux = -1;
		else if(string2) aux = 1;

		if(aux < 0 && string1){
			free(string1);	
		}
		else if(aux > 0 && string2){
			free(string2);	
		}
		else if(aux == 0 && string2 && string1){
			fprintf(output, "%s\n", string1);
			free(string1);
			free(string2);
		}

	}
}
////////////////////////////////////////////////////////////////////////
void merging(FILE *fp1, FILE *fp2, FILE *output){

	char *string1 = NULL, *string2 = NULL;
	int flag_read_file1 = 1;
	int flag_read_file2 = 1;
	int aux = 0;

	while(flag_read_file1 || flag_read_file2){

		if(flag_read_file1 && aux <= 0)
			if(fscanf(fp1, "%ms", &string1) == EOF) flag_read_file1 = 0;

		if(flag_read_file2 && aux >= 0)
				if(fscanf(fp2, "%ms", &string2) == EOF) flag_read_file2 = 0;

		if(string1 && string2) aux = strcmp(string1, string2);
		else if(string1) aux = -1;
		else if(string2) aux = 1;

		if(aux < 0 && string1){
			fprintf(output, "%s\n", string1);
			free(string1);
		}
		else if(aux > 0 && string2){
			fprintf(output, "%s\n", string2);
			free(string2);
		}
		else if(aux == 0 && string2 && string1){
			fprintf(output, "%s\n", string1);
			free(string1);
			free(string2);
		}

	}

}
////////////////////////////////////////////////////////////////
int main(int argc, char *argv[]){

	FILE *fp = NULL, *fp2 = NULL, *output = NULL;
	int op = 0;

	while(op != 3){
		printf("Digite a operação: 1- Merging | 2- Matching | 3- Sair\n");
		scanf("%d", &op);

		if(op == 1){
			fp = fopen("lista1.txt", "r");
			fp2 = fopen("lista2.txt", "r");
			output = fopen("saidaMerging.txt", "w");
			merging(fp, fp2, output);
			fclose(output);
			fclose(fp);
			fclose(fp2);
		}

		if(op == 2){
			fp = fopen("lista1.txt", "r");
			fp2 = fopen("lista2.txt", "r");
			output = fopen("saidaMatching.txt", "w");
			matching(fp, fp2, output);
			fclose(output);
			fclose(fp);
			fclose(fp2);
		}
	}

return 0;
}


