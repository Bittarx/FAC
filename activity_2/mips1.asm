.data
.text	
main:
	#getting the order
	li $v0,12
	syscall
	move $t9,$v0 #$t9 contains the order
	#getting string length
	li $v0,5
	syscall
	move $t2,$v0  #$t2 contains string length
	addi $t2,$t2,1
	#creating array1
	move $a0,$t2
	addi $a0,$a0,1
	li $v0,9
	syscall
	move $t0,$v0 #$t0 contains addr of output array
	#creating array2
	move $a0,$t2
	li $v0,9
	syscall
	move $t1,$v0 #$t1 contains addr of input array
	#reading the string
	li $v0,8
	move $a0,$t1
	move $a1,$t2
	syscall
	
	add $s4,$zero,32 #32=space ascii
	add $s5,$zero,32
	
	move $t3,$zero  #0=index
	loop:
		add $t4,$t1,$t3 #t4=t1(index)
		lbu $t5, 0($t4)
		add $t6,$t0,$t3 #t6=t0(index)
		jal charmander
		beq $t5,$zero,exit
		sb $t5, 0($t6)
		move $s5,$t5
		addi $t3,$t3,1
		#slt $t7,$t3,$t2
		#beq $t3,$t2,loop
		#bne $t7,$zero,loop
		j loop
	exit:
	addi $t5,$zero,10
	sb $t5, 0($t6)
	move $a0,$t0
	li $v0,4
	syscall
	#syscall
	li $v0,10
	syscall	
	
charmander:
	li $s1,77  #M
	li $s2,109 #m
	li $s3,99 #c
	beq $t9,$s1,M
	beq $t9,$s2,m
	beq $t9,$s3,c
	
	M:
	slti $t7,$t5,123
	bne $t7,$zero under
	jr $ra
	under:
	slti $t7,$t5,97
	beq $t7,$zero,above
	jr $ra
	above:
	addi $t5,$t5,-32
	jr $ra
	
	m:
	slti $t7,$t5,91
	bne $t7,$zero under1
	jr $ra
	under1:
	slti $t7,$t5,65
	beq $t7,$zero,above1
	jr $ra
	above1:
	addi $t5,$t5,32
	jr $ra
	
	c:
	beq $s4,$s5,M
	j m