.data
	sal_atual: .asciiz "Salário Atual: R$"
	aumento: .asciiz "Valor do Aumento em 25%: R$"
	sal_novo: .asciiz "\nNovo Salário: R$"
.text
.globl main
main: 
	# LEITURA DO SALARIO ATUAL
	li $v0, 4 #escrita de caracteres
	la $a0, sal_atual 
	syscall
	li $v0, 5 #leitura de inteiros
	syscall
	move $t0, $v0 # t0 = SAL ATUAL 
	
	# CALCULO AUMENTO SALARIAL
	mul $t1, $t0, 25 # t1 = SAL ATUAL * 25
	div $t2, $t1, 100 # t2 = 25% do SAL ATUAL
	add $t3, $t0, $t2 # t3 = ATUAL + AUMENTO
	
	# RETORNO AUMENTO
	li $v0, 4
	la $a0, aumento
	syscall
	li $v0, 1
	move $a0, $t2
	syscall
	
	# RETORNO SALARIO NOVO
	li $v0, 4
	la $a0, sal_novo
	syscall
	li $v0, 1 #escrita de numeros inteiros
	move $a0, $t3
	syscall 
	
	li $v0, 10
	syscall
	