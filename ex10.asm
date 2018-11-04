# Título: Exercício 10
# Autor: Nicolas Campana	
# Data: 03/11/18
# Descrição: Dados dois vetores X e Y, ambos com n elementos, determinar o produto escalar desses vetores. 
# Entrada: Nº de elementos dos vetores X e Y e seus valores
# Output: Produto escalar dos vetores
################# Data segment #####################
.data
entrada1: .asciiz "Quantos elementos tem os vetores X e Y? "
pedeVetX: .asciiz "Entre com os elementos do vetor X:\n"
pedeVetY: .asciiz "Entre com os elementos do vetor Y:\n"
pedeElemento: .asciiz "Elemento "
resultado: .asciiz "\nProduto escalar X * Y = "
doisPontos: .asciiz ": "
virgula: .asciiz ","
vetor: .asciiz "Vetor: "

################# Code segment #####################
.text
.globl main
	main:	# main program entry
		#Solicita n ao usuário
		la $a0, entrada1 	# Carrega Mensagem
		li $v0, 4 		# Código para imprimir string
		syscall 
		
		#Lê n
		li $v0, 5 		# Código para ler inteiro
		syscall
		move $s0, $v0  		# $s0 = n
		
		#Alocando espaço para os vetores X e Y no heap
		sll $a0, $s0, 3 	# $a0 = n * 8 = num de bytes necessários para armazenar n doubles
		#Alocando espaço para o vetor X
		li $v0, 9  		# Código para alocar espaço no heap
		syscall
		move $s1, $v0 		# $s1 = base do vetor X
		
		#Alocando espaço para o vetor Y
		li $v0, 9 		# Código para alocar espaço no heap
		syscall
		move $s2, $v0 		# $s2 = base do vetor Y
		
		
		#Solicita o vetor X
		la $a0, pedeVetX	# Carrega a mensagem solicitando o vetor X
		li $v0, 4		# Código para escrever uma string na tela
		syscall
		
		#Preparando argumentos para para a leitura do vetor X
		move $a1, $s0  		# $a1 = n
		move $a2, $s1		# $a2 = base do vetor X
		
		#Lendo os elementos do vetor X
		jal lerVetor
		
		#Solicita o vetor Y
		la $a0, pedeVetY	# Carrega a mensagem solicitando o vetor Y
		li $v0, 4		# Código para escrever uma string na tela
		syscall
		
		#Preparando argumentos para para a leitura do vetor Y
		move $a1, $s0  		# $a1 = n
		move $a2, $s2		# $a2 = base do vetor Y
		
		#Lendo os elementos do vetor Y
		jal lerVetor
		
		#Calculando o produto escalar X * Y
		li $t0, 0 		# i = 0
		sub.d $f2, $f2, $f2 	# f2 = prodEscalar = 0
		ProdutoEscalar:
			beq $t0, $s0, Exit    	# Se i == n, sai
			
			sll $t1, $t0, 3		# t1 = i * 8
			
			#Carregando X[i]
			add $t2, $s1, $t1 	# t2 = pos de mem de X[i]
			l.d $f4, 0($t2)		# f4 = X[i]
			
			#Carregando Y[i]
			add $t2, $s2, $t1 	# t2 = pos de mem de Y[i]
			l.d $f6, 0($t2)		# f6 = Y[i]
			
			#Calculando o produto escalar da iteração i
			mul.d $f4, $f4, $f6	# f4 = X[i] * Y [i]
			add.d $f2, $f2, $f4	# f2 += X[i] * Y [i] 
			
			#Incrementando o contador
			addi $t0, $t0, 1 	#i++
			
			j ProdutoEscalar 
		
		Exit:
			#Imprime a mensagem com o resultado do produto escalar X * Y
			la $a0, resultado	#Carrega a msg 
			li $v0, 4		#Código para imprimir uma string na tela           
			syscall
			mov.d $f12, $f2		#Prepara o valor do produto escalar para ser impresso
			li $v0, 3		#Código para imprimir um double
			syscall

		#Encerra o programa						
		li $v0, 10
		syscall
	
	
	
	#Funçao que lê um vetor recebendo seu pelo valor em $a1 
	#e a base do vetor em $a2
	lerVetor:
		li $t0, 0 			# $t0 = i = 0
		loop:
			beq $t0, $a1, saida 	# Saia do loop se i == n

			#Solicita o elemento i do vetor
			la $a0, pedeElemento	# Carrega a primeira parte da msg solicitando o elemento
			li $v0, 4 		# Código para imprimir uma string na tela
			syscall
			addi $t1, $t0, 1	# $t1 = i + 1
			move $a0, $t1		# carrega i + 1 para ser impresso
			li $v0, 1		# Código para imprimir um inteiro na tela
			syscall
			la $a0, doisPontos	# Carrega a parte final da msg a ser impressa
			li $v0, 4		# Código para imprimir uma string na tela
			syscall
			
			#Lê o elemento digitado
			li $v0, 7 		#Código para ler um double
			syscall
			#f0 contém o valor lido agora
			
			#Cálculo da posição do vetor a se armazenar o elemento lido
			sll $t1, $t0, 3 	# $t1 = i * 8
			add $t1, $a2, $t1	# t1 = baseDoVetor + i * 8
			#t1 agora contém a posição a se armazenar o double lido
			
			#Armazenando o valor lido no vetor
			s.d $f0, 0($t1) 	# vet[i] = valor lido
			
			addi $t0, $t0, 1	# i++
			
			j loop
		saida:
			jr $ra
	
