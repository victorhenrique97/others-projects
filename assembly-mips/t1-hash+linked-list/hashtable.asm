# ele está indo 2 vezes para a função de hash
.data
.align 2

hash_table: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
cmd: .asciiz "Digite a operacao desejada: 1- Insercao em Hash | 2- Remocao em Hash | 3- Visualizacao da Hash | 4- Finalizar Programa\n"
cmd2: .asciiz "Digite o numero desejado:\n"
str: .asciiz " "
str2: .asciiz "\n"

.text
.globl main

main:

	li $v0, 4		
	la $a0, cmd
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0

	beq $t0, 1, menu_insercao
	beq $t0, 2, menu_remocao
	beq $t0, 3, menu_impressao
	beq $t0, 4, fim_programa
	
	menu_insercao:
		jal insercao
		j main

	menu_remocao:
		jal remocao
		j main
	
	menu_impressao:
		jal impressao
		j main

	fim_programa:
		li $v0, 10
		syscall
	
###################################################################
hash:

	addi $sp, $sp, -4
	sw $ra, 0($sp)

	rem $v0, $a0, 16
	mul $v0, $v0, 4

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra 

#####################################################################
insercao:
		
	addi $sp, $sp,-4
   	sw $ra, 0($sp)

   	li $v0, 4					#Digite um numero
	la $a0, cmd2
	syscall

   	li $v0, 5 					#t0 = numero
	syscall
	move $t0, $v0

	rem $t1, $t0, 16
	mul $t1, $t1, 4

	la $t3, hash_table				#t3 recebe o endereço da cabeça da lista (stack)
	add $t3, $t3, $t1  			#t3 = t3 + t1 (somado o deslocamento a posicao correta do vetor)
	
	li $v0, 9					#t2 aponta para 12 bytes heap |ANT|ELEM|PROX|					
	li $a0, 12 
	syscall
	
	move $t2, $v0 
	sw $t0, 4($t2)				#t2->elem = numero digitado
	lw $t4, 0($t3)				#t4 acessa o valor contido em t3 (heap) (1 elemento da lista)
	sw $t4, 8($t2)				#t2->next = t4 (proximo elemento recebe a cabeca da lista)
	
	beq $t4, $zero, vazia
	sw $t2, 0($t4)				# t4->ant = t2 
		
	vazia:
		sw $t2, 0($t3)				

	ordena:
		lw $s0, 0($t3)				#acesso o enedereço apontado pela cabeça da lista: s0 = head;
	
		loop_ordena:
			beq $s0, $zero, end_insertion
			lw $t0, 4($s0)					#t0 = elem1;

			lw $s1, 8($s0)					#s1 aponta para o proximo
			beq $s1, $zero, end_insertion
			lw $t5, 4($s1)					#t5 = elem2;

			bgt $t0, $t5, swap      		#caso t5 seja menor que t0 eu troco, senão já está ordenado e volto para main.
			j end_insertion

		swap:
			sw $t5, 4($s0)
			sw $t0, 4($s1)
			move $s0 $s1
			j loop_ordena

	end_insertion:
		addi $sp $sp, 4
		jr $ra

##############################################################################################
remocao:

	addi $sp, $sp, -4
   	sw $ra, 0($sp)

   	li $v0, 4					#Digite um numero
	la $a0, cmd2
	syscall

   	li $v0, 5 					#t0 = numero
	syscall
	move $t0, $v0

	rem $t1, $t0, 16
	mul $t1, $t1, 4

	la $t3, hash_table
	add $t3, $t3, $t1
	lw $t4, 0($t3)

	search_loop:
		beq $t4, $zero, not_found
		lw $t5, 4($t4)
		beq $t5, $t0, found 
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
		j end_remotion

	last:
		sw $t7, 8($t6)    #anterior->prox = prox
		j end_remotion
		
	middle:
		sw $t7, 8($t6)    #anterior->prox = prox
		sw $t6, 0($t7)	  #prox->ant = ant
		j end_remotion

	last_elem:
		sw $zero, 0($t3) # cabeça->NULL
		j end_remotion

	not_found:
		j end_remotion

	end_remotion:
		addi $sp $sp, 4
		jr $ra

###############################################################################################
impressao:
	
	addi $sp, $sp, -4
   	sw $ra, 0($sp)
		
	la $t3, hash_table
	
	addi $t0, $zero, 0
	addi $t1, $zero, 16

	loop_ext:

		beq $t0, $t1, end_print
		lw $t4, 0($t3)
		
		loop_int:
			beq $t4, $zero, end_loop_int
			lw $t2, 4($t4)
	
			li $v0, 1
			move $a0, $t2
			syscall
	
			li $v0,4
			la $a0,str
			syscall
	
			lw $t4, 8($t4)
			j loop_int
	
			end_loop_int:
				li $v0, 4
				la $a0, str2
				syscall

		addi $t0, $t0, 1
		addi $t3, $t3, 4
		j loop_ext

	end_print:
		addi $sp $sp, 4
		jr $ra
