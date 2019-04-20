	.data
	.align 2

head: .word 0
cmd0: .asciiz "Digite: 1- Insercao | 2- Impressao | 3- Remocao | 4- Sair\n"
cmd1: .asciiz "Digite um numero: "
str:  .asciiz " "
str2: .asciiz "\n"

.text
.globl main


main:

	li $v0, 4		
	la $a0, cmd0
	syscall

	li $v0, 5
	syscall
	move $t0, $v0

	beq $t0, 1, INSERCAO
	beq $t0, 2, IMPRESSAO
	beq $t0, 3, REMOCAO
	beq $t0, 4, fim

	INSERCAO:
		jal insercao
		j main

	IMPRESSAO:
		jal impressao
		j main

	REMOCAO:
		jal remocao
		j main

	remocao:

		li $v0, 4					#Digite um numero
		la $a0, cmd1
		syscall
	
		li $v0, 5					#leitura do numero em t1
		syscall
		move $t1, $v0

		la $t3, head
		lw $t4, 0($t3)

		search_loop:
			beq $t4, $zero, not_found
			lw $t5, 4($t4)
			beq $t5, $t1, found 
			lw $t4, 8($t4)
			j search_loop

		found:
			lw $t6, 0($t4) #t6 = anterior
			lw $t7, 8($t4) #t7 = prox

		beq $t7, $t6, last_elem
		beq $t7, $zero, last
		beq $t6, $zero, first
		j middle
		
		first:
			sw $t6, 0($t7)	  #prox->ant = prox (NULL)
			sw $t7, 0($t3)	  #cabeça = prox
			j main

		last:
			sw $t7, 8($t6)    #anterior->prox = prox
			j main
			
		middle:
			sw $t7, 8($t6)    #anterior->prox = prox
			sw $t6, 0($t7)	  #prox->ant = ant
			j main

		last_elem:
			sw $zero, 0($t3) # cabeça->NULL
			j main

		not_found:
			j main


		fim:
		li $v0, 10
		syscall
	
##########################################################################
	insercao:
		
		addi $sp, $sp -4
		sw $ra, 0($sp)

		li $v0, 4					#Digite um numero
		la $a0, cmd1
		syscall
	
		li $v0, 5					#t1 = numero digitado
		syscall
		move $t1, $v0
	
		li $v0, 9					#t2 aponta para 12 bytes heap |ANT|ELEM|PROX|					
		li $a0, 12 
		syscall
		move $t2, $v0 

		sw $zero, 0($t2)            #t2->ant = NULL (zero)
		sw $t1, 4($t2)				#t2->elem = numero digitado
		sw $zero, 8($t2)			#t2->prox = NULL (zero)			
	
		la $t3, head    			#t3 recebe o endereço da cabeça da lista (stack)
		lw $t4, 0($t3)				#t4 acessa o valor contido em t3 (heap) (1 elemento da lista)
		sw $t4, 8($t2)				#t2->next = t4 (proximo elemento recebe a cabeca da lista)
	
		beq $t4, $zero, vazia
		sw $t2, 0($t4)				# t4->ant = t2 
		
	vazia:
		sw $t2, 0($t3)				

	ordena:
		lw $s0, 0($t3)				#acesso o enedereço apontado pela cabeça da lista: s0 = head;
	
		search_loop2:
			
			beq $s0, $zero, end_function
			lw $t1, 4($s0)			#t1 = elem1;

			lw $s1, 8($s0)			#s1 aponta para o proximo
			beq $s1, $zero, end_function
			lw $t5, 4($s1)			#t5 = elem2;

			bgt $t1, $t5, swap		#caso t5 seja menor que t1 eu troco, senão já está ordenado e volto para main.
			j end_function

		swap:
			sw $t5, 4($s0)
			sw $t1, 4($s1)

			move $s0 $s1
			j search_loop2

		end_function:
			addi $sp $sp, 4
			jr $ra

########################################################################
	impressao:
		
		addi $sp, $sp -4
		sw $ra, 0($sp)

		la $t3, head
		lw $t4, 0($t3)
	
		loop:
			beq $t4, $zero, fimloop
			lw $t1, 4($t4)
	
			li $v0, 1
			move $a0, $t1
			syscall
	
			li $v0,4
			la $a0,str
			syscall
	
			lw $t4, 8($t4)
			j loop
	
		fimloop:
			li $v0, 4
			la $a0, str2
			syscall

			addi $sp $sp, 4
			jr $ra

			
head	.word 0, 0, 0, 0

	la $t3, head
	lw $t4 0($t3) -> acessa o primeiro elemento
	lw $t4 4($t3) -> acessa o segundo elemento
	lw $t4 8($t3) -> acessa o terceiro elemento
	lw $t4 5($t3) -> acessa o quarto elemento

	rs