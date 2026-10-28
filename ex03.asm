.data
	mes_nasc: .asciiz "Mês de Nascimento (0 a 12): "
	ano_nasc: .asciiz "Ano de Nascimento: "
	mes_atual: .asciiz "Mês Atual (0 a 12): "
	ano_atual: .asciiz "Ano Atual: "
	idade_meses: .asciiz "Idade em Meses: "
.text
.globl main
main: 
	# LEITURA MES DE NASCIMENTO
	li $v0, 4 #escrita de caracteres
	la $a0, mes_nasc
	syscall
	li $v0, 5 #leitura de inteiros
	syscall
	move $t0, $v0 # t0 = MES DE NASCIMENTO
	
	# LEITURA ANO DE NASCIMENTO
	li $v0, 4 #escrita de caracteres
	la $a0, ano_nasc
	syscall
	li $v0, 5 #leitura de inteiros
	syscall
	move $t1, $v0 # t1 = ANO DE NASCIMENTO
	
	# LEITURA DO MES ATUAL
	li $v0, 4
	la $a0, mes_atual
	syscall
	li $v0, 5 
	syscall
	move $t2, $v0 # t2 = MES ATUAL
	
	# LEITURA DO ANO ATUAL
	li $v0, 4
	la $a0, ano_atual
	syscall
	li $v0, 5
	syscall
	move $t3, $v0 # t3 = ANO ATUAL
	
	sub $t5, $t2, $t0 # DIFERENÇA EM MESES (t5) = MES ATUAL - MES NASC 
	sub $t6, $t3, $t1 # IDADE EM ANOS (t6) = ANO ATUAL - ANO NASCI
	
	mul $t7, $t6, 12 # IDADE EM MESES = IDADE EM ANOS * 12 MESES
	add $t8, $t7, $t5 # SOMA IDADE EM MESES + DIFERENÇA EM MESES
	
	# LEITURA IDADE EM MESES
	li $v0, 4
	la $a0, idade_meses
	syscall
	li $v0, 1 # escrita de inteiros
	move $a0, $t8 # copia o conteudo que está dentro do registrador t8 para o registrador a0
	syscall
	
	li $v0, 10
	syscall
	
	
	
