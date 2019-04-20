#victor Henrique Rodrigues

	.data 
String_fat: .asciiz " Fatorial = "

	.text
	.globl main


fatorial:
	
	addi $sp, $sp, -8
	sw $ra, 0($sp) 			#salvando em 0 o endereço de retorno da função
	sw $a0, 4($sp)			#salvando em 4 o (n)

	beq $a0, $zero, retorna1 	#se for igual a zero vá para retorna 1
	addi $a0, $a0, -1			#decremento o meu n de 1 unidade		
	jal fatorial   				#chamo recursivamente a função fatorial

	addi $a0, $a0, 1			#pois o valor de a0 está em n-1 ao inves de n para essa chamada
	mul $v0,$v0, $a0			# return n*fat(n-1)
	j retornafat

retorna1:

	addi $v0, $zero, 1			

retornafat:
	
	lw $a0, 4($sp) 				# recupera o valor de a0
	lw $ra,	0($sp)				# recupera o valor de ra
	addi $sp, $sp, 8			#retorna o ponteiro da pilha para a posição inicial dele
	jr $ra 						#va para a proxima instrução depois do procedimento fatorial

main:

	li $v0, 5 	# comando para ler do teclado um inteiro
	syscall   	# chamada de sistema

	move $t0, $v0 			# salvando em um registrador temporário o valor contido em v0 (n)
	add $a0, $zero, $t0		#salvando no registrador de parametros o valor de (n)
	jal fatorial 			#jump and link para o procedimento fatorial
	move $t1, $v0 			#salvando o retorno da função em t1

	li $v0, 1 				#rotina para a impressão de inteiro (n)
	move $a0, $t0 			#movendo para registrador de argumentos o valor de t0
	syscall

	li $v0, 4 				# rotina para a impressão de uma string 
	la $a0, String_fat 		#carrega para a0 o endereço de string fat
	syscall

	li $v0, 1				#imprimindo fat			
	move $a0,$t1
	syscall

	li $v0, 10				#saindo do programa
	syscall


	



