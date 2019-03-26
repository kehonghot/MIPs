.data
A:	.word	10, -7, 48, -24, 5
Message:.asciiz	"gia tri tuyet doi lon nhat la: "
.text
	la	$t0, A		#$t0 tro den dia chi mang A
	li	$s0, 5		#luu so phan tu cua mang
	li	$t2, 0		#so lan thuc hien vong lap
	lw	$t3, 0($t0)	#khoi tao max abs la phan tu dau tien
	abs	$t3, $t3
loop:	lw	$t1, 0($t0)	#$t1 = |A[i]|
	abs	$t1, $t1
	addi	$t2,$t2,1	#tang bo dem
	bge	$t3,$t1,skip	#skip neu $t3 >= $t1
	or	$t3,$t1,$zero	#dat lai $t3 = $t1
skip:	beq	$t2,$s0,end	#het mang, ket thuc ct
	addi	$t0,$t0,4	#tang dia chi o nho len 4 
	j	loop
end:	li	$v0, 56		#thong bao
	la	$a0, Message
	or	$a1,$t3,$zero
	syscall
	nop
	li	$v0, 10		#exit
	syscall
