.data
des_str:	.space 100	# destination string , empty
src_str:	.space 100	# source string, input
Message1:	.asciiz	"Nhap xau: "
Message2:	.asciiz "Xau dao nguoc la: "
.text
main:
get_string:
	li	$v0, 4
	la	$a0, Message1
	syscall
	li	$v0, 8
	la	$a0, src_str	# a0 = Address(string[0])
	li	$a1, 100
	syscall
get_length:
	xor	$v0,$0,$0	# v0 = length = 0
	xor	$t0,$0,$0	# t1 = a0 + t0
check_char:
	add	$t1, $a0, $t0	#= Address(string[0]+i)
	lb	$t2, 0($t1)	# t2 = string[i]
	beq	$t2,$zero,done	# Is null char?
	addi	$v0, $v0, 1	# v0=v0+1->length=length+1
	addi	$t0, $t0, 1	# t0=t0+1->i = i + 1
	j	check_char
done:
	addi	$t0, $t0, -1	#$t0 la thu tu cua ki tu ngay truoc ki tu ket thuc
	
#copy cac ki tu theo thu tu nguoc lai

	la	$a1, des_str	#$a1 la x, des string
				#$a0 la src string
strcpy:
	add	$s0,$t0,$0	#s0 = i = t0
	add	$s1,$0,$0	#s1 = j = 0
Loop:	add	$t1,$s0,$a0	#t1 = s0 + a0 = i + src string[0]
				#= address of string[i]
	lb	$t2,0($t1)	#t2 = value at t1 = y[i]
	add	$t3,$s1,$a1	#t3 = s1 + a1 = j + x[0]
				#= address of x[j]				
	sb	$t2,0($t3)	#x[i]= t2 = y[i]
	beq	$t2,$zero,print	#if y[i]==0, print
	nop
	addi	$s0,$s0,-1
	addi	$s1,$s1,1
	j	Loop
	nop

#in ra reverse string	
print:	li	$v0, 4
	la	$a0, Message2
	syscall
	la	$a0, 0($a1)
	syscall
exit:	li	$v0, 10
	syscall
