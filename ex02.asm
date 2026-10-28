.data
	x1: .asciiz "Valor de X1: "
	x2: .asciiz "Valor X2: "
	novo_x1: .asciiz "Novo valor de X1: "
	novo_x2: .asciiz "\nNovo valor de X2: "
.text
.globl main
main: 
	# LEITURA E ESCRITA DE X1
	li $v0, 4 #escrita de caracteres
	la $a0, x1
	syscall
	li $v0, 5 #leitura de numeros inteiros
	syscall
	move $t0, $v0 #t0 = VALOR DE X1
	
	# LEITURA E ESCRITA DE X2
	li $v0, 4
	la $a0, x2
	syscall
	li $v0, 5
	syscall
	move $t1, $v0 #t1 = VALOR DE X2
	
	li $v0, 4
	la $a0, novo_x1
	syscall
	li $v0, 1 #escrita de numeros inteiros
	move $a0, $t1 #X1 COM VALOR DE X2
	syscall
	
	li $v0, 4
	la $a0, novo_x2
	syscall
	li $v0, 1
	move $a0, $t0 #X2 COM VALOR DE X1
	syscall
	
	li $v0, 10
	syscall
	
