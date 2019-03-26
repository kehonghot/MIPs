.data
mess1:	.asciiz	"Largest: "
mess2:	.asciiz	"Smallest: "
mess3:	.asciiz	","
mess4:	.asciiz	"\n"
.text
	li	$s0, 6		#khoi tao cac gia tri
	li	$s1, 7
	li	$s2, -3
	li	$s3, 10
	li	$s4, -2
	li	$s5, 3
	li	$s6, 8
	li	$s7, 2
	
push:	addi	$t2,$sp,0	#luu gia tri cua $sp truoc khi truyen tham so vao, dung lam dieu kien ket thuc vong lap
 	addi	$sp,$sp,-32	#lay dia chi trong stack de truyen tham so
	sw	$s0,28($sp)
	sw	$s1,24($sp)
	sw	$s2,20($sp)
	sw	$s3,16($sp)
	sw	$s4,12($sp)
	sw	$s5,8($sp)
	sw	$s6,4($sp)
	sw	$s7,0($sp)
open:	lw	$v0,0($sp)	#v0 mac dinh la min
	addi	$v1,$v0, 0	#v1 mac dinh la max
	addi	$sp,$sp, 4	#tang $sp
	li	$t7, 7		#$t7 dem vi tri cua cac tham so
	move	$t5, $t7	#$t5 la vi tri gia tri min
	move	$t6, $t7	#$t6 la vi tri gia tri max
	jal	max_min		#tim max, min
	nop
	move	$t1, $v0	#t1 la gia tri min
	move	$t2, $v1	#t2 la gia tri max
print:	li $v0, 4
	la $a0, mess1
	syscall
	li $v0, 1
	la $a0, 0($t2)
	syscall
	li $v0, 4
	la $a0, mess3
	syscall
	li $v0, 1
	la $a0, 0($t6)
	syscall
	li $v0, 4
	la $a0, mess4
	syscall
	li $v0, 4
	la $a0, mess2
	syscall
	li $v0, 1
	la $a0, 0($t1)
	syscall
	li $v0, 4
	la $a0, mess3
	syscall
	li $v0, 1
	la $a0, 0($t5)
	syscall
exit:	li	$v0, 10
	syscall
		
max_min:	addi	$t7,$t7,-1	#tang so vong lap
		lw	$t1,0($sp)	#truyen tham so tiep theo vao
		addi	$sp, $sp,4	#tiep tuc tang $sp
		sub	$t0,$t1,$v0	#neu v0 van la min -> okay1, khong thi fix
		bgez	$t0,okay1 	
		nop
fix1:		move	$v0,$t1		#min = t1
		move	$t5,$t7		#vi tri moi cua min
		nop
okay1:		sub	$t0,$v1,$t1	#neu v1 can la max -> okay2, khong thi fix
		bgez	$t0,okay2	
		nop
fix2:		move	$v1,$t1		#max = t1
		move	$t6,$t7		#vi tri moi cua max
		nop
okay2:		bne	$t2, $sp, max_min
		jr	$ra