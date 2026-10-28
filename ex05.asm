.data
	coef_a: .asciiz "Coeficiente A: "
	coef_b: .asciiz "Coeficiente B: "
	coef_c: .asciiz "Coeficiente C: "
	delta: .asciiz "\nValor de Delta: "
	msg1: .asciiz "\n\nDUAS RAÍZES REAIS\n"
	msg2: .asciiz "\n\nUMA RAÍZ REAL\n"
	msg3: .asciiz "\n\nNÃO EXISTEM RAÍZES REAIS\n"
.text
.globl main
main: 
# LEITURA DOS COEFICIENTES 
	#A
	li $v0, 4 #escrita de caracteres
	la $a0, coef_a
	syscall
	li $v0, 5 #leitura de inteiros
	syscall
	move $t0, $v0 # t0 = A
	
	#B
	li $v0, 4
	la $a0, coef_b
	syscall
	li $v0, 5
	syscall
	move $t1, $v0 # t1 = B
	
	#C
	li $v0, 4
	la $a0, coef_c
	syscall
	li $v0, 5
	syscall
	move $t2, $v0 # t2 = C
	
	# CALCULO DELTA
	mul $t3, $t1, $t1 # t3 = B * B
	mul $t4, $t0, 4 # t4 = A * 4
	mul $t4, $t2, $t4 # t4 = C *(4*A)
	sub $t5, $t3, $t4 # VALOR DE DELTA!
	
	# PRINT VALOR DE DELTA
	li $v0, 4
	la $a0, delta
	syscall
	li $v0, 1
	move $a0, $t5
	syscall
	
	# COMPARAÇÃO VALOR DE DELTA
	bgt $t5, 0, maior
	beq $t5, 0, igual
	blt $t5, 0, menor
	
# DELTA > 0
	maior:
	li $v0, 4
	la $a0, msg1
	syscall
	j fim
	
# DELTA = 0
	igual:
	li $v0, 4
	la $a0, msg2
	syscall
	j fim
	
# DELTA < 0
	menor:
	li $v0, 4
	la $a0, msg3
	syscall
	j fim
	
	fim:
	li $v0, 10
	syscall
	
	