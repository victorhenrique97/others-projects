# Victor Henrique Rodrigues

#Algoritmo Bubble
# variáveis
# inteiro: aux, num[7]:= { 7, 5, 2, 1, 1, 3, 4} ,i, j, MAX;
# início.
# MAX := 7;
# para i de 0 até (MAX-1) faça
# para j de (MAX-1) até (i+1) passo -1 faça
# se num[j-1] > num[j] então
# aux := num[j-1];
# num[j-1] := num[j];
# num[j]:= aux;
# fim_se;
# fim_para;
# fim_para;
# para i de 0 até MAX faça
# escreva(num[i]);
# fim_para;
# fim

# for(j = max-1; j>i+1; j--)



#max = t0, i = t1, j = t2, aux(n-1) = t3, t4 = i+1, t5 = j-1, t6 será a variavel aux, 
#t7 armazenara o elemento do vetor(j-1)
#t8 armazenara outro elemento(j)
#t9 = ponteiro que itera no vetor
#s0 ponteiro para o inicio do vetor

	.data

	.align 2 					#alinhamento para inteiros
vector: .word 7,5,2,1,1,3,4		#setando os valores no vetor
	
	.text
	.globl main


end_loop:

swap:

	move $t6, $t7					#aux =  elemento em j-1
	move $t7, $t8					#elemento em j-1 recebe elemento em j	
	move $t8, $t6					#elemento em j recebe elemento em aux
	sw $t7, 0 ($t9)					#com o ponteiro do vetor em j-1, carrego esse valor
	sw $t8, 4 ($t9)					#com o ponteiro do vetor em j-1 + 4 bytes carrego o valor

loop_int:
	
	ble $t2,$t4,loop_ext			#caso j seje menor ou igual a i+1 saia do loop
	lw $t7, $t9, 0					#carregando para t7 o valor de vetor em j-1
	lw $t8, $t9, 4					#carregando para t8 o valor de vetor em j
	bgt $t7,$t8, swap				#se o elemento em j-1 for maior que em j eu troco
	addi $t2, $t2, -1 				# j = j-1
	addi $s6, $s6, 4				# ponteiro é incrementado em 4 unidades
	j loop_int						#vai para o loop

loop_ext:

	$li $t4, 0					#zerando o valor de t4 que será a condição de parada do loop interno
	$addi $t4, $t1, 1           # cond para = i+1
	$addi $t5, $t2, -1        	#t5 = j-1 

main:

	$li $t0, 7 					#setando max como 7
	$li $t1, 0					#setando i como zero
	$addi $t2, $t0, -1			#setando j como max-1
	$addi $t3, $t0, -1			#setando em t3 um aux de comparação












