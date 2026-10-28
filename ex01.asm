#.Elaborar um programa que apresente o valor da conversão em real (R$) de um valor lido em dólar (US$). O programa deve considerar a cotação do dólar em R$5 (Usar apenas números inteiros). 
.data
	dolar: .asciiz "Valor em Dólar: US$"
	real: .asciiz "Valor convertido em Real é: R$"
	
.text
.globl main
main:
	li $v0, 4 #cod 4 = escrita de caracteres
	la $a0, dolar
	syscall
	li $v0, 5 #cod 5 = leitura de numero inteiro
	syscall
	move $t0, $v0 #armazena, em t0, o valor que está em v0 nesse momento
	
	mul $t1, $v0, 5 #armazena em t1 o valor de v0 (dolar digitado) * 5 (cotaçao sugerida pelo exercicio)
	
	li $v0, 4
	la $a0, real
	syscall
	li $v0, 1 #cod 1 = escrita de numero inteiro
	move $a0, $t1
	syscall
	
	li $v0, 10
	syscall