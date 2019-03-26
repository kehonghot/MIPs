.data
A: .word 7, -2, 5, 1, 5,6,7,3,6,8,8,59,5
Aend: .word
.text
main:	la	$a0,A		#$a0 = Address(A[0])
	la	$a1,Aend
	addi	$a1,$a1,-4	#$a1 = Address(A[n-1])
	j	sort		#sort
after_sort:	li	$v0, 10	#exit
		syscall
end_main:

sort:	beq	$a0,$a1,done	#single element list is sorted
	j	pick		#call the max procedure
																												
swap:	lw	$t3,0($v0)	#load gia tri cua v0 ra t3
	sw	$t1,0($v0)	#v0 se co gia tri t1
	sw	$t3,0($t0)	#t0 co gia tri la t3
	addi	$t0, $t0, -4	#giam dia chi di 4
	addi	$v0, $v0, -4	
	j	insert_check	#check xem insert duoc nua hay k?

done:	j	after_sort

pick:		addi	$v0,$a0,4	#init pick pointer to 2nd element
loop:		addi	$t4,$v0,0	#luu gia tri cua v0 vao t4, cot moc de duyet mang
	
		addi	$t0,$v0,-4	#pre point
		beq	$t0,$a1,done	#if pre = last, done
		
insert_check:	beq	$v0,$a0, continue	#v0 tro den dau mang thi tang v0 roi tiep tuc loop
		lw	$t1,0($t0)
		lw	$v1,0($v0)
		slt	$t2,$v1,$t1	#check v1 < t1
		bne	$t2,$zero,swap	# swap
continue:	addi	$v0, $t4, 4	#tang A[i}
		j	loop
