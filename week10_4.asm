.data
command:.word	101, 120, 105, 116	#cac gia tri la luot la "e", "x", "i", "t"

.eqv KEY_CODE	0xFFFF0004		# ASCII code from keyboard, 1 byte
.eqv KEY_READY	0xFFFF0000		# =1 if has a new keycode ?
					# Auto clear after lw
.eqv DISPLAY_CODE	0xFFFF000C	# ASCII code to show, 1 byte
.eqv DISPLAY_READY	0xFFFF0008	# =1 if the display has already to do
					# Auto clear after sw
.text
li	$k0,KEY_CODE
li 	$k1,KEY_READY
li	$s0, DISPLAY_CODE
li 	$s1, DISPLAY_READY
la	$t3, command			#$t3 la con tro dia chi cua mang command
lw	$t4, 0($t3)			#lay gia tri cua command
li	$t5, 116			#luu gia tri cuoi cung

loop: 		nop
WaitKey:	lw 	$t1, 0($k1)	# $t1 = [$k1] = KEY_READY
		nop
		beq 	$t1,$0,WaitKey	# if $t1 == 0 then Polling
		nop
ReadKey:	lw	$t0, 0($k0)	# $t0 = [$k0] = KEY_CODE
		beq	$t0, $t4, check	#xem command co phai la exit hay k? bang cach check ki tu dau tien co phai "e" hay khong
		bne	$t0, $t4, setup	#neu k phai "exit" thi dat lai nhan dien chu cai dau
checkpoint:	nop
		
		nop
WaitDis:	lw	$t2, 0($s1)	# $t2 = [$s1] = DISPLAY_READY
		nop
		beq 	$t2,$0,WaitDis	# if $t2 == 0 then Polling
		nop
Encypt:		addi 	$t0, $t0, 1 	# change input key
Showkey:	sw 	$t0, 0($s0)	# show key
		nop
		j 	loop
		nop
setup:		la	$t3, command	#dat lai gia tri nhan dien ki tu "e"
		lw	$t4, 0($t3)
		j	checkpoint	#quay lai vong lap
check:		jal	check_exit
		j	checkpoint	#quay lai vong lap
check_exit:	beq	$t4, $t5, end	#neu gap "t" trong "exit" thi call ham exit
		addi	$t3, $t3, 4	#tangdia chi mang
		lw	$t4, 0($t3)
		jr	$ra
end:		li	$v0, 10	
		syscall
#exit