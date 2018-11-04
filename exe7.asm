# Programa criado para o trabalho de Arquitetura de Computadores 2.
# Exercício 7 de pontos flutuantes da lista de exercícios do trabalho 1.


.data
	prompt: .asciiz "Entre com o número de alunos: "
	prompt2: .asciiz "Entre com uma nota: "
	prompt3: .asciiz "Media de cada estudante: "
	prompt4: .asciiz "Media da sala: "
	prompt5: .asciiz "Numero de aprovados: "
	prompt6: .asciiz "Numero de reprovados: "
	virgula: .asciiz " - "
	quebra: .asciiz "\n"
	zeroFloat: .float 0.0
	tres: .float 3.0
	aprov: .float 50.0
.text 

	main:
		#contador do número de vezes que vai entrar com um número
		li $v0, 4
		la $a0, prompt
		syscall 
		li $v0, 5
		syscall 
		add $t0, $zero, $v0 
		add $t2, $zero, $t0
		add $t3, $zero, $zero
		add $t4, $zero, $zero
		lwc1 $f16, aprov
		lwc1 $f10, zeroFloat
		lwc1 $f8, zeroFloat
		lwc1 $f14, tres
		#preparando a pilha
		mul $t1, $t0, -8
		#T5 contém um endereço com um espaço a mais para salvar a soma
		addi $t7, $t1, -8
		#arrumando a pilha para salvar os endereços
		add $sp, $t7, $zero #Inicio a pilha com o espaço separado
		add.s $f8, $f10, $f10 #somo
		swc1 $f8, 0($sp)    #salvo o valor da soma 
		#pilha iniciando com o endereço base :)
		add $sp, $t1, $zero
	while:	
		#Pegando um ou mais número(s) que o usuário digitar
		
		li $v0, 4
		la $a0, prompt2
		syscall 
		li $v0, 6
		syscall 
		add.s $f2, $f0, $f10
		li $v0, 4
		la $a0, prompt2
		syscall 
		li $v0, 6
		syscall 
		add.s $f4, $f0, $f10
		li $v0, 4
		la $a0, prompt2
		syscall 
		li $v0, 6
		syscall 
		add.s $f6, $f0, $f10
		#somando as notas de um aluno e salvando a média
		add.s $f2, $f2, $f4
		add.s $f2, $f2, $f6
		div.s $f0, $f2, $f14
		
		#somando a média das notas das sala de aula e salvando
		add $t6, $sp, $zero #salvo o endereço da pilha atual
		add $sp, $t7, $zero #adiciono o novo endereço
		lwc1 $f8, 0($sp)    #pego o valor anterior desse endereço
		add.s $f8, $f8, $f0 #somo
		swc1 $f8, 0($sp)    #salvo o valor da soma 
		add $sp, $t6, $zero #restauro o valor da pilha :)
		
		swc1 $f0, 0($sp)
		add $sp, $sp, 8
		
		#verificando se passou ou não
		c.lt.s $f0, $f16
		bc1t naopassou
		add $t4, $t4, 1 #só entra aqui se passou ;)
		passou:
		addi $t0, $t0, -1
		li $v0, 4
		la $a0, quebra
		syscall 
		bne $t0, $zero, while
		
		#ajustando os registradores
		#add $t4, $zero, $zero
		add $t0, $t2, $zero
		add $t5, $zero, $zero
		add $sp, $t1, $zero
		li $v0, 4
		la $a0, prompt3
		syscall
		j fim
		
	naopassou:
		addi $t3, $t3, 1 
		j passou

		#Ficou bem extensivo e repetitivo para ter uma saída de dados
		#mais clara pelo que foi pedido pelo exercício
	fim:	
		#mostrando a media de cada estudante da turma	
		lwc1 $f4, 0($sp)
		li $v0, 2
		add.s $f12, $f4, $f10
		syscall 
		li $v0, 4
		la $a0, virgula
		syscall
		addi $sp, $sp, 8
		addi $t0, $t0, -1
		bne $t0, $zero, fim
		#número de reprovados
		li $v0, 4
		la $a0, quebra
		syscall 
		li $v0, 4
		la $a0, prompt6
		syscall
		li $v0, 1
		add $a0, $t3, $zero
		syscall 
		#número de aprovados
		li $v0, 4
		la $a0, quebra
		syscall 
		li $v0, 4
		la $a0, prompt5
		syscall
		li $v0, 1
		add $a0, $t4, $zero
		syscall
		#media da sala
		li $v0, 4
		la $a0, quebra
		syscall 
		li $v0, 4
		la $a0, prompt4
		syscall
		#buscando de uma área específica da memória o resultdo da soma
		add $sp, $t7, $zero
		lwc1 $f8, 0($sp)   
		mtc1 $t2, $f2
		cvt.s.w $f2, $f2
		div.s $f8, $f8, $f2
		li $v0, 2
		add.s $f12, $f8, $f10
		syscall 
		

	
