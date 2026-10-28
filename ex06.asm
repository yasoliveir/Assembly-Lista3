.data
	x1: .asciiz "Primeiro Número: "
	x2: .asciiz "Segundo Número: "
	msg_iguais: .asciiz "\nOs números são iguais"
	msg_maior: .asciiz "\nMaior número: "
	msg_menor: .asciiz "\nMenor número: "

.text
.globl main
main:
	# LEITURA PRIMEIRO NUMERO
	li $v0, 4
	la $a0, x1
	syscall
	li $v0, 5
	syscall
	move $t1, $v0 # t1 = x1
	
	# LEITURA SEGUNDO NUMERO
	li $v0, 4
	la $a0, x2
	syscall
	li $v0, 5
	syscall
	move $t2, $v0 # t2 = x2
	
	# COMPARAÇÕES
	beq $t1, $t2, iguais #se x1 = x2
	bgt $t1, $t2, t1_maior #se x1 > x2 vai p t1_maior
	
	#aqui se t2 > t1
	j t2_maior

# SE IGUAIS	
	iguais:
	li $v0, 4
	la $a0, msg_iguais
	syscall
	j fim
	
# SE X1 > X2 (t1 > t2)
	t1_maior:
	#IMPRIMIR O TEXTO "MAIOR NUMERO"	
	li $v0, 4
	la $a0, msg_maior
	syscall
	#JOGAR O VALOR DE T1 EM A0, ANTES DE IMPRIMIR O NUMERO
	li $v0, 1
	move $a0, $t1
	syscall
	
	#IMPRIMIR O TEXTO "MENOR VALOR"
	li $v0, 4
	la $a0, msg_menor
	syscall
	#JOGAR O VALOR DE T2 EM A0, ANTES DE IMPRIMIR O NUMERO
	li $v0, 1
	move $a0, $t2
	syscall
	j fim
	
#SE X2 > X1
	t2_maior:
	li $v0, 4
	la $a0, msg_maior
	syscall
	#JOGAR O VALOR DE T2 EM A0, ANTES DE IMPRIMIR O NUMERO
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4
	la $a0, msg_menor
	syscall
	#JOGAR O VALOR DE T1 EM A0, ANTES DE IMPRIMIR O NUMERO
	li $v0, 1
	move $a0, $t1
	syscall
	j fim
	
	fim:
	li $v0, 10
	syscall
	