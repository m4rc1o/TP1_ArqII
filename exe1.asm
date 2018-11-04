# Título: Exercício 1
# Autor: Lucas Fiorini Braga 	
# Data: 03/11/18
# Descrição: Efetuar potência de dois numeros fornecidos pelo usuário
# Entrada: Numero a ser elevado e qual potencia 
# Output: Potencia entre os dois numeros

################# Data segment #####################

.data

descricao: .asciiz "Este programa calcula P(m,n), "
pedeM: .asciiz "digite o valor de m: "
pedeN: .asciiz "Digite o valor de n: "
resultado: .asciiz "P(m,n) = "

################# Code segment #####################

.text

.globl main

main:	# main program entry
	#Imprime a mensagem de apresentacao do programa
	la $a0, descricao
	li $v0, 4
	syscall 
	
	# Pede o valor de M
	la $a0, pedeM
	li $v0, 4
	syscall 
	
	# Le o M
	li $v0, 5
	syscall
	move $a1, $v0 # a1 = M
	
	# Pede o valor de N
	la $a0, pedeN
	li $v0, 4
	syscall 
	
	# Le o N
	li $v0, 5
	syscall
	move $a2, $v0 #a2 = N
	
	
	jal Potencia
	
	#Escreve indicador da reaposta de P(M,N)
	la $a0, resultado
	li $v0, 4
	syscall 
	
	
	#Mostra o resultado
	move $a0, $v1
	li $v0, 1
	syscall
	
	li $v0, 10	# Exit program
	syscall


Potencia: 
	addi $t0, $zero, 1
	addi $t4, $zero, 1 # P(m,n) = 1
	
	Loop:
		bgt  $t0, $a2, Exit
		mul  $t4, $t4, $a1 # Multiplica M($a1) por P($t4)
		addi $t0, $t0, 1 # ++i
		j Loop #volta para o loop
	Exit:
	move $v1, $t4
	jr $ra  #Volta para onde foi chamado
