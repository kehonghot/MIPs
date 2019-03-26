.data
string:		.space	100
Message1:	.asciiz	"Nhap xau:"
Message2:	.asciiz	"Do dai la "
.text
main:
get_string:
	li	$v0, 4
	la	$a0, Message1
	syscall
	li	$v0, 8
	la	$a0, string	# a0 = Address(string[0])
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
print_length:
	li	$v0, 4
	la	$a0, Message2
	syscall
	li	$v0, 1
	la	$a0, 0($t0)
	syscall
	li	$v0, 10
	syscall