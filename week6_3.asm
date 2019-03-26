.data
A: .word 7, -2 , 5, 1, 5,6,7,3,6,8,8,59,5
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
	j	max		#call the max procedure
swap:	lw	$t3,0($v0)	#load gia tri cua v0 ra t3
	sw	$t1,0($v0)	#v0 se co gia tri t1
	sw	$t3,0($t0)	#t0 co gia tri la t3
	j	next_pair
ret:	
	addi	$a1,$a1,-4	#decrement pointer to last element
	j	sort		#repeat sort for smaller list
	
done:	j	after_sort

max:	addi	$v0,$a0,0	#init max pointer to first element
	addi	$t0,$a0,0	#init next pointer to first
loop:	lw	$v1,0($v0)	#init max value to first value
	beq	$t0,$a1,ret	#if next=last, return
	addi	$t0,$t0,4	#advance to next element
	lw	$t1,0($t0)	#load next element into $t1
	slt	$t2,$t1,$v1	#(next)<(max) ?
	bne	$t2,$zero,swap	#if (next)<(max), swap
next_pair:
	addi	$v0,$t0,0	#tang dia chi A[]	
j	loop			#change completed; now repeat