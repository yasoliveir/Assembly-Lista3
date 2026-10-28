.data
	num: .asciiz "Número inteiro (100 a 999): "
	cen: .asciiz "Centena = "
	dez: .asciiz "\nDezena = "
	uni: .asciiz "\nUnidade = "
	msg1: .asciiz "Número fora do intervalo de 100 a 999"
.text
.globl main
main:
	#LEITURA DO NUMERO 
	li $v0, 4
	la $a0, num
	syscall
	li $v0, 5
	syscall
	move $t0, $v0 #t0 = num
	
	#CONFERIR SE O NUMERO ESTÁ ENTRE 100 E 999
	bgt $t0, 999, nao_entra #Maior que 999
	blt $t0, 100, nao_entra #Menor que 100
	
	#entre o intervalo
	j entra
	
#SE ENTRAR
	entra:
	#Contabilizar centena T0/100
	div $t1, $t0, 100 #t1 = numero da centena
	
	#contabilizar dezena
	mul $t2, $t1, 100 # t2 = num da centena * 100
	sub $t3, $t0, $t2 #$t3 = valor total - centena
	div $t4, $t3, 10 #t4 = oq sobrou % 10 para achara a dezena
	
	#contabilizar a unidade
	mul $t5, $t4, 10 # t5 = dez * 10
	add $t6, $t2, $t5 # t6 = junta a centena + dezena
	sub $t7, $t0, $t6 # t7 = sub o original da centena+dez
	
	#IMPRIMIR TEXTO CENTENA
	li $v0, 4
	la $a0, cen
	syscall
	#JOGAR O VALOR DA CENTENA (t2) EM a0 ANTES DE IMPRIMIR
	li $v0, 1
	move $a0, $t1
	syscall
	
	#IMPRIMIR TEXTO DEZENA
	li $v0, 4
	la $a0, dez
	syscall
	#JOGAR O VALOR DA CENTENA (t4) EM a0 ANTES DE IMPRIMIR
	li $v0, 1
	move $a0, $t4
	syscall
	
	#IMPRIMIR TEXTO UNIDADE
	li $v0, 4
	la $a0, uni
	syscall
	#JOGAR O VALOR DA CENTENA (t7) EM a0 ANTES DE IMPRIMIR
	li $v0, 1
	move $a0, $t7
	syscall
	j fim
	
#SE NAO ENTRAR
	nao_entra:
	li $v0, 4
	la $a0, msg1
	syscall
	j fim
	
#FIM
	fim:
	li $v0, 10
	syscall