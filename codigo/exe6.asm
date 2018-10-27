# Título: Exercício 6
# Autor: Márcio Inácio Santana
# Descrição: Programa que calcula a soma (1/n) + (2/n-1) + ... + (n/1)
# Entradas: O valor de n
# Saídas: O resultado da soma
# Nome do arquivo: exe6.asm
# Data: 27/10/2018

############### Seção de dados
.data
descricao: .asciiz "Este programa executa a soma (1/n) + (2/n-1) + ... +  (n/1)\n\n"
pedirN: .asciiz "Digite o valor de n: "
resultado_pt1: .asciiz "O valor da soma até o "
resultado_pt2: .asciiz "° termo é: "

zeroDouble: .double 0.0
umDouble: .double 1.0

############### Seção de código
.text
.globl main

main:
	#####Imprime a descrição do progrma na tela#####
	la $a0, descricao #carrega a descrição para ser escrita
	li $v0, 4 #Código para imprimir string
	syscall #Chamada de sistema
	
	#####Solicita o valor de n ao usuário####
	la $a0, pedirN #Carrega a mensagem solicitando n para ser exibida
	li $v0, 4   #Código para imprimir uma string
	syscall #Chamada de sistema

	#####Lê o valor de n digitado pelo usuário####
	li $v0, 7 #Código para ler um double(n será lido como double 
		  #para facilitar cálculos futuros)
	syscall #Chamada de sistema
	
	####Armazenando o valor lido(n) em $f4####
	mov.d $f4, $f0  #f4 = n
	
	#####Inicializando o valor da soma####
	l.d $f2, zeroDouble #$f1 = soma = 0
	
	#####Inicializando o contador(i)####
	l.d $f6, umDouble #$f6 = i = 1.0(i é double para facilitar cálculos
			  #futuros)
	
	#####Executando o somatório####
	loop:
		c.le.d $f6, $f4 #i <= n?
		bc1f exit	#Vá para exit se i not<= n
		sub.d $f8, $f4, $f6 #$f8 = n - i
		l.d $f10, umDouble #$f10 = 1.0
		add.d $f8, $f8, $f10 #$f8 = n - i + 1.0
		div.d $f12, $f6, $f8 #$f12 = i/(n - i + 1.0)
		add.d $f2, $f2, $f12 #soma = soma + i/(n - i + 1.0)
		add.d $f6, $f6, $f10 #i++
		j loop
		
	exit:
	
	#####Imprimindo a primeira parte da mensagem do resultado#### 
	la $a0, resultado_pt1
	li $v0, 4
	syscall
	
	#####Imprimindo o valor de n na tela####
	cvt.w.d $f4, $f4 #Arredondando o valor em $f4
	mfc1 $a0, $f4 #Preparando o valor de n(convertido para inteiro) para ser exibido
	li $v0, 1 #Código para imprimir um double
	syscall
	
	#####Imprimindo a segunda parte da mensagem do resultado####
	la $a0, resultado_pt2
	li $v0, 4
	syscall
	
	#####Imprimindo o valor do somatório na tela####
	mov.d $f12, $f2 #Preparando "soma" para ser exibido
	li $v0, 3 #Código para imprimir um double
	syscall

#encerra a execução do programa
li $v0, 10
syscall
