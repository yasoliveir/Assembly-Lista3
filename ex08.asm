.data
	msg_compra:  .asciiz "Digite o valor da compra (1000 a 9999): "
	err_compra:  .asciiz "Valor da compra inválido! Tente novamente.\n\n"
	msg_parcela: .asciiz "Digite o valor da parcela (100 a 500): "
	err_parcela: .asciiz "Valor da parcela inválido! Tente novamente.\n\n"
	
	msg_total:   .asciiz "\nTotal de parcelas: "
	msg_restante:.asciiz "\n(Sendo "
	msg_normais: .asciiz " parcela(s) de R$ "
	msg_ate:     .asciiz " e a última parcela de R$ "
	msg_fecha:   .asciiz ")"

.text
.globl main
main:

# VALIDAÇÃO DO VALOR DA COMPRA (1000 a 9999)
l_compra:
	li $v0, 4
	la $a0, msg_compra
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0    # $t0 = valor da compra
	
	# Verifica se é menor que 1000 ou maior que 9999
	blt $t0, 1000, erro_c
	bgt $t0, 9999, erro_c
	j l_parcela      # Se for válido, vai para a parcela

erro_c:
	li $v0, 4
	la $a0, err_compra
	syscall
	j l_compra       # Retorna para pedir a compra de novo

# VALIDAÇÃO DO VALOR DA PARCELA (100 a 500)
l_parcela:
	li $v0, 4
	la $a0, msg_parcela
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0    # $t1 = valor da parcela
	
	# Verifica se é menor que 100 ou maior que 500
	blt $t1, 100, erro_p
	bgt $t1, 500, erro_p
	j calcula        # Se for válido, vai para o cálculo

erro_p:
	li $v0, 4
	la $a0, err_parcela
	syscall
	j l_parcela      # Retorna para pedir a parcela de novo

# CALCULO DAS PARCELAS
calcula:
	# $t0 = compra, $t1 = parcela
	div $t2, $t0, $t1    # $t2 = quantidade de parcelas cheias 
	
	# resto = compra - (qtd_cheias * valor_parcela)
	mul $t3, $t2, $t1    # $t3 = total coberto pelas parcelas cheias
	sub $t4, $t0, $t3    # $t4 = resto (valor que sobrou para a última parcela)
	
	# Verifica se o resto é maior que 0
	bgt $t4, 0, com_resto
	
	# SE NÃO TEM RESTO 
	move $t5, $t2        # $t5 = total de parcelas
	move $t6, $t1        # $t6 = valor da última parcela (igual as outras)
	move $t7, $t2        # $t7 = quantidade de parcelas normais
	j imprime

# SE TEM RESTO (A última parcela é menor e precisa de 1 a mais)
com_resto:
	move $t7, $t2        # $t7 = quantidade de parcelas normais
	addi $t5, $t2, 1     # $t5 = total de parcelas (quociente + 1)
	move $t6, $t4        # $t6 = valor da última parcela (o resto)
	j imprime

# IMPRIMIR OS RESULTADOS
imprime:
	# Imprime o Total de Parcelas
	li $v0, 4
	la $a0, msg_total
	syscall
	li $v0, 1
	move $a0, $t5
	syscall
	
	# Se tem resto, imprime as parcelas normais e da ultima menor
	bgt $t4, 0, detalhe_resto
	j fim

detalhe_resto:
	li $v0, 4
	la $a0, msg_restante
	syscall
	
	li $v0, 1
	move $a0, $t7        # Quantidade de parcelas normais
	syscall
	
	li $v0, 4
	la $a0, msg_normais
	syscall
	
	li $v0, 1
	move $a0, $t1        # Valor da parcela normal
	syscall
	
	li $v0, 4
	la $a0, msg_ate
	syscall
	
	li $v0, 1
	move $a0, $t6        # Valor da última parcela (menor)
	syscall
	
	li $v0, 4
	la $a0, msg_fecha
	syscall

fim:
	li $v0, 10
	syscall