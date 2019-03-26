.data
Message:.asciiz "String X:"
x:	.space	1000	# destination string x, empty
y:	.asciiz	"mission completed, respect +1"	# source string y
.text
	la	$a0, x
	la	$a1, y
strcpy:
	add	$s0,$0,$0	#s0 = i=0
Loop:	add	$t1,$s0,$a1	#t1 = s0 + a1 = i + y[0]
				#= address of y[i]
	lb	$t2,0($t1)	#t2 = value at t1 = y[i]
	add	$t3,$s0,$a0	#t3 = s0 + a0 = i + x[0]
				#= address of x[i]
	sb	$t2,0($t3)	#x[i]= t2 = y[i]
	beq	$t2,$zero,print	#if y[i]==0, exit
	nop
	addi	$s0,$s0,1
	j	Loop
	nop
print:	li	$v0, 59
	la	$a0, Message
	la	$a1, x
	syscall
exit:	li	$v0, 10
	syscall
