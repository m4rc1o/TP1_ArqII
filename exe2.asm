# Programa criado para o trabalho de Arquitetura de Computadores 2.
# Exercício 2 de inteiros da lista de exercícios do trabalho 1.
# Para execução do exercícios foi implementado um BubbleSort.

.data
	prompt: .asciiz "Entrada de quantos números: "
	prompt2: .asciiz "Entre com um número: "
	virgula: .asciiz ","
.text 

	main:
		#contador do número de vezes que vai entrar com um número
		li $v0, 4
		la $a0, prompt
		syscall 
		li $v0, 5
		syscall 
		add $t0, $zero, $v0 
		add $t1, $zero, $v0
		mul $t8, $t0, -4
		add $sp, $zero, $t8
	while:	
		#Pegando um ou mais número(s) que o usuário digitar
		li $v0, 4
		la $a0, prompt2
		syscall 
		li $v0, 5
		syscall 
		sw $v0, 0($sp)
		addi $sp, $sp, 4
		addi $t0, $t0, -1
		bne $t0, $zero, while
		#Fora do WHILE eu mudo os registradores para andar na memória
		add $sp, $zero, $t8 #minha pilha
		add $t9, $zero, $t1 # indice i
	for1:
		lw $t2, 0($sp)  # carrego o valor de [i]
		add $t7, $zero, $t1
		add $sp, $zero, $t8 # para o j
	for2:
		lw $t4, 0($sp)
		#aqui chamo a troca de valores
		sgt $t6, $t4, $t2 # se t4 < t2
		addi $t3, $zero, 1
		beq $t6, $t3, troca
		trocado:
		addi $t7, $t7, -1
		#aqui ando na pilha
		addi $sp, $sp, 4
		bne $t7, $zero, for2
		addi $t9, $t9, -1 #decremento o contador de i
		mul $t5, $t9, -4
		add $sp, $zero, $t5
		bne $t9, $zero, for1 #se o meu i == 0, terminou de percorrer a pilha
		j exitLoop
	troca:
		add $t3, $t4, $zero
		add $t4, $t2, $zero
		add $t2, $t3, $zero
		#aqui já foi trocado entre os registradores, agora preciso trocar na memória
		mul $t5, $t9, -4
		add $sp, $zero, $t5
		sw $t2, 0($sp) #arrumado para o indice i
		mul $t5, $t7, -4
		add $sp, $zero, $t5
		sw $t4, 0($sp) #arrumado para o indice j
		j trocado
	exitLoop:	
		add $sp, $zero, $t8
	mostraResultado:	
		lw $t4, 0($sp)
		li $v0, 1
		add $a0, $t4, $zero
		syscall 
		li $v0, 4
		la $a0, virgula
		syscall
		addi $sp, $sp, 4
		addi $t1, $t1, -1
		bne $t1, $zero, mostraResultado	
		#end of program
		li $v0, 10
		syscall
