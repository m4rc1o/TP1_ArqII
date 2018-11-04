# Título: Exercício 10
# Autor: Nicolas Campana	
# Data: 03/11/18
# Descrição: Dados dois vetores x e y, ambos com n elementos, determinar o produto escalar desses vetores. 
# Entrada: Nº de elementos dos vetores x e y e seus valores
# Output: Produto escalar dos vetores
################# Data segment #####################
.data
entrada1: .asciiz "Quantos elementos tem os vetores x e y? "
virgula: .asciiz ","
vetor: .asciiz "Vetor: "
parenteses1: .asciiz "("
parenteses2: .asciiz ")"
################# Code segment #####################
.text
.globl main
	main:	# main program entry
		#Imprime a mensagem inicial do programa
		la $a0, entrada1 # Carrega Mensagem
		li $v0, 4 # Mostra Mensagem
		syscall 
		li $v0, 5 # Recolhe a entrada do número de elementos dos vetores 
		syscall
		move $t0, $v0
		
		add $t6, $zero, $t0 # guarda t6 para dps
		# T1 é o registrador base do primeiro vetor, x
		mul $t1, $t0, -8
		# T2 é o registrador base do segundo vetor, y
		mul $t2, $t0, -8
		
	While: 
		#Recebe os números dos vetores
		beq $t0, $zero, Reset # Se i == 0, sai do loop
		add $sp, $zero, $t1  # Ponteiro = controle de t1
		addi $t0, $t0, -1    # i--
		li $v0, 7            # Lê um numero
		syscall             
		mov.d $f2, $f0	     # move o valor lido para f2
		s.d $f2, 0($sp)      # salva o número digitado no x[i]
		addi $t1, $t1, 8      # decrementa ponteiro
		li $v0, 7
		syscall
		mov.d $f2, $f0       # move o lido para f2
		add $sp, $zero, $t2  # recebe o ponteiro
		s.d $f2, 0($sp)      # salva o número digitado no y[i]
		addi $t2, $t2, 8      #decrementa ponteiro
		j While
	Reset:
		mul $t1, $t6, -8     #volta os registradores ao inicio do array
		mul $t2, $t6, -8     # "
		la $a0, parenteses1
		li $v0, 4
		syscall
	Mult:
		beq $t6, $zero, Exit     #Se t6 (i) == 0, sai
		addi $t6, $t6, -1       # i--
		add $sp, $zero, $t1     # Ponteiro = t1 (x[i])
		l.d $f2, 0($sp)		# Recupera prmeiro valor 
		addi $t1, $t1, 8        # anda 1 posição
		add $sp, $zero, $t2     # Pega t2
		l.d $f4, 0($sp)         # recupera primeiro valor (y[i])
		addi $t2, $t2, 8        # Anda 1 posição
		mul.d $f6, $f2, $f4     # y[i] * x[i] 
		mfc1 $a0, $f6           # joga f6 para saida
		li $v0, 3               # Imprime f6
		syscall
		la $a0, virgula         # coloca virgula para parecer um vetor
		li $v0, 4               
		syscall
		j Mult 
		
	Exit:
	la $a0, parenteses2            # coloca parenteses no final para terminar amontagem de um vetor
	li $v0, 4
	syscall
	li $v0, 10	# Exit program
	syscall
