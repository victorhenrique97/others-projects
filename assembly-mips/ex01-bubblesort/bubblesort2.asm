# Victor Henrique Rodrigues

#Algoritmo Bubble
# variáveis
# inteiro: aux, num[7]:= { 7, 5, 2, 1, 1, 3, 4} ,i, j, MAX;
# início.
# MAX := 7;
# 	para i de 0 até (MAX-1) faça
# 		para j de (MAX-1) até (i+1) passo -1 faça
# 			se num[j-1] > num[j] então
# 				aux := num[j-1];
# 				num[j-1] := num[j];
# 				num[j]:= aux;
# 			fim_se;
# 		fim_para;
# 	fim_para;
# 	para i de 0 até MAX faça
# 		escreva(num[i]);
# 	fim_para;
# fim

#t0 = i
#t1 = j
#t2 = i+1
#t3 = j-1
#t4 = MAX
#t5 = MAX-1
#t6 = aux
#t7 = vector[j]
#t8 = vector[j-1]
#s0 = ponteiro inicial vetor
#s1 = ponteiro final que itera no for do vetor
#s2 = ponteiro que itera sobre o vetor

	.data

	.align 2 							#alinhamento para inteiros
vector: .word 7, 5, 2, 1, 1, 3, 4		#setando os valores no vetor
		
	.text
	.globl main

main:

	li $t4, 7					#MAX = 7					
	li $t0, 0					# i = 0
	addi $t5, $t4, -1 			# MAX-1
	move $t1, $t5            	# j = MAX - 1
	la $s0, vector				# p0 = &vector
	addi $s1, $s0, 24			# p1 = final do vetor
	move, $s2, $s1				# p2 = final do vetor

loop1:
	bgt $t0,$t5, endloop1		#caso i seja maior que max-1 saia do loop1

	loop2:
		blt $t1,$t2, endloop2			#condição de parada segundo loop

		if:								#caso j seja menor que i+1 saia do loop2
			lw $t7, 0($s2)				# reg aux = vector[j]
			lw $t8, -4($s2)				#reg aux2 = vector[j-1]
			bge $t7,$t8, endif			#caso j seja maior que j-1 va para o final do loop
			sw $t7, -4($s2)				#retorno o valor pro vetor
			sw $t8, -0($s2)				#retorno o valor pro vetor
		endif:

		addi $t1, $t1, -1 				#j = j-1
		addi $t3, $t3, -1				#j-1 = j-1-1
		addi $s2, $s2, -4				#ponteiro é deslocado para cima no vetor
		j loop2

	endloop2:
		move $s2, $s1					#volto o ponteiro que itera para o final do vetor
		addi $t0, $t0, 1				#i++
		move $t1, $t5					# j = max-1
		addi $t2, $t2,1 				# t2++

	j loop1

endloop1:
	
	li $t0, 0							#retorno o i para zero

loopimprime:

	bgt $t0,$t5, endloopimprime		#caso i seja maior que max-1 termine o loop
	lw $t6, 0($s0) 						#carrega o valor do vetor para t6
	li $v0, 1							#rotina de impressão inteiro
	move $a0 ,$t6						#movendo para o argumento o numero do vetor
	syscall
	
	addi $s0, $s0, 4					#desloco em 4 unidades o ponteiro
	addi $t0, $t0, 1					#i++ 
	j loopimprime

endloopimprime:
	
	li $v0, 10
	syscall


	











