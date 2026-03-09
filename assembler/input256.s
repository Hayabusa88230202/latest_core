	.data
l.25450:	 # -200.000000
	.long	-1018691584
l.25448:	 # 200.000000
	.long	1128792064
l.25353:	 # 128.000000
	.long	1124073472
l.25334:	 # 0.900000
	.long	1063675494
l.24901:	 # 150.000000
	.long	1125515264
l.24787:	 # -150.000000
	.long	-1021968384
l.24761:	 # 0.100000
	.long	1036831949
l.24708:	 # -2.000000
	.long	-1073741824
l.24694:	 # 0.003906
	.long	998244352
l.24670:	 # 20.000000
	.long	1101004800
l.24669:	 # 0.050000
	.long	1028443341
l.24658:	 # 0.250000
	.long	1048576000
l.24642:	 # 10.000000
	.long	1092616192
l.24636:	 # 0.300000
	.long	1050253722
l.24635:	 # 255.000000
	.long	1132396544
l.24634:	 # 0.150000
	.long	1041865114
l.24630:	 # 3.141593
	.long	1078530011
l.24629:	 # 30.000000
	.long	1106247680
l.24628:	 # -0.785398
	.long	-1085730853
l.24627:	 # 2.473500
	.long	1075727827
l.24626:	 # 0.060035
	.long	1031137221
l.24625:	 # 0.089764
	.long	1035458158
l.24624:	 # 0.111111
	.long	1038323256
l.24623:	 # 0.142857
	.long	1041385765
l.24622:	 # 0.200000
	.long	1045220557
l.24621:	 # 0.333333
	.long	1051372202
l.24620:	 # 0.473500
	.long	1056075416
l.24619:	 # 15.000000
	.long	1097859072
l.24618:	 # 0.000100
	.long	953267991
l.24521:	 # 100000000.000000
	.long	1287568416
l.24517:	 # 1000000000.000000
	.long	1315859240
l.24249:	 # -0.100000
	.long	-1110651699
l.24185:	 # 0.010000
	.long	1008981770
l.24184:	 # -0.200000
	.long	-1102263091
l.23949:	 # 0.001370
	.long	984842502
l.23948:	 # 0.041664
	.long	1026205577
l.23947:	 # 0.000196
	.long	961373366
l.23946:	 # 0.008333
	.long	1007191654
l.23945:	 # 0.166667
	.long	1042983596
l.23944:	 # 0.785398
	.long	1061752795
l.23937:	 # 1.570796
	.long	1070141403
l.23917:	 # -1.000000
	.long	-1082130432
l.23916:	 # 1.000000
	.long	1065353216
l.23896:	 # 0.017453
	.long	1016003125
l.23884:	 # 0.000000
	.long	-2147483648
l.23883:	 # 3.141593
	.long	1078530011
l.23876:	 # 0.500000
	.long	1056964608
l.23875:	 # 6.283185
	.long	1086918619
l.23874:	 # 2.000000
	.long	1073741824
	.text
	j	_min_caml_start
adjust_exp.2562:
	fle	$f1, $f0
	fbf	fbt_else.27862
	la	$t8, l.23874
	flw	$f2, 0($t8)
	fmul	$f1, $f2, $f1
	j	adjust_exp.2562
fbt_else.27862:
	fmove	$f0, $f1
	jr	$ra
sub_iter.2565:
	la	$t8, l.23875
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.27863
	fle	$f1, $f0
	fbf	fbt_else.27864
	fsub	$f0, $f0, $f1
fbt_else.27864:
fbt_cont.27865:
	la	$t8, l.23876
	flw	$f2, 0($t8)
	fmul	$f1, $f1, $f2
	j	sub_iter.2565
fbt_else.27863:
	jr	$ra
quot_rem.2597:
	slt	$t8, $v0, $v1
	bne	$t8, $zero, beq_else.27866
	sub	$v0, $v0, $v1
	sw	$ra, 0($sp)
	subi	$sp, $sp, 4
	jal	quot_rem.2597
	addi	$sp, $sp, 4
	lw	$ra, 0($sp)
	lw	$v1, 4($v0)
	lw	$v0, 0($v0)
	addi	$v0, $v0, 1
	move	$a0, $t9
	addi	$t9, $t9, 8
	sw	$v1, 4($a0)
	sw	$v0, 0($a0)
	move	$v0, $a0
	jr	$ra
beq_else.27866:
	move	$v1, $t9
	addi	$t9, $t9, 8
	sw	$v0, 4($v1)
	sw	$zero, 0($v1)
	move	$v0, $v1
	jr	$ra
pow10.2602:
	addi	$t8, $zero, 1
	bne	$t8, $v0, beq_else.27867
	addi	$v0, $zero, 10
	jr	$ra
beq_else.27867:
	subi	$v0, $v0, 1
	sw	$ra, 0($sp)
	subi	$sp, $sp, 4
	jal	pow10.2602
	addi	$sp, $sp, 4
	lw	$ra, 0($sp)
	sll	$v1, $v0, 2
	add	$v1, $v1, $v1
	add	$v1, $v1, $v0
	add	$v0, $v1, $v0
	jr	$ra
get_digits_routine.2604:
	addi	$t8, $zero, 10
	bne	$t8, $v1, beq_else.27868
	addi	$v0, $zero, 10
	jr	$ra
beq_else.27868:
	sw	$v1, 0($sp)
	sw	$v0, -4($sp)
	move	$v0, $v1
	sw	$ra, -8($sp)
	subi	$sp, $sp, 12
	jal	pow10.2602
	addi	$sp, $sp, 12
	lw	$ra, -8($sp)
	lw	$v1, -4($sp)
	slt	$t8, $v1, $v0
	bne	$t8, $zero, beq_else.27869
	lw	$v0, 0($sp)
	addi	$v0, $v0, 1
	move	$gp, $v1
	move	$v1, $v0
	move	$v0, $gp
	j	get_digits_routine.2604
beq_else.27869:
	lw	$v0, 0($sp)
	jr	$ra
print_alldigits.2609:
	addi	$t8, $zero, 1
	bne	$t8, $v1, beq_else.27870
	addi	$v0, $v0, 48
	j	min_caml_print_char
beq_else.27870:
	subi	$a0, $v1, 1
	sw	$v1, 0($sp)
	sw	$v0, -4($sp)
	move	$v0, $a0
	sw	$ra, -8($sp)
	subi	$sp, $sp, 12
	jal	pow10.2602
	addi	$sp, $sp, 12
	lw	$ra, -8($sp)
	move	$v1, $v0
	lw	$v0, -4($sp)
	sw	$ra, -8($sp)
	subi	$sp, $sp, 12
	jal	quot_rem.2597
	addi	$sp, $sp, 12
	lw	$ra, -8($sp)
	lw	$v1, 4($v0)
	lw	$v0, 0($v0)
	addi	$v0, $v0, 48
	sw	$v1, -8($sp)
	sw	$ra, -12($sp)
	subi	$sp, $sp, 16
	jal	min_caml_print_char
	addi	$sp, $sp, 16
	lw	$ra, -12($sp)
	lw	$v0, 0($sp)
	subi	$v1, $v0, 1
	lw	$v0, -8($sp)
	j	print_alldigits.2609
print_int.2612:
	slti	$t8, $v0, 0
	bne	$t8, $zero, beq_else.27871
	slti	$t8, $v0, 1000
	bne	$t8, $zero, beq_else.27872
	addi	$v1, $zero, 1
	sw	$v0, 0($sp)
	sw	$ra, -4($sp)
	subi	$sp, $sp, 8
	jal	get_digits_routine.2604
	addi	$sp, $sp, 8
	lw	$ra, -4($sp)
	move	$v1, $v0
	lw	$v0, 0($sp)
	j	print_alldigits.2609
beq_else.27872:
	addi	$v1, $zero, 100
	sw	$ra, -4($sp)
	subi	$sp, $sp, 8
	jal	quot_rem.2597
	addi	$sp, $sp, 8
	lw	$ra, -4($sp)
	lw	$v1, 4($v0)
	lw	$v0, 0($v0)
	addi	$a0, $zero, 10
	sw	$v0, -4($sp)
	move	$v0, $v1
	move	$v1, $a0
	sw	$ra, -8($sp)
	subi	$sp, $sp, 12
	jal	quot_rem.2597
	addi	$sp, $sp, 12
	lw	$ra, -8($sp)
	lw	$v1, 4($v0)
	lw	$v0, 0($v0)
	lw	$a0, -4($sp)
	sw	$v1, -8($sp)
	bne	$zero, $a0, beq_else.27873
	bne	$zero, $v0, beq_else.27875
	j	beq_cont.27874
beq_else.27875:
	addi	$v0, $v0, 48
	sw	$ra, -12($sp)
	subi	$sp, $sp, 16
	jal	min_caml_print_char
	addi	$sp, $sp, 16
	lw	$ra, -12($sp)
beq_cont.27876:
	j	beq_cont.27874
beq_else.27873:
	addi	$a0, $a0, 48
	sw	$v0, -12($sp)
	move	$v0, $a0
	sw	$ra, -16($sp)
	subi	$sp, $sp, 20
	jal	min_caml_print_char
	addi	$sp, $sp, 20
	lw	$ra, -16($sp)
	lw	$v0, -12($sp)
	addi	$v0, $v0, 48
	sw	$ra, -16($sp)
	subi	$sp, $sp, 20
	jal	min_caml_print_char
	addi	$sp, $sp, 20
	lw	$ra, -16($sp)
beq_cont.27874:
	lw	$v0, -8($sp)
	addi	$v0, $v0, 48
	j	min_caml_print_char
beq_else.27871:
	addi	$v1, $zero, 45
	sw	$v0, 0($sp)
	move	$v0, $v1
	sw	$ra, -16($sp)
	subi	$sp, $sp, 20
	jal	min_caml_print_char
	addi	$sp, $sp, 20
	lw	$ra, -16($sp)
	lw	$v0, 0($sp)
	sub	$v0, $zero, $v0
	j	print_int.2612
read_object.2747:
	lui	$v1, 512
	lui	$a0, 512
	ori	$a0, $a0, 48
	la	$t8, l.23883
	flw	$f0, 0($t8)
	slti	$t8, $v0, 60
	bne	$t8, $zero, beq_else.27877
	jr	$ra
beq_else.27877:
	sw	$v1, 0($sp)
	fsw	$f0, -4($sp)
	sw	$a0, -8($sp)
	sw	$v0, -12($sp)
	sw	$ra, -16($sp)
	subi	$sp, $sp, 20
	jal	min_caml_read_int
	addi	$sp, $sp, 20
	lw	$ra, -16($sp)
	addi	$t8, $zero, -1
	bne	$t8, $v0, beq_else.27879
	addi	$v0, $zero, 0
	j	beq_cont.27880
beq_else.27879:
	sw	$v0, -16($sp)
	sw	$ra, -20($sp)
	subi	$sp, $sp, 24
	jal	min_caml_read_int
	addi	$sp, $sp, 24
	lw	$ra, -20($sp)
	sw	$v0, -20($sp)
	sw	$ra, -24($sp)
	subi	$sp, $sp, 28
	jal	min_caml_read_int
	addi	$sp, $sp, 28
	lw	$ra, -24($sp)
	sw	$v0, -24($sp)
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_read_int
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	addi	$v1, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$v0, -28($sp)
	move	$v0, $v1
	sw	$ra, -32($sp)
	subi	$sp, $sp, 36
	jal	min_caml_create_float_array
	addi	$sp, $sp, 36
	lw	$ra, -32($sp)
	sw	$v0, -32($sp)
	sw	$ra, -36($sp)
	subi	$sp, $sp, 40
	jal	min_caml_read_float
	addi	$sp, $sp, 40
	lw	$ra, -36($sp)
	lw	$v0, -32($sp)
	fsw	$f0, 0($v0)
	sw	$ra, -36($sp)
	subi	$sp, $sp, 40
	jal	min_caml_read_float
	addi	$sp, $sp, 40
	lw	$ra, -36($sp)
	lw	$v0, -32($sp)
	fsw	$f0, 4($v0)
	sw	$ra, -36($sp)
	subi	$sp, $sp, 40
	jal	min_caml_read_float
	addi	$sp, $sp, 40
	lw	$ra, -36($sp)
	lw	$v0, -32($sp)
	fsw	$f0, 8($v0)
	addi	$v1, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	move	$v0, $v1
	sw	$ra, -36($sp)
	subi	$sp, $sp, 40
	jal	min_caml_create_float_array
	addi	$sp, $sp, 40
	lw	$ra, -36($sp)
	sw	$v0, -36($sp)
	sw	$ra, -40($sp)
	subi	$sp, $sp, 44
	jal	min_caml_read_float
	addi	$sp, $sp, 44
	lw	$ra, -40($sp)
	lw	$v0, -36($sp)
	fsw	$f0, 0($v0)
	sw	$ra, -40($sp)
	subi	$sp, $sp, 44
	jal	min_caml_read_float
	addi	$sp, $sp, 44
	lw	$ra, -40($sp)
	lw	$v0, -36($sp)
	fsw	$f0, 4($v0)
	sw	$ra, -40($sp)
	subi	$sp, $sp, 44
	jal	min_caml_read_float
	addi	$sp, $sp, 44
	lw	$ra, -40($sp)
	lw	$v0, -36($sp)
	fsw	$f0, 8($v0)
	sw	$ra, -40($sp)
	subi	$sp, $sp, 44
	jal	min_caml_read_float
	addi	$sp, $sp, 44
	lw	$ra, -40($sp)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.27881
	addi	$v0, $zero, 0
	j	fbt_cont.27882
fbt_else.27881:
	addi	$v0, $zero, 1
fbt_cont.27882:
	addi	$v1, $zero, 2
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$v0, -40($sp)
	move	$v0, $v1
	sw	$ra, -44($sp)
	subi	$sp, $sp, 48
	jal	min_caml_create_float_array
	addi	$sp, $sp, 48
	lw	$ra, -44($sp)
	sw	$v0, -44($sp)
	sw	$ra, -48($sp)
	subi	$sp, $sp, 52
	jal	min_caml_read_float
	addi	$sp, $sp, 52
	lw	$ra, -48($sp)
	lw	$v0, -44($sp)
	fsw	$f0, 0($v0)
	sw	$ra, -48($sp)
	subi	$sp, $sp, 52
	jal	min_caml_read_float
	addi	$sp, $sp, 52
	lw	$ra, -48($sp)
	lw	$v0, -44($sp)
	fsw	$f0, 4($v0)
	addi	$v1, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	move	$v0, $v1
	sw	$ra, -48($sp)
	subi	$sp, $sp, 52
	jal	min_caml_create_float_array
	addi	$sp, $sp, 52
	lw	$ra, -48($sp)
	sw	$v0, -48($sp)
	sw	$ra, -52($sp)
	subi	$sp, $sp, 56
	jal	min_caml_read_float
	addi	$sp, $sp, 56
	lw	$ra, -52($sp)
	lw	$v0, -48($sp)
	fsw	$f0, 0($v0)
	sw	$ra, -52($sp)
	subi	$sp, $sp, 56
	jal	min_caml_read_float
	addi	$sp, $sp, 56
	lw	$ra, -52($sp)
	lw	$v0, -48($sp)
	fsw	$f0, 4($v0)
	sw	$ra, -52($sp)
	subi	$sp, $sp, 56
	jal	min_caml_read_float
	addi	$sp, $sp, 56
	lw	$ra, -52($sp)
	lw	$v0, -48($sp)
	fsw	$f0, 8($v0)
	addi	$v1, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	move	$v0, $v1
	sw	$ra, -52($sp)
	subi	$sp, $sp, 56
	jal	min_caml_create_float_array
	addi	$sp, $sp, 56
	lw	$ra, -52($sp)
	lw	$v1, -28($sp)
	bne	$zero, $v1, beq_else.27883
	j	beq_cont.27884
beq_else.27883:
	sw	$v0, -52($sp)
	sw	$ra, -56($sp)
	subi	$sp, $sp, 60
	jal	min_caml_read_float
	addi	$sp, $sp, 60
	lw	$ra, -56($sp)
	la	$t8, l.23896
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	lw	$v0, -52($sp)
	fsw	$f0, 0($v0)
	sw	$ra, -56($sp)
	subi	$sp, $sp, 60
	jal	min_caml_read_float
	addi	$sp, $sp, 60
	lw	$ra, -56($sp)
	la	$t8, l.23896
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	lw	$v0, -52($sp)
	fsw	$f0, 4($v0)
	sw	$ra, -56($sp)
	subi	$sp, $sp, 60
	jal	min_caml_read_float
	addi	$sp, $sp, 60
	lw	$ra, -56($sp)
	la	$t8, l.23896
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	lw	$v0, -52($sp)
	fsw	$f0, 8($v0)
beq_cont.27884:
	lw	$v1, -20($sp)
	addi	$t8, $zero, 2
	bne	$t8, $v1, beq_else.27885
	addi	$a0, $zero, 1
	j	beq_cont.27886
beq_else.27885:
	lw	$a0, -40($sp)
beq_cont.27886:
	addi	$a1, $zero, 4
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$a0, -56($sp)
	sw	$v0, -52($sp)
	move	$v0, $a1
	sw	$ra, -60($sp)
	subi	$sp, $sp, 64
	jal	min_caml_create_float_array
	addi	$sp, $sp, 64
	lw	$ra, -60($sp)
	move	$v1, $t9
	addi	$t9, $t9, 44
	sw	$v0, 40($v1)
	lw	$v0, -52($sp)
	sw	$v0, 36($v1)
	lw	$a0, -48($sp)
	sw	$a0, 32($v1)
	lw	$a0, -44($sp)
	sw	$a0, 28($v1)
	lw	$a0, -56($sp)
	sw	$a0, 24($v1)
	lw	$a0, -36($sp)
	sw	$a0, 20($v1)
	lw	$a0, -32($sp)
	sw	$a0, 16($v1)
	lw	$a1, -28($sp)
	sw	$a1, 12($v1)
	lw	$a2, -24($sp)
	sw	$a2, 8($v1)
	lw	$a2, -20($sp)
	sw	$a2, 4($v1)
	lw	$a3, -16($sp)
	sw	$a3, 0($v1)
	lw	$a3, -12($sp)
	sll	$t0, $a3, 2
	lw	$t1, -8($sp)
	add	$t8, $t1, $t0
	sw	$v1, 0($t8)
	addi	$t8, $zero, 3
	bne	$t8, $a2, beq_else.27887
	flw	$f0, 0($a0)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.27889
	addi	$v1, $zero, 1
	j	fbt_cont.27890
fbt_else.27889:
	addi	$v1, $zero, 0
fbt_cont.27890:
	bne	$zero, $v1, beq_else.27891
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.27893
	addi	$v1, $zero, 1
	j	fbt_cont.27894
fbt_else.27893:
	addi	$v1, $zero, 0
fbt_cont.27894:
	bne	$zero, $v1, beq_else.27895
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.27897
	addi	$v1, $zero, 0
	j	fbt_cont.27898
fbt_else.27897:
	addi	$v1, $zero, 1
fbt_cont.27898:
	bne	$zero, $v1, beq_else.27899
	la	$t8, l.23917
	flw	$f1, 0($t8)
	j	beq_cont.27896
beq_else.27899:
	la	$t8, l.23916
	flw	$f1, 0($t8)
beq_cont.27900:
	j	beq_cont.27896
beq_else.27895:
	la	$t8, l.23884
	flw	$f1, 0($t8)
beq_cont.27896:
	fmul	$f0, $f0, $f0
	fdiv	$f0, $f1, $f0
	j	beq_cont.27892
beq_else.27891:
	la	$t8, l.23884
	flw	$f0, 0($t8)
beq_cont.27892:
	fsw	$f0, 0($a0)
	flw	$f0, 4($a0)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.27901
	addi	$v1, $zero, 1
	j	fbt_cont.27902
fbt_else.27901:
	addi	$v1, $zero, 0
fbt_cont.27902:
	bne	$zero, $v1, beq_else.27903
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.27905
	addi	$v1, $zero, 1
	j	fbt_cont.27906
fbt_else.27905:
	addi	$v1, $zero, 0
fbt_cont.27906:
	bne	$zero, $v1, beq_else.27907
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.27909
	addi	$v1, $zero, 0
	j	fbt_cont.27910
fbt_else.27909:
	addi	$v1, $zero, 1
fbt_cont.27910:
	bne	$zero, $v1, beq_else.27911
	la	$t8, l.23917
	flw	$f1, 0($t8)
	j	beq_cont.27908
beq_else.27911:
	la	$t8, l.23916
	flw	$f1, 0($t8)
beq_cont.27912:
	j	beq_cont.27908
beq_else.27907:
	la	$t8, l.23884
	flw	$f1, 0($t8)
beq_cont.27908:
	fmul	$f0, $f0, $f0
	fdiv	$f0, $f1, $f0
	j	beq_cont.27904
beq_else.27903:
	la	$t8, l.23884
	flw	$f0, 0($t8)
beq_cont.27904:
	fsw	$f0, 4($a0)
	flw	$f0, 8($a0)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.27913
	addi	$v1, $zero, 1
	j	fbt_cont.27914
fbt_else.27913:
	addi	$v1, $zero, 0
fbt_cont.27914:
	bne	$zero, $v1, beq_else.27915
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.27917
	addi	$v1, $zero, 1
	j	fbt_cont.27918
fbt_else.27917:
	addi	$v1, $zero, 0
fbt_cont.27918:
	bne	$zero, $v1, beq_else.27919
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.27921
	addi	$v1, $zero, 0
	j	fbt_cont.27922
fbt_else.27921:
	addi	$v1, $zero, 1
fbt_cont.27922:
	bne	$zero, $v1, beq_else.27923
	la	$t8, l.23917
	flw	$f1, 0($t8)
	j	beq_cont.27920
beq_else.27923:
	la	$t8, l.23916
	flw	$f1, 0($t8)
beq_cont.27924:
	j	beq_cont.27920
beq_else.27919:
	la	$t8, l.23884
	flw	$f1, 0($t8)
beq_cont.27920:
	fmul	$f0, $f0, $f0
	fdiv	$f0, $f1, $f0
	j	beq_cont.27916
beq_else.27915:
	la	$t8, l.23884
	flw	$f0, 0($t8)
beq_cont.27916:
	fsw	$f0, 8($a0)
	j	beq_cont.27888
beq_else.27887:
	addi	$t8, $zero, 2
	bne	$t8, $a2, beq_else.27925
	lw	$v1, -40($sp)
	bne	$zero, $v1, beq_else.27927
	addi	$v1, $zero, 1
	j	beq_cont.27928
beq_else.27927:
	addi	$v1, $zero, 0
beq_cont.27928:
	flw	$f0, 0($a0)
	fmul	$f0, $f0, $f0
	flw	$f1, 4($a0)
	fmul	$f1, $f1, $f1
	fadd	$f0, $f0, $f1
	flw	$f1, 8($a0)
	fmul	$f1, $f1, $f1
	fadd	$f0, $f0, $f1
	sw	$v1, -60($sp)
	sw	$ra, -64($sp)
	subi	$sp, $sp, 68
	jal	min_caml_sqrt
	addi	$sp, $sp, 68
	lw	$ra, -64($sp)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.27929
	addi	$v0, $zero, 1
	j	fbt_cont.27930
fbt_else.27929:
	addi	$v0, $zero, 0
fbt_cont.27930:
	bne	$zero, $v0, beq_else.27931
	lw	$v0, -60($sp)
	bne	$zero, $v0, beq_else.27933
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fdiv	$f0, $f1, $f0
	j	beq_cont.27932
beq_else.27933:
	la	$t8, l.23917
	flw	$f1, 0($t8)
	fdiv	$f0, $f1, $f0
beq_cont.27934:
	j	beq_cont.27932
beq_else.27931:
	la	$t8, l.23916
	flw	$f0, 0($t8)
beq_cont.27932:
	lw	$v0, -32($sp)
	flw	$f1, 0($v0)
	fmul	$f1, $f1, $f0
	fsw	$f1, 0($v0)
	flw	$f1, 4($v0)
	fmul	$f1, $f1, $f0
	fsw	$f1, 4($v0)
	flw	$f1, 8($v0)
	fmul	$f0, $f1, $f0
	fsw	$f0, 8($v0)
beq_else.27925:
beq_cont.27926:
beq_cont.27888:
	lw	$v0, -28($sp)
	bne	$zero, $v0, beq_else.27935
	j	beq_cont.27936
beq_else.27935:
	lw	$v0, -52($sp)
	flw	$f0, 0($v0)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.27937
	j	fbt_cont.27938
fbt_else.27937:
	fneg	$f0, $f0
fbt_cont.27938:
	la	$t8, l.23875
	flw	$f1, 0($t8)
	fsw	$f0, -64($sp)
	sw	$ra, -68($sp)
	subi	$sp, $sp, 72
	jal	adjust_exp.2562
	addi	$sp, $sp, 72
	lw	$ra, -68($sp)
	fmove	$f1, $f0
	flw	$f0, -64($sp)
	sw	$ra, -68($sp)
	subi	$sp, $sp, 72
	jal	sub_iter.2565
	addi	$sp, $sp, 72
	lw	$ra, -68($sp)
	flw	$f1, -4($sp)
	fle	$f1, $f0
	fbf	fbt_else.27939
	fsub	$f0, $f0, $f1
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	sw	$zero, 0($v0)
	j	fbt_cont.27940
fbt_else.27939:
	addi	$v0, $zero, 1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.27940:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.27941
	bne	$zero, $v0, beq_else.27943
	addi	$v0, $zero, 1
	j	beq_cont.27944
beq_else.27943:
	addi	$v0, $zero, 0
beq_cont.27944:
	fsub	$f0, $f1, $f0
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.27942
fbt_else.27941:
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.27942:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23944
	flw	$f2, 0($t8)
	fle	$f0, $f2
	fbf	fbt_else.27945
	bne	$zero, $v0, beq_else.27947
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
	fneg	$f0, $f0
	j	fbt_cont.27946
beq_else.27947:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
beq_cont.27948:
	j	fbt_cont.27946
fbt_else.27945:
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	bne	$zero, $v0, beq_else.27949
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fneg	$f0, $f0
	j	beq_cont.27950
beq_else.27949:
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
beq_cont.27950:
fbt_cont.27946:
	lw	$v0, -52($sp)
	flw	$f2, 0($v0)
	la	$t8, l.23884
	flw	$f3, 0($t8)
	fle	$f3, $f2
	fbf	fbt_else.27951
	addi	$v1, $zero, 1
	j	fbt_cont.27952
fbt_else.27951:
	addi	$v1, $zero, 0
fbt_cont.27952:
	bne	$zero, $v1, beq_else.27953
	fneg	$f2, $f2
beq_else.27953:
beq_cont.27954:
	la	$t8, l.23875
	flw	$f3, 0($t8)
	fsw	$f0, -68($sp)
	sw	$v1, -72($sp)
	fsw	$f2, -76($sp)
	fmove	$f1, $f3
	fmove	$f0, $f2
	sw	$ra, -80($sp)
	subi	$sp, $sp, 84
	jal	adjust_exp.2562
	addi	$sp, $sp, 84
	lw	$ra, -80($sp)
	fmove	$f1, $f0
	flw	$f0, -76($sp)
	sw	$ra, -80($sp)
	subi	$sp, $sp, 84
	jal	sub_iter.2565
	addi	$sp, $sp, 84
	lw	$ra, -80($sp)
	flw	$f1, -4($sp)
	fle	$f1, $f0
	fbf	fbt_else.27955
	lw	$v0, -72($sp)
	bne	$zero, $v0, beq_else.27957
	addi	$v0, $zero, 1
	j	beq_cont.27958
beq_else.27957:
	addi	$v0, $zero, 0
beq_cont.27958:
	fsub	$f0, $f0, $f1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.27956
fbt_else.27955:
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	lw	$v1, -72($sp)
	sw	$v1, 0($v0)
fbt_cont.27956:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.27959
	fsub	$f0, $f1, $f0
fbt_else.27959:
fbt_cont.27960:
	la	$t8, l.23944
	flw	$f2, 0($t8)
	fle	$f0, $f2
	fbf	fbt_else.27961
	bne	$zero, $v0, beq_else.27963
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fneg	$f0, $f0
	j	fbt_cont.27962
beq_else.27963:
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
beq_cont.27964:
	j	fbt_cont.27962
fbt_else.27961:
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	bne	$zero, $v0, beq_else.27965
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
	fneg	$f0, $f0
	j	beq_cont.27966
beq_else.27965:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
beq_cont.27966:
fbt_cont.27962:
	lw	$v0, -52($sp)
	flw	$f2, 4($v0)
	la	$t8, l.23884
	flw	$f3, 0($t8)
	fle	$f3, $f2
	fbf	fbt_else.27967
	j	fbt_cont.27968
fbt_else.27967:
	fneg	$f2, $f2
fbt_cont.27968:
	la	$t8, l.23875
	flw	$f3, 0($t8)
	fsw	$f0, -80($sp)
	fsw	$f2, -84($sp)
	fmove	$f1, $f3
	fmove	$f0, $f2
	sw	$ra, -88($sp)
	subi	$sp, $sp, 92
	jal	adjust_exp.2562
	addi	$sp, $sp, 92
	lw	$ra, -88($sp)
	fmove	$f1, $f0
	flw	$f0, -84($sp)
	sw	$ra, -88($sp)
	subi	$sp, $sp, 92
	jal	sub_iter.2565
	addi	$sp, $sp, 92
	lw	$ra, -88($sp)
	flw	$f1, -4($sp)
	fle	$f1, $f0
	fbf	fbt_else.27969
	fsub	$f0, $f0, $f1
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	sw	$zero, 0($v0)
	j	fbt_cont.27970
fbt_else.27969:
	addi	$v0, $zero, 1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.27970:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.27971
	bne	$zero, $v0, beq_else.27973
	addi	$v0, $zero, 1
	j	beq_cont.27974
beq_else.27973:
	addi	$v0, $zero, 0
beq_cont.27974:
	fsub	$f0, $f1, $f0
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.27972
fbt_else.27971:
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.27972:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23944
	flw	$f2, 0($t8)
	fle	$f0, $f2
	fbf	fbt_else.27975
	bne	$zero, $v0, beq_else.27977
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
	fneg	$f0, $f0
	j	fbt_cont.27976
beq_else.27977:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
beq_cont.27978:
	j	fbt_cont.27976
fbt_else.27975:
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	bne	$zero, $v0, beq_else.27979
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fneg	$f0, $f0
	j	beq_cont.27980
beq_else.27979:
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
beq_cont.27980:
fbt_cont.27976:
	lw	$v0, -52($sp)
	flw	$f2, 4($v0)
	la	$t8, l.23884
	flw	$f3, 0($t8)
	fle	$f3, $f2
	fbf	fbt_else.27981
	addi	$v1, $zero, 1
	j	fbt_cont.27982
fbt_else.27981:
	addi	$v1, $zero, 0
fbt_cont.27982:
	bne	$zero, $v1, beq_else.27983
	fneg	$f2, $f2
beq_else.27983:
beq_cont.27984:
	la	$t8, l.23875
	flw	$f3, 0($t8)
	fsw	$f0, -88($sp)
	sw	$v1, -92($sp)
	fsw	$f2, -96($sp)
	fmove	$f1, $f3
	fmove	$f0, $f2
	sw	$ra, -100($sp)
	subi	$sp, $sp, 104
	jal	adjust_exp.2562
	addi	$sp, $sp, 104
	lw	$ra, -100($sp)
	fmove	$f1, $f0
	flw	$f0, -96($sp)
	sw	$ra, -100($sp)
	subi	$sp, $sp, 104
	jal	sub_iter.2565
	addi	$sp, $sp, 104
	lw	$ra, -100($sp)
	flw	$f1, -4($sp)
	fle	$f1, $f0
	fbf	fbt_else.27985
	lw	$v0, -92($sp)
	bne	$zero, $v0, beq_else.27987
	addi	$v0, $zero, 1
	j	beq_cont.27988
beq_else.27987:
	addi	$v0, $zero, 0
beq_cont.27988:
	fsub	$f0, $f0, $f1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.27986
fbt_else.27985:
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	lw	$v1, -92($sp)
	sw	$v1, 0($v0)
fbt_cont.27986:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.27989
	fsub	$f0, $f1, $f0
fbt_else.27989:
fbt_cont.27990:
	la	$t8, l.23944
	flw	$f2, 0($t8)
	fle	$f0, $f2
	fbf	fbt_else.27991
	bne	$zero, $v0, beq_else.27993
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fneg	$f0, $f0
	j	fbt_cont.27992
beq_else.27993:
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
beq_cont.27994:
	j	fbt_cont.27992
fbt_else.27991:
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	bne	$zero, $v0, beq_else.27995
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
	fneg	$f0, $f0
	j	beq_cont.27996
beq_else.27995:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
beq_cont.27996:
fbt_cont.27992:
	lw	$v0, -52($sp)
	flw	$f2, 8($v0)
	la	$t8, l.23884
	flw	$f3, 0($t8)
	fle	$f3, $f2
	fbf	fbt_else.27997
	j	fbt_cont.27998
fbt_else.27997:
	fneg	$f2, $f2
fbt_cont.27998:
	la	$t8, l.23875
	flw	$f3, 0($t8)
	fsw	$f0, -100($sp)
	fsw	$f2, -104($sp)
	fmove	$f1, $f3
	fmove	$f0, $f2
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	adjust_exp.2562
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	fmove	$f1, $f0
	flw	$f0, -104($sp)
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	sub_iter.2565
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	flw	$f1, -4($sp)
	fle	$f1, $f0
	fbf	fbt_else.27999
	fsub	$f0, $f0, $f1
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	sw	$zero, 0($v0)
	j	fbt_cont.28000
fbt_else.27999:
	addi	$v0, $zero, 1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.28000:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.28001
	bne	$zero, $v0, beq_else.28003
	addi	$v0, $zero, 1
	j	beq_cont.28004
beq_else.28003:
	addi	$v0, $zero, 0
beq_cont.28004:
	fsub	$f0, $f1, $f0
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.28002
fbt_else.28001:
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.28002:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23944
	flw	$f2, 0($t8)
	fle	$f0, $f2
	fbf	fbt_else.28005
	bne	$zero, $v0, beq_else.28007
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
	fneg	$f0, $f0
	j	fbt_cont.28006
beq_else.28007:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
beq_cont.28008:
	j	fbt_cont.28006
fbt_else.28005:
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	bne	$zero, $v0, beq_else.28009
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fneg	$f0, $f0
	j	beq_cont.28010
beq_else.28009:
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
beq_cont.28010:
fbt_cont.28006:
	lw	$v0, -52($sp)
	flw	$f2, 8($v0)
	la	$t8, l.23884
	flw	$f3, 0($t8)
	fle	$f3, $f2
	fbf	fbt_else.28011
	addi	$v1, $zero, 1
	j	fbt_cont.28012
fbt_else.28011:
	addi	$v1, $zero, 0
fbt_cont.28012:
	bne	$zero, $v1, beq_else.28013
	fneg	$f2, $f2
beq_else.28013:
beq_cont.28014:
	la	$t8, l.23875
	flw	$f3, 0($t8)
	fsw	$f0, -108($sp)
	sw	$v1, -112($sp)
	fsw	$f2, -116($sp)
	fmove	$f1, $f3
	fmove	$f0, $f2
	sw	$ra, -120($sp)
	subi	$sp, $sp, 124
	jal	adjust_exp.2562
	addi	$sp, $sp, 124
	lw	$ra, -120($sp)
	fmove	$f1, $f0
	flw	$f0, -116($sp)
	sw	$ra, -120($sp)
	subi	$sp, $sp, 124
	jal	sub_iter.2565
	addi	$sp, $sp, 124
	lw	$ra, -120($sp)
	flw	$f1, -4($sp)
	fle	$f1, $f0
	fbf	fbt_else.28015
	lw	$v0, -112($sp)
	bne	$zero, $v0, beq_else.28017
	addi	$v0, $zero, 1
	j	beq_cont.28018
beq_else.28017:
	addi	$v0, $zero, 0
beq_cont.28018:
	fsub	$f0, $f0, $f1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.28016
fbt_else.28015:
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	lw	$v1, -112($sp)
	sw	$v1, 0($v0)
fbt_cont.28016:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.28019
	fsub	$f0, $f1, $f0
fbt_else.28019:
fbt_cont.28020:
	la	$t8, l.23944
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28021
	bne	$zero, $v0, beq_else.28023
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	fneg	$f0, $f0
	j	fbt_cont.28022
beq_else.28023:
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
beq_cont.28024:
	j	fbt_cont.28022
fbt_else.28021:
	la	$t8, l.23937
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	bne	$zero, $v0, beq_else.28025
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
	fneg	$f0, $f0
	j	beq_cont.28026
beq_else.28025:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
beq_cont.28026:
fbt_cont.28022:
	flw	$f1, -108($sp)
	flw	$f2, -88($sp)
	fmul	$f3, $f2, $f1
	flw	$f4, -100($sp)
	flw	$f5, -80($sp)
	fmul	$f6, $f5, $f4
	fmul	$f7, $f6, $f1
	flw	$f8, -68($sp)
	fmul	$f9, $f8, $f0
	fsub	$f7, $f7, $f9
	fmul	$f9, $f8, $f4
	fmul	$f10, $f9, $f1
	fmul	$f11, $f5, $f0
	fadd	$f10, $f10, $f11
	fmul	$f11, $f2, $f0
	fmul	$f6, $f6, $f0
	fmul	$f12, $f8, $f1
	fadd	$f6, $f6, $f12
	fmul	$f0, $f9, $f0
	fmul	$f1, $f5, $f1
	fsub	$f0, $f0, $f1
	fneg	$f1, $f4
	fmul	$f4, $f5, $f2
	fmul	$f2, $f8, $f2
	lw	$v0, -32($sp)
	flw	$f5, 0($v0)
	flw	$f8, 4($v0)
	flw	$f9, 8($v0)
	fmul	$f12, $f3, $f3
	fmul	$f12, $f5, $f12
	fmul	$f13, $f11, $f11
	fmul	$f13, $f8, $f13
	fadd	$f12, $f12, $f13
	fmul	$f13, $f1, $f1
	fmul	$f13, $f9, $f13
	fadd	$f12, $f12, $f13
	fsw	$f12, 0($v0)
	fmul	$f12, $f7, $f7
	fmul	$f12, $f5, $f12
	fmul	$f13, $f6, $f6
	fmul	$f13, $f8, $f13
	fadd	$f12, $f12, $f13
	fmul	$f13, $f4, $f4
	fmul	$f13, $f9, $f13
	fadd	$f12, $f12, $f13
	fsw	$f12, 4($v0)
	fmul	$f12, $f10, $f10
	fmul	$f12, $f5, $f12
	fmul	$f13, $f0, $f0
	fmul	$f13, $f8, $f13
	fadd	$f12, $f12, $f13
	fmul	$f13, $f2, $f2
	fmul	$f13, $f9, $f13
	fadd	$f12, $f12, $f13
	fsw	$f12, 8($v0)
	la	$t8, l.23874
	flw	$f12, 0($t8)
	fmul	$f13, $f5, $f7
	fmul	$f13, $f13, $f10
	fmul	$f14, $f8, $f6
	fmul	$f14, $f14, $f0
	fadd	$f13, $f13, $f14
	fmul	$f14, $f9, $f4
	fmul	$f14, $f14, $f2
	fadd	$f13, $f13, $f14
	fmul	$f12, $f12, $f13
	lw	$v0, -52($sp)
	fsw	$f12, 0($v0)
	la	$t8, l.23874
	flw	$f12, 0($t8)
	fmul	$f3, $f5, $f3
	fmul	$f5, $f3, $f10
	fmul	$f8, $f8, $f11
	fmul	$f0, $f8, $f0
	fadd	$f0, $f5, $f0
	fmul	$f1, $f9, $f1
	fmul	$f2, $f1, $f2
	fadd	$f0, $f0, $f2
	fmul	$f0, $f12, $f0
	fsw	$f0, 4($v0)
	la	$t8, l.23874
	flw	$f0, 0($t8)
	fmul	$f2, $f3, $f7
	fmul	$f3, $f8, $f6
	fadd	$f2, $f2, $f3
	fmul	$f1, $f1, $f4
	fadd	$f1, $f2, $f1
	fmul	$f0, $f0, $f1
	fsw	$f0, 8($v0)
beq_cont.27936:
	addi	$v0, $zero, 1
beq_cont.27880:
	bne	$zero, $v0, beq_else.28027
	lw	$v0, 0($sp)
	lw	$v1, -12($sp)
	sw	$v1, 0($v0)
	jr	$ra
beq_else.28027:
	lw	$v0, -12($sp)
	addi	$v0, $v0, 1
	j	read_object.2747
read_net_item.2751:
	sw	$v0, 0($sp)
	sw	$ra, -4($sp)
	subi	$sp, $sp, 8
	jal	min_caml_read_int
	addi	$sp, $sp, 8
	lw	$ra, -4($sp)
	addi	$t8, $zero, -1
	bne	$t8, $v0, beq_else.28029
	lw	$v0, 0($sp)
	addi	$v0, $v0, 1
	addi	$v1, $zero, -1
	j	min_caml_create_array
beq_else.28029:
	lw	$v1, 0($sp)
	addi	$a0, $v1, 1
	sw	$v0, -4($sp)
	move	$v0, $a0
	sw	$ra, -8($sp)
	subi	$sp, $sp, 12
	jal	read_net_item.2751
	addi	$sp, $sp, 12
	lw	$ra, -8($sp)
	lw	$v1, 0($sp)
	sll	$v1, $v1, 2
	lw	$a0, -4($sp)
	add	$t8, $v0, $v1
	sw	$a0, 0($t8)
	jr	$ra
read_or_network.2753:
	sw	$v0, 0($sp)
	move	$v0, $zero
	sw	$ra, -4($sp)
	subi	$sp, $sp, 8
	jal	read_net_item.2751
	addi	$sp, $sp, 8
	lw	$ra, -4($sp)
	move	$v1, $v0
	lw	$v0, 0($v1)
	addi	$t8, $zero, -1
	bne	$t8, $v0, beq_else.28030
	lw	$v0, 0($sp)
	addi	$v0, $v0, 1
	j	min_caml_create_array
beq_else.28030:
	lw	$v0, 0($sp)
	addi	$a0, $v0, 1
	sw	$v1, -4($sp)
	move	$v0, $a0
	sw	$ra, -8($sp)
	subi	$sp, $sp, 12
	jal	read_or_network.2753
	addi	$sp, $sp, 12
	lw	$ra, -8($sp)
	lw	$v1, 0($sp)
	sll	$v1, $v1, 2
	lw	$a0, -4($sp)
	add	$t8, $v0, $v1
	sw	$a0, 0($t8)
	jr	$ra
read_and_network.2755:
	sw	$v0, 0($sp)
	move	$v0, $zero
	sw	$ra, -4($sp)
	subi	$sp, $sp, 8
	jal	read_net_item.2751
	addi	$sp, $sp, 8
	lw	$ra, -4($sp)
	lw	$v1, 0($v0)
	lui	$a0, 512
	ori	$a0, $a0, 332
	addi	$t8, $zero, -1
	bne	$t8, $v1, beq_else.28031
	jr	$ra
beq_else.28031:
	lw	$v1, 0($sp)
	sll	$a1, $v1, 2
	add	$t8, $a0, $a1
	sw	$v0, 0($t8)
	addi	$v0, $v1, 1
	j	read_and_network.2755
iter_setup_dirvec_constants.2852:
	lui	$a0, 512
	ori	$a0, $a0, 48
	slti	$t8, $v1, 0
	bne	$t8, $zero, beq_else.28033
	sll	$a1, $v1, 2
	add	$t8, $a0, $a1
	lw	$a0, 0($t8)
	lw	$a1, 4($v0)
	lw	$a2, 0($v0)
	lw	$a3, 4($a0)
	sw	$v0, 0($sp)
	addi	$t8, $zero, 1
	bne	$t8, $a3, beq_else.28034
	addi	$a3, $zero, 6
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$a1, -4($sp)
	sw	$v1, -8($sp)
	sw	$a0, -12($sp)
	sw	$a2, -16($sp)
	move	$v0, $a3
	sw	$ra, -20($sp)
	subi	$sp, $sp, 24
	jal	min_caml_create_float_array
	addi	$sp, $sp, 24
	lw	$ra, -20($sp)
	lw	$v1, -16($sp)
	flw	$f0, 0($v1)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28036
	addi	$a0, $zero, 1
	j	fbt_cont.28037
fbt_else.28036:
	addi	$a0, $zero, 0
fbt_cont.28037:
	bne	$zero, $a0, beq_else.28038
	lw	$a0, -12($sp)
	lw	$a1, 24($a0)
	flw	$f0, 0($v1)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28040
	addi	$a2, $zero, 0
	j	fbt_cont.28041
fbt_else.28040:
	addi	$a2, $zero, 1
fbt_cont.28041:
	bne	$zero, $a1, beq_else.28042
	move	$a1, $a2
	j	beq_cont.28043
beq_else.28042:
	bne	$zero, $a2, beq_else.28044
	addi	$a1, $zero, 1
	j	beq_cont.28045
beq_else.28044:
	addi	$a1, $zero, 0
beq_cont.28045:
beq_cont.28043:
	lw	$a2, 16($a0)
	flw	$f0, 0($a2)
	bne	$zero, $a1, beq_else.28046
	fneg	$f0, $f0
beq_else.28046:
beq_cont.28047:
	fsw	$f0, 0($v0)
	la	$t8, l.23916
	flw	$f0, 0($t8)
	flw	$f1, 0($v1)
	fdiv	$f0, $f0, $f1
	fsw	$f0, 4($v0)
	j	beq_cont.28039
beq_else.28038:
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 4($v0)
beq_cont.28039:
	flw	$f0, 4($v1)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28048
	addi	$a0, $zero, 1
	j	fbt_cont.28049
fbt_else.28048:
	addi	$a0, $zero, 0
fbt_cont.28049:
	bne	$zero, $a0, beq_else.28050
	lw	$a0, -12($sp)
	lw	$a1, 24($a0)
	flw	$f0, 4($v1)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28052
	addi	$a2, $zero, 0
	j	fbt_cont.28053
fbt_else.28052:
	addi	$a2, $zero, 1
fbt_cont.28053:
	bne	$zero, $a1, beq_else.28054
	move	$a1, $a2
	j	beq_cont.28055
beq_else.28054:
	bne	$zero, $a2, beq_else.28056
	addi	$a1, $zero, 1
	j	beq_cont.28057
beq_else.28056:
	addi	$a1, $zero, 0
beq_cont.28057:
beq_cont.28055:
	lw	$a2, 16($a0)
	flw	$f0, 4($a2)
	bne	$zero, $a1, beq_else.28058
	fneg	$f0, $f0
beq_else.28058:
beq_cont.28059:
	fsw	$f0, 8($v0)
	la	$t8, l.23916
	flw	$f0, 0($t8)
	flw	$f1, 4($v1)
	fdiv	$f0, $f0, $f1
	fsw	$f0, 12($v0)
	j	beq_cont.28051
beq_else.28050:
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 12($v0)
beq_cont.28051:
	flw	$f0, 8($v1)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28060
	addi	$a0, $zero, 1
	j	fbt_cont.28061
fbt_else.28060:
	addi	$a0, $zero, 0
fbt_cont.28061:
	bne	$zero, $a0, beq_else.28062
	lw	$a0, -12($sp)
	lw	$a1, 24($a0)
	flw	$f0, 8($v1)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28064
	addi	$a2, $zero, 0
	j	fbt_cont.28065
fbt_else.28064:
	addi	$a2, $zero, 1
fbt_cont.28065:
	bne	$zero, $a1, beq_else.28066
	move	$a1, $a2
	j	beq_cont.28067
beq_else.28066:
	bne	$zero, $a2, beq_else.28068
	addi	$a1, $zero, 1
	j	beq_cont.28069
beq_else.28068:
	addi	$a1, $zero, 0
beq_cont.28069:
beq_cont.28067:
	lw	$a0, 16($a0)
	flw	$f0, 8($a0)
	bne	$zero, $a1, beq_else.28070
	fneg	$f0, $f0
beq_else.28070:
beq_cont.28071:
	fsw	$f0, 16($v0)
	la	$t8, l.23916
	flw	$f0, 0($t8)
	flw	$f1, 8($v1)
	fdiv	$f0, $f0, $f1
	fsw	$f0, 20($v0)
	j	beq_cont.28063
beq_else.28062:
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 20($v0)
beq_cont.28063:
	lw	$v1, -8($sp)
	sll	$a0, $v1, 2
	lw	$a1, -4($sp)
	add	$t8, $a1, $a0
	sw	$v0, 0($t8)
	j	beq_cont.28035
beq_else.28034:
	addi	$t8, $zero, 2
	bne	$t8, $a3, beq_else.28072
	addi	$a3, $zero, 4
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$a1, -4($sp)
	sw	$v1, -8($sp)
	sw	$a0, -12($sp)
	sw	$a2, -16($sp)
	move	$v0, $a3
	sw	$ra, -20($sp)
	subi	$sp, $sp, 24
	jal	min_caml_create_float_array
	addi	$sp, $sp, 24
	lw	$ra, -20($sp)
	lw	$v1, -16($sp)
	flw	$f0, 0($v1)
	lw	$a0, -12($sp)
	lw	$a1, 16($a0)
	flw	$f1, 0($a1)
	fmul	$f0, $f0, $f1
	flw	$f1, 4($v1)
	lw	$a1, 16($a0)
	flw	$f2, 4($a1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	flw	$f1, 8($v1)
	lw	$v1, 16($a0)
	flw	$f2, 8($v1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28074
	addi	$v1, $zero, 0
	j	fbt_cont.28075
fbt_else.28074:
	addi	$v1, $zero, 1
fbt_cont.28075:
	bne	$zero, $v1, beq_else.28076
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 0($v0)
	j	beq_cont.28077
beq_else.28076:
	la	$t8, l.23917
	flw	$f1, 0($t8)
	fdiv	$f1, $f1, $f0
	fsw	$f1, 0($v0)
	lw	$v1, 16($a0)
	flw	$f1, 0($v1)
	fdiv	$f1, $f1, $f0
	fneg	$f1, $f1
	fsw	$f1, 4($v0)
	lw	$v1, 16($a0)
	flw	$f1, 4($v1)
	fdiv	$f1, $f1, $f0
	fneg	$f1, $f1
	fsw	$f1, 8($v0)
	lw	$v1, 16($a0)
	flw	$f1, 8($v1)
	fdiv	$f0, $f1, $f0
	fneg	$f0, $f0
	fsw	$f0, 12($v0)
beq_cont.28077:
	lw	$v1, -8($sp)
	sll	$a0, $v1, 2
	lw	$a1, -4($sp)
	add	$t8, $a1, $a0
	sw	$v0, 0($t8)
	j	beq_cont.28073
beq_else.28072:
	addi	$a3, $zero, 5
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$a1, -4($sp)
	sw	$v1, -8($sp)
	sw	$a0, -12($sp)
	sw	$a2, -16($sp)
	move	$v0, $a3
	sw	$ra, -20($sp)
	subi	$sp, $sp, 24
	jal	min_caml_create_float_array
	addi	$sp, $sp, 24
	lw	$ra, -20($sp)
	lw	$v1, -16($sp)
	flw	$f0, 0($v1)
	flw	$f1, 4($v1)
	flw	$f2, 8($v1)
	fmul	$f3, $f0, $f0
	lw	$a0, -12($sp)
	lw	$a1, 16($a0)
	flw	$f4, 0($a1)
	fmul	$f3, $f3, $f4
	fmul	$f4, $f1, $f1
	lw	$a1, 16($a0)
	flw	$f5, 4($a1)
	fmul	$f4, $f4, $f5
	fadd	$f3, $f3, $f4
	fmul	$f4, $f2, $f2
	lw	$a1, 16($a0)
	flw	$f5, 8($a1)
	fmul	$f4, $f4, $f5
	fadd	$f3, $f3, $f4
	lw	$a1, 12($a0)
	bne	$zero, $a1, beq_else.28078
	fmove	$f0, $f3
	j	beq_cont.28079
beq_else.28078:
	fmul	$f4, $f1, $f2
	lw	$a1, 36($a0)
	flw	$f5, 0($a1)
	fmul	$f4, $f4, $f5
	fadd	$f3, $f3, $f4
	fmul	$f2, $f2, $f0
	lw	$a1, 36($a0)
	flw	$f4, 4($a1)
	fmul	$f2, $f2, $f4
	fadd	$f2, $f3, $f2
	fmul	$f0, $f0, $f1
	lw	$a1, 36($a0)
	flw	$f1, 8($a1)
	fmul	$f0, $f0, $f1
	fadd	$f0, $f2, $f0
beq_cont.28079:
	flw	$f1, 0($v1)
	lw	$a1, 16($a0)
	flw	$f2, 0($a1)
	fmul	$f1, $f1, $f2
	fneg	$f1, $f1
	flw	$f2, 4($v1)
	lw	$a1, 16($a0)
	flw	$f3, 4($a1)
	fmul	$f2, $f2, $f3
	fneg	$f2, $f2
	flw	$f3, 8($v1)
	lw	$a1, 16($a0)
	flw	$f4, 8($a1)
	fmul	$f3, $f3, $f4
	fneg	$f3, $f3
	fsw	$f0, 0($v0)
	lw	$a1, 12($a0)
	bne	$zero, $a1, beq_else.28080
	fsw	$f1, 4($v0)
	fsw	$f2, 8($v0)
	fsw	$f3, 12($v0)
	j	beq_cont.28081
beq_else.28080:
	flw	$f4, 8($v1)
	lw	$a1, 36($a0)
	flw	$f5, 4($a1)
	fmul	$f4, $f4, $f5
	flw	$f5, 4($v1)
	lw	$a1, 36($a0)
	flw	$f6, 8($a1)
	fmul	$f5, $f5, $f6
	fadd	$f4, $f4, $f5
	la	$t8, l.23876
	flw	$f5, 0($t8)
	fmul	$f4, $f4, $f5
	fsub	$f1, $f1, $f4
	fsw	$f1, 4($v0)
	flw	$f1, 8($v1)
	lw	$a1, 36($a0)
	flw	$f4, 0($a1)
	fmul	$f1, $f1, $f4
	flw	$f4, 0($v1)
	lw	$a1, 36($a0)
	flw	$f5, 8($a1)
	fmul	$f4, $f4, $f5
	fadd	$f1, $f1, $f4
	la	$t8, l.23876
	flw	$f4, 0($t8)
	fmul	$f1, $f1, $f4
	fsub	$f1, $f2, $f1
	fsw	$f1, 8($v0)
	flw	$f1, 4($v1)
	lw	$a1, 36($a0)
	flw	$f2, 0($a1)
	fmul	$f1, $f1, $f2
	flw	$f2, 0($v1)
	lw	$v1, 36($a0)
	flw	$f4, 4($v1)
	fmul	$f2, $f2, $f4
	fadd	$f1, $f1, $f2
	la	$t8, l.23876
	flw	$f2, 0($t8)
	fmul	$f1, $f1, $f2
	fsub	$f1, $f3, $f1
	fsw	$f1, 12($v0)
beq_cont.28081:
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28082
	addi	$v1, $zero, 1
	j	fbt_cont.28083
fbt_else.28082:
	addi	$v1, $zero, 0
fbt_cont.28083:
	bne	$zero, $v1, beq_else.28084
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fdiv	$f0, $f1, $f0
	fsw	$f0, 16($v0)
beq_else.28084:
beq_cont.28085:
	lw	$v1, -8($sp)
	sll	$a0, $v1, 2
	lw	$a1, -4($sp)
	add	$t8, $a1, $a0
	sw	$v0, 0($t8)
beq_cont.28073:
beq_cont.28035:
	subi	$v1, $v1, 1
	lw	$v0, 0($sp)
	j	iter_setup_dirvec_constants.2852
beq_else.28033:
	jr	$ra
setup_startp_constants.2857:
	lui	$a0, 512
	ori	$a0, $a0, 48
	slti	$t8, $v1, 0
	bne	$t8, $zero, beq_else.28087
	sll	$a1, $v1, 2
	add	$t8, $a0, $a1
	lw	$a0, 0($t8)
	lw	$a1, 40($a0)
	lw	$a2, 4($a0)
	flw	$f0, 0($v0)
	lw	$a3, 20($a0)
	flw	$f1, 0($a3)
	fsub	$f0, $f0, $f1
	fsw	$f0, 0($a1)
	flw	$f0, 4($v0)
	lw	$a3, 20($a0)
	flw	$f1, 4($a3)
	fsub	$f0, $f0, $f1
	fsw	$f0, 4($a1)
	flw	$f0, 8($v0)
	lw	$a3, 20($a0)
	flw	$f1, 8($a3)
	fsub	$f0, $f0, $f1
	fsw	$f0, 8($a1)
	addi	$t8, $zero, 2
	bne	$t8, $a2, beq_else.28088
	lw	$a0, 16($a0)
	flw	$f0, 0($a1)
	flw	$f1, 4($a1)
	flw	$f2, 8($a1)
	flw	$f3, 0($a0)
	fmul	$f0, $f3, $f0
	flw	$f3, 4($a0)
	fmul	$f1, $f3, $f1
	fadd	$f0, $f0, $f1
	flw	$f1, 8($a0)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	fsw	$f0, 12($a1)
	j	beq_cont.28089
beq_else.28088:
	sgti	$t8, $a2, 2
	bne	$t8, $zero, beq_else.28090
	j	beq_cont.28091
beq_else.28090:
	flw	$f0, 0($a1)
	flw	$f1, 4($a1)
	flw	$f2, 8($a1)
	fmul	$f3, $f0, $f0
	lw	$a3, 16($a0)
	flw	$f4, 0($a3)
	fmul	$f3, $f3, $f4
	fmul	$f4, $f1, $f1
	lw	$a3, 16($a0)
	flw	$f5, 4($a3)
	fmul	$f4, $f4, $f5
	fadd	$f3, $f3, $f4
	fmul	$f4, $f2, $f2
	lw	$a3, 16($a0)
	flw	$f5, 8($a3)
	fmul	$f4, $f4, $f5
	fadd	$f3, $f3, $f4
	lw	$a3, 12($a0)
	bne	$zero, $a3, beq_else.28092
	fmove	$f0, $f3
	j	beq_cont.28093
beq_else.28092:
	fmul	$f4, $f1, $f2
	lw	$a3, 36($a0)
	flw	$f5, 0($a3)
	fmul	$f4, $f4, $f5
	fadd	$f3, $f3, $f4
	fmul	$f2, $f2, $f0
	lw	$a3, 36($a0)
	flw	$f4, 4($a3)
	fmul	$f2, $f2, $f4
	fadd	$f2, $f3, $f2
	fmul	$f0, $f0, $f1
	lw	$a0, 36($a0)
	flw	$f1, 8($a0)
	fmul	$f0, $f0, $f1
	fadd	$f0, $f2, $f0
beq_cont.28093:
	addi	$t8, $zero, 3
	bne	$t8, $a2, beq_else.28094
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fsub	$f0, $f0, $f1
beq_else.28094:
beq_cont.28095:
	fsw	$f0, 12($a1)
beq_cont.28091:
beq_cont.28089:
	subi	$v1, $v1, 1
	j	setup_startp_constants.2857
beq_else.28087:
	jr	$ra
check_all_inside.2882:
	sll	$a0, $v0, 2
	add	$t8, $v1, $a0
	lw	$a0, 0($t8)
	lui	$a1, 512
	ori	$a1, $a1, 48
	addi	$t8, $zero, -1
	bne	$t8, $a0, beq_else.28097
	addi	$v0, $zero, 1
	jr	$ra
beq_else.28097:
	sll	$a0, $a0, 2
	add	$t8, $a1, $a0
	lw	$a0, 0($t8)
	lw	$a1, 20($a0)
	flw	$f3, 0($a1)
	fsub	$f3, $f0, $f3
	lw	$a1, 20($a0)
	flw	$f4, 4($a1)
	fsub	$f4, $f1, $f4
	lw	$a1, 20($a0)
	flw	$f5, 8($a1)
	fsub	$f5, $f2, $f5
	lw	$a1, 4($a0)
	fsw	$f2, 0($sp)
	fsw	$f1, -4($sp)
	fsw	$f0, -8($sp)
	sw	$v1, -12($sp)
	sw	$v0, -16($sp)
	addi	$t8, $zero, 1
	bne	$t8, $a1, beq_else.28098
	fsw	$f5, -20($sp)
	fsw	$f4, -24($sp)
	sw	$a0, -28($sp)
	fmove	$f0, $f3
	sw	$ra, -32($sp)
	subi	$sp, $sp, 36
	jal	min_caml_fabs
	addi	$sp, $sp, 36
	lw	$ra, -32($sp)
	lw	$v0, -28($sp)
	lw	$v1, 16($v0)
	flw	$f1, 0($v1)
	fle	$f1, $f0
	fbf	fbt_else.28100
	addi	$v1, $zero, 0
	j	fbt_cont.28101
fbt_else.28100:
	addi	$v1, $zero, 1
fbt_cont.28101:
	bne	$zero, $v1, beq_else.28102
	addi	$v1, $zero, 0
	j	beq_cont.28103
beq_else.28102:
	flw	$f0, -24($sp)
	sw	$ra, -32($sp)
	subi	$sp, $sp, 36
	jal	min_caml_fabs
	addi	$sp, $sp, 36
	lw	$ra, -32($sp)
	lw	$v0, -28($sp)
	lw	$v1, 16($v0)
	flw	$f1, 4($v1)
	fle	$f1, $f0
	fbf	fbt_else.28104
	addi	$v1, $zero, 0
	j	fbt_cont.28105
fbt_else.28104:
	addi	$v1, $zero, 1
fbt_cont.28105:
	bne	$zero, $v1, beq_else.28106
	addi	$v1, $zero, 0
	j	beq_cont.28107
beq_else.28106:
	flw	$f0, -20($sp)
	sw	$ra, -32($sp)
	subi	$sp, $sp, 36
	jal	min_caml_fabs
	addi	$sp, $sp, 36
	lw	$ra, -32($sp)
	lw	$v0, -28($sp)
	lw	$v1, 16($v0)
	flw	$f1, 8($v1)
	fle	$f1, $f0
	fbf	fbt_else.28108
	addi	$v1, $zero, 0
	j	fbt_cont.28109
fbt_else.28108:
	addi	$v1, $zero, 1
fbt_cont.28109:
beq_cont.28107:
beq_cont.28103:
	bne	$zero, $v1, beq_else.28110
	lw	$v0, 24($v0)
	bne	$zero, $v0, beq_else.28112
	addi	$v0, $zero, 1
	j	beq_cont.28099
beq_else.28112:
	addi	$v0, $zero, 0
beq_cont.28113:
	j	beq_cont.28099
beq_else.28110:
	lw	$v0, 24($v0)
beq_cont.28111:
	j	beq_cont.28099
beq_else.28098:
	addi	$t8, $zero, 2
	bne	$t8, $a1, beq_else.28114
	lw	$a1, 16($a0)
	flw	$f6, 0($a1)
	fmul	$f3, $f6, $f3
	flw	$f6, 4($a1)
	fmul	$f4, $f6, $f4
	fadd	$f3, $f3, $f4
	flw	$f4, 8($a1)
	fmul	$f4, $f4, $f5
	fadd	$f3, $f3, $f4
	lw	$a0, 24($a0)
	la	$t8, l.23884
	flw	$f4, 0($t8)
	fle	$f4, $f3
	fbf	fbt_else.28116
	addi	$a1, $zero, 0
	j	fbt_cont.28117
fbt_else.28116:
	addi	$a1, $zero, 1
fbt_cont.28117:
	bne	$zero, $a0, beq_else.28118
	move	$a0, $a1
	j	beq_cont.28119
beq_else.28118:
	bne	$zero, $a1, beq_else.28120
	addi	$a0, $zero, 1
	j	beq_cont.28121
beq_else.28120:
	addi	$a0, $zero, 0
beq_cont.28121:
beq_cont.28119:
	bne	$zero, $a0, beq_else.28122
	addi	$v0, $zero, 1
	j	beq_cont.28115
beq_else.28122:
	addi	$v0, $zero, 0
beq_cont.28123:
	j	beq_cont.28115
beq_else.28114:
	fmul	$f6, $f3, $f3
	lw	$a1, 16($a0)
	flw	$f7, 0($a1)
	fmul	$f6, $f6, $f7
	fmul	$f7, $f4, $f4
	lw	$a1, 16($a0)
	flw	$f8, 4($a1)
	fmul	$f7, $f7, $f8
	fadd	$f6, $f6, $f7
	fmul	$f7, $f5, $f5
	lw	$a1, 16($a0)
	flw	$f8, 8($a1)
	fmul	$f7, $f7, $f8
	fadd	$f6, $f6, $f7
	lw	$a1, 12($a0)
	bne	$zero, $a1, beq_else.28124
	fmove	$f3, $f6
	j	beq_cont.28125
beq_else.28124:
	fmul	$f7, $f4, $f5
	lw	$a1, 36($a0)
	flw	$f8, 0($a1)
	fmul	$f7, $f7, $f8
	fadd	$f6, $f6, $f7
	fmul	$f5, $f5, $f3
	lw	$a1, 36($a0)
	flw	$f7, 4($a1)
	fmul	$f5, $f5, $f7
	fadd	$f5, $f6, $f5
	fmul	$f3, $f3, $f4
	lw	$a1, 36($a0)
	flw	$f4, 8($a1)
	fmul	$f3, $f3, $f4
	fadd	$f3, $f5, $f3
beq_cont.28125:
	lw	$a1, 4($a0)
	addi	$t8, $zero, 3
	bne	$t8, $a1, beq_else.28126
	la	$t8, l.23916
	flw	$f4, 0($t8)
	fsub	$f3, $f3, $f4
beq_else.28126:
beq_cont.28127:
	lw	$a0, 24($a0)
	la	$t8, l.23884
	flw	$f4, 0($t8)
	fle	$f4, $f3
	fbf	fbt_else.28128
	addi	$a1, $zero, 0
	j	fbt_cont.28129
fbt_else.28128:
	addi	$a1, $zero, 1
fbt_cont.28129:
	bne	$zero, $a0, beq_else.28130
	move	$a0, $a1
	j	beq_cont.28131
beq_else.28130:
	bne	$zero, $a1, beq_else.28132
	addi	$a0, $zero, 1
	j	beq_cont.28133
beq_else.28132:
	addi	$a0, $zero, 0
beq_cont.28133:
beq_cont.28131:
	bne	$zero, $a0, beq_else.28134
	addi	$v0, $zero, 1
	j	beq_cont.28135
beq_else.28134:
	addi	$v0, $zero, 0
beq_cont.28135:
beq_cont.28115:
beq_cont.28099:
	bne	$zero, $v0, beq_else.28136
	lw	$v0, -16($sp)
	addi	$v0, $v0, 1
	flw	$f0, -8($sp)
	flw	$f1, -4($sp)
	flw	$f2, 0($sp)
	lw	$v1, -12($sp)
	j	check_all_inside.2882
beq_else.28136:
	addi	$v0, $zero, 0
	jr	$ra
shadow_check_and_group.2888:
	sll	$a0, $v0, 2
	add	$t8, $v1, $a0
	lw	$a0, 0($t8)
	lui	$a1, 512
	ori	$a1, $a1, 552
	lui	$a2, 512
	ori	$a2, $a2, 312
	lui	$a3, 512
	ori	$a3, $a3, 988
	lui	$t0, 512
	ori	$t0, $t0, 48
	lui	$t1, 512
	ori	$t1, $t1, 540
	addi	$t8, $zero, -1
	bne	$t8, $a0, beq_else.28137
	addi	$v0, $zero, 0
	jr	$ra
beq_else.28137:
	sll	$a0, $v0, 2
	add	$t8, $v1, $a0
	lw	$a0, 0($t8)
	sll	$t2, $a0, 2
	add	$t8, $t0, $t2
	lw	$t2, 0($t8)
	flw	$f0, 0($a1)
	lw	$t3, 20($t2)
	flw	$f1, 0($t3)
	fsub	$f0, $f0, $f1
	flw	$f1, 4($a1)
	lw	$t3, 20($t2)
	flw	$f2, 4($t3)
	fsub	$f1, $f1, $f2
	flw	$f2, 8($a1)
	lw	$t3, 20($t2)
	flw	$f3, 8($t3)
	fsub	$f2, $f2, $f3
	lw	$t3, 4($a3)
	sll	$t4, $a0, 2
	add	$t8, $t3, $t4
	lw	$t3, 0($t8)
	lw	$t4, 4($t2)
	sw	$a1, 0($sp)
	sw	$a2, -4($sp)
	sw	$v1, -8($sp)
	sw	$v0, -12($sp)
	sw	$t0, -16($sp)
	sw	$a0, -20($sp)
	sw	$t1, -24($sp)
	addi	$t8, $zero, 1
	bne	$t8, $t4, beq_else.28138
	lw	$a3, 0($a3)
	flw	$f3, 0($t3)
	fsub	$f3, $f3, $f0
	flw	$f4, 4($t3)
	fmul	$f3, $f3, $f4
	flw	$f4, 4($a3)
	fmul	$f4, $f3, $f4
	fadd	$f4, $f4, $f1
	fsw	$f0, -28($sp)
	fsw	$f1, -32($sp)
	sw	$t3, -36($sp)
	fsw	$f2, -40($sp)
	fsw	$f3, -44($sp)
	sw	$a3, -48($sp)
	sw	$t2, -52($sp)
	fmove	$f0, $f4
	sw	$ra, -56($sp)
	subi	$sp, $sp, 60
	jal	min_caml_fabs
	addi	$sp, $sp, 60
	lw	$ra, -56($sp)
	lw	$v0, -52($sp)
	lw	$v1, 16($v0)
	flw	$f1, 4($v1)
	fle	$f1, $f0
	fbf	fbt_else.28140
	addi	$v1, $zero, 0
	j	fbt_cont.28141
fbt_else.28140:
	addi	$v1, $zero, 1
fbt_cont.28141:
	bne	$zero, $v1, beq_else.28142
	addi	$v1, $zero, 0
	j	beq_cont.28143
beq_else.28142:
	lw	$v1, -48($sp)
	flw	$f0, 8($v1)
	flw	$f1, -44($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -40($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -56($sp)
	subi	$sp, $sp, 60
	jal	min_caml_fabs
	addi	$sp, $sp, 60
	lw	$ra, -56($sp)
	lw	$v0, -52($sp)
	lw	$v1, 16($v0)
	flw	$f1, 8($v1)
	fle	$f1, $f0
	fbf	fbt_else.28144
	addi	$v1, $zero, 0
	j	fbt_cont.28145
fbt_else.28144:
	addi	$v1, $zero, 1
fbt_cont.28145:
	bne	$zero, $v1, beq_else.28146
	addi	$v1, $zero, 0
	j	beq_cont.28147
beq_else.28146:
	lw	$v1, -36($sp)
	flw	$f0, 4($v1)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28148
	addi	$a0, $zero, 1
	j	fbt_cont.28149
fbt_else.28148:
	addi	$a0, $zero, 0
fbt_cont.28149:
	bne	$zero, $a0, beq_else.28150
	addi	$v1, $zero, 1
	j	beq_cont.28151
beq_else.28150:
	addi	$v1, $zero, 0
beq_cont.28151:
beq_cont.28147:
beq_cont.28143:
	bne	$zero, $v1, beq_else.28152
	lw	$v1, -36($sp)
	flw	$f0, 8($v1)
	flw	$f1, -32($sp)
	fsub	$f0, $f0, $f1
	flw	$f2, 12($v1)
	fmul	$f0, $f0, $f2
	lw	$a0, -48($sp)
	flw	$f2, 0($a0)
	fmul	$f2, $f0, $f2
	flw	$f3, -28($sp)
	fadd	$f2, $f2, $f3
	fsw	$f0, -56($sp)
	fmove	$f0, $f2
	sw	$ra, -60($sp)
	subi	$sp, $sp, 64
	jal	min_caml_fabs
	addi	$sp, $sp, 64
	lw	$ra, -60($sp)
	lw	$v0, -52($sp)
	lw	$v1, 16($v0)
	flw	$f1, 0($v1)
	fle	$f1, $f0
	fbf	fbt_else.28154
	addi	$v1, $zero, 0
	j	fbt_cont.28155
fbt_else.28154:
	addi	$v1, $zero, 1
fbt_cont.28155:
	bne	$zero, $v1, beq_else.28156
	addi	$v1, $zero, 0
	j	beq_cont.28157
beq_else.28156:
	lw	$v1, -48($sp)
	flw	$f0, 8($v1)
	flw	$f1, -56($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -40($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -60($sp)
	subi	$sp, $sp, 64
	jal	min_caml_fabs
	addi	$sp, $sp, 64
	lw	$ra, -60($sp)
	lw	$v0, -52($sp)
	lw	$v1, 16($v0)
	flw	$f1, 8($v1)
	fle	$f1, $f0
	fbf	fbt_else.28158
	addi	$v1, $zero, 0
	j	fbt_cont.28159
fbt_else.28158:
	addi	$v1, $zero, 1
fbt_cont.28159:
	bne	$zero, $v1, beq_else.28160
	addi	$v1, $zero, 0
	j	beq_cont.28161
beq_else.28160:
	lw	$v1, -36($sp)
	flw	$f0, 12($v1)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28162
	addi	$a0, $zero, 1
	j	fbt_cont.28163
fbt_else.28162:
	addi	$a0, $zero, 0
fbt_cont.28163:
	bne	$zero, $a0, beq_else.28164
	addi	$v1, $zero, 1
	j	beq_cont.28165
beq_else.28164:
	addi	$v1, $zero, 0
beq_cont.28165:
beq_cont.28161:
beq_cont.28157:
	bne	$zero, $v1, beq_else.28166
	lw	$v1, -36($sp)
	flw	$f0, 16($v1)
	flw	$f1, -40($sp)
	fsub	$f0, $f0, $f1
	flw	$f1, 20($v1)
	fmul	$f0, $f0, $f1
	lw	$a0, -48($sp)
	flw	$f1, 0($a0)
	fmul	$f1, $f0, $f1
	flw	$f2, -28($sp)
	fadd	$f1, $f1, $f2
	fsw	$f0, -60($sp)
	fmove	$f0, $f1
	sw	$ra, -64($sp)
	subi	$sp, $sp, 68
	jal	min_caml_fabs
	addi	$sp, $sp, 68
	lw	$ra, -64($sp)
	lw	$v0, -52($sp)
	lw	$v1, 16($v0)
	flw	$f1, 0($v1)
	fle	$f1, $f0
	fbf	fbt_else.28168
	addi	$v1, $zero, 0
	j	fbt_cont.28169
fbt_else.28168:
	addi	$v1, $zero, 1
fbt_cont.28169:
	bne	$zero, $v1, beq_else.28170
	addi	$v0, $zero, 0
	j	beq_cont.28171
beq_else.28170:
	lw	$v1, -48($sp)
	flw	$f0, 4($v1)
	flw	$f1, -60($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -32($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -64($sp)
	subi	$sp, $sp, 68
	jal	min_caml_fabs
	addi	$sp, $sp, 68
	lw	$ra, -64($sp)
	lw	$v0, -52($sp)
	lw	$v0, 16($v0)
	flw	$f1, 4($v0)
	fle	$f1, $f0
	fbf	fbt_else.28172
	addi	$v0, $zero, 0
	j	fbt_cont.28173
fbt_else.28172:
	addi	$v0, $zero, 1
fbt_cont.28173:
	bne	$zero, $v0, beq_else.28174
	addi	$v0, $zero, 0
	j	beq_cont.28175
beq_else.28174:
	lw	$v0, -36($sp)
	flw	$f0, 20($v0)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28176
	addi	$v0, $zero, 1
	j	fbt_cont.28177
fbt_else.28176:
	addi	$v0, $zero, 0
fbt_cont.28177:
	bne	$zero, $v0, beq_else.28178
	addi	$v0, $zero, 1
	j	beq_cont.28179
beq_else.28178:
	addi	$v0, $zero, 0
beq_cont.28179:
beq_cont.28175:
beq_cont.28171:
	bne	$zero, $v0, beq_else.28180
	addi	$v0, $zero, 0
	j	beq_cont.28139
beq_else.28180:
	lw	$v0, -24($sp)
	flw	$f0, -60($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 3
beq_cont.28181:
	j	beq_cont.28139
beq_else.28166:
	lw	$v0, -24($sp)
	flw	$f0, -56($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 2
beq_cont.28167:
	j	beq_cont.28139
beq_else.28152:
	lw	$v0, -24($sp)
	flw	$f0, -44($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 1
beq_cont.28153:
	j	beq_cont.28139
beq_else.28138:
	addi	$t8, $zero, 2
	bne	$t8, $t4, beq_else.28182
	flw	$f3, 0($t3)
	la	$t8, l.23884
	flw	$f4, 0($t8)
	fle	$f4, $f3
	fbf	fbt_else.28184
	addi	$a3, $zero, 0
	j	fbt_cont.28185
fbt_else.28184:
	addi	$a3, $zero, 1
fbt_cont.28185:
	bne	$zero, $a3, beq_else.28186
	addi	$v0, $zero, 0
	j	beq_cont.28183
beq_else.28186:
	flw	$f3, 4($t3)
	fmul	$f0, $f3, $f0
	flw	$f3, 8($t3)
	fmul	$f1, $f3, $f1
	fadd	$f0, $f0, $f1
	flw	$f1, 12($t3)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	fsw	$f0, 0($t1)
	addi	$v0, $zero, 1
beq_cont.28187:
	j	beq_cont.28183
beq_else.28182:
	flw	$f3, 0($t3)
	la	$t8, l.23884
	flw	$f4, 0($t8)
	feq	$f3, $f4
	fbf	fbt_else.28188
	addi	$a3, $zero, 1
	j	fbt_cont.28189
fbt_else.28188:
	addi	$a3, $zero, 0
fbt_cont.28189:
	bne	$zero, $a3, beq_else.28190
	flw	$f4, 4($t3)
	fmul	$f4, $f4, $f0
	flw	$f5, 8($t3)
	fmul	$f5, $f5, $f1
	fadd	$f4, $f4, $f5
	flw	$f5, 12($t3)
	fmul	$f5, $f5, $f2
	fadd	$f4, $f4, $f5
	fmul	$f5, $f0, $f0
	lw	$a3, 16($t2)
	flw	$f6, 0($a3)
	fmul	$f5, $f5, $f6
	fmul	$f6, $f1, $f1
	lw	$a3, 16($t2)
	flw	$f7, 4($a3)
	fmul	$f6, $f6, $f7
	fadd	$f5, $f5, $f6
	fmul	$f6, $f2, $f2
	lw	$a3, 16($t2)
	flw	$f7, 8($a3)
	fmul	$f6, $f6, $f7
	fadd	$f5, $f5, $f6
	lw	$a3, 12($t2)
	bne	$zero, $a3, beq_else.28192
	fmove	$f0, $f5
	j	beq_cont.28193
beq_else.28192:
	fmul	$f6, $f1, $f2
	lw	$a3, 36($t2)
	flw	$f7, 0($a3)
	fmul	$f6, $f6, $f7
	fadd	$f5, $f5, $f6
	fmul	$f2, $f2, $f0
	lw	$a3, 36($t2)
	flw	$f6, 4($a3)
	fmul	$f2, $f2, $f6
	fadd	$f2, $f5, $f2
	fmul	$f0, $f0, $f1
	lw	$a3, 36($t2)
	flw	$f1, 8($a3)
	fmul	$f0, $f0, $f1
	fadd	$f0, $f2, $f0
beq_cont.28193:
	lw	$a3, 4($t2)
	addi	$t8, $zero, 3
	bne	$t8, $a3, beq_else.28194
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fsub	$f0, $f0, $f1
beq_else.28194:
beq_cont.28195:
	fmul	$f1, $f4, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f1, $f0
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28196
	addi	$a3, $zero, 0
	j	fbt_cont.28197
fbt_else.28196:
	addi	$a3, $zero, 1
fbt_cont.28197:
	bne	$zero, $a3, beq_else.28198
	addi	$v0, $zero, 0
	j	beq_cont.28191
beq_else.28198:
	lw	$a3, 24($t2)
	bne	$zero, $a3, beq_else.28200
	sw	$t3, -36($sp)
	fsw	$f4, -64($sp)
	sw	$ra, -68($sp)
	subi	$sp, $sp, 72
	jal	min_caml_sqrt
	addi	$sp, $sp, 72
	lw	$ra, -68($sp)
	flw	$f1, -64($sp)
	fsub	$f0, $f1, $f0
	lw	$v0, -36($sp)
	flw	$f1, 16($v0)
	fmul	$f0, $f0, $f1
	lw	$v0, -24($sp)
	fsw	$f0, 0($v0)
	j	beq_cont.28201
beq_else.28200:
	sw	$t3, -36($sp)
	fsw	$f4, -64($sp)
	sw	$ra, -68($sp)
	subi	$sp, $sp, 72
	jal	min_caml_sqrt
	addi	$sp, $sp, 72
	lw	$ra, -68($sp)
	flw	$f1, -64($sp)
	fadd	$f0, $f1, $f0
	lw	$v0, -36($sp)
	flw	$f1, 16($v0)
	fmul	$f0, $f0, $f1
	lw	$v0, -24($sp)
	fsw	$f0, 0($v0)
beq_cont.28201:
	addi	$v0, $zero, 1
beq_cont.28199:
	j	beq_cont.28191
beq_else.28190:
	addi	$v0, $zero, 0
beq_cont.28191:
beq_cont.28183:
beq_cont.28139:
	lw	$v1, -24($sp)
	flw	$f0, 0($v1)
	bne	$zero, $v0, beq_else.28202
	addi	$v0, $zero, 0
	j	beq_cont.28203
beq_else.28202:
	la	$t8, l.24184
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28204
	addi	$v0, $zero, 0
	j	fbt_cont.28205
fbt_else.28204:
	addi	$v0, $zero, 1
fbt_cont.28205:
beq_cont.28203:
	bne	$zero, $v0, beq_else.28206
	lw	$v0, -20($sp)
	sll	$v0, $v0, 2
	lw	$v1, -16($sp)
	add	$t8, $v1, $v0
	lw	$v0, 0($t8)
	lw	$v0, 24($v0)
	bne	$zero, $v0, beq_else.28207
	addi	$v0, $zero, 0
	jr	$ra
beq_else.28207:
	lw	$v0, -12($sp)
	addi	$v0, $v0, 1
	lw	$v1, -8($sp)
	j	shadow_check_and_group.2888
beq_else.28206:
	la	$t8, l.24185
	flw	$f1, 0($t8)
	fadd	$f0, $f0, $f1
	lw	$v0, -4($sp)
	flw	$f1, 0($v0)
	fmul	$f1, $f1, $f0
	lw	$v1, 0($sp)
	flw	$f2, 0($v1)
	fadd	$f1, $f1, $f2
	flw	$f2, 4($v0)
	fmul	$f2, $f2, $f0
	flw	$f3, 4($v1)
	fadd	$f2, $f2, $f3
	flw	$f3, 8($v0)
	fmul	$f0, $f3, $f0
	flw	$f3, 8($v1)
	fadd	$f0, $f0, $f3
	lw	$v1, -8($sp)
	move	$v0, $zero
	fmove	$f31, $f2
	fmove	$f2, $f0
	fmove	$f0, $f1
	fmove	$f1, $f31
	sw	$ra, -68($sp)
	subi	$sp, $sp, 72
	jal	check_all_inside.2882
	addi	$sp, $sp, 72
	lw	$ra, -68($sp)
	bne	$zero, $v0, beq_else.28208
	lw	$v0, -12($sp)
	addi	$v0, $v0, 1
	lw	$v1, -8($sp)
	j	shadow_check_and_group.2888
beq_else.28208:
	addi	$v0, $zero, 1
	jr	$ra
shadow_check_one_or_group.2891:
	sll	$a0, $v0, 2
	add	$t8, $v1, $a0
	lw	$a0, 0($t8)
	lui	$a1, 512
	ori	$a1, $a1, 332
	addi	$t8, $zero, -1
	bne	$t8, $a0, beq_else.28209
	addi	$v0, $zero, 0
	jr	$ra
beq_else.28209:
	sll	$a0, $a0, 2
	add	$t8, $a1, $a0
	lw	$a0, 0($t8)
	sw	$v1, 0($sp)
	sw	$v0, -4($sp)
	move	$v1, $a0
	move	$v0, $zero
	sw	$ra, -8($sp)
	subi	$sp, $sp, 12
	jal	shadow_check_and_group.2888
	addi	$sp, $sp, 12
	lw	$ra, -8($sp)
	bne	$zero, $v0, beq_else.28210
	lw	$v0, -4($sp)
	addi	$v0, $v0, 1
	lw	$v1, 0($sp)
	j	shadow_check_one_or_group.2891
beq_else.28210:
	addi	$v0, $zero, 1
	jr	$ra
shadow_check_one_or_matrix.2894:
	sll	$a0, $v0, 2
	add	$t8, $v1, $a0
	lw	$a0, 0($t8)
	lw	$a1, 0($a0)
	lui	$a2, 512
	ori	$a2, $a2, 552
	lui	$a3, 512
	ori	$a3, $a3, 988
	lui	$t0, 512
	ori	$t0, $t0, 48
	lui	$t1, 512
	ori	$t1, $t1, 540
	addi	$t8, $zero, -1
	bne	$t8, $a1, beq_else.28211
	addi	$v0, $zero, 0
	jr	$ra
beq_else.28211:
	sw	$a0, 0($sp)
	sw	$v1, -4($sp)
	sw	$v0, -8($sp)
	addi	$t8, $zero, 99
	bne	$t8, $a1, beq_else.28212
	addi	$v0, $zero, 1
	j	beq_cont.28213
beq_else.28212:
	sll	$t2, $a1, 2
	add	$t8, $t0, $t2
	lw	$t0, 0($t8)
	flw	$f0, 0($a2)
	lw	$t2, 20($t0)
	flw	$f1, 0($t2)
	fsub	$f0, $f0, $f1
	flw	$f1, 4($a2)
	lw	$t2, 20($t0)
	flw	$f2, 4($t2)
	fsub	$f1, $f1, $f2
	flw	$f2, 8($a2)
	lw	$a2, 20($t0)
	flw	$f3, 8($a2)
	fsub	$f2, $f2, $f3
	lw	$a2, 4($a3)
	sll	$a1, $a1, 2
	add	$t8, $a2, $a1
	lw	$a1, 0($t8)
	lw	$a2, 4($t0)
	sw	$t1, -12($sp)
	addi	$t8, $zero, 1
	bne	$t8, $a2, beq_else.28214
	lw	$a2, 0($a3)
	flw	$f3, 0($a1)
	fsub	$f3, $f3, $f0
	flw	$f4, 4($a1)
	fmul	$f3, $f3, $f4
	flw	$f4, 4($a2)
	fmul	$f4, $f3, $f4
	fadd	$f4, $f4, $f1
	fsw	$f0, -16($sp)
	fsw	$f1, -20($sp)
	sw	$a1, -24($sp)
	fsw	$f2, -28($sp)
	fsw	$f3, -32($sp)
	sw	$a2, -36($sp)
	sw	$t0, -40($sp)
	fmove	$f0, $f4
	sw	$ra, -44($sp)
	subi	$sp, $sp, 48
	jal	min_caml_fabs
	addi	$sp, $sp, 48
	lw	$ra, -44($sp)
	lw	$v0, -40($sp)
	lw	$v1, 16($v0)
	flw	$f1, 4($v1)
	fle	$f1, $f0
	fbf	fbt_else.28216
	addi	$v1, $zero, 0
	j	fbt_cont.28217
fbt_else.28216:
	addi	$v1, $zero, 1
fbt_cont.28217:
	bne	$zero, $v1, beq_else.28218
	addi	$v1, $zero, 0
	j	beq_cont.28219
beq_else.28218:
	lw	$v1, -36($sp)
	flw	$f0, 8($v1)
	flw	$f1, -32($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -28($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -44($sp)
	subi	$sp, $sp, 48
	jal	min_caml_fabs
	addi	$sp, $sp, 48
	lw	$ra, -44($sp)
	lw	$v0, -40($sp)
	lw	$v1, 16($v0)
	flw	$f1, 8($v1)
	fle	$f1, $f0
	fbf	fbt_else.28220
	addi	$v1, $zero, 0
	j	fbt_cont.28221
fbt_else.28220:
	addi	$v1, $zero, 1
fbt_cont.28221:
	bne	$zero, $v1, beq_else.28222
	addi	$v1, $zero, 0
	j	beq_cont.28223
beq_else.28222:
	lw	$v1, -24($sp)
	flw	$f0, 4($v1)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28224
	addi	$a0, $zero, 1
	j	fbt_cont.28225
fbt_else.28224:
	addi	$a0, $zero, 0
fbt_cont.28225:
	bne	$zero, $a0, beq_else.28226
	addi	$v1, $zero, 1
	j	beq_cont.28227
beq_else.28226:
	addi	$v1, $zero, 0
beq_cont.28227:
beq_cont.28223:
beq_cont.28219:
	bne	$zero, $v1, beq_else.28228
	lw	$v1, -24($sp)
	flw	$f0, 8($v1)
	flw	$f1, -20($sp)
	fsub	$f0, $f0, $f1
	flw	$f2, 12($v1)
	fmul	$f0, $f0, $f2
	lw	$a0, -36($sp)
	flw	$f2, 0($a0)
	fmul	$f2, $f0, $f2
	flw	$f3, -16($sp)
	fadd	$f2, $f2, $f3
	fsw	$f0, -44($sp)
	fmove	$f0, $f2
	sw	$ra, -48($sp)
	subi	$sp, $sp, 52
	jal	min_caml_fabs
	addi	$sp, $sp, 52
	lw	$ra, -48($sp)
	lw	$v0, -40($sp)
	lw	$v1, 16($v0)
	flw	$f1, 0($v1)
	fle	$f1, $f0
	fbf	fbt_else.28230
	addi	$v1, $zero, 0
	j	fbt_cont.28231
fbt_else.28230:
	addi	$v1, $zero, 1
fbt_cont.28231:
	bne	$zero, $v1, beq_else.28232
	addi	$v1, $zero, 0
	j	beq_cont.28233
beq_else.28232:
	lw	$v1, -36($sp)
	flw	$f0, 8($v1)
	flw	$f1, -44($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -28($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -48($sp)
	subi	$sp, $sp, 52
	jal	min_caml_fabs
	addi	$sp, $sp, 52
	lw	$ra, -48($sp)
	lw	$v0, -40($sp)
	lw	$v1, 16($v0)
	flw	$f1, 8($v1)
	fle	$f1, $f0
	fbf	fbt_else.28234
	addi	$v1, $zero, 0
	j	fbt_cont.28235
fbt_else.28234:
	addi	$v1, $zero, 1
fbt_cont.28235:
	bne	$zero, $v1, beq_else.28236
	addi	$v1, $zero, 0
	j	beq_cont.28237
beq_else.28236:
	lw	$v1, -24($sp)
	flw	$f0, 12($v1)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28238
	addi	$a0, $zero, 1
	j	fbt_cont.28239
fbt_else.28238:
	addi	$a0, $zero, 0
fbt_cont.28239:
	bne	$zero, $a0, beq_else.28240
	addi	$v1, $zero, 1
	j	beq_cont.28241
beq_else.28240:
	addi	$v1, $zero, 0
beq_cont.28241:
beq_cont.28237:
beq_cont.28233:
	bne	$zero, $v1, beq_else.28242
	lw	$v1, -24($sp)
	flw	$f0, 16($v1)
	flw	$f1, -28($sp)
	fsub	$f0, $f0, $f1
	flw	$f1, 20($v1)
	fmul	$f0, $f0, $f1
	lw	$a0, -36($sp)
	flw	$f1, 0($a0)
	fmul	$f1, $f0, $f1
	flw	$f2, -16($sp)
	fadd	$f1, $f1, $f2
	fsw	$f0, -48($sp)
	fmove	$f0, $f1
	sw	$ra, -52($sp)
	subi	$sp, $sp, 56
	jal	min_caml_fabs
	addi	$sp, $sp, 56
	lw	$ra, -52($sp)
	lw	$v0, -40($sp)
	lw	$v1, 16($v0)
	flw	$f1, 0($v1)
	fle	$f1, $f0
	fbf	fbt_else.28244
	addi	$v1, $zero, 0
	j	fbt_cont.28245
fbt_else.28244:
	addi	$v1, $zero, 1
fbt_cont.28245:
	bne	$zero, $v1, beq_else.28246
	addi	$v0, $zero, 0
	j	beq_cont.28247
beq_else.28246:
	lw	$v1, -36($sp)
	flw	$f0, 4($v1)
	flw	$f1, -48($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -20($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -52($sp)
	subi	$sp, $sp, 56
	jal	min_caml_fabs
	addi	$sp, $sp, 56
	lw	$ra, -52($sp)
	lw	$v0, -40($sp)
	lw	$v0, 16($v0)
	flw	$f1, 4($v0)
	fle	$f1, $f0
	fbf	fbt_else.28248
	addi	$v0, $zero, 0
	j	fbt_cont.28249
fbt_else.28248:
	addi	$v0, $zero, 1
fbt_cont.28249:
	bne	$zero, $v0, beq_else.28250
	addi	$v0, $zero, 0
	j	beq_cont.28251
beq_else.28250:
	lw	$v0, -24($sp)
	flw	$f0, 20($v0)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28252
	addi	$v0, $zero, 1
	j	fbt_cont.28253
fbt_else.28252:
	addi	$v0, $zero, 0
fbt_cont.28253:
	bne	$zero, $v0, beq_else.28254
	addi	$v0, $zero, 1
	j	beq_cont.28255
beq_else.28254:
	addi	$v0, $zero, 0
beq_cont.28255:
beq_cont.28251:
beq_cont.28247:
	bne	$zero, $v0, beq_else.28256
	addi	$v0, $zero, 0
	j	beq_cont.28215
beq_else.28256:
	lw	$v0, -12($sp)
	flw	$f0, -48($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 3
beq_cont.28257:
	j	beq_cont.28215
beq_else.28242:
	lw	$v0, -12($sp)
	flw	$f0, -44($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 2
beq_cont.28243:
	j	beq_cont.28215
beq_else.28228:
	lw	$v0, -12($sp)
	flw	$f0, -32($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 1
beq_cont.28229:
	j	beq_cont.28215
beq_else.28214:
	addi	$t8, $zero, 2
	bne	$t8, $a2, beq_else.28258
	flw	$f3, 0($a1)
	la	$t8, l.23884
	flw	$f4, 0($t8)
	fle	$f4, $f3
	fbf	fbt_else.28260
	addi	$a2, $zero, 0
	j	fbt_cont.28261
fbt_else.28260:
	addi	$a2, $zero, 1
fbt_cont.28261:
	bne	$zero, $a2, beq_else.28262
	addi	$v0, $zero, 0
	j	beq_cont.28259
beq_else.28262:
	flw	$f3, 4($a1)
	fmul	$f0, $f3, $f0
	flw	$f3, 8($a1)
	fmul	$f1, $f3, $f1
	fadd	$f0, $f0, $f1
	flw	$f1, 12($a1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	fsw	$f0, 0($t1)
	addi	$v0, $zero, 1
beq_cont.28263:
	j	beq_cont.28259
beq_else.28258:
	flw	$f3, 0($a1)
	la	$t8, l.23884
	flw	$f4, 0($t8)
	feq	$f3, $f4
	fbf	fbt_else.28264
	addi	$a2, $zero, 1
	j	fbt_cont.28265
fbt_else.28264:
	addi	$a2, $zero, 0
fbt_cont.28265:
	bne	$zero, $a2, beq_else.28266
	flw	$f4, 4($a1)
	fmul	$f4, $f4, $f0
	flw	$f5, 8($a1)
	fmul	$f5, $f5, $f1
	fadd	$f4, $f4, $f5
	flw	$f5, 12($a1)
	fmul	$f5, $f5, $f2
	fadd	$f4, $f4, $f5
	fmul	$f5, $f0, $f0
	lw	$a2, 16($t0)
	flw	$f6, 0($a2)
	fmul	$f5, $f5, $f6
	fmul	$f6, $f1, $f1
	lw	$a2, 16($t0)
	flw	$f7, 4($a2)
	fmul	$f6, $f6, $f7
	fadd	$f5, $f5, $f6
	fmul	$f6, $f2, $f2
	lw	$a2, 16($t0)
	flw	$f7, 8($a2)
	fmul	$f6, $f6, $f7
	fadd	$f5, $f5, $f6
	lw	$a2, 12($t0)
	bne	$zero, $a2, beq_else.28268
	fmove	$f0, $f5
	j	beq_cont.28269
beq_else.28268:
	fmul	$f6, $f1, $f2
	lw	$a2, 36($t0)
	flw	$f7, 0($a2)
	fmul	$f6, $f6, $f7
	fadd	$f5, $f5, $f6
	fmul	$f2, $f2, $f0
	lw	$a2, 36($t0)
	flw	$f6, 4($a2)
	fmul	$f2, $f2, $f6
	fadd	$f2, $f5, $f2
	fmul	$f0, $f0, $f1
	lw	$a2, 36($t0)
	flw	$f1, 8($a2)
	fmul	$f0, $f0, $f1
	fadd	$f0, $f2, $f0
beq_cont.28269:
	lw	$a2, 4($t0)
	addi	$t8, $zero, 3
	bne	$t8, $a2, beq_else.28270
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fsub	$f0, $f0, $f1
beq_else.28270:
beq_cont.28271:
	fmul	$f1, $f4, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f1, $f0
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28272
	addi	$a2, $zero, 0
	j	fbt_cont.28273
fbt_else.28272:
	addi	$a2, $zero, 1
fbt_cont.28273:
	bne	$zero, $a2, beq_else.28274
	addi	$v0, $zero, 0
	j	beq_cont.28267
beq_else.28274:
	lw	$a2, 24($t0)
	bne	$zero, $a2, beq_else.28276
	sw	$a1, -24($sp)
	fsw	$f4, -52($sp)
	sw	$ra, -56($sp)
	subi	$sp, $sp, 60
	jal	min_caml_sqrt
	addi	$sp, $sp, 60
	lw	$ra, -56($sp)
	flw	$f1, -52($sp)
	fsub	$f0, $f1, $f0
	lw	$v0, -24($sp)
	flw	$f1, 16($v0)
	fmul	$f0, $f0, $f1
	lw	$v0, -12($sp)
	fsw	$f0, 0($v0)
	j	beq_cont.28277
beq_else.28276:
	sw	$a1, -24($sp)
	fsw	$f4, -52($sp)
	sw	$ra, -56($sp)
	subi	$sp, $sp, 60
	jal	min_caml_sqrt
	addi	$sp, $sp, 60
	lw	$ra, -56($sp)
	flw	$f1, -52($sp)
	fadd	$f0, $f1, $f0
	lw	$v0, -24($sp)
	flw	$f1, 16($v0)
	fmul	$f0, $f0, $f1
	lw	$v0, -12($sp)
	fsw	$f0, 0($v0)
beq_cont.28277:
	addi	$v0, $zero, 1
beq_cont.28275:
	j	beq_cont.28267
beq_else.28266:
	addi	$v0, $zero, 0
beq_cont.28267:
beq_cont.28259:
beq_cont.28215:
	bne	$zero, $v0, beq_else.28278
	addi	$v0, $zero, 0
	j	beq_cont.28279
beq_else.28278:
	lw	$v0, -12($sp)
	flw	$f0, 0($v0)
	la	$t8, l.24249
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28280
	addi	$v0, $zero, 0
	j	fbt_cont.28281
fbt_else.28280:
	addi	$v0, $zero, 1
fbt_cont.28281:
	bne	$zero, $v0, beq_else.28282
	addi	$v0, $zero, 0
	j	beq_cont.28283
beq_else.28282:
	addi	$v0, $zero, 1
	lw	$v1, 0($sp)
	sw	$ra, -56($sp)
	subi	$sp, $sp, 60
	jal	shadow_check_one_or_group.2891
	addi	$sp, $sp, 60
	lw	$ra, -56($sp)
	bne	$zero, $v0, beq_else.28284
	addi	$v0, $zero, 0
	j	beq_cont.28285
beq_else.28284:
	addi	$v0, $zero, 1
beq_cont.28285:
beq_cont.28283:
beq_cont.28279:
beq_cont.28213:
	bne	$zero, $v0, beq_else.28286
	lw	$v0, -8($sp)
	addi	$v0, $v0, 1
	lw	$v1, -4($sp)
	j	shadow_check_one_or_matrix.2894
beq_else.28286:
	addi	$v0, $zero, 1
	lw	$v1, 0($sp)
	sw	$ra, -56($sp)
	subi	$sp, $sp, 60
	jal	shadow_check_one_or_group.2891
	addi	$sp, $sp, 60
	lw	$ra, -56($sp)
	bne	$zero, $v0, beq_else.28287
	lw	$v0, -8($sp)
	addi	$v0, $v0, 1
	lw	$v1, -4($sp)
	j	shadow_check_one_or_matrix.2894
beq_else.28287:
	addi	$v0, $zero, 1
	jr	$ra
solve_each_element.2897:
	sll	$a1, $v0, 2
	add	$t8, $v1, $a1
	lw	$a1, 0($t8)
	lui	$a2, 512
	ori	$a2, $a2, 564
	lui	$a3, 512
	ori	$a3, $a3, 552
	lui	$t0, 512
	ori	$t0, $t0, 544
	lui	$t1, 512
	ori	$t1, $t1, 48
	lui	$t2, 512
	ori	$t2, $t2, 540
	lui	$t3, 512
	ori	$t3, $t3, 636
	lui	$t4, 512
	ori	$t4, $t4, 548
	addi	$t8, $zero, -1
	bne	$t8, $a1, beq_else.28288
	jr	$ra
beq_else.28288:
	sll	$t5, $a1, 2
	add	$t8, $t1, $t5
	lw	$t5, 0($t8)
	flw	$f0, 0($t3)
	lw	$t6, 20($t5)
	flw	$f1, 0($t6)
	fsub	$f0, $f0, $f1
	flw	$f1, 4($t3)
	lw	$t6, 20($t5)
	flw	$f2, 4($t6)
	fsub	$f1, $f1, $f2
	flw	$f2, 8($t3)
	lw	$t6, 20($t5)
	flw	$f3, 8($t6)
	fsub	$f2, $f2, $f3
	lw	$t6, 4($t5)
	sw	$t0, 0($sp)
	sw	$a2, -4($sp)
	sw	$a3, -8($sp)
	sw	$t3, -12($sp)
	sw	$t4, -16($sp)
	sw	$t2, -20($sp)
	sw	$a0, -24($sp)
	sw	$v1, -28($sp)
	sw	$v0, -32($sp)
	sw	$t1, -36($sp)
	sw	$a1, -40($sp)
	addi	$t8, $zero, 1
	bne	$t8, $t6, beq_else.28290
	flw	$f3, 0($a0)
	la	$t8, l.23884
	flw	$f4, 0($t8)
	feq	$f3, $f4
	fbf	fbt_else.28292
	addi	$t6, $zero, 1
	j	fbt_cont.28293
fbt_else.28292:
	addi	$t6, $zero, 0
fbt_cont.28293:
	fsw	$f0, -44($sp)
	fsw	$f2, -48($sp)
	fsw	$f1, -52($sp)
	sw	$t5, -56($sp)
	bne	$zero, $t6, beq_else.28294
	lw	$t6, 16($t5)
	lw	$s0, 24($t5)
	flw	$f3, 0($a0)
	la	$t8, l.23884
	flw	$f4, 0($t8)
	fle	$f4, $f3
	fbf	fbt_else.28296
	addi	$s1, $zero, 0
	j	fbt_cont.28297
fbt_else.28296:
	addi	$s1, $zero, 1
fbt_cont.28297:
	bne	$zero, $s0, beq_else.28298
	move	$s0, $s1
	j	beq_cont.28299
beq_else.28298:
	bne	$zero, $s1, beq_else.28300
	addi	$s0, $zero, 1
	j	beq_cont.28301
beq_else.28300:
	addi	$s0, $zero, 0
beq_cont.28301:
beq_cont.28299:
	flw	$f3, 0($t6)
	bne	$zero, $s0, beq_else.28302
	fneg	$f3, $f3
beq_else.28302:
beq_cont.28303:
	fsub	$f3, $f3, $f0
	flw	$f4, 0($a0)
	fdiv	$f3, $f3, $f4
	flw	$f4, 4($a0)
	fmul	$f4, $f3, $f4
	fadd	$f4, $f4, $f1
	fsw	$f3, -60($sp)
	sw	$t6, -64($sp)
	fmove	$f0, $f4
	sw	$ra, -68($sp)
	subi	$sp, $sp, 72
	jal	min_caml_fabs
	addi	$sp, $sp, 72
	lw	$ra, -68($sp)
	lw	$v0, -64($sp)
	flw	$f1, 4($v0)
	fle	$f1, $f0
	fbf	fbt_else.28304
	addi	$v1, $zero, 0
	j	fbt_cont.28305
fbt_else.28304:
	addi	$v1, $zero, 1
fbt_cont.28305:
	bne	$zero, $v1, beq_else.28306
	addi	$v0, $zero, 0
	j	beq_cont.28295
beq_else.28306:
	lw	$v1, -24($sp)
	flw	$f0, 8($v1)
	flw	$f1, -60($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -48($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -68($sp)
	subi	$sp, $sp, 72
	jal	min_caml_fabs
	addi	$sp, $sp, 72
	lw	$ra, -68($sp)
	lw	$v0, -64($sp)
	flw	$f1, 8($v0)
	fle	$f1, $f0
	fbf	fbt_else.28308
	addi	$v0, $zero, 0
	j	fbt_cont.28309
fbt_else.28308:
	addi	$v0, $zero, 1
fbt_cont.28309:
	bne	$zero, $v0, beq_else.28310
	addi	$v0, $zero, 0
	j	beq_cont.28295
beq_else.28310:
	lw	$v0, -20($sp)
	flw	$f0, -60($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 1
beq_cont.28311:
beq_cont.28307:
	j	beq_cont.28295
beq_else.28294:
	addi	$v0, $zero, 0
beq_cont.28295:
	bne	$zero, $v0, beq_else.28312
	lw	$a0, -24($sp)
	flw	$f0, 4($a0)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28314
	addi	$v0, $zero, 1
	j	fbt_cont.28315
fbt_else.28314:
	addi	$v0, $zero, 0
fbt_cont.28315:
	bne	$zero, $v0, beq_else.28316
	lw	$v0, -56($sp)
	lw	$v1, 16($v0)
	lw	$a1, 24($v0)
	flw	$f0, 4($a0)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28318
	addi	$a2, $zero, 0
	j	fbt_cont.28319
fbt_else.28318:
	addi	$a2, $zero, 1
fbt_cont.28319:
	bne	$zero, $a1, beq_else.28320
	move	$a1, $a2
	j	beq_cont.28321
beq_else.28320:
	bne	$zero, $a2, beq_else.28322
	addi	$a1, $zero, 1
	j	beq_cont.28323
beq_else.28322:
	addi	$a1, $zero, 0
beq_cont.28323:
beq_cont.28321:
	flw	$f0, 4($v1)
	bne	$zero, $a1, beq_else.28324
	fneg	$f0, $f0
beq_else.28324:
beq_cont.28325:
	flw	$f1, -52($sp)
	fsub	$f0, $f0, $f1
	flw	$f2, 4($a0)
	fdiv	$f0, $f0, $f2
	flw	$f2, 8($a0)
	fmul	$f2, $f0, $f2
	flw	$f3, -48($sp)
	fadd	$f2, $f2, $f3
	fsw	$f0, -68($sp)
	sw	$v1, -72($sp)
	fmove	$f0, $f2
	sw	$ra, -76($sp)
	subi	$sp, $sp, 80
	jal	min_caml_fabs
	addi	$sp, $sp, 80
	lw	$ra, -76($sp)
	lw	$v0, -72($sp)
	flw	$f1, 8($v0)
	fle	$f1, $f0
	fbf	fbt_else.28326
	addi	$v1, $zero, 0
	j	fbt_cont.28327
fbt_else.28326:
	addi	$v1, $zero, 1
fbt_cont.28327:
	bne	$zero, $v1, beq_else.28328
	addi	$v0, $zero, 0
	j	beq_cont.28317
beq_else.28328:
	lw	$v1, -24($sp)
	flw	$f0, 0($v1)
	flw	$f1, -68($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -44($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -76($sp)
	subi	$sp, $sp, 80
	jal	min_caml_fabs
	addi	$sp, $sp, 80
	lw	$ra, -76($sp)
	lw	$v0, -72($sp)
	flw	$f1, 0($v0)
	fle	$f1, $f0
	fbf	fbt_else.28330
	addi	$v0, $zero, 0
	j	fbt_cont.28331
fbt_else.28330:
	addi	$v0, $zero, 1
fbt_cont.28331:
	bne	$zero, $v0, beq_else.28332
	addi	$v0, $zero, 0
	j	beq_cont.28317
beq_else.28332:
	lw	$v0, -20($sp)
	flw	$f0, -68($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 1
beq_cont.28333:
beq_cont.28329:
	j	beq_cont.28317
beq_else.28316:
	addi	$v0, $zero, 0
beq_cont.28317:
	bne	$zero, $v0, beq_else.28334
	lw	$a0, -24($sp)
	flw	$f0, 8($a0)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28336
	addi	$v0, $zero, 1
	j	fbt_cont.28337
fbt_else.28336:
	addi	$v0, $zero, 0
fbt_cont.28337:
	bne	$zero, $v0, beq_else.28338
	lw	$v0, -56($sp)
	lw	$v1, 16($v0)
	lw	$v0, 24($v0)
	flw	$f0, 8($a0)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28340
	addi	$a1, $zero, 0
	j	fbt_cont.28341
fbt_else.28340:
	addi	$a1, $zero, 1
fbt_cont.28341:
	bne	$zero, $v0, beq_else.28342
	move	$v0, $a1
	j	beq_cont.28343
beq_else.28342:
	bne	$zero, $a1, beq_else.28344
	addi	$v0, $zero, 1
	j	beq_cont.28345
beq_else.28344:
	addi	$v0, $zero, 0
beq_cont.28345:
beq_cont.28343:
	flw	$f0, 8($v1)
	bne	$zero, $v0, beq_else.28346
	fneg	$f0, $f0
beq_else.28346:
beq_cont.28347:
	flw	$f1, -48($sp)
	fsub	$f0, $f0, $f1
	flw	$f1, 8($a0)
	fdiv	$f0, $f0, $f1
	flw	$f1, 0($a0)
	fmul	$f1, $f0, $f1
	flw	$f2, -44($sp)
	fadd	$f1, $f1, $f2
	fsw	$f0, -76($sp)
	sw	$v1, -80($sp)
	fmove	$f0, $f1
	sw	$ra, -84($sp)
	subi	$sp, $sp, 88
	jal	min_caml_fabs
	addi	$sp, $sp, 88
	lw	$ra, -84($sp)
	lw	$v0, -80($sp)
	flw	$f1, 0($v0)
	fle	$f1, $f0
	fbf	fbt_else.28348
	addi	$v1, $zero, 0
	j	fbt_cont.28349
fbt_else.28348:
	addi	$v1, $zero, 1
fbt_cont.28349:
	bne	$zero, $v1, beq_else.28350
	addi	$v0, $zero, 0
	j	beq_cont.28339
beq_else.28350:
	lw	$v1, -24($sp)
	flw	$f0, 4($v1)
	flw	$f1, -76($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -52($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -84($sp)
	subi	$sp, $sp, 88
	jal	min_caml_fabs
	addi	$sp, $sp, 88
	lw	$ra, -84($sp)
	lw	$v0, -80($sp)
	flw	$f1, 4($v0)
	fle	$f1, $f0
	fbf	fbt_else.28352
	addi	$v0, $zero, 0
	j	fbt_cont.28353
fbt_else.28352:
	addi	$v0, $zero, 1
fbt_cont.28353:
	bne	$zero, $v0, beq_else.28354
	addi	$v0, $zero, 0
	j	beq_cont.28339
beq_else.28354:
	lw	$v0, -20($sp)
	flw	$f0, -76($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 1
beq_cont.28355:
beq_cont.28351:
	j	beq_cont.28339
beq_else.28338:
	addi	$v0, $zero, 0
beq_cont.28339:
	bne	$zero, $v0, beq_else.28356
	addi	$v0, $zero, 0
	j	beq_cont.28291
beq_else.28356:
	addi	$v0, $zero, 3
beq_cont.28357:
	j	beq_cont.28291
beq_else.28334:
	addi	$v0, $zero, 2
beq_cont.28335:
	j	beq_cont.28291
beq_else.28312:
	addi	$v0, $zero, 1
beq_cont.28313:
	j	beq_cont.28291
beq_else.28290:
	addi	$t8, $zero, 2
	bne	$t8, $t6, beq_else.28358
	lw	$t5, 16($t5)
	flw	$f3, 0($a0)
	flw	$f4, 0($t5)
	fmul	$f3, $f3, $f4
	flw	$f4, 4($a0)
	flw	$f5, 4($t5)
	fmul	$f4, $f4, $f5
	fadd	$f3, $f3, $f4
	flw	$f4, 8($a0)
	flw	$f5, 8($t5)
	fmul	$f4, $f4, $f5
	fadd	$f3, $f3, $f4
	la	$t8, l.23884
	flw	$f4, 0($t8)
	fle	$f3, $f4
	fbf	fbt_else.28360
	addi	$t6, $zero, 0
	j	fbt_cont.28361
fbt_else.28360:
	addi	$t6, $zero, 1
fbt_cont.28361:
	bne	$zero, $t6, beq_else.28362
	addi	$v0, $zero, 0
	j	beq_cont.28359
beq_else.28362:
	flw	$f4, 0($t5)
	fmul	$f0, $f4, $f0
	flw	$f4, 4($t5)
	fmul	$f1, $f4, $f1
	fadd	$f0, $f0, $f1
	flw	$f1, 8($t5)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	fneg	$f0, $f0
	fdiv	$f0, $f0, $f3
	fsw	$f0, 0($t2)
	addi	$v0, $zero, 1
beq_cont.28363:
	j	beq_cont.28359
beq_else.28358:
	flw	$f3, 0($a0)
	flw	$f4, 4($a0)
	flw	$f5, 8($a0)
	fmul	$f6, $f3, $f3
	lw	$t6, 16($t5)
	flw	$f7, 0($t6)
	fmul	$f6, $f6, $f7
	fmul	$f7, $f4, $f4
	lw	$t6, 16($t5)
	flw	$f8, 4($t6)
	fmul	$f7, $f7, $f8
	fadd	$f6, $f6, $f7
	fmul	$f7, $f5, $f5
	lw	$t6, 16($t5)
	flw	$f8, 8($t6)
	fmul	$f7, $f7, $f8
	fadd	$f6, $f6, $f7
	lw	$t6, 12($t5)
	bne	$zero, $t6, beq_else.28364
	fmove	$f3, $f6
	j	beq_cont.28365
beq_else.28364:
	fmul	$f7, $f4, $f5
	lw	$t6, 36($t5)
	flw	$f8, 0($t6)
	fmul	$f7, $f7, $f8
	fadd	$f6, $f6, $f7
	fmul	$f5, $f5, $f3
	lw	$t6, 36($t5)
	flw	$f7, 4($t6)
	fmul	$f5, $f5, $f7
	fadd	$f5, $f6, $f5
	fmul	$f3, $f3, $f4
	lw	$t6, 36($t5)
	flw	$f4, 8($t6)
	fmul	$f3, $f3, $f4
	fadd	$f3, $f5, $f3
beq_cont.28365:
	la	$t8, l.23884
	flw	$f4, 0($t8)
	feq	$f3, $f4
	fbf	fbt_else.28366
	addi	$t6, $zero, 1
	j	fbt_cont.28367
fbt_else.28366:
	addi	$t6, $zero, 0
fbt_cont.28367:
	bne	$zero, $t6, beq_else.28368
	flw	$f4, 0($a0)
	flw	$f5, 4($a0)
	flw	$f6, 8($a0)
	fmul	$f7, $f4, $f0
	lw	$t6, 16($t5)
	flw	$f8, 0($t6)
	fmul	$f7, $f7, $f8
	fmul	$f8, $f5, $f1
	lw	$t6, 16($t5)
	flw	$f9, 4($t6)
	fmul	$f8, $f8, $f9
	fadd	$f7, $f7, $f8
	fmul	$f8, $f6, $f2
	lw	$t6, 16($t5)
	flw	$f9, 8($t6)
	fmul	$f8, $f8, $f9
	fadd	$f7, $f7, $f8
	lw	$t6, 12($t5)
	bne	$zero, $t6, beq_else.28370
	fmove	$f4, $f7
	j	beq_cont.28371
beq_else.28370:
	fmul	$f8, $f6, $f1
	fmul	$f9, $f5, $f2
	fadd	$f8, $f8, $f9
	lw	$t6, 36($t5)
	flw	$f9, 0($t6)
	fmul	$f8, $f8, $f9
	fmul	$f9, $f4, $f2
	fmul	$f6, $f6, $f0
	fadd	$f6, $f9, $f6
	lw	$t6, 36($t5)
	flw	$f9, 4($t6)
	fmul	$f6, $f6, $f9
	fadd	$f6, $f8, $f6
	fmul	$f4, $f4, $f1
	fmul	$f5, $f5, $f0
	fadd	$f4, $f4, $f5
	lw	$t6, 36($t5)
	flw	$f5, 8($t6)
	fmul	$f4, $f4, $f5
	fadd	$f4, $f6, $f4
	la	$t8, l.23876
	flw	$f5, 0($t8)
	fmul	$f4, $f4, $f5
	fadd	$f4, $f7, $f4
beq_cont.28371:
	fmul	$f5, $f0, $f0
	lw	$t6, 16($t5)
	flw	$f6, 0($t6)
	fmul	$f5, $f5, $f6
	fmul	$f6, $f1, $f1
	lw	$t6, 16($t5)
	flw	$f7, 4($t6)
	fmul	$f6, $f6, $f7
	fadd	$f5, $f5, $f6
	fmul	$f6, $f2, $f2
	lw	$t6, 16($t5)
	flw	$f7, 8($t6)
	fmul	$f6, $f6, $f7
	fadd	$f5, $f5, $f6
	lw	$t6, 12($t5)
	bne	$zero, $t6, beq_else.28372
	fmove	$f0, $f5
	j	beq_cont.28373
beq_else.28372:
	fmul	$f6, $f1, $f2
	lw	$t6, 36($t5)
	flw	$f7, 0($t6)
	fmul	$f6, $f6, $f7
	fadd	$f5, $f5, $f6
	fmul	$f2, $f2, $f0
	lw	$t6, 36($t5)
	flw	$f6, 4($t6)
	fmul	$f2, $f2, $f6
	fadd	$f2, $f5, $f2
	fmul	$f0, $f0, $f1
	lw	$t6, 36($t5)
	flw	$f1, 8($t6)
	fmul	$f0, $f0, $f1
	fadd	$f0, $f2, $f0
beq_cont.28373:
	lw	$t6, 4($t5)
	addi	$t8, $zero, 3
	bne	$t8, $t6, beq_else.28374
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fsub	$f0, $f0, $f1
beq_else.28374:
beq_cont.28375:
	fmul	$f1, $f4, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f1, $f0
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28376
	addi	$t6, $zero, 0
	j	fbt_cont.28377
fbt_else.28376:
	addi	$t6, $zero, 1
fbt_cont.28377:
	bne	$zero, $t6, beq_else.28378
	addi	$v0, $zero, 0
	j	beq_cont.28369
beq_else.28378:
	fsw	$f3, -84($sp)
	fsw	$f4, -88($sp)
	sw	$t5, -56($sp)
	sw	$ra, -92($sp)
	subi	$sp, $sp, 96
	jal	min_caml_sqrt
	addi	$sp, $sp, 96
	lw	$ra, -92($sp)
	lw	$v0, -56($sp)
	lw	$v0, 24($v0)
	bne	$zero, $v0, beq_else.28380
	fneg	$f0, $f0
beq_else.28380:
beq_cont.28381:
	flw	$f1, -88($sp)
	fsub	$f0, $f0, $f1
	flw	$f1, -84($sp)
	fdiv	$f0, $f0, $f1
	lw	$v0, -20($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 1
beq_cont.28379:
	j	beq_cont.28369
beq_else.28368:
	addi	$v0, $zero, 0
beq_cont.28369:
beq_cont.28359:
beq_cont.28291:
	bne	$zero, $v0, beq_else.28382
	lw	$v0, -40($sp)
	sll	$v0, $v0, 2
	lw	$v1, -36($sp)
	add	$t8, $v1, $v0
	lw	$v0, 0($t8)
	lw	$v0, 24($v0)
	bne	$zero, $v0, beq_else.28383
	jr	$ra
beq_else.28383:
	lw	$v0, -32($sp)
	addi	$v0, $v0, 1
	lw	$v1, -28($sp)
	lw	$a0, -24($sp)
	j	solve_each_element.2897
beq_else.28382:
	lw	$v1, -20($sp)
	flw	$f0, 0($v1)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28385
	addi	$v1, $zero, 0
	j	fbt_cont.28386
fbt_else.28385:
	addi	$v1, $zero, 1
fbt_cont.28386:
	bne	$zero, $v1, beq_else.28387
	j	beq_cont.28388
beq_else.28387:
	lw	$v1, -16($sp)
	flw	$f1, 0($v1)
	fle	$f1, $f0
	fbf	fbt_else.28389
	addi	$a0, $zero, 0
	j	fbt_cont.28390
fbt_else.28389:
	addi	$a0, $zero, 1
fbt_cont.28390:
	bne	$zero, $a0, beq_else.28391
	j	beq_cont.28392
beq_else.28391:
	la	$t8, l.24185
	flw	$f1, 0($t8)
	fadd	$f0, $f0, $f1
	lw	$a0, -24($sp)
	flw	$f1, 0($a0)
	fmul	$f1, $f1, $f0
	lw	$a1, -12($sp)
	flw	$f2, 0($a1)
	fadd	$f1, $f1, $f2
	flw	$f2, 4($a0)
	fmul	$f2, $f2, $f0
	flw	$f3, 4($a1)
	fadd	$f2, $f2, $f3
	flw	$f3, 8($a0)
	fmul	$f3, $f3, $f0
	flw	$f4, 8($a1)
	fadd	$f3, $f3, $f4
	lw	$a1, -28($sp)
	sw	$v0, -92($sp)
	fsw	$f3, -96($sp)
	fsw	$f2, -100($sp)
	fsw	$f1, -104($sp)
	fsw	$f0, -108($sp)
	move	$v1, $a1
	move	$v0, $zero
	fmove	$f0, $f1
	fmove	$f1, $f2
	fmove	$f2, $f3
	sw	$ra, -112($sp)
	subi	$sp, $sp, 116
	jal	check_all_inside.2882
	addi	$sp, $sp, 116
	lw	$ra, -112($sp)
	bne	$zero, $v0, beq_else.28393
	j	beq_cont.28394
beq_else.28393:
	lw	$v0, -16($sp)
	flw	$f0, -108($sp)
	fsw	$f0, 0($v0)
	lw	$v0, -8($sp)
	flw	$f0, -104($sp)
	fsw	$f0, 0($v0)
	flw	$f0, -100($sp)
	fsw	$f0, 4($v0)
	flw	$f0, -96($sp)
	fsw	$f0, 8($v0)
	lw	$v0, -4($sp)
	lw	$v1, -40($sp)
	sw	$v1, 0($v0)
	lw	$v0, 0($sp)
	lw	$v1, -92($sp)
	sw	$v1, 0($v0)
beq_cont.28394:
beq_cont.28392:
beq_cont.28388:
	lw	$v0, -32($sp)
	addi	$v0, $v0, 1
	lw	$v1, -28($sp)
	lw	$a0, -24($sp)
	j	solve_each_element.2897
solve_one_or_network.2901:
	sll	$a1, $v0, 2
	add	$t8, $v1, $a1
	lw	$a1, 0($t8)
	lui	$a2, 512
	ori	$a2, $a2, 332
	addi	$t8, $zero, -1
	bne	$t8, $a1, beq_else.28395
	jr	$ra
beq_else.28395:
	sll	$a1, $a1, 2
	add	$t8, $a2, $a1
	lw	$a1, 0($t8)
	sw	$a0, 0($sp)
	sw	$v1, -4($sp)
	sw	$v0, -8($sp)
	move	$v1, $a1
	move	$v0, $zero
	sw	$ra, -12($sp)
	subi	$sp, $sp, 16
	jal	solve_each_element.2897
	addi	$sp, $sp, 16
	lw	$ra, -12($sp)
	lw	$v0, -8($sp)
	addi	$v0, $v0, 1
	lw	$v1, -4($sp)
	lw	$a0, 0($sp)
	j	solve_one_or_network.2901
trace_or_matrix.2905:
	sll	$a1, $v0, 2
	add	$t8, $v1, $a1
	lw	$a1, 0($t8)
	lw	$a2, 0($a1)
	lui	$a3, 512
	ori	$a3, $a3, 48
	lui	$t0, 512
	ori	$t0, $t0, 540
	lui	$t1, 512
	ori	$t1, $t1, 636
	lui	$t2, 512
	ori	$t2, $t2, 548
	addi	$t8, $zero, -1
	bne	$t8, $a2, beq_else.28397
	jr	$ra
beq_else.28397:
	sw	$a0, 0($sp)
	sw	$v1, -4($sp)
	sw	$v0, -8($sp)
	addi	$t8, $zero, 99
	bne	$t8, $a2, beq_else.28399
	addi	$a2, $zero, 1
	move	$v1, $a1
	move	$v0, $a2
	sw	$ra, -12($sp)
	subi	$sp, $sp, 16
	jal	solve_one_or_network.2901
	addi	$sp, $sp, 16
	lw	$ra, -12($sp)
	j	beq_cont.28400
beq_else.28399:
	sll	$a2, $a2, 2
	add	$t8, $a3, $a2
	lw	$a2, 0($t8)
	flw	$f0, 0($t1)
	lw	$a3, 20($a2)
	flw	$f1, 0($a3)
	fsub	$f0, $f0, $f1
	flw	$f1, 4($t1)
	lw	$a3, 20($a2)
	flw	$f2, 4($a3)
	fsub	$f1, $f1, $f2
	flw	$f2, 8($t1)
	lw	$a3, 20($a2)
	flw	$f3, 8($a3)
	fsub	$f2, $f2, $f3
	lw	$a3, 4($a2)
	sw	$a1, -12($sp)
	sw	$t2, -16($sp)
	sw	$t0, -20($sp)
	addi	$t8, $zero, 1
	bne	$t8, $a3, beq_else.28401
	flw	$f3, 0($a0)
	la	$t8, l.23884
	flw	$f4, 0($t8)
	feq	$f3, $f4
	fbf	fbt_else.28403
	addi	$a3, $zero, 1
	j	fbt_cont.28404
fbt_else.28403:
	addi	$a3, $zero, 0
fbt_cont.28404:
	fsw	$f0, -24($sp)
	fsw	$f2, -28($sp)
	fsw	$f1, -32($sp)
	sw	$a2, -36($sp)
	bne	$zero, $a3, beq_else.28405
	lw	$a3, 16($a2)
	lw	$t1, 24($a2)
	flw	$f3, 0($a0)
	la	$t8, l.23884
	flw	$f4, 0($t8)
	fle	$f4, $f3
	fbf	fbt_else.28407
	addi	$t3, $zero, 0
	j	fbt_cont.28408
fbt_else.28407:
	addi	$t3, $zero, 1
fbt_cont.28408:
	bne	$zero, $t1, beq_else.28409
	move	$t1, $t3
	j	beq_cont.28410
beq_else.28409:
	bne	$zero, $t3, beq_else.28411
	addi	$t1, $zero, 1
	j	beq_cont.28412
beq_else.28411:
	addi	$t1, $zero, 0
beq_cont.28412:
beq_cont.28410:
	flw	$f3, 0($a3)
	bne	$zero, $t1, beq_else.28413
	fneg	$f3, $f3
beq_else.28413:
beq_cont.28414:
	fsub	$f3, $f3, $f0
	flw	$f4, 0($a0)
	fdiv	$f3, $f3, $f4
	flw	$f4, 4($a0)
	fmul	$f4, $f3, $f4
	fadd	$f4, $f4, $f1
	fsw	$f3, -40($sp)
	sw	$a3, -44($sp)
	fmove	$f0, $f4
	sw	$ra, -48($sp)
	subi	$sp, $sp, 52
	jal	min_caml_fabs
	addi	$sp, $sp, 52
	lw	$ra, -48($sp)
	lw	$v0, -44($sp)
	flw	$f1, 4($v0)
	fle	$f1, $f0
	fbf	fbt_else.28415
	addi	$v1, $zero, 0
	j	fbt_cont.28416
fbt_else.28415:
	addi	$v1, $zero, 1
fbt_cont.28416:
	bne	$zero, $v1, beq_else.28417
	addi	$v0, $zero, 0
	j	beq_cont.28406
beq_else.28417:
	lw	$v1, 0($sp)
	flw	$f0, 8($v1)
	flw	$f1, -40($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -28($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -48($sp)
	subi	$sp, $sp, 52
	jal	min_caml_fabs
	addi	$sp, $sp, 52
	lw	$ra, -48($sp)
	lw	$v0, -44($sp)
	flw	$f1, 8($v0)
	fle	$f1, $f0
	fbf	fbt_else.28419
	addi	$v0, $zero, 0
	j	fbt_cont.28420
fbt_else.28419:
	addi	$v0, $zero, 1
fbt_cont.28420:
	bne	$zero, $v0, beq_else.28421
	addi	$v0, $zero, 0
	j	beq_cont.28406
beq_else.28421:
	lw	$v0, -20($sp)
	flw	$f0, -40($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 1
beq_cont.28422:
beq_cont.28418:
	j	beq_cont.28406
beq_else.28405:
	addi	$v0, $zero, 0
beq_cont.28406:
	bne	$zero, $v0, beq_else.28423
	lw	$a0, 0($sp)
	flw	$f0, 4($a0)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28425
	addi	$v0, $zero, 1
	j	fbt_cont.28426
fbt_else.28425:
	addi	$v0, $zero, 0
fbt_cont.28426:
	bne	$zero, $v0, beq_else.28427
	lw	$v0, -36($sp)
	lw	$v1, 16($v0)
	lw	$a1, 24($v0)
	flw	$f0, 4($a0)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28429
	addi	$a2, $zero, 0
	j	fbt_cont.28430
fbt_else.28429:
	addi	$a2, $zero, 1
fbt_cont.28430:
	bne	$zero, $a1, beq_else.28431
	move	$a1, $a2
	j	beq_cont.28432
beq_else.28431:
	bne	$zero, $a2, beq_else.28433
	addi	$a1, $zero, 1
	j	beq_cont.28434
beq_else.28433:
	addi	$a1, $zero, 0
beq_cont.28434:
beq_cont.28432:
	flw	$f0, 4($v1)
	bne	$zero, $a1, beq_else.28435
	fneg	$f0, $f0
beq_else.28435:
beq_cont.28436:
	flw	$f1, -32($sp)
	fsub	$f0, $f0, $f1
	flw	$f2, 4($a0)
	fdiv	$f0, $f0, $f2
	flw	$f2, 8($a0)
	fmul	$f2, $f0, $f2
	flw	$f3, -28($sp)
	fadd	$f2, $f2, $f3
	fsw	$f0, -48($sp)
	sw	$v1, -52($sp)
	fmove	$f0, $f2
	sw	$ra, -56($sp)
	subi	$sp, $sp, 60
	jal	min_caml_fabs
	addi	$sp, $sp, 60
	lw	$ra, -56($sp)
	lw	$v0, -52($sp)
	flw	$f1, 8($v0)
	fle	$f1, $f0
	fbf	fbt_else.28437
	addi	$v1, $zero, 0
	j	fbt_cont.28438
fbt_else.28437:
	addi	$v1, $zero, 1
fbt_cont.28438:
	bne	$zero, $v1, beq_else.28439
	addi	$v0, $zero, 0
	j	beq_cont.28428
beq_else.28439:
	lw	$v1, 0($sp)
	flw	$f0, 0($v1)
	flw	$f1, -48($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -24($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -56($sp)
	subi	$sp, $sp, 60
	jal	min_caml_fabs
	addi	$sp, $sp, 60
	lw	$ra, -56($sp)
	lw	$v0, -52($sp)
	flw	$f1, 0($v0)
	fle	$f1, $f0
	fbf	fbt_else.28441
	addi	$v0, $zero, 0
	j	fbt_cont.28442
fbt_else.28441:
	addi	$v0, $zero, 1
fbt_cont.28442:
	bne	$zero, $v0, beq_else.28443
	addi	$v0, $zero, 0
	j	beq_cont.28428
beq_else.28443:
	lw	$v0, -20($sp)
	flw	$f0, -48($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 1
beq_cont.28444:
beq_cont.28440:
	j	beq_cont.28428
beq_else.28427:
	addi	$v0, $zero, 0
beq_cont.28428:
	bne	$zero, $v0, beq_else.28445
	lw	$a0, 0($sp)
	flw	$f0, 8($a0)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28447
	addi	$v0, $zero, 1
	j	fbt_cont.28448
fbt_else.28447:
	addi	$v0, $zero, 0
fbt_cont.28448:
	bne	$zero, $v0, beq_else.28449
	lw	$v0, -36($sp)
	lw	$v1, 16($v0)
	lw	$v0, 24($v0)
	flw	$f0, 8($a0)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28451
	addi	$a1, $zero, 0
	j	fbt_cont.28452
fbt_else.28451:
	addi	$a1, $zero, 1
fbt_cont.28452:
	bne	$zero, $v0, beq_else.28453
	move	$v0, $a1
	j	beq_cont.28454
beq_else.28453:
	bne	$zero, $a1, beq_else.28455
	addi	$v0, $zero, 1
	j	beq_cont.28456
beq_else.28455:
	addi	$v0, $zero, 0
beq_cont.28456:
beq_cont.28454:
	flw	$f0, 8($v1)
	bne	$zero, $v0, beq_else.28457
	fneg	$f0, $f0
beq_else.28457:
beq_cont.28458:
	flw	$f1, -28($sp)
	fsub	$f0, $f0, $f1
	flw	$f1, 8($a0)
	fdiv	$f0, $f0, $f1
	flw	$f1, 0($a0)
	fmul	$f1, $f0, $f1
	flw	$f2, -24($sp)
	fadd	$f1, $f1, $f2
	fsw	$f0, -56($sp)
	sw	$v1, -60($sp)
	fmove	$f0, $f1
	sw	$ra, -64($sp)
	subi	$sp, $sp, 68
	jal	min_caml_fabs
	addi	$sp, $sp, 68
	lw	$ra, -64($sp)
	lw	$v0, -60($sp)
	flw	$f1, 0($v0)
	fle	$f1, $f0
	fbf	fbt_else.28459
	addi	$v1, $zero, 0
	j	fbt_cont.28460
fbt_else.28459:
	addi	$v1, $zero, 1
fbt_cont.28460:
	bne	$zero, $v1, beq_else.28461
	addi	$v0, $zero, 0
	j	beq_cont.28450
beq_else.28461:
	lw	$v1, 0($sp)
	flw	$f0, 4($v1)
	flw	$f1, -56($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -32($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -64($sp)
	subi	$sp, $sp, 68
	jal	min_caml_fabs
	addi	$sp, $sp, 68
	lw	$ra, -64($sp)
	lw	$v0, -60($sp)
	flw	$f1, 4($v0)
	fle	$f1, $f0
	fbf	fbt_else.28463
	addi	$v0, $zero, 0
	j	fbt_cont.28464
fbt_else.28463:
	addi	$v0, $zero, 1
fbt_cont.28464:
	bne	$zero, $v0, beq_else.28465
	addi	$v0, $zero, 0
	j	beq_cont.28450
beq_else.28465:
	lw	$v0, -20($sp)
	flw	$f0, -56($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 1
beq_cont.28466:
beq_cont.28462:
	j	beq_cont.28450
beq_else.28449:
	addi	$v0, $zero, 0
beq_cont.28450:
	bne	$zero, $v0, beq_else.28467
	addi	$v0, $zero, 0
	j	beq_cont.28402
beq_else.28467:
	addi	$v0, $zero, 3
beq_cont.28468:
	j	beq_cont.28402
beq_else.28445:
	addi	$v0, $zero, 2
beq_cont.28446:
	j	beq_cont.28402
beq_else.28423:
	addi	$v0, $zero, 1
beq_cont.28424:
	j	beq_cont.28402
beq_else.28401:
	addi	$t8, $zero, 2
	bne	$t8, $a3, beq_else.28469
	lw	$a2, 16($a2)
	flw	$f3, 0($a0)
	flw	$f4, 0($a2)
	fmul	$f3, $f3, $f4
	flw	$f4, 4($a0)
	flw	$f5, 4($a2)
	fmul	$f4, $f4, $f5
	fadd	$f3, $f3, $f4
	flw	$f4, 8($a0)
	flw	$f5, 8($a2)
	fmul	$f4, $f4, $f5
	fadd	$f3, $f3, $f4
	la	$t8, l.23884
	flw	$f4, 0($t8)
	fle	$f3, $f4
	fbf	fbt_else.28471
	addi	$a3, $zero, 0
	j	fbt_cont.28472
fbt_else.28471:
	addi	$a3, $zero, 1
fbt_cont.28472:
	bne	$zero, $a3, beq_else.28473
	addi	$v0, $zero, 0
	j	beq_cont.28470
beq_else.28473:
	flw	$f4, 0($a2)
	fmul	$f0, $f4, $f0
	flw	$f4, 4($a2)
	fmul	$f1, $f4, $f1
	fadd	$f0, $f0, $f1
	flw	$f1, 8($a2)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	fneg	$f0, $f0
	fdiv	$f0, $f0, $f3
	fsw	$f0, 0($t0)
	addi	$v0, $zero, 1
beq_cont.28474:
	j	beq_cont.28470
beq_else.28469:
	flw	$f3, 0($a0)
	flw	$f4, 4($a0)
	flw	$f5, 8($a0)
	fmul	$f6, $f3, $f3
	lw	$a3, 16($a2)
	flw	$f7, 0($a3)
	fmul	$f6, $f6, $f7
	fmul	$f7, $f4, $f4
	lw	$a3, 16($a2)
	flw	$f8, 4($a3)
	fmul	$f7, $f7, $f8
	fadd	$f6, $f6, $f7
	fmul	$f7, $f5, $f5
	lw	$a3, 16($a2)
	flw	$f8, 8($a3)
	fmul	$f7, $f7, $f8
	fadd	$f6, $f6, $f7
	lw	$a3, 12($a2)
	bne	$zero, $a3, beq_else.28475
	fmove	$f3, $f6
	j	beq_cont.28476
beq_else.28475:
	fmul	$f7, $f4, $f5
	lw	$a3, 36($a2)
	flw	$f8, 0($a3)
	fmul	$f7, $f7, $f8
	fadd	$f6, $f6, $f7
	fmul	$f5, $f5, $f3
	lw	$a3, 36($a2)
	flw	$f7, 4($a3)
	fmul	$f5, $f5, $f7
	fadd	$f5, $f6, $f5
	fmul	$f3, $f3, $f4
	lw	$a3, 36($a2)
	flw	$f4, 8($a3)
	fmul	$f3, $f3, $f4
	fadd	$f3, $f5, $f3
beq_cont.28476:
	la	$t8, l.23884
	flw	$f4, 0($t8)
	feq	$f3, $f4
	fbf	fbt_else.28477
	addi	$a3, $zero, 1
	j	fbt_cont.28478
fbt_else.28477:
	addi	$a3, $zero, 0
fbt_cont.28478:
	bne	$zero, $a3, beq_else.28479
	flw	$f4, 0($a0)
	flw	$f5, 4($a0)
	flw	$f6, 8($a0)
	fmul	$f7, $f4, $f0
	lw	$a3, 16($a2)
	flw	$f8, 0($a3)
	fmul	$f7, $f7, $f8
	fmul	$f8, $f5, $f1
	lw	$a3, 16($a2)
	flw	$f9, 4($a3)
	fmul	$f8, $f8, $f9
	fadd	$f7, $f7, $f8
	fmul	$f8, $f6, $f2
	lw	$a3, 16($a2)
	flw	$f9, 8($a3)
	fmul	$f8, $f8, $f9
	fadd	$f7, $f7, $f8
	lw	$a3, 12($a2)
	bne	$zero, $a3, beq_else.28481
	fmove	$f4, $f7
	j	beq_cont.28482
beq_else.28481:
	fmul	$f8, $f6, $f1
	fmul	$f9, $f5, $f2
	fadd	$f8, $f8, $f9
	lw	$a3, 36($a2)
	flw	$f9, 0($a3)
	fmul	$f8, $f8, $f9
	fmul	$f9, $f4, $f2
	fmul	$f6, $f6, $f0
	fadd	$f6, $f9, $f6
	lw	$a3, 36($a2)
	flw	$f9, 4($a3)
	fmul	$f6, $f6, $f9
	fadd	$f6, $f8, $f6
	fmul	$f4, $f4, $f1
	fmul	$f5, $f5, $f0
	fadd	$f4, $f4, $f5
	lw	$a3, 36($a2)
	flw	$f5, 8($a3)
	fmul	$f4, $f4, $f5
	fadd	$f4, $f6, $f4
	la	$t8, l.23876
	flw	$f5, 0($t8)
	fmul	$f4, $f4, $f5
	fadd	$f4, $f7, $f4
beq_cont.28482:
	fmul	$f5, $f0, $f0
	lw	$a3, 16($a2)
	flw	$f6, 0($a3)
	fmul	$f5, $f5, $f6
	fmul	$f6, $f1, $f1
	lw	$a3, 16($a2)
	flw	$f7, 4($a3)
	fmul	$f6, $f6, $f7
	fadd	$f5, $f5, $f6
	fmul	$f6, $f2, $f2
	lw	$a3, 16($a2)
	flw	$f7, 8($a3)
	fmul	$f6, $f6, $f7
	fadd	$f5, $f5, $f6
	lw	$a3, 12($a2)
	bne	$zero, $a3, beq_else.28483
	fmove	$f0, $f5
	j	beq_cont.28484
beq_else.28483:
	fmul	$f6, $f1, $f2
	lw	$a3, 36($a2)
	flw	$f7, 0($a3)
	fmul	$f6, $f6, $f7
	fadd	$f5, $f5, $f6
	fmul	$f2, $f2, $f0
	lw	$a3, 36($a2)
	flw	$f6, 4($a3)
	fmul	$f2, $f2, $f6
	fadd	$f2, $f5, $f2
	fmul	$f0, $f0, $f1
	lw	$a3, 36($a2)
	flw	$f1, 8($a3)
	fmul	$f0, $f0, $f1
	fadd	$f0, $f2, $f0
beq_cont.28484:
	lw	$a3, 4($a2)
	addi	$t8, $zero, 3
	bne	$t8, $a3, beq_else.28485
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fsub	$f0, $f0, $f1
beq_else.28485:
beq_cont.28486:
	fmul	$f1, $f4, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f1, $f0
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28487
	addi	$a3, $zero, 0
	j	fbt_cont.28488
fbt_else.28487:
	addi	$a3, $zero, 1
fbt_cont.28488:
	bne	$zero, $a3, beq_else.28489
	addi	$v0, $zero, 0
	j	beq_cont.28480
beq_else.28489:
	fsw	$f3, -64($sp)
	fsw	$f4, -68($sp)
	sw	$a2, -36($sp)
	sw	$ra, -72($sp)
	subi	$sp, $sp, 76
	jal	min_caml_sqrt
	addi	$sp, $sp, 76
	lw	$ra, -72($sp)
	lw	$v0, -36($sp)
	lw	$v0, 24($v0)
	bne	$zero, $v0, beq_else.28491
	fneg	$f0, $f0
beq_else.28491:
beq_cont.28492:
	flw	$f1, -68($sp)
	fsub	$f0, $f0, $f1
	flw	$f1, -64($sp)
	fdiv	$f0, $f0, $f1
	lw	$v0, -20($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 1
beq_cont.28490:
	j	beq_cont.28480
beq_else.28479:
	addi	$v0, $zero, 0
beq_cont.28480:
beq_cont.28470:
beq_cont.28402:
	bne	$zero, $v0, beq_else.28493
	j	beq_cont.28494
beq_else.28493:
	lw	$v0, -20($sp)
	flw	$f0, 0($v0)
	lw	$v0, -16($sp)
	flw	$f1, 0($v0)
	fle	$f1, $f0
	fbf	fbt_else.28495
	addi	$v0, $zero, 0
	j	fbt_cont.28496
fbt_else.28495:
	addi	$v0, $zero, 1
fbt_cont.28496:
	bne	$zero, $v0, beq_else.28497
	j	beq_cont.28498
beq_else.28497:
	addi	$v0, $zero, 1
	lw	$v1, -12($sp)
	lw	$a0, 0($sp)
	sw	$ra, -72($sp)
	subi	$sp, $sp, 76
	jal	solve_one_or_network.2901
	addi	$sp, $sp, 76
	lw	$ra, -72($sp)
beq_cont.28498:
beq_cont.28494:
beq_cont.28400:
	lw	$v0, -8($sp)
	addi	$v0, $v0, 1
	lw	$v1, -4($sp)
	lw	$a0, 0($sp)
	j	trace_or_matrix.2905
solve_each_element_fast.2911:
	lw	$a1, 0($a0)
	sll	$a2, $v0, 2
	add	$t8, $v1, $a2
	lw	$a2, 0($t8)
	lui	$a3, 512
	ori	$a3, $a3, 564
	lui	$t0, 512
	ori	$t0, $t0, 552
	lui	$t1, 512
	ori	$t1, $t1, 544
	lui	$t2, 512
	ori	$t2, $t2, 48
	lui	$t3, 512
	ori	$t3, $t3, 540
	lui	$t4, 512
	ori	$t4, $t4, 648
	lui	$t5, 512
	ori	$t5, $t5, 548
	addi	$t8, $zero, -1
	bne	$t8, $a2, beq_else.28499
	jr	$ra
beq_else.28499:
	sll	$t6, $a2, 2
	add	$t8, $t2, $t6
	lw	$t6, 0($t8)
	lw	$s0, 40($t6)
	flw	$f0, 0($s0)
	flw	$f1, 4($s0)
	flw	$f2, 8($s0)
	lw	$s1, 4($a0)
	sll	$s2, $a2, 2
	add	$t8, $s1, $s2
	lw	$s1, 0($t8)
	lw	$s2, 4($t6)
	sw	$t1, 0($sp)
	sw	$a3, -4($sp)
	sw	$t0, -8($sp)
	sw	$t4, -12($sp)
	sw	$a1, -16($sp)
	sw	$t5, -20($sp)
	sw	$t3, -24($sp)
	sw	$a0, -28($sp)
	sw	$v1, -32($sp)
	sw	$v0, -36($sp)
	sw	$t2, -40($sp)
	sw	$a2, -44($sp)
	addi	$t8, $zero, 1
	bne	$t8, $s2, beq_else.28501
	lw	$s0, 0($a0)
	flw	$f3, 0($s1)
	fsub	$f3, $f3, $f0
	flw	$f4, 4($s1)
	fmul	$f3, $f3, $f4
	flw	$f4, 4($s0)
	fmul	$f4, $f3, $f4
	fadd	$f4, $f4, $f1
	fsw	$f0, -48($sp)
	fsw	$f1, -52($sp)
	sw	$s1, -56($sp)
	fsw	$f2, -60($sp)
	fsw	$f3, -64($sp)
	sw	$s0, -68($sp)
	sw	$t6, -72($sp)
	fmove	$f0, $f4
	sw	$ra, -76($sp)
	subi	$sp, $sp, 80
	jal	min_caml_fabs
	addi	$sp, $sp, 80
	lw	$ra, -76($sp)
	lw	$v0, -72($sp)
	lw	$v1, 16($v0)
	flw	$f1, 4($v1)
	fle	$f1, $f0
	fbf	fbt_else.28503
	addi	$v1, $zero, 0
	j	fbt_cont.28504
fbt_else.28503:
	addi	$v1, $zero, 1
fbt_cont.28504:
	bne	$zero, $v1, beq_else.28505
	addi	$v1, $zero, 0
	j	beq_cont.28506
beq_else.28505:
	lw	$v1, -68($sp)
	flw	$f0, 8($v1)
	flw	$f1, -64($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -60($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -76($sp)
	subi	$sp, $sp, 80
	jal	min_caml_fabs
	addi	$sp, $sp, 80
	lw	$ra, -76($sp)
	lw	$v0, -72($sp)
	lw	$v1, 16($v0)
	flw	$f1, 8($v1)
	fle	$f1, $f0
	fbf	fbt_else.28507
	addi	$v1, $zero, 0
	j	fbt_cont.28508
fbt_else.28507:
	addi	$v1, $zero, 1
fbt_cont.28508:
	bne	$zero, $v1, beq_else.28509
	addi	$v1, $zero, 0
	j	beq_cont.28510
beq_else.28509:
	lw	$v1, -56($sp)
	flw	$f0, 4($v1)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28511
	addi	$a0, $zero, 1
	j	fbt_cont.28512
fbt_else.28511:
	addi	$a0, $zero, 0
fbt_cont.28512:
	bne	$zero, $a0, beq_else.28513
	addi	$v1, $zero, 1
	j	beq_cont.28514
beq_else.28513:
	addi	$v1, $zero, 0
beq_cont.28514:
beq_cont.28510:
beq_cont.28506:
	bne	$zero, $v1, beq_else.28515
	lw	$v1, -56($sp)
	flw	$f0, 8($v1)
	flw	$f1, -52($sp)
	fsub	$f0, $f0, $f1
	flw	$f2, 12($v1)
	fmul	$f0, $f0, $f2
	lw	$a0, -68($sp)
	flw	$f2, 0($a0)
	fmul	$f2, $f0, $f2
	flw	$f3, -48($sp)
	fadd	$f2, $f2, $f3
	fsw	$f0, -76($sp)
	fmove	$f0, $f2
	sw	$ra, -80($sp)
	subi	$sp, $sp, 84
	jal	min_caml_fabs
	addi	$sp, $sp, 84
	lw	$ra, -80($sp)
	lw	$v0, -72($sp)
	lw	$v1, 16($v0)
	flw	$f1, 0($v1)
	fle	$f1, $f0
	fbf	fbt_else.28517
	addi	$v1, $zero, 0
	j	fbt_cont.28518
fbt_else.28517:
	addi	$v1, $zero, 1
fbt_cont.28518:
	bne	$zero, $v1, beq_else.28519
	addi	$v1, $zero, 0
	j	beq_cont.28520
beq_else.28519:
	lw	$v1, -68($sp)
	flw	$f0, 8($v1)
	flw	$f1, -76($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -60($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -80($sp)
	subi	$sp, $sp, 84
	jal	min_caml_fabs
	addi	$sp, $sp, 84
	lw	$ra, -80($sp)
	lw	$v0, -72($sp)
	lw	$v1, 16($v0)
	flw	$f1, 8($v1)
	fle	$f1, $f0
	fbf	fbt_else.28521
	addi	$v1, $zero, 0
	j	fbt_cont.28522
fbt_else.28521:
	addi	$v1, $zero, 1
fbt_cont.28522:
	bne	$zero, $v1, beq_else.28523
	addi	$v1, $zero, 0
	j	beq_cont.28524
beq_else.28523:
	lw	$v1, -56($sp)
	flw	$f0, 12($v1)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28525
	addi	$a0, $zero, 1
	j	fbt_cont.28526
fbt_else.28525:
	addi	$a0, $zero, 0
fbt_cont.28526:
	bne	$zero, $a0, beq_else.28527
	addi	$v1, $zero, 1
	j	beq_cont.28528
beq_else.28527:
	addi	$v1, $zero, 0
beq_cont.28528:
beq_cont.28524:
beq_cont.28520:
	bne	$zero, $v1, beq_else.28529
	lw	$v1, -56($sp)
	flw	$f0, 16($v1)
	flw	$f1, -60($sp)
	fsub	$f0, $f0, $f1
	flw	$f1, 20($v1)
	fmul	$f0, $f0, $f1
	lw	$a0, -68($sp)
	flw	$f1, 0($a0)
	fmul	$f1, $f0, $f1
	flw	$f2, -48($sp)
	fadd	$f1, $f1, $f2
	fsw	$f0, -80($sp)
	fmove	$f0, $f1
	sw	$ra, -84($sp)
	subi	$sp, $sp, 88
	jal	min_caml_fabs
	addi	$sp, $sp, 88
	lw	$ra, -84($sp)
	lw	$v0, -72($sp)
	lw	$v1, 16($v0)
	flw	$f1, 0($v1)
	fle	$f1, $f0
	fbf	fbt_else.28531
	addi	$v1, $zero, 0
	j	fbt_cont.28532
fbt_else.28531:
	addi	$v1, $zero, 1
fbt_cont.28532:
	bne	$zero, $v1, beq_else.28533
	addi	$v0, $zero, 0
	j	beq_cont.28534
beq_else.28533:
	lw	$v1, -68($sp)
	flw	$f0, 4($v1)
	flw	$f1, -80($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -52($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -84($sp)
	subi	$sp, $sp, 88
	jal	min_caml_fabs
	addi	$sp, $sp, 88
	lw	$ra, -84($sp)
	lw	$v0, -72($sp)
	lw	$v0, 16($v0)
	flw	$f1, 4($v0)
	fle	$f1, $f0
	fbf	fbt_else.28535
	addi	$v0, $zero, 0
	j	fbt_cont.28536
fbt_else.28535:
	addi	$v0, $zero, 1
fbt_cont.28536:
	bne	$zero, $v0, beq_else.28537
	addi	$v0, $zero, 0
	j	beq_cont.28538
beq_else.28537:
	lw	$v0, -56($sp)
	flw	$f0, 20($v0)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28539
	addi	$v0, $zero, 1
	j	fbt_cont.28540
fbt_else.28539:
	addi	$v0, $zero, 0
fbt_cont.28540:
	bne	$zero, $v0, beq_else.28541
	addi	$v0, $zero, 1
	j	beq_cont.28542
beq_else.28541:
	addi	$v0, $zero, 0
beq_cont.28542:
beq_cont.28538:
beq_cont.28534:
	bne	$zero, $v0, beq_else.28543
	addi	$v0, $zero, 0
	j	beq_cont.28502
beq_else.28543:
	lw	$v0, -24($sp)
	flw	$f0, -80($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 3
beq_cont.28544:
	j	beq_cont.28502
beq_else.28529:
	lw	$v0, -24($sp)
	flw	$f0, -76($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 2
beq_cont.28530:
	j	beq_cont.28502
beq_else.28515:
	lw	$v0, -24($sp)
	flw	$f0, -64($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 1
beq_cont.28516:
	j	beq_cont.28502
beq_else.28501:
	addi	$t8, $zero, 2
	bne	$t8, $s2, beq_else.28545
	flw	$f0, 0($s1)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28547
	addi	$t6, $zero, 0
	j	fbt_cont.28548
fbt_else.28547:
	addi	$t6, $zero, 1
fbt_cont.28548:
	bne	$zero, $t6, beq_else.28549
	addi	$v0, $zero, 0
	j	beq_cont.28546
beq_else.28549:
	flw	$f0, 0($s1)
	flw	$f1, 12($s0)
	fmul	$f0, $f0, $f1
	fsw	$f0, 0($t3)
	addi	$v0, $zero, 1
beq_cont.28550:
	j	beq_cont.28546
beq_else.28545:
	flw	$f3, 0($s1)
	la	$t8, l.23884
	flw	$f4, 0($t8)
	feq	$f3, $f4
	fbf	fbt_else.28551
	addi	$s2, $zero, 1
	j	fbt_cont.28552
fbt_else.28551:
	addi	$s2, $zero, 0
fbt_cont.28552:
	bne	$zero, $s2, beq_else.28553
	flw	$f4, 4($s1)
	fmul	$f0, $f4, $f0
	flw	$f4, 8($s1)
	fmul	$f1, $f4, $f1
	fadd	$f0, $f0, $f1
	flw	$f1, 12($s1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	flw	$f1, 12($s0)
	fmul	$f2, $f0, $f0
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	la	$t8, l.23884
	flw	$f2, 0($t8)
	fle	$f1, $f2
	fbf	fbt_else.28555
	addi	$s0, $zero, 0
	j	fbt_cont.28556
fbt_else.28555:
	addi	$s0, $zero, 1
fbt_cont.28556:
	bne	$zero, $s0, beq_else.28557
	addi	$v0, $zero, 0
	j	beq_cont.28554
beq_else.28557:
	lw	$t6, 24($t6)
	bne	$zero, $t6, beq_else.28559
	sw	$s1, -56($sp)
	fsw	$f0, -84($sp)
	fmove	$f0, $f1
	sw	$ra, -88($sp)
	subi	$sp, $sp, 92
	jal	min_caml_sqrt
	addi	$sp, $sp, 92
	lw	$ra, -88($sp)
	flw	$f1, -84($sp)
	fsub	$f0, $f1, $f0
	lw	$v0, -56($sp)
	flw	$f1, 16($v0)
	fmul	$f0, $f0, $f1
	lw	$v0, -24($sp)
	fsw	$f0, 0($v0)
	j	beq_cont.28560
beq_else.28559:
	sw	$s1, -56($sp)
	fsw	$f0, -84($sp)
	fmove	$f0, $f1
	sw	$ra, -88($sp)
	subi	$sp, $sp, 92
	jal	min_caml_sqrt
	addi	$sp, $sp, 92
	lw	$ra, -88($sp)
	flw	$f1, -84($sp)
	fadd	$f0, $f1, $f0
	lw	$v0, -56($sp)
	flw	$f1, 16($v0)
	fmul	$f0, $f0, $f1
	lw	$v0, -24($sp)
	fsw	$f0, 0($v0)
beq_cont.28560:
	addi	$v0, $zero, 1
beq_cont.28558:
	j	beq_cont.28554
beq_else.28553:
	addi	$v0, $zero, 0
beq_cont.28554:
beq_cont.28546:
beq_cont.28502:
	bne	$zero, $v0, beq_else.28561
	lw	$v0, -44($sp)
	sll	$v0, $v0, 2
	lw	$v1, -40($sp)
	add	$t8, $v1, $v0
	lw	$v0, 0($t8)
	lw	$v0, 24($v0)
	bne	$zero, $v0, beq_else.28562
	jr	$ra
beq_else.28562:
	lw	$v0, -36($sp)
	addi	$v0, $v0, 1
	lw	$v1, -32($sp)
	lw	$a0, -28($sp)
	j	solve_each_element_fast.2911
beq_else.28561:
	lw	$v1, -24($sp)
	flw	$f0, 0($v1)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28564
	addi	$v1, $zero, 0
	j	fbt_cont.28565
fbt_else.28564:
	addi	$v1, $zero, 1
fbt_cont.28565:
	bne	$zero, $v1, beq_else.28566
	j	beq_cont.28567
beq_else.28566:
	lw	$v1, -20($sp)
	flw	$f1, 0($v1)
	fle	$f1, $f0
	fbf	fbt_else.28568
	addi	$a0, $zero, 0
	j	fbt_cont.28569
fbt_else.28568:
	addi	$a0, $zero, 1
fbt_cont.28569:
	bne	$zero, $a0, beq_else.28570
	j	beq_cont.28571
beq_else.28570:
	la	$t8, l.24185
	flw	$f1, 0($t8)
	fadd	$f0, $f0, $f1
	lw	$a0, -16($sp)
	flw	$f1, 0($a0)
	fmul	$f1, $f1, $f0
	lw	$a1, -12($sp)
	flw	$f2, 0($a1)
	fadd	$f1, $f1, $f2
	flw	$f2, 4($a0)
	fmul	$f2, $f2, $f0
	flw	$f3, 4($a1)
	fadd	$f2, $f2, $f3
	flw	$f3, 8($a0)
	fmul	$f3, $f3, $f0
	flw	$f4, 8($a1)
	fadd	$f3, $f3, $f4
	lw	$a0, -32($sp)
	sw	$v0, -88($sp)
	fsw	$f3, -92($sp)
	fsw	$f2, -96($sp)
	fsw	$f1, -100($sp)
	fsw	$f0, -104($sp)
	move	$v1, $a0
	move	$v0, $zero
	fmove	$f0, $f1
	fmove	$f1, $f2
	fmove	$f2, $f3
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	check_all_inside.2882
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	bne	$zero, $v0, beq_else.28572
	j	beq_cont.28573
beq_else.28572:
	lw	$v0, -20($sp)
	flw	$f0, -104($sp)
	fsw	$f0, 0($v0)
	lw	$v0, -8($sp)
	flw	$f0, -100($sp)
	fsw	$f0, 0($v0)
	flw	$f0, -96($sp)
	fsw	$f0, 4($v0)
	flw	$f0, -92($sp)
	fsw	$f0, 8($v0)
	lw	$v0, -4($sp)
	lw	$v1, -44($sp)
	sw	$v1, 0($v0)
	lw	$v0, 0($sp)
	lw	$v1, -88($sp)
	sw	$v1, 0($v0)
beq_cont.28573:
beq_cont.28571:
beq_cont.28567:
	lw	$v0, -36($sp)
	addi	$v0, $v0, 1
	lw	$v1, -32($sp)
	lw	$a0, -28($sp)
	j	solve_each_element_fast.2911
solve_one_or_network_fast.2915:
	sll	$a1, $v0, 2
	add	$t8, $v1, $a1
	lw	$a1, 0($t8)
	lui	$a2, 512
	ori	$a2, $a2, 332
	addi	$t8, $zero, -1
	bne	$t8, $a1, beq_else.28574
	jr	$ra
beq_else.28574:
	sll	$a1, $a1, 2
	add	$t8, $a2, $a1
	lw	$a1, 0($t8)
	sw	$a0, 0($sp)
	sw	$v1, -4($sp)
	sw	$v0, -8($sp)
	move	$v1, $a1
	move	$v0, $zero
	sw	$ra, -12($sp)
	subi	$sp, $sp, 16
	jal	solve_each_element_fast.2911
	addi	$sp, $sp, 16
	lw	$ra, -12($sp)
	lw	$v0, -8($sp)
	addi	$v0, $v0, 1
	lw	$v1, -4($sp)
	lw	$a0, 0($sp)
	j	solve_one_or_network_fast.2915
trace_or_matrix_fast.2919:
	sll	$a1, $v0, 2
	add	$t8, $v1, $a1
	lw	$a1, 0($t8)
	lw	$a2, 0($a1)
	lui	$a3, 512
	ori	$a3, $a3, 48
	lui	$t0, 512
	ori	$t0, $t0, 540
	lui	$t1, 512
	ori	$t1, $t1, 548
	addi	$t8, $zero, -1
	bne	$t8, $a2, beq_else.28576
	jr	$ra
beq_else.28576:
	sw	$a0, 0($sp)
	sw	$v1, -4($sp)
	sw	$v0, -8($sp)
	addi	$t8, $zero, 99
	bne	$t8, $a2, beq_else.28578
	addi	$a2, $zero, 1
	move	$v1, $a1
	move	$v0, $a2
	sw	$ra, -12($sp)
	subi	$sp, $sp, 16
	jal	solve_one_or_network_fast.2915
	addi	$sp, $sp, 16
	lw	$ra, -12($sp)
	j	beq_cont.28579
beq_else.28578:
	sll	$t2, $a2, 2
	add	$t8, $a3, $t2
	lw	$a3, 0($t8)
	lw	$t2, 40($a3)
	flw	$f0, 0($t2)
	flw	$f1, 4($t2)
	flw	$f2, 8($t2)
	lw	$t3, 4($a0)
	sll	$a2, $a2, 2
	add	$t8, $t3, $a2
	lw	$a2, 0($t8)
	lw	$t3, 4($a3)
	sw	$a1, -12($sp)
	sw	$t1, -16($sp)
	sw	$t0, -20($sp)
	addi	$t8, $zero, 1
	bne	$t8, $t3, beq_else.28580
	lw	$t2, 0($a0)
	flw	$f3, 0($a2)
	fsub	$f3, $f3, $f0
	flw	$f4, 4($a2)
	fmul	$f3, $f3, $f4
	flw	$f4, 4($t2)
	fmul	$f4, $f3, $f4
	fadd	$f4, $f4, $f1
	fsw	$f0, -24($sp)
	fsw	$f1, -28($sp)
	sw	$a2, -32($sp)
	fsw	$f2, -36($sp)
	fsw	$f3, -40($sp)
	sw	$t2, -44($sp)
	sw	$a3, -48($sp)
	fmove	$f0, $f4
	sw	$ra, -52($sp)
	subi	$sp, $sp, 56
	jal	min_caml_fabs
	addi	$sp, $sp, 56
	lw	$ra, -52($sp)
	lw	$v0, -48($sp)
	lw	$v1, 16($v0)
	flw	$f1, 4($v1)
	fle	$f1, $f0
	fbf	fbt_else.28582
	addi	$v1, $zero, 0
	j	fbt_cont.28583
fbt_else.28582:
	addi	$v1, $zero, 1
fbt_cont.28583:
	bne	$zero, $v1, beq_else.28584
	addi	$v1, $zero, 0
	j	beq_cont.28585
beq_else.28584:
	lw	$v1, -44($sp)
	flw	$f0, 8($v1)
	flw	$f1, -40($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -36($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -52($sp)
	subi	$sp, $sp, 56
	jal	min_caml_fabs
	addi	$sp, $sp, 56
	lw	$ra, -52($sp)
	lw	$v0, -48($sp)
	lw	$v1, 16($v0)
	flw	$f1, 8($v1)
	fle	$f1, $f0
	fbf	fbt_else.28586
	addi	$v1, $zero, 0
	j	fbt_cont.28587
fbt_else.28586:
	addi	$v1, $zero, 1
fbt_cont.28587:
	bne	$zero, $v1, beq_else.28588
	addi	$v1, $zero, 0
	j	beq_cont.28589
beq_else.28588:
	lw	$v1, -32($sp)
	flw	$f0, 4($v1)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28590
	addi	$a0, $zero, 1
	j	fbt_cont.28591
fbt_else.28590:
	addi	$a0, $zero, 0
fbt_cont.28591:
	bne	$zero, $a0, beq_else.28592
	addi	$v1, $zero, 1
	j	beq_cont.28593
beq_else.28592:
	addi	$v1, $zero, 0
beq_cont.28593:
beq_cont.28589:
beq_cont.28585:
	bne	$zero, $v1, beq_else.28594
	lw	$v1, -32($sp)
	flw	$f0, 8($v1)
	flw	$f1, -28($sp)
	fsub	$f0, $f0, $f1
	flw	$f2, 12($v1)
	fmul	$f0, $f0, $f2
	lw	$a0, -44($sp)
	flw	$f2, 0($a0)
	fmul	$f2, $f0, $f2
	flw	$f3, -24($sp)
	fadd	$f2, $f2, $f3
	fsw	$f0, -52($sp)
	fmove	$f0, $f2
	sw	$ra, -56($sp)
	subi	$sp, $sp, 60
	jal	min_caml_fabs
	addi	$sp, $sp, 60
	lw	$ra, -56($sp)
	lw	$v0, -48($sp)
	lw	$v1, 16($v0)
	flw	$f1, 0($v1)
	fle	$f1, $f0
	fbf	fbt_else.28596
	addi	$v1, $zero, 0
	j	fbt_cont.28597
fbt_else.28596:
	addi	$v1, $zero, 1
fbt_cont.28597:
	bne	$zero, $v1, beq_else.28598
	addi	$v1, $zero, 0
	j	beq_cont.28599
beq_else.28598:
	lw	$v1, -44($sp)
	flw	$f0, 8($v1)
	flw	$f1, -52($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -36($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -56($sp)
	subi	$sp, $sp, 60
	jal	min_caml_fabs
	addi	$sp, $sp, 60
	lw	$ra, -56($sp)
	lw	$v0, -48($sp)
	lw	$v1, 16($v0)
	flw	$f1, 8($v1)
	fle	$f1, $f0
	fbf	fbt_else.28600
	addi	$v1, $zero, 0
	j	fbt_cont.28601
fbt_else.28600:
	addi	$v1, $zero, 1
fbt_cont.28601:
	bne	$zero, $v1, beq_else.28602
	addi	$v1, $zero, 0
	j	beq_cont.28603
beq_else.28602:
	lw	$v1, -32($sp)
	flw	$f0, 12($v1)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28604
	addi	$a0, $zero, 1
	j	fbt_cont.28605
fbt_else.28604:
	addi	$a0, $zero, 0
fbt_cont.28605:
	bne	$zero, $a0, beq_else.28606
	addi	$v1, $zero, 1
	j	beq_cont.28607
beq_else.28606:
	addi	$v1, $zero, 0
beq_cont.28607:
beq_cont.28603:
beq_cont.28599:
	bne	$zero, $v1, beq_else.28608
	lw	$v1, -32($sp)
	flw	$f0, 16($v1)
	flw	$f1, -36($sp)
	fsub	$f0, $f0, $f1
	flw	$f1, 20($v1)
	fmul	$f0, $f0, $f1
	lw	$a0, -44($sp)
	flw	$f1, 0($a0)
	fmul	$f1, $f0, $f1
	flw	$f2, -24($sp)
	fadd	$f1, $f1, $f2
	fsw	$f0, -56($sp)
	fmove	$f0, $f1
	sw	$ra, -60($sp)
	subi	$sp, $sp, 64
	jal	min_caml_fabs
	addi	$sp, $sp, 64
	lw	$ra, -60($sp)
	lw	$v0, -48($sp)
	lw	$v1, 16($v0)
	flw	$f1, 0($v1)
	fle	$f1, $f0
	fbf	fbt_else.28610
	addi	$v1, $zero, 0
	j	fbt_cont.28611
fbt_else.28610:
	addi	$v1, $zero, 1
fbt_cont.28611:
	bne	$zero, $v1, beq_else.28612
	addi	$v0, $zero, 0
	j	beq_cont.28613
beq_else.28612:
	lw	$v1, -44($sp)
	flw	$f0, 4($v1)
	flw	$f1, -56($sp)
	fmul	$f0, $f1, $f0
	flw	$f2, -28($sp)
	fadd	$f0, $f0, $f2
	sw	$ra, -60($sp)
	subi	$sp, $sp, 64
	jal	min_caml_fabs
	addi	$sp, $sp, 64
	lw	$ra, -60($sp)
	lw	$v0, -48($sp)
	lw	$v0, 16($v0)
	flw	$f1, 4($v0)
	fle	$f1, $f0
	fbf	fbt_else.28614
	addi	$v0, $zero, 0
	j	fbt_cont.28615
fbt_else.28614:
	addi	$v0, $zero, 1
fbt_cont.28615:
	bne	$zero, $v0, beq_else.28616
	addi	$v0, $zero, 0
	j	beq_cont.28617
beq_else.28616:
	lw	$v0, -32($sp)
	flw	$f0, 20($v0)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28618
	addi	$v0, $zero, 1
	j	fbt_cont.28619
fbt_else.28618:
	addi	$v0, $zero, 0
fbt_cont.28619:
	bne	$zero, $v0, beq_else.28620
	addi	$v0, $zero, 1
	j	beq_cont.28621
beq_else.28620:
	addi	$v0, $zero, 0
beq_cont.28621:
beq_cont.28617:
beq_cont.28613:
	bne	$zero, $v0, beq_else.28622
	addi	$v0, $zero, 0
	j	beq_cont.28581
beq_else.28622:
	lw	$v0, -20($sp)
	flw	$f0, -56($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 3
beq_cont.28623:
	j	beq_cont.28581
beq_else.28608:
	lw	$v0, -20($sp)
	flw	$f0, -52($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 2
beq_cont.28609:
	j	beq_cont.28581
beq_else.28594:
	lw	$v0, -20($sp)
	flw	$f0, -40($sp)
	fsw	$f0, 0($v0)
	addi	$v0, $zero, 1
beq_cont.28595:
	j	beq_cont.28581
beq_else.28580:
	addi	$t8, $zero, 2
	bne	$t8, $t3, beq_else.28624
	flw	$f0, 0($a2)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28626
	addi	$a3, $zero, 0
	j	fbt_cont.28627
fbt_else.28626:
	addi	$a3, $zero, 1
fbt_cont.28627:
	bne	$zero, $a3, beq_else.28628
	addi	$v0, $zero, 0
	j	beq_cont.28625
beq_else.28628:
	flw	$f0, 0($a2)
	flw	$f1, 12($t2)
	fmul	$f0, $f0, $f1
	fsw	$f0, 0($t0)
	addi	$v0, $zero, 1
beq_cont.28629:
	j	beq_cont.28625
beq_else.28624:
	flw	$f3, 0($a2)
	la	$t8, l.23884
	flw	$f4, 0($t8)
	feq	$f3, $f4
	fbf	fbt_else.28630
	addi	$t3, $zero, 1
	j	fbt_cont.28631
fbt_else.28630:
	addi	$t3, $zero, 0
fbt_cont.28631:
	bne	$zero, $t3, beq_else.28632
	flw	$f4, 4($a2)
	fmul	$f0, $f4, $f0
	flw	$f4, 8($a2)
	fmul	$f1, $f4, $f1
	fadd	$f0, $f0, $f1
	flw	$f1, 12($a2)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	flw	$f1, 12($t2)
	fmul	$f2, $f0, $f0
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	la	$t8, l.23884
	flw	$f2, 0($t8)
	fle	$f1, $f2
	fbf	fbt_else.28634
	addi	$t2, $zero, 0
	j	fbt_cont.28635
fbt_else.28634:
	addi	$t2, $zero, 1
fbt_cont.28635:
	bne	$zero, $t2, beq_else.28636
	addi	$v0, $zero, 0
	j	beq_cont.28633
beq_else.28636:
	lw	$a3, 24($a3)
	bne	$zero, $a3, beq_else.28638
	sw	$a2, -32($sp)
	fsw	$f0, -60($sp)
	fmove	$f0, $f1
	sw	$ra, -64($sp)
	subi	$sp, $sp, 68
	jal	min_caml_sqrt
	addi	$sp, $sp, 68
	lw	$ra, -64($sp)
	flw	$f1, -60($sp)
	fsub	$f0, $f1, $f0
	lw	$v0, -32($sp)
	flw	$f1, 16($v0)
	fmul	$f0, $f0, $f1
	lw	$v0, -20($sp)
	fsw	$f0, 0($v0)
	j	beq_cont.28639
beq_else.28638:
	sw	$a2, -32($sp)
	fsw	$f0, -60($sp)
	fmove	$f0, $f1
	sw	$ra, -64($sp)
	subi	$sp, $sp, 68
	jal	min_caml_sqrt
	addi	$sp, $sp, 68
	lw	$ra, -64($sp)
	flw	$f1, -60($sp)
	fadd	$f0, $f1, $f0
	lw	$v0, -32($sp)
	flw	$f1, 16($v0)
	fmul	$f0, $f0, $f1
	lw	$v0, -20($sp)
	fsw	$f0, 0($v0)
beq_cont.28639:
	addi	$v0, $zero, 1
beq_cont.28637:
	j	beq_cont.28633
beq_else.28632:
	addi	$v0, $zero, 0
beq_cont.28633:
beq_cont.28625:
beq_cont.28581:
	bne	$zero, $v0, beq_else.28640
	j	beq_cont.28641
beq_else.28640:
	lw	$v0, -20($sp)
	flw	$f0, 0($v0)
	lw	$v0, -16($sp)
	flw	$f1, 0($v0)
	fle	$f1, $f0
	fbf	fbt_else.28642
	addi	$v0, $zero, 0
	j	fbt_cont.28643
fbt_else.28642:
	addi	$v0, $zero, 1
fbt_cont.28643:
	bne	$zero, $v0, beq_else.28644
	j	beq_cont.28645
beq_else.28644:
	addi	$v0, $zero, 1
	lw	$v1, -12($sp)
	lw	$a0, 0($sp)
	sw	$ra, -64($sp)
	subi	$sp, $sp, 68
	jal	solve_one_or_network_fast.2915
	addi	$sp, $sp, 68
	lw	$ra, -64($sp)
beq_cont.28645:
beq_cont.28641:
beq_cont.28579:
	lw	$v0, -8($sp)
	addi	$v0, $v0, 1
	lw	$v1, -4($sp)
	lw	$a0, 0($sp)
	j	trace_or_matrix_fast.2919
trace_reflections.2941:
	lui	$a0, 512
	ori	$a0, $a0, 564
	lui	$a1, 512
	ori	$a1, $a1, 544
	lui	$a2, 512
	ori	$a2, $a2, 568
	lui	$a3, 512
	ori	$a3, $a3, 536
	lui	$t0, 512
	ori	$t0, $t0, 1016
	lui	$t1, 512
	ori	$t1, $t1, 604
	lui	$t2, 512
	ori	$t2, $t2, 580
	lui	$t3, 512
	ori	$t3, $t3, 548
	slti	$t8, $v0, 0
	bne	$t8, $zero, beq_else.28646
	sll	$t4, $v0, 2
	add	$t8, $t0, $t4
	lw	$t0, 0($t8)
	lw	$t4, 4($t0)
	la	$t8, l.24517
	flw	$f2, 0($t8)
	fsw	$f2, 0($t3)
	lw	$t5, 0($a3)
	sw	$v0, 0($sp)
	fsw	$f1, -4($sp)
	sw	$t2, -8($sp)
	sw	$t1, -12($sp)
	sw	$v1, -16($sp)
	fsw	$f0, -20($sp)
	sw	$a2, -24($sp)
	sw	$t4, -28($sp)
	sw	$a3, -32($sp)
	sw	$t0, -36($sp)
	sw	$a1, -40($sp)
	sw	$a0, -44($sp)
	sw	$t3, -48($sp)
	move	$a0, $t4
	move	$v1, $t5
	move	$v0, $zero
	sw	$ra, -52($sp)
	subi	$sp, $sp, 56
	jal	trace_or_matrix_fast.2919
	addi	$sp, $sp, 56
	lw	$ra, -52($sp)
	lw	$v0, -48($sp)
	flw	$f0, 0($v0)
	la	$t8, l.24249
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28647
	addi	$v0, $zero, 0
	j	fbt_cont.28648
fbt_else.28647:
	addi	$v0, $zero, 1
fbt_cont.28648:
	bne	$zero, $v0, beq_else.28649
	addi	$v0, $zero, 0
	j	beq_cont.28650
beq_else.28649:
	la	$t8, l.24521
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28651
	addi	$v0, $zero, 0
	j	fbt_cont.28652
fbt_else.28651:
	addi	$v0, $zero, 1
fbt_cont.28652:
beq_cont.28650:
	bne	$zero, $v0, beq_else.28653
	j	beq_cont.28654
beq_else.28653:
	lw	$v0, -44($sp)
	lw	$v0, 0($v0)
	sll	$v0, $v0, 2
	lw	$v1, -40($sp)
	lw	$v1, 0($v1)
	add	$v0, $v0, $v1
	lw	$v1, -36($sp)
	lw	$a0, 0($v1)
	bne	$v0, $a0, beq_else.28655
	lw	$v0, -32($sp)
	lw	$v0, 0($v0)
	move	$v1, $v0
	move	$v0, $zero
	sw	$ra, -52($sp)
	subi	$sp, $sp, 56
	jal	shadow_check_one_or_matrix.2894
	addi	$sp, $sp, 56
	lw	$ra, -52($sp)
	bne	$zero, $v0, beq_else.28657
	lw	$v0, -28($sp)
	lw	$v1, 0($v0)
	lw	$a0, -24($sp)
	flw	$f0, 0($a0)
	flw	$f1, 0($v1)
	fmul	$f0, $f0, $f1
	flw	$f1, 4($a0)
	flw	$f2, 4($v1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	flw	$f1, 8($a0)
	flw	$f2, 8($v1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	lw	$v1, -36($sp)
	flw	$f1, 8($v1)
	flw	$f2, -20($sp)
	fmul	$f3, $f1, $f2
	fmul	$f0, $f3, $f0
	lw	$v0, 0($v0)
	lw	$v1, -16($sp)
	flw	$f3, 0($v1)
	flw	$f4, 0($v0)
	fmul	$f3, $f3, $f4
	flw	$f4, 4($v1)
	flw	$f5, 4($v0)
	fmul	$f4, $f4, $f5
	fadd	$f3, $f3, $f4
	flw	$f4, 8($v1)
	flw	$f5, 8($v0)
	fmul	$f4, $f4, $f5
	fadd	$f3, $f3, $f4
	fmul	$f1, $f1, $f3
	la	$t8, l.23884
	flw	$f3, 0($t8)
	fle	$f0, $f3
	fbf	fbt_else.28659
	addi	$v0, $zero, 0
	j	fbt_cont.28660
fbt_else.28659:
	addi	$v0, $zero, 1
fbt_cont.28660:
	bne	$zero, $v0, beq_else.28661
	j	beq_cont.28662
beq_else.28661:
	lw	$v0, -12($sp)
	flw	$f3, 0($v0)
	lw	$a0, -8($sp)
	flw	$f4, 0($a0)
	fmul	$f4, $f0, $f4
	fadd	$f3, $f3, $f4
	fsw	$f3, 0($v0)
	flw	$f3, 4($v0)
	flw	$f4, 4($a0)
	fmul	$f4, $f0, $f4
	fadd	$f3, $f3, $f4
	fsw	$f3, 4($v0)
	flw	$f3, 8($v0)
	flw	$f4, 8($a0)
	fmul	$f0, $f0, $f4
	fadd	$f0, $f3, $f0
	fsw	$f0, 8($v0)
beq_cont.28662:
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28663
	addi	$v0, $zero, 0
	j	fbt_cont.28664
fbt_else.28663:
	addi	$v0, $zero, 1
fbt_cont.28664:
	bne	$zero, $v0, beq_else.28665
	j	beq_cont.28666
beq_else.28665:
	fmul	$f0, $f1, $f1
	fmul	$f0, $f0, $f0
	flw	$f1, -4($sp)
	fmul	$f0, $f0, $f1
	lw	$v0, -12($sp)
	flw	$f3, 0($v0)
	fadd	$f3, $f3, $f0
	fsw	$f3, 0($v0)
	flw	$f3, 4($v0)
	fadd	$f3, $f3, $f0
	fsw	$f3, 4($v0)
	flw	$f3, 8($v0)
	fadd	$f0, $f3, $f0
	fsw	$f0, 8($v0)
beq_cont.28666:
beq_else.28657:
beq_cont.28658:
beq_else.28655:
beq_cont.28656:
beq_cont.28654:
	lw	$v0, 0($sp)
	subi	$v0, $v0, 1
	flw	$f0, -20($sp)
	flw	$f1, -4($sp)
	lw	$v1, -16($sp)
	j	trace_reflections.2941
beq_else.28646:
	jr	$ra
trace_ray.2946:
	lui	$a1, 512
	ori	$a1, $a1, 324
	lui	$a2, 512
	ori	$a2, $a2, 564
	lui	$a3, 512
	ori	$a3, $a3, 552
	lui	$t0, 512
	ori	$t0, $t0, 544
	lui	$t1, 512
	ori	$t1, $t1, 312
	lui	$t2, 512
	lui	$t3, 512
	ori	$t3, $t3, 1736
	lui	$t4, 512
	ori	$t4, $t4, 568
	lui	$t5, 512
	ori	$t5, $t5, 48
	lui	$t6, 512
	ori	$t6, $t6, 536
	la	$t8, l.23883
	flw	$f2, 0($t8)
	lui	$s0, 512
	ori	$s0, $s0, 604
	lui	$s1, 512
	ori	$s1, $s1, 636
	lui	$s2, 512
	ori	$s2, $s2, 648
	lui	$s3, 512
	ori	$s3, $s3, 580
	lui	$s4, 512
	ori	$s4, $s4, 548
	sgti	$t8, $v0, 4
	bne	$t8, $zero, beq_else.28668
	lw	$s5, 8($a0)
	la	$t8, l.24517
	flw	$f3, 0($t8)
	fsw	$f3, 0($s4)
	lw	$s6, 0($t6)
	fsw	$f1, 0($sp)
	sw	$t3, -4($sp)
	sw	$t2, -8($sp)
	sw	$s2, -12($sp)
	sw	$t6, -16($sp)
	sw	$a0, -20($sp)
	fsw	$f2, -24($sp)
	sw	$s3, -28($sp)
	sw	$s1, -32($sp)
	sw	$a3, -36($sp)
	sw	$t4, -40($sp)
	sw	$t0, -44($sp)
	sw	$t5, -48($sp)
	sw	$a2, -52($sp)
	sw	$s0, -56($sp)
	sw	$a1, -60($sp)
	fsw	$f0, -64($sp)
	sw	$t1, -68($sp)
	sw	$v1, -72($sp)
	sw	$s5, -76($sp)
	sw	$v0, -80($sp)
	sw	$s4, -84($sp)
	move	$a0, $v1
	move	$v0, $zero
	move	$v1, $s6
	sw	$ra, -88($sp)
	subi	$sp, $sp, 92
	jal	trace_or_matrix.2905
	addi	$sp, $sp, 92
	lw	$ra, -88($sp)
	lw	$v0, -84($sp)
	flw	$f0, 0($v0)
	la	$t8, l.24249
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28669
	addi	$v1, $zero, 0
	j	fbt_cont.28670
fbt_else.28669:
	addi	$v1, $zero, 1
fbt_cont.28670:
	bne	$zero, $v1, beq_else.28671
	addi	$v1, $zero, 0
	j	beq_cont.28672
beq_else.28671:
	la	$t8, l.24521
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28673
	addi	$v1, $zero, 0
	j	fbt_cont.28674
fbt_else.28673:
	addi	$v1, $zero, 1
fbt_cont.28674:
beq_cont.28672:
	bne	$zero, $v1, beq_else.28675
	addi	$v0, $zero, -1
	lw	$v1, -80($sp)
	sll	$a0, $v1, 2
	lw	$a1, -76($sp)
	add	$t8, $a1, $a0
	sw	$v0, 0($t8)
	bne	$zero, $v1, beq_else.28676
	jr	$ra
beq_else.28676:
	lw	$v0, -72($sp)
	flw	$f0, 0($v0)
	lw	$v1, -68($sp)
	flw	$f1, 0($v1)
	fmul	$f0, $f0, $f1
	flw	$f1, 4($v0)
	flw	$f2, 4($v1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	flw	$f1, 8($v0)
	flw	$f2, 8($v1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	fneg	$f0, $f0
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28678
	addi	$v0, $zero, 0
	j	fbt_cont.28679
fbt_else.28678:
	addi	$v0, $zero, 1
fbt_cont.28679:
	bne	$zero, $v0, beq_else.28680
	jr	$ra
beq_else.28680:
	fmul	$f1, $f0, $f0
	fmul	$f0, $f1, $f0
	flw	$f1, -64($sp)
	fmul	$f0, $f0, $f1
	lw	$v0, -60($sp)
	flw	$f1, 0($v0)
	fmul	$f0, $f0, $f1
	lw	$v0, -56($sp)
	flw	$f1, 0($v0)
	fadd	$f1, $f1, $f0
	fsw	$f1, 0($v0)
	flw	$f1, 4($v0)
	fadd	$f1, $f1, $f0
	fsw	$f1, 4($v0)
	flw	$f1, 8($v0)
	fadd	$f0, $f1, $f0
	fsw	$f0, 8($v0)
	jr	$ra
beq_else.28675:
	lw	$v1, -52($sp)
	lw	$v1, 0($v1)
	sll	$a0, $v1, 2
	lw	$a1, -48($sp)
	add	$t8, $a1, $a0
	lw	$a0, 0($t8)
	lw	$a1, 8($a0)
	lw	$a2, 28($a0)
	flw	$f0, 0($a2)
	flw	$f1, -64($sp)
	fmul	$f0, $f0, $f1
	lw	$a2, 4($a0)
	sw	$a1, -88($sp)
	fsw	$f0, -92($sp)
	sw	$v1, -96($sp)
	sw	$a0, -100($sp)
	addi	$t8, $zero, 1
	bne	$t8, $a2, beq_else.28683
	lw	$a2, -44($sp)
	lw	$a3, 0($a2)
	la	$t8, l.23884
	flw	$f2, 0($t8)
	lw	$t0, -40($sp)
	fsw	$f2, 0($t0)
	fsw	$f2, 4($t0)
	fsw	$f2, 8($t0)
	subi	$t1, $a3, 1
	subi	$a3, $a3, 1
	sll	$a3, $a3, 2
	lw	$t2, -72($sp)
	add	$t8, $t2, $a3
	flw	$f2, 0($t8)
	la	$t8, l.23884
	flw	$f3, 0($t8)
	feq	$f2, $f3
	fbf	fbt_else.28685
	addi	$a3, $zero, 1
	j	fbt_cont.28686
fbt_else.28685:
	addi	$a3, $zero, 0
fbt_cont.28686:
	bne	$zero, $a3, beq_else.28687
	la	$t8, l.23884
	flw	$f3, 0($t8)
	fle	$f2, $f3
	fbf	fbt_else.28689
	addi	$a3, $zero, 0
	j	fbt_cont.28690
fbt_else.28689:
	addi	$a3, $zero, 1
fbt_cont.28690:
	bne	$zero, $a3, beq_else.28691
	la	$t8, l.23917
	flw	$f2, 0($t8)
	j	beq_cont.28688
beq_else.28691:
	la	$t8, l.23916
	flw	$f2, 0($t8)
beq_cont.28692:
	j	beq_cont.28688
beq_else.28687:
	la	$t8, l.23884
	flw	$f2, 0($t8)
beq_cont.28688:
	fneg	$f2, $f2
	sll	$a3, $t1, 2
	add	$t8, $t0, $a3
	fsw	$f2, 0($t8)
	j	beq_cont.28684
beq_else.28683:
	addi	$t8, $zero, 2
	bne	$t8, $a2, beq_else.28693
	lw	$a2, 16($a0)
	flw	$f2, 0($a2)
	fneg	$f2, $f2
	lw	$a2, -40($sp)
	fsw	$f2, 0($a2)
	lw	$a3, 16($a0)
	flw	$f2, 4($a3)
	fneg	$f2, $f2
	fsw	$f2, 4($a2)
	lw	$a3, 16($a0)
	flw	$f2, 8($a3)
	fneg	$f2, $f2
	fsw	$f2, 8($a2)
	j	beq_cont.28694
beq_else.28693:
	lw	$a2, -36($sp)
	flw	$f2, 0($a2)
	lw	$a3, 20($a0)
	flw	$f3, 0($a3)
	fsub	$f2, $f2, $f3
	flw	$f3, 4($a2)
	lw	$a3, 20($a0)
	flw	$f4, 4($a3)
	fsub	$f3, $f3, $f4
	flw	$f4, 8($a2)
	lw	$a3, 20($a0)
	flw	$f5, 8($a3)
	fsub	$f4, $f4, $f5
	lw	$a3, 16($a0)
	flw	$f5, 0($a3)
	fmul	$f5, $f2, $f5
	lw	$a3, 16($a0)
	flw	$f6, 4($a3)
	fmul	$f6, $f3, $f6
	lw	$a3, 16($a0)
	flw	$f7, 8($a3)
	fmul	$f7, $f4, $f7
	lw	$a3, 12($a0)
	bne	$zero, $a3, beq_else.28695
	lw	$a3, -40($sp)
	fsw	$f5, 0($a3)
	fsw	$f6, 4($a3)
	fsw	$f7, 8($a3)
	j	beq_cont.28696
beq_else.28695:
	lw	$a3, 36($a0)
	flw	$f8, 8($a3)
	fmul	$f8, $f3, $f8
	lw	$a3, 36($a0)
	flw	$f9, 4($a3)
	fmul	$f9, $f4, $f9
	fadd	$f8, $f8, $f9
	la	$t8, l.23876
	flw	$f9, 0($t8)
	fmul	$f8, $f8, $f9
	fadd	$f5, $f5, $f8
	lw	$a3, -40($sp)
	fsw	$f5, 0($a3)
	lw	$t0, 36($a0)
	flw	$f5, 8($t0)
	fmul	$f5, $f2, $f5
	lw	$t0, 36($a0)
	flw	$f8, 0($t0)
	fmul	$f4, $f4, $f8
	fadd	$f4, $f5, $f4
	la	$t8, l.23876
	flw	$f5, 0($t8)
	fmul	$f4, $f4, $f5
	fadd	$f4, $f6, $f4
	fsw	$f4, 4($a3)
	lw	$t0, 36($a0)
	flw	$f4, 4($t0)
	fmul	$f2, $f2, $f4
	lw	$t0, 36($a0)
	flw	$f4, 0($t0)
	fmul	$f3, $f3, $f4
	fadd	$f2, $f2, $f3
	la	$t8, l.23876
	flw	$f3, 0($t8)
	fmul	$f2, $f2, $f3
	fadd	$f2, $f7, $f2
	fsw	$f2, 8($a3)
beq_cont.28696:
	lw	$t0, 24($a0)
	flw	$f2, 0($a3)
	fmul	$f2, $f2, $f2
	flw	$f3, 4($a3)
	fmul	$f3, $f3, $f3
	fadd	$f2, $f2, $f3
	flw	$f3, 8($a3)
	fmul	$f3, $f3, $f3
	fadd	$f2, $f2, $f3
	sw	$t0, -104($sp)
	fmove	$f0, $f2
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	min_caml_sqrt
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28697
	addi	$v0, $zero, 1
	j	fbt_cont.28698
fbt_else.28697:
	addi	$v0, $zero, 0
fbt_cont.28698:
	bne	$zero, $v0, beq_else.28699
	lw	$v0, -104($sp)
	bne	$zero, $v0, beq_else.28701
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fdiv	$f0, $f1, $f0
	j	beq_cont.28700
beq_else.28701:
	la	$t8, l.23917
	flw	$f1, 0($t8)
	fdiv	$f0, $f1, $f0
beq_cont.28702:
	j	beq_cont.28700
beq_else.28699:
	la	$t8, l.23916
	flw	$f0, 0($t8)
beq_cont.28700:
	lw	$v0, -40($sp)
	flw	$f1, 0($v0)
	fmul	$f1, $f1, $f0
	fsw	$f1, 0($v0)
	flw	$f1, 4($v0)
	fmul	$f1, $f1, $f0
	fsw	$f1, 4($v0)
	flw	$f1, 8($v0)
	fmul	$f0, $f1, $f0
	fsw	$f0, 8($v0)
beq_cont.28694:
beq_cont.28684:
	lw	$v0, -36($sp)
	flw	$f0, 0($v0)
	lw	$v1, -32($sp)
	fsw	$f0, 0($v1)
	flw	$f0, 4($v0)
	fsw	$f0, 4($v1)
	flw	$f0, 8($v0)
	fsw	$f0, 8($v1)
	lw	$v1, -100($sp)
	lw	$a0, 0($v1)
	lw	$a1, 32($v1)
	flw	$f0, 0($a1)
	lw	$a1, -28($sp)
	fsw	$f0, 0($a1)
	lw	$a2, 32($v1)
	flw	$f0, 4($a2)
	fsw	$f0, 4($a1)
	lw	$a2, 32($v1)
	flw	$f0, 8($a2)
	fsw	$f0, 8($a1)
	addi	$t8, $zero, 1
	bne	$t8, $a0, beq_else.28703
	flw	$f0, 0($v0)
	lw	$a0, 20($v1)
	flw	$f1, 0($a0)
	fsub	$f0, $f0, $f1
	la	$t8, l.24669
	flw	$f1, 0($t8)
	fmul	$f1, $f0, $f1
	fsw	$f0, -108($sp)
	fmove	$f0, $f1
	sw	$ra, -112($sp)
	subi	$sp, $sp, 116
	jal	min_caml_floor
	addi	$sp, $sp, 116
	lw	$ra, -112($sp)
	la	$t8, l.24670
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	flw	$f1, -108($sp)
	fsub	$f0, $f1, $f0
	la	$t8, l.24642
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28705
	addi	$v0, $zero, 0
	j	fbt_cont.28706
fbt_else.28705:
	addi	$v0, $zero, 1
fbt_cont.28706:
	lw	$v1, -36($sp)
	flw	$f0, 8($v1)
	lw	$a0, -100($sp)
	lw	$a1, 20($a0)
	flw	$f1, 8($a1)
	fsub	$f0, $f0, $f1
	la	$t8, l.24669
	flw	$f1, 0($t8)
	fmul	$f1, $f0, $f1
	sw	$v0, -112($sp)
	fsw	$f0, -116($sp)
	fmove	$f0, $f1
	sw	$ra, -120($sp)
	subi	$sp, $sp, 124
	jal	min_caml_floor
	addi	$sp, $sp, 124
	lw	$ra, -120($sp)
	la	$t8, l.24670
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	flw	$f1, -116($sp)
	fsub	$f0, $f1, $f0
	la	$t8, l.24642
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28707
	addi	$v0, $zero, 0
	j	fbt_cont.28708
fbt_else.28707:
	addi	$v0, $zero, 1
fbt_cont.28708:
	lw	$v1, -112($sp)
	bne	$zero, $v1, beq_else.28709
	bne	$zero, $v0, beq_else.28711
	la	$t8, l.24635
	flw	$f0, 0($t8)
	j	beq_cont.28710
beq_else.28711:
	la	$t8, l.23884
	flw	$f0, 0($t8)
beq_cont.28712:
	j	beq_cont.28710
beq_else.28709:
	bne	$zero, $v0, beq_else.28713
	la	$t8, l.23884
	flw	$f0, 0($t8)
	j	beq_cont.28714
beq_else.28713:
	la	$t8, l.24635
	flw	$f0, 0($t8)
beq_cont.28714:
beq_cont.28710:
	lw	$v0, -28($sp)
	fsw	$f0, 4($v0)
	j	beq_cont.28704
beq_else.28703:
	addi	$t8, $zero, 2
	bne	$t8, $a0, beq_else.28715
	flw	$f0, 4($v0)
	la	$t8, l.24658
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28717
	addi	$a0, $zero, 1
	j	fbt_cont.28718
fbt_else.28717:
	addi	$a0, $zero, 0
fbt_cont.28718:
	bne	$zero, $a0, beq_else.28719
	fneg	$f0, $f0
beq_else.28719:
beq_cont.28720:
	la	$t8, l.23875
	flw	$f1, 0($t8)
	sw	$a0, -120($sp)
	fsw	$f0, -124($sp)
	sw	$ra, -128($sp)
	subi	$sp, $sp, 132
	jal	adjust_exp.2562
	addi	$sp, $sp, 132
	lw	$ra, -128($sp)
	fmove	$f1, $f0
	flw	$f0, -124($sp)
	sw	$ra, -128($sp)
	subi	$sp, $sp, 132
	jal	sub_iter.2565
	addi	$sp, $sp, 132
	lw	$ra, -128($sp)
	flw	$f1, -24($sp)
	fle	$f1, $f0
	fbf	fbt_else.28721
	lw	$v0, -120($sp)
	bne	$zero, $v0, beq_else.28723
	addi	$v0, $zero, 1
	j	beq_cont.28724
beq_else.28723:
	addi	$v0, $zero, 0
beq_cont.28724:
	fsub	$f0, $f0, $f1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.28722
fbt_else.28721:
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	lw	$v1, -120($sp)
	sw	$v1, 0($v0)
fbt_cont.28722:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.28725
	fsub	$f0, $f1, $f0
fbt_else.28725:
fbt_cont.28726:
	la	$t8, l.23944
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28727
	bne	$zero, $v0, beq_else.28729
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	fneg	$f0, $f0
	j	fbt_cont.28728
beq_else.28729:
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
beq_cont.28730:
	j	fbt_cont.28728
fbt_else.28727:
	la	$t8, l.23937
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	bne	$zero, $v0, beq_else.28731
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
	fneg	$f0, $f0
	j	beq_cont.28732
beq_else.28731:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
beq_cont.28732:
fbt_cont.28728:
	fmul	$f0, $f0, $f0
	la	$t8, l.24635
	flw	$f1, 0($t8)
	fmul	$f1, $f1, $f0
	lw	$v0, -28($sp)
	fsw	$f1, 0($v0)
	la	$t8, l.24635
	flw	$f1, 0($t8)
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	fmul	$f0, $f1, $f0
	fsw	$f0, 4($v0)
	j	beq_cont.28716
beq_else.28715:
	addi	$t8, $zero, 3
	bne	$t8, $a0, beq_else.28733
	flw	$f0, 0($v0)
	lw	$a0, 20($v1)
	flw	$f1, 0($a0)
	fsub	$f0, $f0, $f1
	flw	$f1, 8($v0)
	lw	$a0, 20($v1)
	flw	$f2, 8($a0)
	fsub	$f1, $f1, $f2
	fmul	$f0, $f0, $f0
	fmul	$f1, $f1, $f1
	fadd	$f0, $f0, $f1
	sw	$ra, -128($sp)
	subi	$sp, $sp, 132
	jal	min_caml_sqrt
	addi	$sp, $sp, 132
	lw	$ra, -128($sp)
	la	$t8, l.24642
	flw	$f1, 0($t8)
	fdiv	$f0, $f0, $f1
	fsw	$f0, -128($sp)
	sw	$ra, -132($sp)
	subi	$sp, $sp, 136
	jal	min_caml_floor
	addi	$sp, $sp, 136
	lw	$ra, -132($sp)
	flw	$f1, -128($sp)
	fsub	$f0, $f1, $f0
	la	$t8, l.24630
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28735
	j	fbt_cont.28736
fbt_else.28735:
	fneg	$f0, $f0
fbt_cont.28736:
	la	$t8, l.23875
	flw	$f1, 0($t8)
	fsw	$f0, -132($sp)
	sw	$ra, -136($sp)
	subi	$sp, $sp, 140
	jal	adjust_exp.2562
	addi	$sp, $sp, 140
	lw	$ra, -136($sp)
	fmove	$f1, $f0
	flw	$f0, -132($sp)
	sw	$ra, -136($sp)
	subi	$sp, $sp, 140
	jal	sub_iter.2565
	addi	$sp, $sp, 140
	lw	$ra, -136($sp)
	flw	$f1, -24($sp)
	fle	$f1, $f0
	fbf	fbt_else.28737
	fsub	$f0, $f0, $f1
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	sw	$zero, 0($v0)
	j	fbt_cont.28738
fbt_else.28737:
	addi	$v0, $zero, 1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.28738:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.28739
	bne	$zero, $v0, beq_else.28741
	addi	$v0, $zero, 1
	j	beq_cont.28742
beq_else.28741:
	addi	$v0, $zero, 0
beq_cont.28742:
	fsub	$f0, $f1, $f0
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.28740
fbt_else.28739:
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.28740:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23944
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28743
	bne	$zero, $v0, beq_else.28745
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
	fneg	$f0, $f0
	j	fbt_cont.28744
beq_else.28745:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
beq_cont.28746:
	j	fbt_cont.28744
fbt_else.28743:
	la	$t8, l.23937
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	bne	$zero, $v0, beq_else.28747
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	fneg	$f0, $f0
	j	beq_cont.28748
beq_else.28747:
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
beq_cont.28748:
fbt_cont.28744:
	fmul	$f0, $f0, $f0
	la	$t8, l.24635
	flw	$f1, 0($t8)
	fmul	$f1, $f0, $f1
	lw	$v0, -28($sp)
	fsw	$f1, 4($v0)
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	la	$t8, l.24635
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	fsw	$f0, 8($v0)
	j	beq_cont.28734
beq_else.28733:
	addi	$t8, $zero, 4
	bne	$t8, $a0, beq_else.28749
	flw	$f0, 0($v0)
	lw	$a0, 20($v1)
	flw	$f1, 0($a0)
	fsub	$f0, $f0, $f1
	lw	$a0, 16($v1)
	flw	$f1, 0($a0)
	fsw	$f0, -136($sp)
	fmove	$f0, $f1
	sw	$ra, -140($sp)
	subi	$sp, $sp, 144
	jal	min_caml_sqrt
	addi	$sp, $sp, 144
	lw	$ra, -140($sp)
	flw	$f1, -136($sp)
	fmul	$f0, $f1, $f0
	lw	$v0, -36($sp)
	flw	$f1, 8($v0)
	lw	$v1, -100($sp)
	lw	$a0, 20($v1)
	flw	$f2, 8($a0)
	fsub	$f1, $f1, $f2
	lw	$a0, 16($v1)
	flw	$f2, 8($a0)
	fsw	$f0, -140($sp)
	fsw	$f1, -144($sp)
	fmove	$f0, $f2
	sw	$ra, -148($sp)
	subi	$sp, $sp, 152
	jal	min_caml_sqrt
	addi	$sp, $sp, 152
	lw	$ra, -148($sp)
	flw	$f1, -144($sp)
	fmul	$f0, $f1, $f0
	flw	$f1, -140($sp)
	fmul	$f2, $f1, $f1
	fmul	$f3, $f0, $f0
	fadd	$f2, $f2, $f3
	fsw	$f2, -148($sp)
	fsw	$f0, -152($sp)
	fmove	$f0, $f1
	sw	$ra, -156($sp)
	subi	$sp, $sp, 160
	jal	min_caml_fabs
	addi	$sp, $sp, 160
	lw	$ra, -156($sp)
	la	$t8, l.24618
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28751
	addi	$v0, $zero, 0
	j	fbt_cont.28752
fbt_else.28751:
	addi	$v0, $zero, 1
fbt_cont.28752:
	bne	$zero, $v0, beq_else.28753
	flw	$f0, -140($sp)
	flw	$f1, -152($sp)
	fdiv	$f0, $f1, $f0
	sw	$ra, -156($sp)
	subi	$sp, $sp, 160
	jal	min_caml_fabs
	addi	$sp, $sp, 160
	lw	$ra, -156($sp)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28755
	addi	$v0, $zero, 1
	j	fbt_cont.28756
fbt_else.28755:
	addi	$v0, $zero, 0
fbt_cont.28756:
	bne	$zero, $v0, beq_else.28757
	fneg	$f0, $f0
beq_else.28757:
beq_cont.28758:
	la	$t8, l.24620
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28759
	la	$t8, l.24627
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28761
	bne	$zero, $v0, beq_else.28763
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fdiv	$f0, $f1, $f0
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	la	$t8, l.23937
	flw	$f1, 0($t8)
	fsub	$f0, $f0, $f1
	j	fbt_cont.28760
beq_else.28763:
	la	$t8, l.23937
	flw	$f1, 0($t8)
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fdiv	$f0, $f2, $f0
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.24621
	flw	$f4, 0($t8)
	la	$t8, l.24622
	flw	$f5, 0($t8)
	la	$t8, l.24623
	flw	$f6, 0($t8)
	la	$t8, l.24624
	flw	$f7, 0($t8)
	la	$t8, l.24625
	flw	$f8, 0($t8)
	la	$t8, l.24626
	flw	$f9, 0($t8)
	fmul	$f9, $f9, $f2
	fsub	$f8, $f8, $f9
	fmul	$f8, $f8, $f2
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f2
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
beq_cont.28764:
	j	fbt_cont.28760
fbt_else.28761:
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fsub	$f1, $f0, $f1
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fadd	$f0, $f0, $f2
	fdiv	$f0, $f1, $f0
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	bne	$zero, $v0, beq_else.28765
	la	$t8, l.24628
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	j	fbt_cont.28760
beq_else.28765:
	la	$t8, l.23944
	flw	$f1, 0($t8)
	fadd	$f0, $f1, $f0
beq_cont.28766:
fbt_cont.28762:
	j	fbt_cont.28760
fbt_else.28759:
	bne	$zero, $v0, beq_else.28767
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	fneg	$f0, $f0
	j	beq_cont.28768
beq_else.28767:
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
beq_cont.28768:
fbt_cont.28760:
	la	$t8, l.24629
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	la	$t8, l.24630
	flw	$f1, 0($t8)
	fdiv	$f0, $f0, $f1
	j	beq_cont.28754
beq_else.28753:
	la	$t8, l.24619
	flw	$f0, 0($t8)
beq_cont.28754:
	fsw	$f0, -156($sp)
	sw	$ra, -160($sp)
	subi	$sp, $sp, 164
	jal	min_caml_floor
	addi	$sp, $sp, 164
	lw	$ra, -160($sp)
	flw	$f1, -156($sp)
	fsub	$f0, $f1, $f0
	lw	$v0, -36($sp)
	flw	$f1, 4($v0)
	lw	$v1, -100($sp)
	lw	$a0, 20($v1)
	flw	$f2, 4($a0)
	fsub	$f1, $f1, $f2
	lw	$a0, 16($v1)
	flw	$f2, 4($a0)
	fsw	$f0, -160($sp)
	fsw	$f1, -164($sp)
	fmove	$f0, $f2
	sw	$ra, -168($sp)
	subi	$sp, $sp, 172
	jal	min_caml_sqrt
	addi	$sp, $sp, 172
	lw	$ra, -168($sp)
	flw	$f1, -164($sp)
	fmul	$f0, $f1, $f0
	flw	$f1, -148($sp)
	fsw	$f0, -168($sp)
	fmove	$f0, $f1
	sw	$ra, -172($sp)
	subi	$sp, $sp, 176
	jal	min_caml_fabs
	addi	$sp, $sp, 176
	lw	$ra, -172($sp)
	la	$t8, l.24618
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28769
	addi	$v0, $zero, 0
	j	fbt_cont.28770
fbt_else.28769:
	addi	$v0, $zero, 1
fbt_cont.28770:
	bne	$zero, $v0, beq_else.28771
	flw	$f0, -148($sp)
	flw	$f1, -168($sp)
	fdiv	$f0, $f1, $f0
	sw	$ra, -172($sp)
	subi	$sp, $sp, 176
	jal	min_caml_fabs
	addi	$sp, $sp, 176
	lw	$ra, -172($sp)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28773
	addi	$v0, $zero, 1
	j	fbt_cont.28774
fbt_else.28773:
	addi	$v0, $zero, 0
fbt_cont.28774:
	bne	$zero, $v0, beq_else.28775
	fneg	$f0, $f0
beq_else.28775:
beq_cont.28776:
	la	$t8, l.24620
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28777
	la	$t8, l.24627
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28779
	bne	$zero, $v0, beq_else.28781
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fdiv	$f0, $f1, $f0
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	la	$t8, l.23937
	flw	$f1, 0($t8)
	fsub	$f0, $f0, $f1
	j	fbt_cont.28778
beq_else.28781:
	la	$t8, l.23937
	flw	$f1, 0($t8)
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fdiv	$f0, $f2, $f0
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.24621
	flw	$f4, 0($t8)
	la	$t8, l.24622
	flw	$f5, 0($t8)
	la	$t8, l.24623
	flw	$f6, 0($t8)
	la	$t8, l.24624
	flw	$f7, 0($t8)
	la	$t8, l.24625
	flw	$f8, 0($t8)
	la	$t8, l.24626
	flw	$f9, 0($t8)
	fmul	$f9, $f9, $f2
	fsub	$f8, $f8, $f9
	fmul	$f8, $f8, $f2
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f2
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
beq_cont.28782:
	j	fbt_cont.28778
fbt_else.28779:
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fsub	$f1, $f0, $f1
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fadd	$f0, $f0, $f2
	fdiv	$f0, $f1, $f0
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	bne	$zero, $v0, beq_else.28783
	la	$t8, l.24628
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	j	fbt_cont.28778
beq_else.28783:
	la	$t8, l.23944
	flw	$f1, 0($t8)
	fadd	$f0, $f1, $f0
beq_cont.28784:
fbt_cont.28780:
	j	fbt_cont.28778
fbt_else.28777:
	bne	$zero, $v0, beq_else.28785
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	fneg	$f0, $f0
	j	beq_cont.28786
beq_else.28785:
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
beq_cont.28786:
fbt_cont.28778:
	la	$t8, l.24629
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	la	$t8, l.24630
	flw	$f1, 0($t8)
	fdiv	$f0, $f0, $f1
	j	beq_cont.28772
beq_else.28771:
	la	$t8, l.24619
	flw	$f0, 0($t8)
beq_cont.28772:
	fsw	$f0, -172($sp)
	sw	$ra, -176($sp)
	subi	$sp, $sp, 180
	jal	min_caml_floor
	addi	$sp, $sp, 180
	lw	$ra, -176($sp)
	flw	$f1, -172($sp)
	fsub	$f0, $f1, $f0
	la	$t8, l.24634
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	flw	$f3, -160($sp)
	fsub	$f2, $f2, $f3
	fmul	$f2, $f2, $f2
	fsub	$f1, $f1, $f2
	la	$t8, l.23876
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	fmul	$f0, $f0, $f0
	fsub	$f0, $f1, $f0
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28787
	addi	$v0, $zero, 0
	j	fbt_cont.28788
fbt_else.28787:
	addi	$v0, $zero, 1
fbt_cont.28788:
	bne	$zero, $v0, beq_else.28789
	j	beq_cont.28790
beq_else.28789:
	la	$t8, l.23884
	flw	$f0, 0($t8)
beq_cont.28790:
	la	$t8, l.24635
	flw	$f1, 0($t8)
	fmul	$f0, $f1, $f0
	la	$t8, l.24636
	flw	$f1, 0($t8)
	fdiv	$f0, $f0, $f1
	lw	$v0, -28($sp)
	fsw	$f0, 8($v0)
beq_else.28749:
beq_cont.28750:
beq_cont.28734:
beq_cont.28716:
beq_cont.28704:
	lw	$v0, -96($sp)
	sll	$v0, $v0, 2
	lw	$v1, -44($sp)
	lw	$v1, 0($v1)
	add	$v0, $v0, $v1
	lw	$v1, -80($sp)
	sll	$a0, $v1, 2
	lw	$a1, -76($sp)
	add	$t8, $a1, $a0
	sw	$v0, 0($t8)
	lw	$v0, -20($sp)
	lw	$a0, 4($v0)
	sll	$a2, $v1, 2
	add	$t8, $a0, $a2
	lw	$a0, 0($t8)
	lw	$a2, -36($sp)
	flw	$f0, 0($a2)
	fsw	$f0, 0($a0)
	flw	$f0, 4($a2)
	fsw	$f0, 4($a0)
	flw	$f0, 8($a2)
	fsw	$f0, 8($a0)
	lw	$a0, 12($v0)
	lw	$a3, -100($sp)
	lw	$t0, 28($a3)
	flw	$f0, 0($t0)
	la	$t8, l.23876
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28791
	addi	$t0, $zero, 0
	j	fbt_cont.28792
fbt_else.28791:
	addi	$t0, $zero, 1
fbt_cont.28792:
	bne	$zero, $t0, beq_else.28793
	addi	$t0, $zero, 1
	sll	$t1, $v1, 2
	add	$t8, $a0, $t1
	sw	$t0, 0($t8)
	lw	$a0, 16($v0)
	sll	$t0, $v1, 2
	add	$t8, $a0, $t0
	lw	$t0, 0($t8)
	lw	$t1, -28($sp)
	flw	$f0, 0($t1)
	fsw	$f0, 0($t0)
	flw	$f0, 4($t1)
	fsw	$f0, 4($t0)
	flw	$f0, 8($t1)
	fsw	$f0, 8($t0)
	sll	$t0, $v1, 2
	add	$t8, $a0, $t0
	lw	$a0, 0($t8)
	la	$t8, l.24694
	flw	$f0, 0($t8)
	flw	$f1, -92($sp)
	fmul	$f0, $f0, $f1
	flw	$f2, 0($a0)
	fmul	$f2, $f2, $f0
	fsw	$f2, 0($a0)
	flw	$f2, 4($a0)
	fmul	$f2, $f2, $f0
	fsw	$f2, 4($a0)
	flw	$f2, 8($a0)
	fmul	$f0, $f2, $f0
	fsw	$f0, 8($a0)
	lw	$a0, 28($v0)
	sll	$t0, $v1, 2
	add	$t8, $a0, $t0
	lw	$a0, 0($t8)
	lw	$t0, -40($sp)
	flw	$f0, 0($t0)
	fsw	$f0, 0($a0)
	flw	$f0, 4($t0)
	fsw	$f0, 4($a0)
	flw	$f0, 8($t0)
	fsw	$f0, 8($a0)
	j	beq_cont.28794
beq_else.28793:
	sll	$t0, $v1, 2
	add	$t8, $a0, $t0
	sw	$zero, 0($t8)
beq_cont.28794:
	la	$t8, l.24708
	flw	$f0, 0($t8)
	lw	$a0, -72($sp)
	flw	$f1, 0($a0)
	lw	$t0, -40($sp)
	flw	$f2, 0($t0)
	fmul	$f1, $f1, $f2
	flw	$f2, 4($a0)
	flw	$f3, 4($t0)
	fmul	$f2, $f2, $f3
	fadd	$f1, $f1, $f2
	flw	$f2, 8($a0)
	flw	$f3, 8($t0)
	fmul	$f2, $f2, $f3
	fadd	$f1, $f1, $f2
	fmul	$f0, $f0, $f1
	flw	$f1, 0($a0)
	flw	$f2, 0($t0)
	fmul	$f2, $f0, $f2
	fadd	$f1, $f1, $f2
	fsw	$f1, 0($a0)
	flw	$f1, 4($a0)
	flw	$f2, 4($t0)
	fmul	$f2, $f0, $f2
	fadd	$f1, $f1, $f2
	fsw	$f1, 4($a0)
	flw	$f1, 8($a0)
	flw	$f2, 8($t0)
	fmul	$f0, $f0, $f2
	fadd	$f0, $f1, $f0
	fsw	$f0, 8($a0)
	lw	$t1, 28($a3)
	flw	$f0, 4($t1)
	flw	$f1, -64($sp)
	fmul	$f0, $f1, $f0
	lw	$t1, -16($sp)
	lw	$t1, 0($t1)
	fsw	$f0, -176($sp)
	move	$v1, $t1
	move	$v0, $zero
	sw	$ra, -180($sp)
	subi	$sp, $sp, 184
	jal	shadow_check_one_or_matrix.2894
	addi	$sp, $sp, 184
	lw	$ra, -180($sp)
	bne	$zero, $v0, beq_else.28795
	lw	$v0, -40($sp)
	flw	$f0, 0($v0)
	lw	$v1, -68($sp)
	flw	$f1, 0($v1)
	fmul	$f0, $f0, $f1
	flw	$f1, 4($v0)
	flw	$f2, 4($v1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	flw	$f1, 8($v0)
	flw	$f2, 8($v1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	fneg	$f0, $f0
	flw	$f1, -92($sp)
	fmul	$f0, $f0, $f1
	lw	$v0, -72($sp)
	flw	$f2, 0($v0)
	flw	$f3, 0($v1)
	fmul	$f2, $f2, $f3
	flw	$f3, 4($v0)
	flw	$f4, 4($v1)
	fmul	$f3, $f3, $f4
	fadd	$f2, $f2, $f3
	flw	$f3, 8($v0)
	flw	$f4, 8($v1)
	fmul	$f3, $f3, $f4
	fadd	$f2, $f2, $f3
	fneg	$f2, $f2
	la	$t8, l.23884
	flw	$f3, 0($t8)
	fle	$f0, $f3
	fbf	fbt_else.28797
	addi	$v1, $zero, 0
	j	fbt_cont.28798
fbt_else.28797:
	addi	$v1, $zero, 1
fbt_cont.28798:
	bne	$zero, $v1, beq_else.28799
	j	beq_cont.28800
beq_else.28799:
	lw	$v1, -56($sp)
	flw	$f3, 0($v1)
	lw	$a0, -28($sp)
	flw	$f4, 0($a0)
	fmul	$f4, $f0, $f4
	fadd	$f3, $f3, $f4
	fsw	$f3, 0($v1)
	flw	$f3, 4($v1)
	flw	$f4, 4($a0)
	fmul	$f4, $f0, $f4
	fadd	$f3, $f3, $f4
	fsw	$f3, 4($v1)
	flw	$f3, 8($v1)
	flw	$f4, 8($a0)
	fmul	$f0, $f0, $f4
	fadd	$f0, $f3, $f0
	fsw	$f0, 8($v1)
beq_cont.28800:
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.28801
	addi	$v1, $zero, 0
	j	fbt_cont.28802
fbt_else.28801:
	addi	$v1, $zero, 1
fbt_cont.28802:
	bne	$zero, $v1, beq_else.28803
	j	beq_cont.28804
beq_else.28803:
	fmul	$f0, $f2, $f2
	fmul	$f0, $f0, $f0
	flw	$f2, -176($sp)
	fmul	$f0, $f0, $f2
	lw	$v1, -56($sp)
	flw	$f3, 0($v1)
	fadd	$f3, $f3, $f0
	fsw	$f3, 0($v1)
	flw	$f3, 4($v1)
	fadd	$f3, $f3, $f0
	fsw	$f3, 4($v1)
	flw	$f3, 8($v1)
	fadd	$f0, $f3, $f0
	fsw	$f0, 8($v1)
beq_cont.28804:
beq_else.28795:
beq_cont.28796:
	lw	$v0, -36($sp)
	flw	$f0, 0($v0)
	lw	$v1, -12($sp)
	fsw	$f0, 0($v1)
	flw	$f0, 4($v0)
	fsw	$f0, 4($v1)
	flw	$f0, 8($v0)
	fsw	$f0, 8($v1)
	lw	$v1, -8($sp)
	lw	$v1, 0($v1)
	subi	$v1, $v1, 1
	sw	$ra, -180($sp)
	subi	$sp, $sp, 184
	jal	setup_startp_constants.2857
	addi	$sp, $sp, 184
	lw	$ra, -180($sp)
	lw	$v0, -4($sp)
	lw	$v0, 0($v0)
	subi	$v0, $v0, 1
	flw	$f0, -92($sp)
	flw	$f1, -176($sp)
	lw	$v1, -72($sp)
	sw	$ra, -180($sp)
	subi	$sp, $sp, 184
	jal	trace_reflections.2941
	addi	$sp, $sp, 184
	lw	$ra, -180($sp)
	la	$t8, l.24761
	flw	$f0, 0($t8)
	flw	$f1, -64($sp)
	fle	$f1, $f0
	fbf	fbt_else.28805
	addi	$v0, $zero, 0
	j	fbt_cont.28806
fbt_else.28805:
	addi	$v0, $zero, 1
fbt_cont.28806:
	bne	$zero, $v0, beq_else.28807
	jr	$ra
beq_else.28807:
	lw	$v0, -80($sp)
	slti	$t8, $v0, 4
	bne	$t8, $zero, beq_else.28809
	j	beq_cont.28810
beq_else.28809:
	addi	$v1, $v0, 1
	addi	$a0, $zero, -1
	sll	$v1, $v1, 2
	lw	$a1, -76($sp)
	add	$t8, $a1, $v1
	sw	$a0, 0($t8)
beq_cont.28810:
	lw	$v1, -88($sp)
	addi	$t8, $zero, 2
	bne	$t8, $v1, beq_else.28811
	la	$t8, l.23916
	flw	$f0, 0($t8)
	lw	$v1, -100($sp)
	lw	$v1, 28($v1)
	flw	$f2, 0($v1)
	fsub	$f0, $f0, $f2
	fmul	$f0, $f1, $f0
	addi	$v0, $v0, 1
	lw	$v1, -84($sp)
	flw	$f1, 0($v1)
	flw	$f2, 0($sp)
	fadd	$f1, $f2, $f1
	lw	$v1, -72($sp)
	lw	$a0, -20($sp)
	j	trace_ray.2946
beq_else.28811:
	jr	$ra
beq_else.28668:
	jr	$ra
iter_trace_diffuse_rays.2955:
	lui	$a2, 512
	ori	$a2, $a2, 592
	lui	$a3, 512
	ori	$a3, $a3, 564
	lui	$t0, 512
	ori	$t0, $t0, 552
	lui	$t1, 512
	ori	$t1, $t1, 544
	lui	$t2, 512
	ori	$t2, $t2, 312
	lui	$t3, 512
	ori	$t3, $t3, 568
	lui	$t4, 512
	ori	$t4, $t4, 48
	lui	$t5, 512
	ori	$t5, $t5, 536
	la	$t8, l.23883
	flw	$f0, 0($t8)
	lui	$t6, 512
	ori	$t6, $t6, 580
	lui	$s0, 512
	ori	$s0, $s0, 548
	slti	$t8, $a1, 0
	bne	$t8, $zero, beq_else.28814
	sll	$s1, $a1, 2
	add	$t8, $v0, $s1
	lw	$s1, 0($t8)
	lw	$s1, 0($s1)
	flw	$f1, 0($s1)
	flw	$f2, 0($v1)
	fmul	$f1, $f1, $f2
	flw	$f2, 4($s1)
	flw	$f3, 4($v1)
	fmul	$f2, $f2, $f3
	fadd	$f1, $f1, $f2
	flw	$f2, 8($s1)
	flw	$f3, 8($v1)
	fmul	$f2, $f2, $f3
	fadd	$f1, $f1, $f2
	la	$t8, l.23884
	flw	$f2, 0($t8)
	fle	$f2, $f1
	fbf	fbt_else.28815
	addi	$s1, $zero, 0
	j	fbt_cont.28816
fbt_else.28815:
	addi	$s1, $zero, 1
fbt_cont.28816:
	sw	$a0, 0($sp)
	sw	$v1, -4($sp)
	sw	$v0, -8($sp)
	sw	$a1, -12($sp)
	bne	$zero, $s1, beq_else.28817
	sll	$s1, $a1, 2
	add	$t8, $v0, $s1
	lw	$s1, 0($t8)
	la	$t8, l.24901
	flw	$f2, 0($t8)
	fdiv	$f1, $f1, $f2
	la	$t8, l.24517
	flw	$f2, 0($t8)
	fsw	$f2, 0($s0)
	lw	$s2, 0($t5)
	sw	$a2, -16($sp)
	fsw	$f1, -20($sp)
	sw	$t2, -24($sp)
	sw	$t5, -28($sp)
	fsw	$f0, -32($sp)
	sw	$t6, -36($sp)
	sw	$t0, -40($sp)
	sw	$t3, -44($sp)
	sw	$t1, -48($sp)
	sw	$s1, -52($sp)
	sw	$t4, -56($sp)
	sw	$a3, -60($sp)
	sw	$s0, -64($sp)
	move	$a0, $s1
	move	$v1, $s2
	move	$v0, $zero
	sw	$ra, -68($sp)
	subi	$sp, $sp, 72
	jal	trace_or_matrix_fast.2919
	addi	$sp, $sp, 72
	lw	$ra, -68($sp)
	lw	$v0, -64($sp)
	flw	$f0, 0($v0)
	la	$t8, l.24249
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28819
	addi	$v0, $zero, 0
	j	fbt_cont.28820
fbt_else.28819:
	addi	$v0, $zero, 1
fbt_cont.28820:
	bne	$zero, $v0, beq_else.28821
	addi	$v0, $zero, 0
	j	beq_cont.28822
beq_else.28821:
	la	$t8, l.24521
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28823
	addi	$v0, $zero, 0
	j	fbt_cont.28824
fbt_else.28823:
	addi	$v0, $zero, 1
fbt_cont.28824:
beq_cont.28822:
	bne	$zero, $v0, beq_else.28825
	j	beq_cont.28818
beq_else.28825:
	lw	$v0, -60($sp)
	lw	$v0, 0($v0)
	sll	$v0, $v0, 2
	lw	$v1, -56($sp)
	add	$t8, $v1, $v0
	lw	$v0, 0($t8)
	lw	$v1, -52($sp)
	lw	$v1, 0($v1)
	lw	$a0, 4($v0)
	sw	$v0, -68($sp)
	addi	$t8, $zero, 1
	bne	$t8, $a0, beq_else.28827
	lw	$a0, -48($sp)
	lw	$a0, 0($a0)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	lw	$a1, -44($sp)
	fsw	$f0, 0($a1)
	fsw	$f0, 4($a1)
	fsw	$f0, 8($a1)
	subi	$a2, $a0, 1
	subi	$a0, $a0, 1
	sll	$a0, $a0, 2
	add	$t8, $v1, $a0
	flw	$f0, 0($t8)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28829
	addi	$v1, $zero, 1
	j	fbt_cont.28830
fbt_else.28829:
	addi	$v1, $zero, 0
fbt_cont.28830:
	bne	$zero, $v1, beq_else.28831
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28833
	addi	$v1, $zero, 0
	j	fbt_cont.28834
fbt_else.28833:
	addi	$v1, $zero, 1
fbt_cont.28834:
	bne	$zero, $v1, beq_else.28835
	la	$t8, l.23917
	flw	$f0, 0($t8)
	j	beq_cont.28832
beq_else.28835:
	la	$t8, l.23916
	flw	$f0, 0($t8)
beq_cont.28836:
	j	beq_cont.28832
beq_else.28831:
	la	$t8, l.23884
	flw	$f0, 0($t8)
beq_cont.28832:
	fneg	$f0, $f0
	sll	$v1, $a2, 2
	add	$t8, $a1, $v1
	fsw	$f0, 0($t8)
	j	beq_cont.28828
beq_else.28827:
	addi	$t8, $zero, 2
	bne	$t8, $a0, beq_else.28837
	lw	$v1, 16($v0)
	flw	$f0, 0($v1)
	fneg	$f0, $f0
	lw	$v1, -44($sp)
	fsw	$f0, 0($v1)
	lw	$a0, 16($v0)
	flw	$f0, 4($a0)
	fneg	$f0, $f0
	fsw	$f0, 4($v1)
	lw	$a0, 16($v0)
	flw	$f0, 8($a0)
	fneg	$f0, $f0
	fsw	$f0, 8($v1)
	j	beq_cont.28838
beq_else.28837:
	lw	$v1, -40($sp)
	flw	$f0, 0($v1)
	lw	$a0, 20($v0)
	flw	$f1, 0($a0)
	fsub	$f0, $f0, $f1
	flw	$f1, 4($v1)
	lw	$a0, 20($v0)
	flw	$f2, 4($a0)
	fsub	$f1, $f1, $f2
	flw	$f2, 8($v1)
	lw	$a0, 20($v0)
	flw	$f3, 8($a0)
	fsub	$f2, $f2, $f3
	lw	$a0, 16($v0)
	flw	$f3, 0($a0)
	fmul	$f3, $f0, $f3
	lw	$a0, 16($v0)
	flw	$f4, 4($a0)
	fmul	$f4, $f1, $f4
	lw	$a0, 16($v0)
	flw	$f5, 8($a0)
	fmul	$f5, $f2, $f5
	lw	$a0, 12($v0)
	bne	$zero, $a0, beq_else.28839
	lw	$a0, -44($sp)
	fsw	$f3, 0($a0)
	fsw	$f4, 4($a0)
	fsw	$f5, 8($a0)
	j	beq_cont.28840
beq_else.28839:
	lw	$a0, 36($v0)
	flw	$f6, 8($a0)
	fmul	$f6, $f1, $f6
	lw	$a0, 36($v0)
	flw	$f7, 4($a0)
	fmul	$f7, $f2, $f7
	fadd	$f6, $f6, $f7
	la	$t8, l.23876
	flw	$f7, 0($t8)
	fmul	$f6, $f6, $f7
	fadd	$f3, $f3, $f6
	lw	$a0, -44($sp)
	fsw	$f3, 0($a0)
	lw	$a1, 36($v0)
	flw	$f3, 8($a1)
	fmul	$f3, $f0, $f3
	lw	$a1, 36($v0)
	flw	$f6, 0($a1)
	fmul	$f2, $f2, $f6
	fadd	$f2, $f3, $f2
	la	$t8, l.23876
	flw	$f3, 0($t8)
	fmul	$f2, $f2, $f3
	fadd	$f2, $f4, $f2
	fsw	$f2, 4($a0)
	lw	$a1, 36($v0)
	flw	$f2, 4($a1)
	fmul	$f0, $f0, $f2
	lw	$a1, 36($v0)
	flw	$f2, 0($a1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	la	$t8, l.23876
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	fadd	$f0, $f5, $f0
	fsw	$f0, 8($a0)
beq_cont.28840:
	lw	$a1, 24($v0)
	flw	$f0, 0($a0)
	fmul	$f0, $f0, $f0
	flw	$f1, 4($a0)
	fmul	$f1, $f1, $f1
	fadd	$f0, $f0, $f1
	flw	$f1, 8($a0)
	fmul	$f1, $f1, $f1
	fadd	$f0, $f0, $f1
	sw	$a1, -72($sp)
	sw	$ra, -76($sp)
	subi	$sp, $sp, 80
	jal	min_caml_sqrt
	addi	$sp, $sp, 80
	lw	$ra, -76($sp)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28841
	addi	$v0, $zero, 1
	j	fbt_cont.28842
fbt_else.28841:
	addi	$v0, $zero, 0
fbt_cont.28842:
	bne	$zero, $v0, beq_else.28843
	lw	$v0, -72($sp)
	bne	$zero, $v0, beq_else.28845
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fdiv	$f0, $f1, $f0
	j	beq_cont.28844
beq_else.28845:
	la	$t8, l.23917
	flw	$f1, 0($t8)
	fdiv	$f0, $f1, $f0
beq_cont.28846:
	j	beq_cont.28844
beq_else.28843:
	la	$t8, l.23916
	flw	$f0, 0($t8)
beq_cont.28844:
	lw	$v0, -44($sp)
	flw	$f1, 0($v0)
	fmul	$f1, $f1, $f0
	fsw	$f1, 0($v0)
	flw	$f1, 4($v0)
	fmul	$f1, $f1, $f0
	fsw	$f1, 4($v0)
	flw	$f1, 8($v0)
	fmul	$f0, $f1, $f0
	fsw	$f0, 8($v0)
beq_cont.28838:
beq_cont.28828:
	lw	$v0, -68($sp)
	lw	$v1, 0($v0)
	lw	$a0, 32($v0)
	flw	$f0, 0($a0)
	lw	$a0, -36($sp)
	fsw	$f0, 0($a0)
	lw	$a1, 32($v0)
	flw	$f0, 4($a1)
	fsw	$f0, 4($a0)
	lw	$a1, 32($v0)
	flw	$f0, 8($a1)
	fsw	$f0, 8($a0)
	addi	$t8, $zero, 1
	bne	$t8, $v1, beq_else.28847
	lw	$v1, -40($sp)
	flw	$f0, 0($v1)
	lw	$a1, 20($v0)
	flw	$f1, 0($a1)
	fsub	$f0, $f0, $f1
	la	$t8, l.24669
	flw	$f1, 0($t8)
	fmul	$f1, $f0, $f1
	fsw	$f0, -76($sp)
	fmove	$f0, $f1
	sw	$ra, -80($sp)
	subi	$sp, $sp, 84
	jal	min_caml_floor
	addi	$sp, $sp, 84
	lw	$ra, -80($sp)
	la	$t8, l.24670
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	flw	$f1, -76($sp)
	fsub	$f0, $f1, $f0
	la	$t8, l.24642
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28849
	addi	$v0, $zero, 0
	j	fbt_cont.28850
fbt_else.28849:
	addi	$v0, $zero, 1
fbt_cont.28850:
	lw	$v1, -40($sp)
	flw	$f0, 8($v1)
	lw	$v1, -68($sp)
	lw	$a0, 20($v1)
	flw	$f1, 8($a0)
	fsub	$f0, $f0, $f1
	la	$t8, l.24669
	flw	$f1, 0($t8)
	fmul	$f1, $f0, $f1
	sw	$v0, -80($sp)
	fsw	$f0, -84($sp)
	fmove	$f0, $f1
	sw	$ra, -88($sp)
	subi	$sp, $sp, 92
	jal	min_caml_floor
	addi	$sp, $sp, 92
	lw	$ra, -88($sp)
	la	$t8, l.24670
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	flw	$f1, -84($sp)
	fsub	$f0, $f1, $f0
	la	$t8, l.24642
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28851
	addi	$v0, $zero, 0
	j	fbt_cont.28852
fbt_else.28851:
	addi	$v0, $zero, 1
fbt_cont.28852:
	lw	$v1, -80($sp)
	bne	$zero, $v1, beq_else.28853
	bne	$zero, $v0, beq_else.28855
	la	$t8, l.24635
	flw	$f0, 0($t8)
	j	beq_cont.28854
beq_else.28855:
	la	$t8, l.23884
	flw	$f0, 0($t8)
beq_cont.28856:
	j	beq_cont.28854
beq_else.28853:
	bne	$zero, $v0, beq_else.28857
	la	$t8, l.23884
	flw	$f0, 0($t8)
	j	beq_cont.28858
beq_else.28857:
	la	$t8, l.24635
	flw	$f0, 0($t8)
beq_cont.28858:
beq_cont.28854:
	lw	$v0, -36($sp)
	fsw	$f0, 4($v0)
	j	beq_cont.28848
beq_else.28847:
	addi	$t8, $zero, 2
	bne	$t8, $v1, beq_else.28859
	lw	$v1, -40($sp)
	flw	$f0, 4($v1)
	la	$t8, l.24658
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28861
	addi	$v1, $zero, 1
	j	fbt_cont.28862
fbt_else.28861:
	addi	$v1, $zero, 0
fbt_cont.28862:
	bne	$zero, $v1, beq_else.28863
	fneg	$f0, $f0
beq_else.28863:
beq_cont.28864:
	la	$t8, l.23875
	flw	$f1, 0($t8)
	sw	$v1, -88($sp)
	fsw	$f0, -92($sp)
	sw	$ra, -96($sp)
	subi	$sp, $sp, 100
	jal	adjust_exp.2562
	addi	$sp, $sp, 100
	lw	$ra, -96($sp)
	fmove	$f1, $f0
	flw	$f0, -92($sp)
	sw	$ra, -96($sp)
	subi	$sp, $sp, 100
	jal	sub_iter.2565
	addi	$sp, $sp, 100
	lw	$ra, -96($sp)
	flw	$f1, -32($sp)
	fle	$f1, $f0
	fbf	fbt_else.28865
	lw	$v0, -88($sp)
	bne	$zero, $v0, beq_else.28867
	addi	$v0, $zero, 1
	j	beq_cont.28868
beq_else.28867:
	addi	$v0, $zero, 0
beq_cont.28868:
	fsub	$f0, $f0, $f1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.28866
fbt_else.28865:
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	lw	$v1, -88($sp)
	sw	$v1, 0($v0)
fbt_cont.28866:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.28869
	fsub	$f0, $f1, $f0
fbt_else.28869:
fbt_cont.28870:
	la	$t8, l.23944
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28871
	bne	$zero, $v0, beq_else.28873
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	fneg	$f0, $f0
	j	fbt_cont.28872
beq_else.28873:
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
beq_cont.28874:
	j	fbt_cont.28872
fbt_else.28871:
	la	$t8, l.23937
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	bne	$zero, $v0, beq_else.28875
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
	fneg	$f0, $f0
	j	beq_cont.28876
beq_else.28875:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
beq_cont.28876:
fbt_cont.28872:
	fmul	$f0, $f0, $f0
	la	$t8, l.24635
	flw	$f1, 0($t8)
	fmul	$f1, $f1, $f0
	lw	$v0, -36($sp)
	fsw	$f1, 0($v0)
	la	$t8, l.24635
	flw	$f1, 0($t8)
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	fmul	$f0, $f1, $f0
	fsw	$f0, 4($v0)
	j	beq_cont.28860
beq_else.28859:
	addi	$t8, $zero, 3
	bne	$t8, $v1, beq_else.28877
	lw	$v1, -40($sp)
	flw	$f0, 0($v1)
	lw	$a1, 20($v0)
	flw	$f1, 0($a1)
	fsub	$f0, $f0, $f1
	flw	$f1, 8($v1)
	lw	$v1, 20($v0)
	flw	$f2, 8($v1)
	fsub	$f1, $f1, $f2
	fmul	$f0, $f0, $f0
	fmul	$f1, $f1, $f1
	fadd	$f0, $f0, $f1
	sw	$ra, -96($sp)
	subi	$sp, $sp, 100
	jal	min_caml_sqrt
	addi	$sp, $sp, 100
	lw	$ra, -96($sp)
	la	$t8, l.24642
	flw	$f1, 0($t8)
	fdiv	$f0, $f0, $f1
	fsw	$f0, -96($sp)
	sw	$ra, -100($sp)
	subi	$sp, $sp, 104
	jal	min_caml_floor
	addi	$sp, $sp, 104
	lw	$ra, -100($sp)
	flw	$f1, -96($sp)
	fsub	$f0, $f1, $f0
	la	$t8, l.24630
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28879
	j	fbt_cont.28880
fbt_else.28879:
	fneg	$f0, $f0
fbt_cont.28880:
	la	$t8, l.23875
	flw	$f1, 0($t8)
	fsw	$f0, -100($sp)
	sw	$ra, -104($sp)
	subi	$sp, $sp, 108
	jal	adjust_exp.2562
	addi	$sp, $sp, 108
	lw	$ra, -104($sp)
	fmove	$f1, $f0
	flw	$f0, -100($sp)
	sw	$ra, -104($sp)
	subi	$sp, $sp, 108
	jal	sub_iter.2565
	addi	$sp, $sp, 108
	lw	$ra, -104($sp)
	flw	$f1, -32($sp)
	fle	$f1, $f0
	fbf	fbt_else.28881
	fsub	$f0, $f0, $f1
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	sw	$zero, 0($v0)
	j	fbt_cont.28882
fbt_else.28881:
	addi	$v0, $zero, 1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.28882:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.28883
	bne	$zero, $v0, beq_else.28885
	addi	$v0, $zero, 1
	j	beq_cont.28886
beq_else.28885:
	addi	$v0, $zero, 0
beq_cont.28886:
	fsub	$f0, $f1, $f0
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.28884
fbt_else.28883:
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.28884:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23944
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28887
	bne	$zero, $v0, beq_else.28889
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
	fneg	$f0, $f0
	j	fbt_cont.28888
beq_else.28889:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
beq_cont.28890:
	j	fbt_cont.28888
fbt_else.28887:
	la	$t8, l.23937
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	bne	$zero, $v0, beq_else.28891
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	fneg	$f0, $f0
	j	beq_cont.28892
beq_else.28891:
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
beq_cont.28892:
fbt_cont.28888:
	fmul	$f0, $f0, $f0
	la	$t8, l.24635
	flw	$f1, 0($t8)
	fmul	$f1, $f0, $f1
	lw	$v0, -36($sp)
	fsw	$f1, 4($v0)
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	la	$t8, l.24635
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	fsw	$f0, 8($v0)
	j	beq_cont.28878
beq_else.28877:
	addi	$t8, $zero, 4
	bne	$t8, $v1, beq_else.28893
	lw	$v1, -40($sp)
	flw	$f0, 0($v1)
	lw	$a1, 20($v0)
	flw	$f1, 0($a1)
	fsub	$f0, $f0, $f1
	lw	$a1, 16($v0)
	flw	$f1, 0($a1)
	fsw	$f0, -104($sp)
	fmove	$f0, $f1
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	min_caml_sqrt
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	flw	$f1, -104($sp)
	fmul	$f0, $f1, $f0
	lw	$v0, -40($sp)
	flw	$f1, 8($v0)
	lw	$v1, -68($sp)
	lw	$a0, 20($v1)
	flw	$f2, 8($a0)
	fsub	$f1, $f1, $f2
	lw	$a0, 16($v1)
	flw	$f2, 8($a0)
	fsw	$f0, -108($sp)
	fsw	$f1, -112($sp)
	fmove	$f0, $f2
	sw	$ra, -116($sp)
	subi	$sp, $sp, 120
	jal	min_caml_sqrt
	addi	$sp, $sp, 120
	lw	$ra, -116($sp)
	flw	$f1, -112($sp)
	fmul	$f0, $f1, $f0
	flw	$f1, -108($sp)
	fmul	$f2, $f1, $f1
	fmul	$f3, $f0, $f0
	fadd	$f2, $f2, $f3
	fsw	$f2, -116($sp)
	fsw	$f0, -120($sp)
	fmove	$f0, $f1
	sw	$ra, -124($sp)
	subi	$sp, $sp, 128
	jal	min_caml_fabs
	addi	$sp, $sp, 128
	lw	$ra, -124($sp)
	la	$t8, l.24618
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28895
	addi	$v0, $zero, 0
	j	fbt_cont.28896
fbt_else.28895:
	addi	$v0, $zero, 1
fbt_cont.28896:
	bne	$zero, $v0, beq_else.28897
	flw	$f0, -108($sp)
	flw	$f1, -120($sp)
	fdiv	$f0, $f1, $f0
	sw	$ra, -124($sp)
	subi	$sp, $sp, 128
	jal	min_caml_fabs
	addi	$sp, $sp, 128
	lw	$ra, -124($sp)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28899
	addi	$v0, $zero, 1
	j	fbt_cont.28900
fbt_else.28899:
	addi	$v0, $zero, 0
fbt_cont.28900:
	bne	$zero, $v0, beq_else.28901
	fneg	$f0, $f0
beq_else.28901:
beq_cont.28902:
	la	$t8, l.24620
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28903
	la	$t8, l.24627
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28905
	bne	$zero, $v0, beq_else.28907
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fdiv	$f0, $f1, $f0
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	la	$t8, l.23937
	flw	$f1, 0($t8)
	fsub	$f0, $f0, $f1
	j	fbt_cont.28904
beq_else.28907:
	la	$t8, l.23937
	flw	$f1, 0($t8)
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fdiv	$f0, $f2, $f0
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.24621
	flw	$f4, 0($t8)
	la	$t8, l.24622
	flw	$f5, 0($t8)
	la	$t8, l.24623
	flw	$f6, 0($t8)
	la	$t8, l.24624
	flw	$f7, 0($t8)
	la	$t8, l.24625
	flw	$f8, 0($t8)
	la	$t8, l.24626
	flw	$f9, 0($t8)
	fmul	$f9, $f9, $f2
	fsub	$f8, $f8, $f9
	fmul	$f8, $f8, $f2
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f2
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
beq_cont.28908:
	j	fbt_cont.28904
fbt_else.28905:
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fsub	$f1, $f0, $f1
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fadd	$f0, $f0, $f2
	fdiv	$f0, $f1, $f0
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	bne	$zero, $v0, beq_else.28909
	la	$t8, l.24628
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	j	fbt_cont.28904
beq_else.28909:
	la	$t8, l.23944
	flw	$f1, 0($t8)
	fadd	$f0, $f1, $f0
beq_cont.28910:
fbt_cont.28906:
	j	fbt_cont.28904
fbt_else.28903:
	bne	$zero, $v0, beq_else.28911
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	fneg	$f0, $f0
	j	beq_cont.28912
beq_else.28911:
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
beq_cont.28912:
fbt_cont.28904:
	la	$t8, l.24629
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	la	$t8, l.24630
	flw	$f1, 0($t8)
	fdiv	$f0, $f0, $f1
	j	beq_cont.28898
beq_else.28897:
	la	$t8, l.24619
	flw	$f0, 0($t8)
beq_cont.28898:
	fsw	$f0, -124($sp)
	sw	$ra, -128($sp)
	subi	$sp, $sp, 132
	jal	min_caml_floor
	addi	$sp, $sp, 132
	lw	$ra, -128($sp)
	flw	$f1, -124($sp)
	fsub	$f0, $f1, $f0
	lw	$v0, -40($sp)
	flw	$f1, 4($v0)
	lw	$v0, -68($sp)
	lw	$v1, 20($v0)
	flw	$f2, 4($v1)
	fsub	$f1, $f1, $f2
	lw	$v1, 16($v0)
	flw	$f2, 4($v1)
	fsw	$f0, -128($sp)
	fsw	$f1, -132($sp)
	fmove	$f0, $f2
	sw	$ra, -136($sp)
	subi	$sp, $sp, 140
	jal	min_caml_sqrt
	addi	$sp, $sp, 140
	lw	$ra, -136($sp)
	flw	$f1, -132($sp)
	fmul	$f0, $f1, $f0
	flw	$f1, -116($sp)
	fsw	$f0, -136($sp)
	fmove	$f0, $f1
	sw	$ra, -140($sp)
	subi	$sp, $sp, 144
	jal	min_caml_fabs
	addi	$sp, $sp, 144
	lw	$ra, -140($sp)
	la	$t8, l.24618
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28913
	addi	$v0, $zero, 0
	j	fbt_cont.28914
fbt_else.28913:
	addi	$v0, $zero, 1
fbt_cont.28914:
	bne	$zero, $v0, beq_else.28915
	flw	$f0, -116($sp)
	flw	$f1, -136($sp)
	fdiv	$f0, $f1, $f0
	sw	$ra, -140($sp)
	subi	$sp, $sp, 144
	jal	min_caml_fabs
	addi	$sp, $sp, 144
	lw	$ra, -140($sp)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28917
	addi	$v0, $zero, 1
	j	fbt_cont.28918
fbt_else.28917:
	addi	$v0, $zero, 0
fbt_cont.28918:
	bne	$zero, $v0, beq_else.28919
	fneg	$f0, $f0
beq_else.28919:
beq_cont.28920:
	la	$t8, l.24620
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28921
	la	$t8, l.24627
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28923
	bne	$zero, $v0, beq_else.28925
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fdiv	$f0, $f1, $f0
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	la	$t8, l.23937
	flw	$f1, 0($t8)
	fsub	$f0, $f0, $f1
	j	fbt_cont.28922
beq_else.28925:
	la	$t8, l.23937
	flw	$f1, 0($t8)
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fdiv	$f0, $f2, $f0
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.24621
	flw	$f4, 0($t8)
	la	$t8, l.24622
	flw	$f5, 0($t8)
	la	$t8, l.24623
	flw	$f6, 0($t8)
	la	$t8, l.24624
	flw	$f7, 0($t8)
	la	$t8, l.24625
	flw	$f8, 0($t8)
	la	$t8, l.24626
	flw	$f9, 0($t8)
	fmul	$f9, $f9, $f2
	fsub	$f8, $f8, $f9
	fmul	$f8, $f8, $f2
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f2
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
beq_cont.28926:
	j	fbt_cont.28922
fbt_else.28923:
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fsub	$f1, $f0, $f1
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fadd	$f0, $f0, $f2
	fdiv	$f0, $f1, $f0
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	bne	$zero, $v0, beq_else.28927
	la	$t8, l.24628
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	j	fbt_cont.28922
beq_else.28927:
	la	$t8, l.23944
	flw	$f1, 0($t8)
	fadd	$f0, $f1, $f0
beq_cont.28928:
fbt_cont.28924:
	j	fbt_cont.28922
fbt_else.28921:
	bne	$zero, $v0, beq_else.28929
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	fneg	$f0, $f0
	j	beq_cont.28930
beq_else.28929:
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
beq_cont.28930:
fbt_cont.28922:
	la	$t8, l.24629
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	la	$t8, l.24630
	flw	$f1, 0($t8)
	fdiv	$f0, $f0, $f1
	j	beq_cont.28916
beq_else.28915:
	la	$t8, l.24619
	flw	$f0, 0($t8)
beq_cont.28916:
	fsw	$f0, -140($sp)
	sw	$ra, -144($sp)
	subi	$sp, $sp, 148
	jal	min_caml_floor
	addi	$sp, $sp, 148
	lw	$ra, -144($sp)
	flw	$f1, -140($sp)
	fsub	$f0, $f1, $f0
	la	$t8, l.24634
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	flw	$f3, -128($sp)
	fsub	$f2, $f2, $f3
	fmul	$f2, $f2, $f2
	fsub	$f1, $f1, $f2
	la	$t8, l.23876
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	fmul	$f0, $f0, $f0
	fsub	$f0, $f1, $f0
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28931
	addi	$v0, $zero, 0
	j	fbt_cont.28932
fbt_else.28931:
	addi	$v0, $zero, 1
fbt_cont.28932:
	bne	$zero, $v0, beq_else.28933
	j	beq_cont.28934
beq_else.28933:
	la	$t8, l.23884
	flw	$f0, 0($t8)
beq_cont.28934:
	la	$t8, l.24635
	flw	$f1, 0($t8)
	fmul	$f0, $f1, $f0
	la	$t8, l.24636
	flw	$f1, 0($t8)
	fdiv	$f0, $f0, $f1
	lw	$v0, -36($sp)
	fsw	$f0, 8($v0)
beq_else.28893:
beq_cont.28894:
beq_cont.28878:
beq_cont.28860:
beq_cont.28848:
	lw	$v0, -28($sp)
	lw	$v1, 0($v0)
	move	$v0, $zero
	sw	$ra, -144($sp)
	subi	$sp, $sp, 148
	jal	shadow_check_one_or_matrix.2894
	addi	$sp, $sp, 148
	lw	$ra, -144($sp)
	bne	$zero, $v0, beq_cont.28818
	lw	$v0, -44($sp)
	flw	$f0, 0($v0)
	lw	$v1, -24($sp)
	flw	$f1, 0($v1)
	fmul	$f0, $f0, $f1
	flw	$f1, 4($v0)
	flw	$f2, 4($v1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	flw	$f1, 8($v0)
	flw	$f2, 8($v1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	fneg	$f0, $f0
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28937
	addi	$v0, $zero, 0
	j	fbt_cont.28938
fbt_else.28937:
	addi	$v0, $zero, 1
fbt_cont.28938:
	bne	$zero, $v0, beq_else.28939
	la	$t8, l.23884
	flw	$f0, 0($t8)
beq_else.28939:
beq_cont.28940:
	flw	$f1, -20($sp)
	fmul	$f0, $f1, $f0
	lw	$v0, -68($sp)
	lw	$v0, 28($v0)
	flw	$f1, 0($v0)
	fmul	$f0, $f0, $f1
	lw	$v0, -16($sp)
	flw	$f1, 0($v0)
	lw	$v1, -36($sp)
	flw	$f2, 0($v1)
	fmul	$f2, $f0, $f2
	fadd	$f1, $f1, $f2
	fsw	$f1, 0($v0)
	flw	$f1, 4($v0)
	flw	$f2, 4($v1)
	fmul	$f2, $f0, $f2
	fadd	$f1, $f1, $f2
	fsw	$f1, 4($v0)
	flw	$f1, 8($v0)
	flw	$f2, 8($v1)
	fmul	$f0, $f0, $f2
	fadd	$f0, $f1, $f0
	fsw	$f0, 8($v0)
beq_else.28935:
beq_cont.28936:
beq_cont.28826:
	j	beq_cont.28818
beq_else.28817:
	addi	$s1, $a1, 1
	sll	$s1, $s1, 2
	add	$t8, $v0, $s1
	lw	$s1, 0($t8)
	la	$t8, l.24787
	flw	$f2, 0($t8)
	fdiv	$f1, $f1, $f2
	la	$t8, l.24517
	flw	$f2, 0($t8)
	fsw	$f2, 0($s0)
	lw	$s2, 0($t5)
	sw	$a2, -16($sp)
	fsw	$f1, -144($sp)
	sw	$t2, -24($sp)
	sw	$t5, -28($sp)
	fsw	$f0, -32($sp)
	sw	$t6, -36($sp)
	sw	$t0, -40($sp)
	sw	$t3, -44($sp)
	sw	$t1, -48($sp)
	sw	$s1, -148($sp)
	sw	$t4, -56($sp)
	sw	$a3, -60($sp)
	sw	$s0, -64($sp)
	move	$a0, $s1
	move	$v1, $s2
	move	$v0, $zero
	sw	$ra, -152($sp)
	subi	$sp, $sp, 156
	jal	trace_or_matrix_fast.2919
	addi	$sp, $sp, 156
	lw	$ra, -152($sp)
	lw	$v0, -64($sp)
	flw	$f0, 0($v0)
	la	$t8, l.24249
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28941
	addi	$v0, $zero, 0
	j	fbt_cont.28942
fbt_else.28941:
	addi	$v0, $zero, 1
fbt_cont.28942:
	bne	$zero, $v0, beq_else.28943
	addi	$v0, $zero, 0
	j	beq_cont.28944
beq_else.28943:
	la	$t8, l.24521
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28945
	addi	$v0, $zero, 0
	j	fbt_cont.28946
fbt_else.28945:
	addi	$v0, $zero, 1
fbt_cont.28946:
beq_cont.28944:
	bne	$zero, $v0, beq_else.28947
	j	beq_cont.28948
beq_else.28947:
	lw	$v0, -60($sp)
	lw	$v0, 0($v0)
	sll	$v0, $v0, 2
	lw	$v1, -56($sp)
	add	$t8, $v1, $v0
	lw	$v0, 0($t8)
	lw	$v1, -148($sp)
	lw	$v1, 0($v1)
	lw	$a0, 4($v0)
	sw	$v0, -152($sp)
	addi	$t8, $zero, 1
	bne	$t8, $a0, beq_else.28949
	lw	$a0, -48($sp)
	lw	$a0, 0($a0)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	lw	$a1, -44($sp)
	fsw	$f0, 0($a1)
	fsw	$f0, 4($a1)
	fsw	$f0, 8($a1)
	subi	$a2, $a0, 1
	subi	$a0, $a0, 1
	sll	$a0, $a0, 2
	add	$t8, $v1, $a0
	flw	$f0, 0($t8)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28951
	addi	$v1, $zero, 1
	j	fbt_cont.28952
fbt_else.28951:
	addi	$v1, $zero, 0
fbt_cont.28952:
	bne	$zero, $v1, beq_else.28953
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28955
	addi	$v1, $zero, 0
	j	fbt_cont.28956
fbt_else.28955:
	addi	$v1, $zero, 1
fbt_cont.28956:
	bne	$zero, $v1, beq_else.28957
	la	$t8, l.23917
	flw	$f0, 0($t8)
	j	beq_cont.28954
beq_else.28957:
	la	$t8, l.23916
	flw	$f0, 0($t8)
beq_cont.28958:
	j	beq_cont.28954
beq_else.28953:
	la	$t8, l.23884
	flw	$f0, 0($t8)
beq_cont.28954:
	fneg	$f0, $f0
	sll	$v1, $a2, 2
	add	$t8, $a1, $v1
	fsw	$f0, 0($t8)
	j	beq_cont.28950
beq_else.28949:
	addi	$t8, $zero, 2
	bne	$t8, $a0, beq_else.28959
	lw	$v1, 16($v0)
	flw	$f0, 0($v1)
	fneg	$f0, $f0
	lw	$v1, -44($sp)
	fsw	$f0, 0($v1)
	lw	$a0, 16($v0)
	flw	$f0, 4($a0)
	fneg	$f0, $f0
	fsw	$f0, 4($v1)
	lw	$a0, 16($v0)
	flw	$f0, 8($a0)
	fneg	$f0, $f0
	fsw	$f0, 8($v1)
	j	beq_cont.28960
beq_else.28959:
	lw	$v1, -40($sp)
	flw	$f0, 0($v1)
	lw	$a0, 20($v0)
	flw	$f1, 0($a0)
	fsub	$f0, $f0, $f1
	flw	$f1, 4($v1)
	lw	$a0, 20($v0)
	flw	$f2, 4($a0)
	fsub	$f1, $f1, $f2
	flw	$f2, 8($v1)
	lw	$a0, 20($v0)
	flw	$f3, 8($a0)
	fsub	$f2, $f2, $f3
	lw	$a0, 16($v0)
	flw	$f3, 0($a0)
	fmul	$f3, $f0, $f3
	lw	$a0, 16($v0)
	flw	$f4, 4($a0)
	fmul	$f4, $f1, $f4
	lw	$a0, 16($v0)
	flw	$f5, 8($a0)
	fmul	$f5, $f2, $f5
	lw	$a0, 12($v0)
	bne	$zero, $a0, beq_else.28961
	lw	$a0, -44($sp)
	fsw	$f3, 0($a0)
	fsw	$f4, 4($a0)
	fsw	$f5, 8($a0)
	j	beq_cont.28962
beq_else.28961:
	lw	$a0, 36($v0)
	flw	$f6, 8($a0)
	fmul	$f6, $f1, $f6
	lw	$a0, 36($v0)
	flw	$f7, 4($a0)
	fmul	$f7, $f2, $f7
	fadd	$f6, $f6, $f7
	la	$t8, l.23876
	flw	$f7, 0($t8)
	fmul	$f6, $f6, $f7
	fadd	$f3, $f3, $f6
	lw	$a0, -44($sp)
	fsw	$f3, 0($a0)
	lw	$a1, 36($v0)
	flw	$f3, 8($a1)
	fmul	$f3, $f0, $f3
	lw	$a1, 36($v0)
	flw	$f6, 0($a1)
	fmul	$f2, $f2, $f6
	fadd	$f2, $f3, $f2
	la	$t8, l.23876
	flw	$f3, 0($t8)
	fmul	$f2, $f2, $f3
	fadd	$f2, $f4, $f2
	fsw	$f2, 4($a0)
	lw	$a1, 36($v0)
	flw	$f2, 4($a1)
	fmul	$f0, $f0, $f2
	lw	$a1, 36($v0)
	flw	$f2, 0($a1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	la	$t8, l.23876
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	fadd	$f0, $f5, $f0
	fsw	$f0, 8($a0)
beq_cont.28962:
	lw	$a1, 24($v0)
	flw	$f0, 0($a0)
	fmul	$f0, $f0, $f0
	flw	$f1, 4($a0)
	fmul	$f1, $f1, $f1
	fadd	$f0, $f0, $f1
	flw	$f1, 8($a0)
	fmul	$f1, $f1, $f1
	fadd	$f0, $f0, $f1
	sw	$a1, -156($sp)
	sw	$ra, -160($sp)
	subi	$sp, $sp, 164
	jal	min_caml_sqrt
	addi	$sp, $sp, 164
	lw	$ra, -160($sp)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.28963
	addi	$v0, $zero, 1
	j	fbt_cont.28964
fbt_else.28963:
	addi	$v0, $zero, 0
fbt_cont.28964:
	bne	$zero, $v0, beq_else.28965
	lw	$v0, -156($sp)
	bne	$zero, $v0, beq_else.28967
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fdiv	$f0, $f1, $f0
	j	beq_cont.28966
beq_else.28967:
	la	$t8, l.23917
	flw	$f1, 0($t8)
	fdiv	$f0, $f1, $f0
beq_cont.28968:
	j	beq_cont.28966
beq_else.28965:
	la	$t8, l.23916
	flw	$f0, 0($t8)
beq_cont.28966:
	lw	$v0, -44($sp)
	flw	$f1, 0($v0)
	fmul	$f1, $f1, $f0
	fsw	$f1, 0($v0)
	flw	$f1, 4($v0)
	fmul	$f1, $f1, $f0
	fsw	$f1, 4($v0)
	flw	$f1, 8($v0)
	fmul	$f0, $f1, $f0
	fsw	$f0, 8($v0)
beq_cont.28960:
beq_cont.28950:
	lw	$v0, -152($sp)
	lw	$v1, 0($v0)
	lw	$a0, 32($v0)
	flw	$f0, 0($a0)
	lw	$a0, -36($sp)
	fsw	$f0, 0($a0)
	lw	$a1, 32($v0)
	flw	$f0, 4($a1)
	fsw	$f0, 4($a0)
	lw	$a1, 32($v0)
	flw	$f0, 8($a1)
	fsw	$f0, 8($a0)
	addi	$t8, $zero, 1
	bne	$t8, $v1, beq_else.28969
	lw	$v1, -40($sp)
	flw	$f0, 0($v1)
	lw	$a1, 20($v0)
	flw	$f1, 0($a1)
	fsub	$f0, $f0, $f1
	la	$t8, l.24669
	flw	$f1, 0($t8)
	fmul	$f1, $f0, $f1
	fsw	$f0, -160($sp)
	fmove	$f0, $f1
	sw	$ra, -164($sp)
	subi	$sp, $sp, 168
	jal	min_caml_floor
	addi	$sp, $sp, 168
	lw	$ra, -164($sp)
	la	$t8, l.24670
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	flw	$f1, -160($sp)
	fsub	$f0, $f1, $f0
	la	$t8, l.24642
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28971
	addi	$v0, $zero, 0
	j	fbt_cont.28972
fbt_else.28971:
	addi	$v0, $zero, 1
fbt_cont.28972:
	lw	$v1, -40($sp)
	flw	$f0, 8($v1)
	lw	$v1, -152($sp)
	lw	$a0, 20($v1)
	flw	$f1, 8($a0)
	fsub	$f0, $f0, $f1
	la	$t8, l.24669
	flw	$f1, 0($t8)
	fmul	$f1, $f0, $f1
	sw	$v0, -164($sp)
	fsw	$f0, -168($sp)
	fmove	$f0, $f1
	sw	$ra, -172($sp)
	subi	$sp, $sp, 176
	jal	min_caml_floor
	addi	$sp, $sp, 176
	lw	$ra, -172($sp)
	la	$t8, l.24670
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	flw	$f1, -168($sp)
	fsub	$f0, $f1, $f0
	la	$t8, l.24642
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28973
	addi	$v0, $zero, 0
	j	fbt_cont.28974
fbt_else.28973:
	addi	$v0, $zero, 1
fbt_cont.28974:
	lw	$v1, -164($sp)
	bne	$zero, $v1, beq_else.28975
	bne	$zero, $v0, beq_else.28977
	la	$t8, l.24635
	flw	$f0, 0($t8)
	j	beq_cont.28976
beq_else.28977:
	la	$t8, l.23884
	flw	$f0, 0($t8)
beq_cont.28978:
	j	beq_cont.28976
beq_else.28975:
	bne	$zero, $v0, beq_else.28979
	la	$t8, l.23884
	flw	$f0, 0($t8)
	j	beq_cont.28980
beq_else.28979:
	la	$t8, l.24635
	flw	$f0, 0($t8)
beq_cont.28980:
beq_cont.28976:
	lw	$v0, -36($sp)
	fsw	$f0, 4($v0)
	j	beq_cont.28970
beq_else.28969:
	addi	$t8, $zero, 2
	bne	$t8, $v1, beq_else.28981
	lw	$v1, -40($sp)
	flw	$f0, 4($v1)
	la	$t8, l.24658
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.28983
	addi	$v1, $zero, 1
	j	fbt_cont.28984
fbt_else.28983:
	addi	$v1, $zero, 0
fbt_cont.28984:
	bne	$zero, $v1, beq_else.28985
	fneg	$f0, $f0
beq_else.28985:
beq_cont.28986:
	la	$t8, l.23875
	flw	$f1, 0($t8)
	sw	$v1, -172($sp)
	fsw	$f0, -176($sp)
	sw	$ra, -180($sp)
	subi	$sp, $sp, 184
	jal	adjust_exp.2562
	addi	$sp, $sp, 184
	lw	$ra, -180($sp)
	fmove	$f1, $f0
	flw	$f0, -176($sp)
	sw	$ra, -180($sp)
	subi	$sp, $sp, 184
	jal	sub_iter.2565
	addi	$sp, $sp, 184
	lw	$ra, -180($sp)
	flw	$f1, -32($sp)
	fle	$f1, $f0
	fbf	fbt_else.28987
	lw	$v0, -172($sp)
	bne	$zero, $v0, beq_else.28989
	addi	$v0, $zero, 1
	j	beq_cont.28990
beq_else.28989:
	addi	$v0, $zero, 0
beq_cont.28990:
	fsub	$f0, $f0, $f1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.28988
fbt_else.28987:
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	lw	$v1, -172($sp)
	sw	$v1, 0($v0)
fbt_cont.28988:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.28991
	fsub	$f0, $f1, $f0
fbt_else.28991:
fbt_cont.28992:
	la	$t8, l.23944
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.28993
	bne	$zero, $v0, beq_else.28995
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	fneg	$f0, $f0
	j	fbt_cont.28994
beq_else.28995:
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
beq_cont.28996:
	j	fbt_cont.28994
fbt_else.28993:
	la	$t8, l.23937
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	bne	$zero, $v0, beq_else.28997
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
	fneg	$f0, $f0
	j	beq_cont.28998
beq_else.28997:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
beq_cont.28998:
fbt_cont.28994:
	fmul	$f0, $f0, $f0
	la	$t8, l.24635
	flw	$f1, 0($t8)
	fmul	$f1, $f1, $f0
	lw	$v0, -36($sp)
	fsw	$f1, 0($v0)
	la	$t8, l.24635
	flw	$f1, 0($t8)
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	fmul	$f0, $f1, $f0
	fsw	$f0, 4($v0)
	j	beq_cont.28982
beq_else.28981:
	addi	$t8, $zero, 3
	bne	$t8, $v1, beq_else.28999
	lw	$v1, -40($sp)
	flw	$f0, 0($v1)
	lw	$a1, 20($v0)
	flw	$f1, 0($a1)
	fsub	$f0, $f0, $f1
	flw	$f1, 8($v1)
	lw	$v1, 20($v0)
	flw	$f2, 8($v1)
	fsub	$f1, $f1, $f2
	fmul	$f0, $f0, $f0
	fmul	$f1, $f1, $f1
	fadd	$f0, $f0, $f1
	sw	$ra, -180($sp)
	subi	$sp, $sp, 184
	jal	min_caml_sqrt
	addi	$sp, $sp, 184
	lw	$ra, -180($sp)
	la	$t8, l.24642
	flw	$f1, 0($t8)
	fdiv	$f0, $f0, $f1
	fsw	$f0, -180($sp)
	sw	$ra, -184($sp)
	subi	$sp, $sp, 188
	jal	min_caml_floor
	addi	$sp, $sp, 188
	lw	$ra, -184($sp)
	flw	$f1, -180($sp)
	fsub	$f0, $f1, $f0
	la	$t8, l.24630
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.29001
	j	fbt_cont.29002
fbt_else.29001:
	fneg	$f0, $f0
fbt_cont.29002:
	la	$t8, l.23875
	flw	$f1, 0($t8)
	fsw	$f0, -184($sp)
	sw	$ra, -188($sp)
	subi	$sp, $sp, 192
	jal	adjust_exp.2562
	addi	$sp, $sp, 192
	lw	$ra, -188($sp)
	fmove	$f1, $f0
	flw	$f0, -184($sp)
	sw	$ra, -188($sp)
	subi	$sp, $sp, 192
	jal	sub_iter.2565
	addi	$sp, $sp, 192
	lw	$ra, -188($sp)
	flw	$f1, -32($sp)
	fle	$f1, $f0
	fbf	fbt_else.29003
	fsub	$f0, $f0, $f1
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	sw	$zero, 0($v0)
	j	fbt_cont.29004
fbt_else.29003:
	addi	$v0, $zero, 1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.29004:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.29005
	bne	$zero, $v0, beq_else.29007
	addi	$v0, $zero, 1
	j	beq_cont.29008
beq_else.29007:
	addi	$v0, $zero, 0
beq_cont.29008:
	fsub	$f0, $f1, $f0
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.29006
fbt_else.29005:
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.29006:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23944
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.29009
	bne	$zero, $v0, beq_else.29011
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
	fneg	$f0, $f0
	j	fbt_cont.29010
beq_else.29011:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
beq_cont.29012:
	j	fbt_cont.29010
fbt_else.29009:
	la	$t8, l.23937
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	bne	$zero, $v0, beq_else.29013
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	fneg	$f0, $f0
	j	beq_cont.29014
beq_else.29013:
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
beq_cont.29014:
fbt_cont.29010:
	fmul	$f0, $f0, $f0
	la	$t8, l.24635
	flw	$f1, 0($t8)
	fmul	$f1, $f0, $f1
	lw	$v0, -36($sp)
	fsw	$f1, 4($v0)
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	la	$t8, l.24635
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	fsw	$f0, 8($v0)
	j	beq_cont.29000
beq_else.28999:
	addi	$t8, $zero, 4
	bne	$t8, $v1, beq_else.29015
	lw	$v1, -40($sp)
	flw	$f0, 0($v1)
	lw	$a1, 20($v0)
	flw	$f1, 0($a1)
	fsub	$f0, $f0, $f1
	lw	$a1, 16($v0)
	flw	$f1, 0($a1)
	fsw	$f0, -188($sp)
	fmove	$f0, $f1
	sw	$ra, -192($sp)
	subi	$sp, $sp, 196
	jal	min_caml_sqrt
	addi	$sp, $sp, 196
	lw	$ra, -192($sp)
	flw	$f1, -188($sp)
	fmul	$f0, $f1, $f0
	lw	$v0, -40($sp)
	flw	$f1, 8($v0)
	lw	$v1, -152($sp)
	lw	$a0, 20($v1)
	flw	$f2, 8($a0)
	fsub	$f1, $f1, $f2
	lw	$a0, 16($v1)
	flw	$f2, 8($a0)
	fsw	$f0, -192($sp)
	fsw	$f1, -196($sp)
	fmove	$f0, $f2
	sw	$ra, -200($sp)
	subi	$sp, $sp, 204
	jal	min_caml_sqrt
	addi	$sp, $sp, 204
	lw	$ra, -200($sp)
	flw	$f1, -196($sp)
	fmul	$f0, $f1, $f0
	flw	$f1, -192($sp)
	fmul	$f2, $f1, $f1
	fmul	$f3, $f0, $f0
	fadd	$f2, $f2, $f3
	fsw	$f2, -200($sp)
	fsw	$f0, -204($sp)
	fmove	$f0, $f1
	sw	$ra, -208($sp)
	subi	$sp, $sp, 212
	jal	min_caml_fabs
	addi	$sp, $sp, 212
	lw	$ra, -208($sp)
	la	$t8, l.24618
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.29017
	addi	$v0, $zero, 0
	j	fbt_cont.29018
fbt_else.29017:
	addi	$v0, $zero, 1
fbt_cont.29018:
	bne	$zero, $v0, beq_else.29019
	flw	$f0, -192($sp)
	flw	$f1, -204($sp)
	fdiv	$f0, $f1, $f0
	sw	$ra, -208($sp)
	subi	$sp, $sp, 212
	jal	min_caml_fabs
	addi	$sp, $sp, 212
	lw	$ra, -208($sp)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.29021
	addi	$v0, $zero, 1
	j	fbt_cont.29022
fbt_else.29021:
	addi	$v0, $zero, 0
fbt_cont.29022:
	bne	$zero, $v0, beq_else.29023
	fneg	$f0, $f0
beq_else.29023:
beq_cont.29024:
	la	$t8, l.24620
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.29025
	la	$t8, l.24627
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.29027
	bne	$zero, $v0, beq_else.29029
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fdiv	$f0, $f1, $f0
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	la	$t8, l.23937
	flw	$f1, 0($t8)
	fsub	$f0, $f0, $f1
	j	fbt_cont.29026
beq_else.29029:
	la	$t8, l.23937
	flw	$f1, 0($t8)
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fdiv	$f0, $f2, $f0
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.24621
	flw	$f4, 0($t8)
	la	$t8, l.24622
	flw	$f5, 0($t8)
	la	$t8, l.24623
	flw	$f6, 0($t8)
	la	$t8, l.24624
	flw	$f7, 0($t8)
	la	$t8, l.24625
	flw	$f8, 0($t8)
	la	$t8, l.24626
	flw	$f9, 0($t8)
	fmul	$f9, $f9, $f2
	fsub	$f8, $f8, $f9
	fmul	$f8, $f8, $f2
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f2
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
beq_cont.29030:
	j	fbt_cont.29026
fbt_else.29027:
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fsub	$f1, $f0, $f1
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fadd	$f0, $f0, $f2
	fdiv	$f0, $f1, $f0
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	bne	$zero, $v0, beq_else.29031
	la	$t8, l.24628
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	j	fbt_cont.29026
beq_else.29031:
	la	$t8, l.23944
	flw	$f1, 0($t8)
	fadd	$f0, $f1, $f0
beq_cont.29032:
fbt_cont.29028:
	j	fbt_cont.29026
fbt_else.29025:
	bne	$zero, $v0, beq_else.29033
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	fneg	$f0, $f0
	j	beq_cont.29034
beq_else.29033:
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
beq_cont.29034:
fbt_cont.29026:
	la	$t8, l.24629
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	la	$t8, l.24630
	flw	$f1, 0($t8)
	fdiv	$f0, $f0, $f1
	j	beq_cont.29020
beq_else.29019:
	la	$t8, l.24619
	flw	$f0, 0($t8)
beq_cont.29020:
	fsw	$f0, -208($sp)
	sw	$ra, -212($sp)
	subi	$sp, $sp, 216
	jal	min_caml_floor
	addi	$sp, $sp, 216
	lw	$ra, -212($sp)
	flw	$f1, -208($sp)
	fsub	$f0, $f1, $f0
	lw	$v0, -40($sp)
	flw	$f1, 4($v0)
	lw	$v0, -152($sp)
	lw	$v1, 20($v0)
	flw	$f2, 4($v1)
	fsub	$f1, $f1, $f2
	lw	$v1, 16($v0)
	flw	$f2, 4($v1)
	fsw	$f0, -212($sp)
	fsw	$f1, -216($sp)
	fmove	$f0, $f2
	sw	$ra, -220($sp)
	subi	$sp, $sp, 224
	jal	min_caml_sqrt
	addi	$sp, $sp, 224
	lw	$ra, -220($sp)
	flw	$f1, -216($sp)
	fmul	$f0, $f1, $f0
	flw	$f1, -200($sp)
	fsw	$f0, -220($sp)
	fmove	$f0, $f1
	sw	$ra, -224($sp)
	subi	$sp, $sp, 228
	jal	min_caml_fabs
	addi	$sp, $sp, 228
	lw	$ra, -224($sp)
	la	$t8, l.24618
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.29035
	addi	$v0, $zero, 0
	j	fbt_cont.29036
fbt_else.29035:
	addi	$v0, $zero, 1
fbt_cont.29036:
	bne	$zero, $v0, beq_else.29037
	flw	$f0, -200($sp)
	flw	$f1, -220($sp)
	fdiv	$f0, $f1, $f0
	sw	$ra, -224($sp)
	subi	$sp, $sp, 228
	jal	min_caml_fabs
	addi	$sp, $sp, 228
	lw	$ra, -224($sp)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.29039
	addi	$v0, $zero, 1
	j	fbt_cont.29040
fbt_else.29039:
	addi	$v0, $zero, 0
fbt_cont.29040:
	bne	$zero, $v0, beq_else.29041
	fneg	$f0, $f0
beq_else.29041:
beq_cont.29042:
	la	$t8, l.24620
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.29043
	la	$t8, l.24627
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.29045
	bne	$zero, $v0, beq_else.29047
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fdiv	$f0, $f1, $f0
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	la	$t8, l.23937
	flw	$f1, 0($t8)
	fsub	$f0, $f0, $f1
	j	fbt_cont.29044
beq_else.29047:
	la	$t8, l.23937
	flw	$f1, 0($t8)
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fdiv	$f0, $f2, $f0
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.24621
	flw	$f4, 0($t8)
	la	$t8, l.24622
	flw	$f5, 0($t8)
	la	$t8, l.24623
	flw	$f6, 0($t8)
	la	$t8, l.24624
	flw	$f7, 0($t8)
	la	$t8, l.24625
	flw	$f8, 0($t8)
	la	$t8, l.24626
	flw	$f9, 0($t8)
	fmul	$f9, $f9, $f2
	fsub	$f8, $f8, $f9
	fmul	$f8, $f8, $f2
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f2
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
beq_cont.29048:
	j	fbt_cont.29044
fbt_else.29045:
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fsub	$f1, $f0, $f1
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fadd	$f0, $f0, $f2
	fdiv	$f0, $f1, $f0
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	bne	$zero, $v0, beq_else.29049
	la	$t8, l.24628
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	j	fbt_cont.29044
beq_else.29049:
	la	$t8, l.23944
	flw	$f1, 0($t8)
	fadd	$f0, $f1, $f0
beq_cont.29050:
fbt_cont.29046:
	j	fbt_cont.29044
fbt_else.29043:
	bne	$zero, $v0, beq_else.29051
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	fneg	$f0, $f0
	j	beq_cont.29052
beq_else.29051:
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.24621
	flw	$f3, 0($t8)
	la	$t8, l.24622
	flw	$f4, 0($t8)
	la	$t8, l.24623
	flw	$f5, 0($t8)
	la	$t8, l.24624
	flw	$f6, 0($t8)
	la	$t8, l.24625
	flw	$f7, 0($t8)
	la	$t8, l.24626
	flw	$f8, 0($t8)
	fmul	$f8, $f8, $f1
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f1
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f1
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
beq_cont.29052:
fbt_cont.29044:
	la	$t8, l.24629
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	la	$t8, l.24630
	flw	$f1, 0($t8)
	fdiv	$f0, $f0, $f1
	j	beq_cont.29038
beq_else.29037:
	la	$t8, l.24619
	flw	$f0, 0($t8)
beq_cont.29038:
	fsw	$f0, -224($sp)
	sw	$ra, -228($sp)
	subi	$sp, $sp, 232
	jal	min_caml_floor
	addi	$sp, $sp, 232
	lw	$ra, -228($sp)
	flw	$f1, -224($sp)
	fsub	$f0, $f1, $f0
	la	$t8, l.24634
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	flw	$f3, -212($sp)
	fsub	$f2, $f2, $f3
	fmul	$f2, $f2, $f2
	fsub	$f1, $f1, $f2
	la	$t8, l.23876
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	fmul	$f0, $f0, $f0
	fsub	$f0, $f1, $f0
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.29053
	addi	$v0, $zero, 0
	j	fbt_cont.29054
fbt_else.29053:
	addi	$v0, $zero, 1
fbt_cont.29054:
	bne	$zero, $v0, beq_else.29055
	j	beq_cont.29056
beq_else.29055:
	la	$t8, l.23884
	flw	$f0, 0($t8)
beq_cont.29056:
	la	$t8, l.24635
	flw	$f1, 0($t8)
	fmul	$f0, $f1, $f0
	la	$t8, l.24636
	flw	$f1, 0($t8)
	fdiv	$f0, $f0, $f1
	lw	$v0, -36($sp)
	fsw	$f0, 8($v0)
beq_else.29015:
beq_cont.29016:
beq_cont.29000:
beq_cont.28982:
beq_cont.28970:
	lw	$v0, -28($sp)
	lw	$v1, 0($v0)
	move	$v0, $zero
	sw	$ra, -228($sp)
	subi	$sp, $sp, 232
	jal	shadow_check_one_or_matrix.2894
	addi	$sp, $sp, 232
	lw	$ra, -228($sp)
	bne	$zero, $v0, beq_else.29057
	lw	$v0, -44($sp)
	flw	$f0, 0($v0)
	lw	$v1, -24($sp)
	flw	$f1, 0($v1)
	fmul	$f0, $f0, $f1
	flw	$f1, 4($v0)
	flw	$f2, 4($v1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	flw	$f1, 8($v0)
	flw	$f2, 8($v1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	fneg	$f0, $f0
	la	$t8, l.23884
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.29059
	addi	$v0, $zero, 0
	j	fbt_cont.29060
fbt_else.29059:
	addi	$v0, $zero, 1
fbt_cont.29060:
	bne	$zero, $v0, beq_else.29061
	la	$t8, l.23884
	flw	$f0, 0($t8)
beq_else.29061:
beq_cont.29062:
	flw	$f1, -144($sp)
	fmul	$f0, $f1, $f0
	lw	$v0, -152($sp)
	lw	$v0, 28($v0)
	flw	$f1, 0($v0)
	fmul	$f0, $f0, $f1
	lw	$v0, -16($sp)
	flw	$f1, 0($v0)
	lw	$v1, -36($sp)
	flw	$f2, 0($v1)
	fmul	$f2, $f0, $f2
	fadd	$f1, $f1, $f2
	fsw	$f1, 0($v0)
	flw	$f1, 4($v0)
	flw	$f2, 4($v1)
	fmul	$f2, $f0, $f2
	fadd	$f1, $f1, $f2
	fsw	$f1, 4($v0)
	flw	$f1, 8($v0)
	flw	$f2, 8($v1)
	fmul	$f0, $f0, $f2
	fadd	$f0, $f1, $f0
	fsw	$f0, 8($v0)
beq_else.29057:
beq_cont.29058:
beq_cont.28948:
beq_cont.28818:
	lw	$v0, -12($sp)
	subi	$a1, $v0, 2
	lw	$v0, -8($sp)
	lw	$v1, -4($sp)
	lw	$a0, 0($sp)
	j	iter_trace_diffuse_rays.2955
beq_else.28814:
	jr	$ra
do_without_neighbors.2977:
	lui	$a0, 512
	ori	$a0, $a0, 592
	lui	$a1, 512
	ori	$a1, $a1, 716
	lui	$a2, 512
	lui	$a3, 512
	ori	$a3, $a3, 604
	lui	$t0, 512
	ori	$t0, $t0, 648
	sgti	$t8, $v1, 4
	bne	$t8, $zero, beq_else.29064
	lw	$t1, 8($v0)
	sll	$t2, $v1, 2
	add	$t8, $t1, $t2
	lw	$t1, 0($t8)
	slti	$t8, $t1, 0
	bne	$t8, $zero, beq_else.29065
	lw	$t1, 12($v0)
	sll	$t2, $v1, 2
	add	$t8, $t1, $t2
	lw	$t1, 0($t8)
	sw	$v0, 0($sp)
	sw	$v1, -4($sp)
	bne	$zero, $t1, beq_else.29066
	j	beq_cont.29067
beq_else.29066:
	lw	$t1, 20($v0)
	lw	$t2, 28($v0)
	lw	$t3, 4($v0)
	lw	$t4, 16($v0)
	sll	$t5, $v1, 2
	add	$t8, $t1, $t5
	lw	$t1, 0($t8)
	flw	$f0, 0($t1)
	fsw	$f0, 0($a0)
	flw	$f0, 4($t1)
	fsw	$f0, 4($a0)
	flw	$f0, 8($t1)
	fsw	$f0, 8($a0)
	lw	$t1, 24($v0)
	lw	$t1, 0($t1)
	sll	$t5, $v1, 2
	add	$t8, $t2, $t5
	lw	$t2, 0($t8)
	sll	$t5, $v1, 2
	add	$t8, $t3, $t5
	lw	$t3, 0($t8)
	sw	$a0, -8($sp)
	sw	$a3, -12($sp)
	sw	$t4, -16($sp)
	sw	$t2, -20($sp)
	sw	$a2, -24($sp)
	sw	$t0, -28($sp)
	sw	$t3, -32($sp)
	sw	$a1, -36($sp)
	sw	$t1, -40($sp)
	bne	$zero, $t1, beq_else.29068
	j	beq_cont.29069
beq_else.29068:
	lw	$t5, 0($a1)
	flw	$f0, 0($t3)
	fsw	$f0, 0($t0)
	flw	$f0, 4($t3)
	fsw	$f0, 4($t0)
	flw	$f0, 8($t3)
	fsw	$f0, 8($t0)
	lw	$t6, 0($a2)
	subi	$t6, $t6, 1
	sw	$t5, -44($sp)
	move	$v1, $t6
	move	$v0, $t3
	sw	$ra, -48($sp)
	subi	$sp, $sp, 52
	jal	setup_startp_constants.2857
	addi	$sp, $sp, 52
	lw	$ra, -48($sp)
	addi	$a1, $zero, 118
	lw	$v0, -44($sp)
	lw	$v1, -20($sp)
	lw	$a0, -32($sp)
	sw	$ra, -48($sp)
	subi	$sp, $sp, 52
	jal	iter_trace_diffuse_rays.2955
	addi	$sp, $sp, 52
	lw	$ra, -48($sp)
beq_cont.29069:
	lw	$v0, -40($sp)
	addi	$t8, $zero, 1
	bne	$t8, $v0, beq_else.29070
	j	beq_cont.29071
beq_else.29070:
	lw	$v1, -36($sp)
	lw	$a0, 4($v1)
	lw	$a1, -32($sp)
	flw	$f0, 0($a1)
	lw	$a2, -28($sp)
	fsw	$f0, 0($a2)
	flw	$f0, 4($a1)
	fsw	$f0, 4($a2)
	flw	$f0, 8($a1)
	fsw	$f0, 8($a2)
	lw	$a3, -24($sp)
	lw	$t0, 0($a3)
	subi	$t0, $t0, 1
	sw	$a0, -48($sp)
	move	$v1, $t0
	move	$v0, $a1
	sw	$ra, -52($sp)
	subi	$sp, $sp, 56
	jal	setup_startp_constants.2857
	addi	$sp, $sp, 56
	lw	$ra, -52($sp)
	addi	$a1, $zero, 118
	lw	$v0, -48($sp)
	lw	$v1, -20($sp)
	lw	$a0, -32($sp)
	sw	$ra, -52($sp)
	subi	$sp, $sp, 56
	jal	iter_trace_diffuse_rays.2955
	addi	$sp, $sp, 56
	lw	$ra, -52($sp)
beq_cont.29071:
	lw	$v0, -40($sp)
	addi	$t8, $zero, 2
	bne	$t8, $v0, beq_else.29072
	j	beq_cont.29073
beq_else.29072:
	lw	$v1, -36($sp)
	lw	$a0, 8($v1)
	lw	$a1, -32($sp)
	flw	$f0, 0($a1)
	lw	$a2, -28($sp)
	fsw	$f0, 0($a2)
	flw	$f0, 4($a1)
	fsw	$f0, 4($a2)
	flw	$f0, 8($a1)
	fsw	$f0, 8($a2)
	lw	$a3, -24($sp)
	lw	$t0, 0($a3)
	subi	$t0, $t0, 1
	sw	$a0, -52($sp)
	move	$v1, $t0
	move	$v0, $a1
	sw	$ra, -56($sp)
	subi	$sp, $sp, 60
	jal	setup_startp_constants.2857
	addi	$sp, $sp, 60
	lw	$ra, -56($sp)
	addi	$a1, $zero, 118
	lw	$v0, -52($sp)
	lw	$v1, -20($sp)
	lw	$a0, -32($sp)
	sw	$ra, -56($sp)
	subi	$sp, $sp, 60
	jal	iter_trace_diffuse_rays.2955
	addi	$sp, $sp, 60
	lw	$ra, -56($sp)
beq_cont.29073:
	lw	$v0, -40($sp)
	addi	$t8, $zero, 3
	bne	$t8, $v0, beq_else.29074
	j	beq_cont.29075
beq_else.29074:
	lw	$v1, -36($sp)
	lw	$a0, 12($v1)
	lw	$a1, -32($sp)
	flw	$f0, 0($a1)
	lw	$a2, -28($sp)
	fsw	$f0, 0($a2)
	flw	$f0, 4($a1)
	fsw	$f0, 4($a2)
	flw	$f0, 8($a1)
	fsw	$f0, 8($a2)
	lw	$a3, -24($sp)
	lw	$t0, 0($a3)
	subi	$t0, $t0, 1
	sw	$a0, -56($sp)
	move	$v1, $t0
	move	$v0, $a1
	sw	$ra, -60($sp)
	subi	$sp, $sp, 64
	jal	setup_startp_constants.2857
	addi	$sp, $sp, 64
	lw	$ra, -60($sp)
	addi	$a1, $zero, 118
	lw	$v0, -56($sp)
	lw	$v1, -20($sp)
	lw	$a0, -32($sp)
	sw	$ra, -60($sp)
	subi	$sp, $sp, 64
	jal	iter_trace_diffuse_rays.2955
	addi	$sp, $sp, 64
	lw	$ra, -60($sp)
beq_cont.29075:
	lw	$v0, -40($sp)
	addi	$t8, $zero, 4
	bne	$t8, $v0, beq_else.29076
	j	beq_cont.29077
beq_else.29076:
	lw	$v0, -36($sp)
	lw	$v0, 16($v0)
	lw	$v1, -32($sp)
	flw	$f0, 0($v1)
	lw	$a0, -28($sp)
	fsw	$f0, 0($a0)
	flw	$f0, 4($v1)
	fsw	$f0, 4($a0)
	flw	$f0, 8($v1)
	fsw	$f0, 8($a0)
	lw	$a0, -24($sp)
	lw	$a0, 0($a0)
	subi	$a0, $a0, 1
	sw	$v0, -60($sp)
	move	$v0, $v1
	move	$v1, $a0
	sw	$ra, -64($sp)
	subi	$sp, $sp, 68
	jal	setup_startp_constants.2857
	addi	$sp, $sp, 68
	lw	$ra, -64($sp)
	addi	$a1, $zero, 118
	lw	$v0, -60($sp)
	lw	$v1, -20($sp)
	lw	$a0, -32($sp)
	sw	$ra, -64($sp)
	subi	$sp, $sp, 68
	jal	iter_trace_diffuse_rays.2955
	addi	$sp, $sp, 68
	lw	$ra, -64($sp)
beq_cont.29077:
	lw	$v0, -4($sp)
	sll	$v1, $v0, 2
	lw	$a0, -16($sp)
	add	$t8, $a0, $v1
	lw	$v1, 0($t8)
	lw	$a0, -12($sp)
	flw	$f0, 0($a0)
	flw	$f1, 0($v1)
	lw	$a1, -8($sp)
	flw	$f2, 0($a1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	fsw	$f0, 0($a0)
	flw	$f0, 4($a0)
	flw	$f1, 4($v1)
	flw	$f2, 4($a1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	fsw	$f0, 4($a0)
	flw	$f0, 8($a0)
	flw	$f1, 8($v1)
	flw	$f2, 8($a1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	fsw	$f0, 8($a0)
beq_cont.29067:
	lw	$v0, -4($sp)
	addi	$v1, $v0, 1
	lw	$v0, 0($sp)
	j	do_without_neighbors.2977
beq_else.29065:
	jr	$ra
beq_else.29064:
	jr	$ra
try_exploit_neighbors.2993:
	sll	$t0, $v0, 2
	add	$t8, $a1, $t0
	lw	$t0, 0($t8)
	lui	$t1, 512
	ori	$t1, $t1, 592
	lui	$t2, 512
	ori	$t2, $t2, 604
	sgti	$t8, $a3, 4
	bne	$t8, $zero, beq_else.29080
	lw	$t3, 8($t0)
	sll	$t4, $a3, 2
	add	$t8, $t3, $t4
	lw	$t3, 0($t8)
	slti	$t8, $t3, 0
	bne	$t8, $zero, beq_else.29081
	sll	$t3, $v0, 2
	add	$t8, $a1, $t3
	lw	$t3, 0($t8)
	lw	$t3, 8($t3)
	sll	$t4, $a3, 2
	add	$t8, $t3, $t4
	lw	$t3, 0($t8)
	sll	$t4, $v0, 2
	add	$t8, $a0, $t4
	lw	$t4, 0($t8)
	lw	$t4, 8($t4)
	sll	$t5, $a3, 2
	add	$t8, $t4, $t5
	lw	$t4, 0($t8)
	bne	$t4, $t3, beq_else.29082
	sll	$t4, $v0, 2
	add	$t8, $a2, $t4
	lw	$t4, 0($t8)
	lw	$t4, 8($t4)
	sll	$t5, $a3, 2
	add	$t8, $t4, $t5
	lw	$t4, 0($t8)
	bne	$t4, $t3, beq_else.29084
	subi	$t4, $v0, 1
	sll	$t4, $t4, 2
	add	$t8, $a1, $t4
	lw	$t4, 0($t8)
	lw	$t4, 8($t4)
	sll	$t5, $a3, 2
	add	$t8, $t4, $t5
	lw	$t4, 0($t8)
	bne	$t4, $t3, beq_else.29086
	addi	$t4, $v0, 1
	sll	$t4, $t4, 2
	add	$t8, $a1, $t4
	lw	$t4, 0($t8)
	lw	$t4, 8($t4)
	sll	$t5, $a3, 2
	add	$t8, $t4, $t5
	lw	$t4, 0($t8)
	bne	$t4, $t3, beq_else.29088
	addi	$t3, $zero, 1
	j	beq_cont.29083
beq_else.29088:
	addi	$t3, $zero, 0
beq_cont.29089:
	j	beq_cont.29083
beq_else.29086:
	addi	$t3, $zero, 0
beq_cont.29087:
	j	beq_cont.29083
beq_else.29084:
	addi	$t3, $zero, 0
beq_cont.29085:
	j	beq_cont.29083
beq_else.29082:
	addi	$t3, $zero, 0
beq_cont.29083:
	bne	$zero, $t3, beq_else.29090
	sll	$v0, $v0, 2
	add	$t8, $a1, $v0
	lw	$v0, 0($t8)
	move	$v1, $a3
	j	do_without_neighbors.2977
beq_else.29090:
	lw	$t0, 12($t0)
	sll	$t3, $a3, 2
	add	$t8, $t0, $t3
	lw	$t0, 0($t8)
	bne	$zero, $t0, beq_else.29091
	j	beq_cont.29092
beq_else.29091:
	sll	$t0, $v0, 2
	add	$t8, $a0, $t0
	lw	$t0, 0($t8)
	lw	$t0, 20($t0)
	subi	$t3, $v0, 1
	sll	$t3, $t3, 2
	add	$t8, $a1, $t3
	lw	$t3, 0($t8)
	lw	$t3, 20($t3)
	sll	$t4, $v0, 2
	add	$t8, $a1, $t4
	lw	$t4, 0($t8)
	lw	$t4, 20($t4)
	addi	$t5, $v0, 1
	sll	$t5, $t5, 2
	add	$t8, $a1, $t5
	lw	$t5, 0($t8)
	lw	$t5, 20($t5)
	sll	$t6, $v0, 2
	add	$t8, $a2, $t6
	lw	$t6, 0($t8)
	lw	$t6, 20($t6)
	sll	$s0, $a3, 2
	add	$t8, $t0, $s0
	lw	$t0, 0($t8)
	flw	$f0, 0($t0)
	fsw	$f0, 0($t1)
	flw	$f0, 4($t0)
	fsw	$f0, 4($t1)
	flw	$f0, 8($t0)
	fsw	$f0, 8($t1)
	sll	$t0, $a3, 2
	add	$t8, $t3, $t0
	lw	$t0, 0($t8)
	flw	$f0, 0($t1)
	flw	$f1, 0($t0)
	fadd	$f0, $f0, $f1
	fsw	$f0, 0($t1)
	flw	$f0, 4($t1)
	flw	$f1, 4($t0)
	fadd	$f0, $f0, $f1
	fsw	$f0, 4($t1)
	flw	$f0, 8($t1)
	flw	$f1, 8($t0)
	fadd	$f0, $f0, $f1
	fsw	$f0, 8($t1)
	sll	$t0, $a3, 2
	add	$t8, $t4, $t0
	lw	$t0, 0($t8)
	flw	$f0, 0($t1)
	flw	$f1, 0($t0)
	fadd	$f0, $f0, $f1
	fsw	$f0, 0($t1)
	flw	$f0, 4($t1)
	flw	$f1, 4($t0)
	fadd	$f0, $f0, $f1
	fsw	$f0, 4($t1)
	flw	$f0, 8($t1)
	flw	$f1, 8($t0)
	fadd	$f0, $f0, $f1
	fsw	$f0, 8($t1)
	sll	$t0, $a3, 2
	add	$t8, $t5, $t0
	lw	$t0, 0($t8)
	flw	$f0, 0($t1)
	flw	$f1, 0($t0)
	fadd	$f0, $f0, $f1
	fsw	$f0, 0($t1)
	flw	$f0, 4($t1)
	flw	$f1, 4($t0)
	fadd	$f0, $f0, $f1
	fsw	$f0, 4($t1)
	flw	$f0, 8($t1)
	flw	$f1, 8($t0)
	fadd	$f0, $f0, $f1
	fsw	$f0, 8($t1)
	sll	$t0, $a3, 2
	add	$t8, $t6, $t0
	lw	$t0, 0($t8)
	flw	$f0, 0($t1)
	flw	$f1, 0($t0)
	fadd	$f0, $f0, $f1
	fsw	$f0, 0($t1)
	flw	$f0, 4($t1)
	flw	$f1, 4($t0)
	fadd	$f0, $f0, $f1
	fsw	$f0, 4($t1)
	flw	$f0, 8($t1)
	flw	$f1, 8($t0)
	fadd	$f0, $f0, $f1
	fsw	$f0, 8($t1)
	sll	$t0, $v0, 2
	add	$t8, $a1, $t0
	lw	$t0, 0($t8)
	lw	$t0, 16($t0)
	sll	$t3, $a3, 2
	add	$t8, $t0, $t3
	lw	$t0, 0($t8)
	flw	$f0, 0($t2)
	flw	$f1, 0($t0)
	flw	$f2, 0($t1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	fsw	$f0, 0($t2)
	flw	$f0, 4($t2)
	flw	$f1, 4($t0)
	flw	$f2, 4($t1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	fsw	$f0, 4($t2)
	flw	$f0, 8($t2)
	flw	$f1, 8($t0)
	flw	$f2, 8($t1)
	fmul	$f1, $f1, $f2
	fadd	$f0, $f0, $f1
	fsw	$f0, 8($t2)
beq_cont.29092:
	addi	$a3, $a3, 1
	j	try_exploit_neighbors.2993
beq_else.29081:
	jr	$ra
beq_else.29080:
	jr	$ra
pretrace_diffuse_rays.3008:
	lui	$a0, 512
	ori	$a0, $a0, 592
	lui	$a1, 512
	ori	$a1, $a1, 716
	lui	$a2, 512
	lui	$a3, 512
	ori	$a3, $a3, 648
	sgti	$t8, $v1, 4
	bne	$t8, $zero, beq_else.29095
	lw	$t0, 8($v0)
	sll	$t1, $v1, 2
	add	$t8, $t0, $t1
	lw	$t0, 0($t8)
	slti	$t8, $t0, 0
	bne	$t8, $zero, beq_else.29096
	lw	$t0, 12($v0)
	sll	$t1, $v1, 2
	add	$t8, $t0, $t1
	lw	$t0, 0($t8)
	sw	$v1, 0($sp)
	bne	$zero, $t0, beq_else.29097
	j	beq_cont.29098
beq_else.29097:
	lw	$t0, 24($v0)
	lw	$t0, 0($t0)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 0($a0)
	fsw	$f0, 4($a0)
	fsw	$f0, 8($a0)
	lw	$t1, 28($v0)
	lw	$t2, 4($v0)
	sll	$t0, $t0, 2
	add	$t8, $a1, $t0
	lw	$a1, 0($t8)
	sll	$t0, $v1, 2
	add	$t8, $t1, $t0
	lw	$t0, 0($t8)
	sll	$t1, $v1, 2
	add	$t8, $t2, $t1
	lw	$t1, 0($t8)
	flw	$f0, 0($t1)
	fsw	$f0, 0($a3)
	flw	$f0, 4($t1)
	fsw	$f0, 4($a3)
	flw	$f0, 8($t1)
	fsw	$f0, 8($a3)
	lw	$a2, 0($a2)
	subi	$a2, $a2, 1
	sw	$a0, -4($sp)
	sw	$v0, -8($sp)
	sw	$t1, -12($sp)
	sw	$t0, -16($sp)
	sw	$a1, -20($sp)
	move	$v1, $a2
	move	$v0, $t1
	sw	$ra, -24($sp)
	subi	$sp, $sp, 28
	jal	setup_startp_constants.2857
	addi	$sp, $sp, 28
	lw	$ra, -24($sp)
	addi	$a1, $zero, 118
	lw	$v0, -20($sp)
	lw	$v1, -16($sp)
	lw	$a0, -12($sp)
	sw	$ra, -24($sp)
	subi	$sp, $sp, 28
	jal	iter_trace_diffuse_rays.2955
	addi	$sp, $sp, 28
	lw	$ra, -24($sp)
	lw	$v0, -8($sp)
	lw	$v1, 20($v0)
	lw	$a0, 0($sp)
	sll	$a1, $a0, 2
	add	$t8, $v1, $a1
	lw	$v1, 0($t8)
	lw	$a1, -4($sp)
	flw	$f0, 0($a1)
	fsw	$f0, 0($v1)
	flw	$f0, 4($a1)
	fsw	$f0, 4($v1)
	flw	$f0, 8($a1)
	fsw	$f0, 8($v1)
beq_cont.29098:
	lw	$v1, 0($sp)
	addi	$v1, $v1, 1
	j	pretrace_diffuse_rays.3008
beq_else.29096:
	jr	$ra
beq_else.29095:
	jr	$ra
pretrace_pixels.3011:
	lui	$a1, 512
	ori	$a1, $a1, 624
	lui	$a2, 512
	ori	$a2, $a2, 696
	lui	$a3, 512
	ori	$a3, $a3, 604
	lui	$t0, 512
	ori	$t0, $t0, 632
	lui	$t1, 512
	ori	$t1, $t1, 660
	lui	$t2, 512
	ori	$t2, $t2, 636
	lui	$t3, 512
	ori	$t3, $t3, 300
	slti	$t8, $v1, 0
	bne	$t8, $zero, beq_else.29101
	flw	$f3, 0($t0)
	lw	$a1, 0($a1)
	sub	$a1, $v1, $a1
	sw	$a0, 0($sp)
	sw	$v0, -4($sp)
	sw	$v1, -8($sp)
	sw	$t2, -12($sp)
	sw	$t3, -16($sp)
	sw	$a3, -20($sp)
	fsw	$f2, -24($sp)
	fsw	$f1, -28($sp)
	sw	$a2, -32($sp)
	fsw	$f0, -36($sp)
	sw	$t1, -40($sp)
	fsw	$f3, -44($sp)
	move	$v0, $a1
	sw	$ra, -48($sp)
	subi	$sp, $sp, 52
	jal	min_caml_float_of_int
	addi	$sp, $sp, 52
	lw	$ra, -48($sp)
	flw	$f1, -44($sp)
	fmul	$f0, $f1, $f0
	lw	$v0, -40($sp)
	flw	$f1, 0($v0)
	fmul	$f1, $f0, $f1
	flw	$f2, -36($sp)
	fadd	$f1, $f1, $f2
	lw	$v1, -32($sp)
	fsw	$f1, 0($v1)
	flw	$f1, 4($v0)
	fmul	$f1, $f0, $f1
	flw	$f3, -28($sp)
	fadd	$f1, $f1, $f3
	fsw	$f1, 4($v1)
	flw	$f1, 8($v0)
	fmul	$f0, $f0, $f1
	flw	$f1, -24($sp)
	fadd	$f0, $f0, $f1
	fsw	$f0, 8($v1)
	flw	$f0, 0($v1)
	fmul	$f0, $f0, $f0
	flw	$f4, 4($v1)
	fmul	$f4, $f4, $f4
	fadd	$f0, $f0, $f4
	flw	$f4, 8($v1)
	fmul	$f4, $f4, $f4
	fadd	$f0, $f0, $f4
	sw	$ra, -48($sp)
	subi	$sp, $sp, 52
	jal	min_caml_sqrt
	addi	$sp, $sp, 52
	lw	$ra, -48($sp)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	feq	$f0, $f1
	fbf	fbt_else.29102
	addi	$v0, $zero, 1
	j	fbt_cont.29103
fbt_else.29102:
	addi	$v0, $zero, 0
fbt_cont.29103:
	bne	$zero, $v0, beq_else.29104
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fdiv	$f0, $f1, $f0
	j	beq_cont.29105
beq_else.29104:
	la	$t8, l.23916
	flw	$f0, 0($t8)
beq_cont.29105:
	lw	$v1, -32($sp)
	flw	$f1, 0($v1)
	fmul	$f1, $f1, $f0
	fsw	$f1, 0($v1)
	flw	$f1, 4($v1)
	fmul	$f1, $f1, $f0
	fsw	$f1, 4($v1)
	flw	$f1, 8($v1)
	fmul	$f0, $f1, $f0
	fsw	$f0, 8($v1)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	lw	$v0, -20($sp)
	fsw	$f0, 0($v0)
	fsw	$f0, 4($v0)
	fsw	$f0, 8($v0)
	lw	$a0, -16($sp)
	flw	$f0, 0($a0)
	lw	$a1, -12($sp)
	fsw	$f0, 0($a1)
	flw	$f0, 4($a0)
	fsw	$f0, 4($a1)
	flw	$f0, 8($a0)
	fsw	$f0, 8($a1)
	la	$t8, l.23916
	flw	$f0, 0($t8)
	lw	$a0, -8($sp)
	sll	$a1, $a0, 2
	lw	$a2, -4($sp)
	add	$t8, $a2, $a1
	lw	$a1, 0($t8)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	move	$a0, $a1
	move	$v0, $zero
	sw	$ra, -48($sp)
	subi	$sp, $sp, 52
	jal	trace_ray.2946
	addi	$sp, $sp, 52
	lw	$ra, -48($sp)
	lw	$v0, -8($sp)
	sll	$v1, $v0, 2
	lw	$a0, -4($sp)
	add	$t8, $a0, $v1
	lw	$v1, 0($t8)
	lw	$v1, 0($v1)
	lw	$a1, -20($sp)
	flw	$f0, 0($a1)
	fsw	$f0, 0($v1)
	flw	$f0, 4($a1)
	fsw	$f0, 4($v1)
	flw	$f0, 8($a1)
	fsw	$f0, 8($v1)
	sll	$v1, $v0, 2
	add	$t8, $a0, $v1
	lw	$v1, 0($t8)
	lw	$v1, 24($v1)
	lw	$a1, 0($sp)
	sw	$a1, 0($v1)
	sll	$v1, $v0, 2
	add	$t8, $a0, $v1
	lw	$v1, 0($t8)
	move	$v0, $v1
	move	$v1, $zero
	sw	$ra, -48($sp)
	subi	$sp, $sp, 52
	jal	pretrace_diffuse_rays.3008
	addi	$sp, $sp, 52
	lw	$ra, -48($sp)
	lw	$v0, -8($sp)
	subi	$v1, $v0, 1
	lw	$v0, 0($sp)
	addi	$v0, $v0, 1
	slti	$t8, $v0, 5
	bne	$t8, $zero, beq_else.29106
	subi	$a0, $v0, 5
	j	beq_cont.29107
beq_else.29106:
	move	$a0, $v0
beq_cont.29107:
	flw	$f0, -36($sp)
	flw	$f1, -28($sp)
	flw	$f2, -24($sp)
	lw	$v0, -4($sp)
	j	pretrace_pixels.3011
beq_else.29101:
	jr	$ra
scan_pixel.3022:
	lui	$t0, 512
	ori	$t0, $t0, 616
	lw	$t1, 0($t0)
	lui	$t2, 512
	ori	$t2, $t2, 604
	slt	$t8, $v0, $t1
	bne	$t8, $zero, beq_else.29109
	jr	$ra
beq_else.29109:
	sll	$t1, $v0, 2
	add	$t8, $a1, $t1
	lw	$t1, 0($t8)
	lw	$t1, 0($t1)
	flw	$f0, 0($t1)
	fsw	$f0, 0($t2)
	flw	$f0, 4($t1)
	fsw	$f0, 4($t2)
	flw	$f0, 8($t1)
	fsw	$f0, 8($t2)
	lw	$t1, 4($t0)
	addi	$t3, $v1, 1
	slt	$t8, $t3, $t1
	bne	$t8, $zero, beq_else.29111
	addi	$t0, $zero, 0
	j	beq_cont.29112
beq_else.29111:
	sgti	$t8, $v1, 0
	bne	$t8, $zero, beq_else.29113
	addi	$t0, $zero, 0
	j	beq_cont.29114
beq_else.29113:
	lw	$t0, 0($t0)
	addi	$t1, $v0, 1
	slt	$t8, $t1, $t0
	bne	$t8, $zero, beq_else.29115
	addi	$t0, $zero, 0
	j	beq_cont.29116
beq_else.29115:
	sgti	$t8, $v0, 0
	bne	$t8, $zero, beq_else.29117
	addi	$t0, $zero, 0
	j	beq_cont.29118
beq_else.29117:
	addi	$t0, $zero, 1
beq_cont.29118:
beq_cont.29116:
beq_cont.29114:
beq_cont.29112:
	sw	$a2, 0($sp)
	sw	$a1, -4($sp)
	sw	$a0, -8($sp)
	sw	$v1, -12($sp)
	sw	$v0, -16($sp)
	sw	$t2, -20($sp)
	sw	$a3, -24($sp)
	bne	$zero, $t0, beq_else.29119
	sll	$t0, $v0, 2
	add	$t8, $a1, $t0
	lw	$t0, 0($t8)
	move	$v1, $zero
	move	$v0, $t0
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	do_without_neighbors.2977
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	j	beq_cont.29120
beq_else.29119:
	move	$a3, $zero
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	try_exploit_neighbors.2993
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
beq_cont.29120:
	lw	$v0, -24($sp)
	addi	$t8, $zero, 3
	bne	$t8, $v0, beq_else.29121
	lw	$v1, -20($sp)
	flw	$f0, 0($v1)
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_int_of_float
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	sgti	$t8, $v0, 255
	bne	$t8, $zero, beq_else.29123
	slti	$t8, $v0, 0
	bne	$t8, $zero, beq_else.29125
	j	beq_cont.29124
beq_else.29125:
	addi	$v0, $zero, 0
beq_cont.29126:
	j	beq_cont.29124
beq_else.29123:
	addi	$v0, $zero, 255
beq_cont.29124:
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	print_int.2612
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	addi	$v0, $zero, 32
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_print_char
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	lw	$v0, -20($sp)
	flw	$f0, 4($v0)
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_int_of_float
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	sgti	$t8, $v0, 255
	bne	$t8, $zero, beq_else.29127
	slti	$t8, $v0, 0
	bne	$t8, $zero, beq_else.29129
	j	beq_cont.29128
beq_else.29129:
	addi	$v0, $zero, 0
beq_cont.29130:
	j	beq_cont.29128
beq_else.29127:
	addi	$v0, $zero, 255
beq_cont.29128:
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	print_int.2612
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	addi	$v0, $zero, 32
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_print_char
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	lw	$v0, -20($sp)
	flw	$f0, 8($v0)
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_int_of_float
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	sgti	$t8, $v0, 255
	bne	$t8, $zero, beq_else.29131
	slti	$t8, $v0, 0
	bne	$t8, $zero, beq_else.29133
	j	beq_cont.29132
beq_else.29133:
	addi	$v0, $zero, 0
beq_cont.29134:
	j	beq_cont.29132
beq_else.29131:
	addi	$v0, $zero, 255
beq_cont.29132:
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	print_int.2612
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	addi	$v0, $zero, 10
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_print_char
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	j	beq_cont.29122
beq_else.29121:
	lw	$v1, -20($sp)
	flw	$f0, 0($v1)
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_int_of_float
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	sgti	$t8, $v0, 255
	bne	$t8, $zero, beq_else.29135
	slti	$t8, $v0, 0
	bne	$t8, $zero, beq_else.29137
	j	beq_cont.29136
beq_else.29137:
	addi	$v0, $zero, 0
beq_cont.29138:
	j	beq_cont.29136
beq_else.29135:
	addi	$v0, $zero, 255
beq_cont.29136:
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_print_char
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	lw	$v0, -20($sp)
	flw	$f0, 4($v0)
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_int_of_float
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	sgti	$t8, $v0, 255
	bne	$t8, $zero, beq_else.29139
	slti	$t8, $v0, 0
	bne	$t8, $zero, beq_else.29141
	j	beq_cont.29140
beq_else.29141:
	addi	$v0, $zero, 0
beq_cont.29142:
	j	beq_cont.29140
beq_else.29139:
	addi	$v0, $zero, 255
beq_cont.29140:
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_print_char
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	lw	$v0, -20($sp)
	flw	$f0, 8($v0)
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_int_of_float
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	sgti	$t8, $v0, 255
	bne	$t8, $zero, beq_else.29143
	slti	$t8, $v0, 0
	bne	$t8, $zero, beq_else.29145
	j	beq_cont.29144
beq_else.29145:
	addi	$v0, $zero, 0
beq_cont.29146:
	j	beq_cont.29144
beq_else.29143:
	addi	$v0, $zero, 255
beq_cont.29144:
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_print_char
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
beq_cont.29122:
	lw	$v0, -16($sp)
	addi	$v0, $v0, 1
	lw	$v1, -12($sp)
	lw	$a0, -8($sp)
	lw	$a1, -4($sp)
	lw	$a2, 0($sp)
	lw	$a3, -24($sp)
	j	scan_pixel.3022
scan_line.3029:
	lui	$t0, 512
	ori	$t0, $t0, 616
	lw	$t1, 4($t0)
	lui	$t2, 512
	ori	$t2, $t2, 624
	lui	$t3, 512
	ori	$t3, $t3, 632
	lui	$t4, 512
	ori	$t4, $t4, 672
	lui	$t5, 512
	ori	$t5, $t5, 684
	slt	$t8, $v0, $t1
	bne	$t8, $zero, beq_else.29147
	jr	$ra
beq_else.29147:
	lw	$t1, 4($t0)
	subi	$t1, $t1, 1
	sw	$a2, 0($sp)
	sw	$a3, -4($sp)
	sw	$a1, -8($sp)
	sw	$a0, -12($sp)
	sw	$v1, -16($sp)
	sw	$v0, -20($sp)
	slt	$t8, $v0, $t1
	bne	$t8, $zero, beq_else.29149
	j	beq_cont.29150
beq_else.29149:
	addi	$t1, $v0, 1
	flw	$f0, 0($t3)
	lw	$t2, 4($t2)
	sub	$t1, $t1, $t2
	sw	$t0, -24($sp)
	sw	$t5, -28($sp)
	sw	$t4, -32($sp)
	fsw	$f0, -36($sp)
	move	$v0, $t1
	sw	$ra, -40($sp)
	subi	$sp, $sp, 44
	jal	min_caml_float_of_int
	addi	$sp, $sp, 44
	lw	$ra, -40($sp)
	flw	$f1, -36($sp)
	fmul	$f0, $f1, $f0
	lw	$v0, -32($sp)
	flw	$f1, 0($v0)
	fmul	$f1, $f0, $f1
	lw	$v1, -28($sp)
	flw	$f2, 0($v1)
	fadd	$f1, $f1, $f2
	flw	$f2, 4($v0)
	fmul	$f2, $f0, $f2
	flw	$f3, 4($v1)
	fadd	$f2, $f2, $f3
	flw	$f3, 8($v0)
	fmul	$f0, $f0, $f3
	flw	$f3, 8($v1)
	fadd	$f0, $f0, $f3
	lw	$v0, -24($sp)
	lw	$v0, 0($v0)
	subi	$v1, $v0, 1
	lw	$v0, -8($sp)
	lw	$a0, 0($sp)
	fmove	$f31, $f2
	fmove	$f2, $f0
	fmove	$f0, $f1
	fmove	$f1, $f31
	sw	$ra, -40($sp)
	subi	$sp, $sp, 44
	jal	pretrace_pixels.3011
	addi	$sp, $sp, 44
	lw	$ra, -40($sp)
beq_cont.29150:
	lw	$v1, -20($sp)
	lw	$a0, -16($sp)
	lw	$a1, -12($sp)
	lw	$a2, -8($sp)
	lw	$a3, -4($sp)
	move	$v0, $zero
	sw	$ra, -40($sp)
	subi	$sp, $sp, 44
	jal	scan_pixel.3022
	addi	$sp, $sp, 44
	lw	$ra, -40($sp)
	lw	$v0, -20($sp)
	addi	$v0, $v0, 1
	lw	$v1, 0($sp)
	addi	$v1, $v1, 2
	slti	$t8, $v1, 5
	bne	$t8, $zero, beq_else.29151
	subi	$a2, $v1, 5
	j	beq_cont.29152
beq_else.29151:
	move	$a2, $v1
beq_cont.29152:
	lw	$v1, -12($sp)
	lw	$a0, -8($sp)
	lw	$a1, -16($sp)
	lw	$a3, -4($sp)
	j	scan_line.3029
init_line_elements.3040:
	slti	$t8, $v1, 0
	bne	$t8, $zero, beq_else.29153
	addi	$a0, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$v0, 0($sp)
	sw	$v1, -4($sp)
	move	$v0, $a0
	sw	$ra, -8($sp)
	subi	$sp, $sp, 12
	jal	min_caml_create_float_array
	addi	$sp, $sp, 12
	lw	$ra, -8($sp)
	addi	$v1, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$v0, -8($sp)
	move	$v0, $v1
	sw	$ra, -12($sp)
	subi	$sp, $sp, 16
	jal	min_caml_create_float_array
	addi	$sp, $sp, 16
	lw	$ra, -12($sp)
	move	$v1, $v0
	addi	$v0, $zero, 5
	sw	$ra, -12($sp)
	subi	$sp, $sp, 16
	jal	min_caml_create_array
	addi	$sp, $sp, 16
	lw	$ra, -12($sp)
	addi	$v1, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$v0, -12($sp)
	move	$v0, $v1
	sw	$ra, -16($sp)
	subi	$sp, $sp, 20
	jal	min_caml_create_float_array
	addi	$sp, $sp, 20
	lw	$ra, -16($sp)
	lw	$v1, -12($sp)
	sw	$v0, 4($v1)
	addi	$v0, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$ra, -16($sp)
	subi	$sp, $sp, 20
	jal	min_caml_create_float_array
	addi	$sp, $sp, 20
	lw	$ra, -16($sp)
	lw	$v1, -12($sp)
	sw	$v0, 8($v1)
	addi	$v0, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$ra, -16($sp)
	subi	$sp, $sp, 20
	jal	min_caml_create_float_array
	addi	$sp, $sp, 20
	lw	$ra, -16($sp)
	lw	$v1, -12($sp)
	sw	$v0, 12($v1)
	addi	$v0, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$ra, -16($sp)
	subi	$sp, $sp, 20
	jal	min_caml_create_float_array
	addi	$sp, $sp, 20
	lw	$ra, -16($sp)
	lw	$v1, -12($sp)
	sw	$v0, 16($v1)
	addi	$v0, $zero, 5
	move	$v1, $zero
	sw	$ra, -16($sp)
	subi	$sp, $sp, 20
	jal	min_caml_create_array
	addi	$sp, $sp, 20
	lw	$ra, -16($sp)
	addi	$v1, $zero, 5
	sw	$v0, -16($sp)
	move	$v0, $v1
	move	$v1, $zero
	sw	$ra, -20($sp)
	subi	$sp, $sp, 24
	jal	min_caml_create_array
	addi	$sp, $sp, 24
	lw	$ra, -20($sp)
	addi	$v1, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$v0, -20($sp)
	move	$v0, $v1
	sw	$ra, -24($sp)
	subi	$sp, $sp, 28
	jal	min_caml_create_float_array
	addi	$sp, $sp, 28
	lw	$ra, -24($sp)
	move	$v1, $v0
	addi	$v0, $zero, 5
	sw	$ra, -24($sp)
	subi	$sp, $sp, 28
	jal	min_caml_create_array
	addi	$sp, $sp, 28
	lw	$ra, -24($sp)
	addi	$v1, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$v0, -24($sp)
	move	$v0, $v1
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_create_float_array
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	lw	$v1, -24($sp)
	sw	$v0, 4($v1)
	addi	$v0, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_create_float_array
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	lw	$v1, -24($sp)
	sw	$v0, 8($v1)
	addi	$v0, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_create_float_array
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	lw	$v1, -24($sp)
	sw	$v0, 12($v1)
	addi	$v0, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_create_float_array
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	lw	$v1, -24($sp)
	sw	$v0, 16($v1)
	addi	$v0, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_create_float_array
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	move	$v1, $v0
	addi	$v0, $zero, 5
	sw	$ra, -28($sp)
	subi	$sp, $sp, 32
	jal	min_caml_create_array
	addi	$sp, $sp, 32
	lw	$ra, -28($sp)
	addi	$v1, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$v0, -28($sp)
	move	$v0, $v1
	sw	$ra, -32($sp)
	subi	$sp, $sp, 36
	jal	min_caml_create_float_array
	addi	$sp, $sp, 36
	lw	$ra, -32($sp)
	lw	$v1, -28($sp)
	sw	$v0, 4($v1)
	addi	$v0, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$ra, -32($sp)
	subi	$sp, $sp, 36
	jal	min_caml_create_float_array
	addi	$sp, $sp, 36
	lw	$ra, -32($sp)
	lw	$v1, -28($sp)
	sw	$v0, 8($v1)
	addi	$v0, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$ra, -32($sp)
	subi	$sp, $sp, 36
	jal	min_caml_create_float_array
	addi	$sp, $sp, 36
	lw	$ra, -32($sp)
	lw	$v1, -28($sp)
	sw	$v0, 12($v1)
	addi	$v0, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$ra, -32($sp)
	subi	$sp, $sp, 36
	jal	min_caml_create_float_array
	addi	$sp, $sp, 36
	lw	$ra, -32($sp)
	lw	$v1, -28($sp)
	sw	$v0, 16($v1)
	addi	$v0, $zero, 1
	move	$v1, $zero
	sw	$ra, -32($sp)
	subi	$sp, $sp, 36
	jal	min_caml_create_array
	addi	$sp, $sp, 36
	lw	$ra, -32($sp)
	addi	$v1, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$v0, -32($sp)
	move	$v0, $v1
	sw	$ra, -36($sp)
	subi	$sp, $sp, 40
	jal	min_caml_create_float_array
	addi	$sp, $sp, 40
	lw	$ra, -36($sp)
	move	$v1, $v0
	addi	$v0, $zero, 5
	sw	$ra, -36($sp)
	subi	$sp, $sp, 40
	jal	min_caml_create_array
	addi	$sp, $sp, 40
	lw	$ra, -36($sp)
	addi	$v1, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$v0, -36($sp)
	move	$v0, $v1
	sw	$ra, -40($sp)
	subi	$sp, $sp, 44
	jal	min_caml_create_float_array
	addi	$sp, $sp, 44
	lw	$ra, -40($sp)
	lw	$v1, -36($sp)
	sw	$v0, 4($v1)
	addi	$v0, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$ra, -40($sp)
	subi	$sp, $sp, 44
	jal	min_caml_create_float_array
	addi	$sp, $sp, 44
	lw	$ra, -40($sp)
	lw	$v1, -36($sp)
	sw	$v0, 8($v1)
	addi	$v0, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$ra, -40($sp)
	subi	$sp, $sp, 44
	jal	min_caml_create_float_array
	addi	$sp, $sp, 44
	lw	$ra, -40($sp)
	lw	$v1, -36($sp)
	sw	$v0, 12($v1)
	addi	$v0, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$ra, -40($sp)
	subi	$sp, $sp, 44
	jal	min_caml_create_float_array
	addi	$sp, $sp, 44
	lw	$ra, -40($sp)
	lw	$v1, -36($sp)
	sw	$v0, 16($v1)
	move	$v0, $t9
	addi	$t9, $t9, 32
	sw	$v1, 28($v0)
	lw	$v1, -32($sp)
	sw	$v1, 24($v0)
	lw	$v1, -28($sp)
	sw	$v1, 20($v0)
	lw	$v1, -24($sp)
	sw	$v1, 16($v0)
	lw	$v1, -20($sp)
	sw	$v1, 12($v0)
	lw	$v1, -16($sp)
	sw	$v1, 8($v0)
	lw	$v1, -12($sp)
	sw	$v1, 4($v0)
	lw	$v1, -8($sp)
	sw	$v1, 0($v0)
	lw	$v1, -4($sp)
	sll	$a0, $v1, 2
	lw	$a1, 0($sp)
	add	$t8, $a1, $a0
	sw	$v0, 0($t8)
	subi	$v1, $v1, 1
	move	$v0, $a1
	j	init_line_elements.3040
beq_else.29153:
	jr	$ra
calc_dirvec.3050:
	lui	$a1, 512
	ori	$a1, $a1, 716
	la	$t8, l.23883
	flw	$f4, 0($t8)
	slti	$t8, $v0, 5
	bne	$t8, $zero, beq_else.29154
	fmul	$f2, $f0, $f0
	fmul	$f3, $f1, $f1
	fadd	$f2, $f2, $f3
	la	$t8, l.23916
	flw	$f3, 0($t8)
	fadd	$f2, $f2, $f3
	sw	$a0, 0($sp)
	sw	$a1, -4($sp)
	sw	$v1, -8($sp)
	fsw	$f1, -12($sp)
	fsw	$f0, -16($sp)
	fmove	$f0, $f2
	sw	$ra, -20($sp)
	subi	$sp, $sp, 24
	jal	min_caml_sqrt
	addi	$sp, $sp, 24
	lw	$ra, -20($sp)
	flw	$f1, -16($sp)
	fdiv	$f1, $f1, $f0
	flw	$f2, -12($sp)
	fdiv	$f2, $f2, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	fdiv	$f0, $f3, $f0
	lw	$v0, -8($sp)
	sll	$v0, $v0, 2
	lw	$v1, -4($sp)
	add	$t8, $v1, $v0
	lw	$v0, 0($t8)
	lw	$v1, 0($sp)
	sll	$a0, $v1, 2
	add	$t8, $v0, $a0
	lw	$a0, 0($t8)
	lw	$a0, 0($a0)
	fsw	$f1, 0($a0)
	fsw	$f2, 4($a0)
	fsw	$f0, 8($a0)
	addi	$a0, $v1, 40
	sll	$a0, $a0, 2
	add	$t8, $v0, $a0
	lw	$a0, 0($t8)
	lw	$a0, 0($a0)
	fneg	$f3, $f2
	fsw	$f1, 0($a0)
	fsw	$f0, 4($a0)
	fsw	$f3, 8($a0)
	addi	$a0, $v1, 80
	sll	$a0, $a0, 2
	add	$t8, $v0, $a0
	lw	$a0, 0($t8)
	lw	$a0, 0($a0)
	fneg	$f4, $f1
	fsw	$f0, 0($a0)
	fsw	$f4, 4($a0)
	fsw	$f3, 8($a0)
	addi	$a0, $v1, 1
	sll	$a0, $a0, 2
	add	$t8, $v0, $a0
	lw	$a0, 0($t8)
	lw	$a0, 0($a0)
	fneg	$f0, $f0
	fsw	$f4, 0($a0)
	fsw	$f3, 4($a0)
	fsw	$f0, 8($a0)
	addi	$a0, $v1, 41
	sll	$a0, $a0, 2
	add	$t8, $v0, $a0
	lw	$a0, 0($t8)
	lw	$a0, 0($a0)
	fsw	$f4, 0($a0)
	fsw	$f0, 4($a0)
	fsw	$f2, 8($a0)
	addi	$v1, $v1, 81
	sll	$v1, $v1, 2
	add	$t8, $v0, $v1
	lw	$v0, 0($t8)
	lw	$v0, 0($v0)
	fsw	$f0, 0($v0)
	fsw	$f1, 4($v0)
	fsw	$f2, 8($v0)
	jr	$ra
beq_else.29154:
	fmul	$f0, $f1, $f1
	la	$t8, l.24761
	flw	$f1, 0($t8)
	fadd	$f0, $f0, $f1
	sw	$a0, 0($sp)
	sw	$v1, -8($sp)
	fsw	$f3, -20($sp)
	sw	$v0, -24($sp)
	fsw	$f4, -28($sp)
	fsw	$f2, -32($sp)
	sw	$ra, -36($sp)
	subi	$sp, $sp, 40
	jal	min_caml_sqrt
	addi	$sp, $sp, 40
	lw	$ra, -36($sp)
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fdiv	$f1, $f1, $f0
	la	$t8, l.23884
	flw	$f2, 0($t8)
	fle	$f2, $f1
	fbf	fbt_else.29156
	addi	$v0, $zero, 1
	j	fbt_cont.29157
fbt_else.29156:
	addi	$v0, $zero, 0
fbt_cont.29157:
	bne	$zero, $v0, beq_else.29158
	fneg	$f1, $f1
beq_else.29158:
beq_cont.29159:
	la	$t8, l.24620
	flw	$f2, 0($t8)
	fle	$f2, $f1
	fbf	fbt_else.29160
	la	$t8, l.24627
	flw	$f2, 0($t8)
	fle	$f2, $f1
	fbf	fbt_else.29162
	bne	$zero, $v0, beq_else.29164
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fdiv	$f1, $f2, $f1
	fmul	$f2, $f1, $f1
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.24621
	flw	$f4, 0($t8)
	la	$t8, l.24622
	flw	$f5, 0($t8)
	la	$t8, l.24623
	flw	$f6, 0($t8)
	la	$t8, l.24624
	flw	$f7, 0($t8)
	la	$t8, l.24625
	flw	$f8, 0($t8)
	la	$t8, l.24626
	flw	$f9, 0($t8)
	fmul	$f9, $f9, $f2
	fsub	$f8, $f8, $f9
	fmul	$f8, $f8, $f2
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f2
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f1, $f2, $f1
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fsub	$f1, $f1, $f2
	j	fbt_cont.29161
beq_else.29164:
	la	$t8, l.23937
	flw	$f2, 0($t8)
	la	$t8, l.23916
	flw	$f3, 0($t8)
	fdiv	$f1, $f3, $f1
	fmul	$f3, $f1, $f1
	la	$t8, l.23916
	flw	$f4, 0($t8)
	la	$t8, l.24621
	flw	$f5, 0($t8)
	la	$t8, l.24622
	flw	$f6, 0($t8)
	la	$t8, l.24623
	flw	$f7, 0($t8)
	la	$t8, l.24624
	flw	$f8, 0($t8)
	la	$t8, l.24625
	flw	$f9, 0($t8)
	la	$t8, l.24626
	flw	$f10, 0($t8)
	fmul	$f10, $f10, $f3
	fsub	$f9, $f9, $f10
	fmul	$f9, $f9, $f3
	fsub	$f8, $f8, $f9
	fmul	$f8, $f8, $f3
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f3
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f3
	fsub	$f5, $f5, $f6
	fmul	$f3, $f5, $f3
	fsub	$f3, $f4, $f3
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
beq_cont.29165:
	j	fbt_cont.29161
fbt_else.29162:
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fsub	$f2, $f1, $f2
	la	$t8, l.23916
	flw	$f3, 0($t8)
	fadd	$f1, $f1, $f3
	fdiv	$f1, $f2, $f1
	fmul	$f2, $f1, $f1
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.24621
	flw	$f4, 0($t8)
	la	$t8, l.24622
	flw	$f5, 0($t8)
	la	$t8, l.24623
	flw	$f6, 0($t8)
	la	$t8, l.24624
	flw	$f7, 0($t8)
	la	$t8, l.24625
	flw	$f8, 0($t8)
	la	$t8, l.24626
	flw	$f9, 0($t8)
	fmul	$f9, $f9, $f2
	fsub	$f8, $f8, $f9
	fmul	$f8, $f8, $f2
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f2
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f1, $f2, $f1
	bne	$zero, $v0, beq_else.29166
	la	$t8, l.24628
	flw	$f2, 0($t8)
	fsub	$f1, $f2, $f1
	j	fbt_cont.29161
beq_else.29166:
	la	$t8, l.23944
	flw	$f2, 0($t8)
	fadd	$f1, $f2, $f1
beq_cont.29167:
fbt_cont.29163:
	j	fbt_cont.29161
fbt_else.29160:
	bne	$zero, $v0, beq_else.29168
	fmul	$f2, $f1, $f1
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.24621
	flw	$f4, 0($t8)
	la	$t8, l.24622
	flw	$f5, 0($t8)
	la	$t8, l.24623
	flw	$f6, 0($t8)
	la	$t8, l.24624
	flw	$f7, 0($t8)
	la	$t8, l.24625
	flw	$f8, 0($t8)
	la	$t8, l.24626
	flw	$f9, 0($t8)
	fmul	$f9, $f9, $f2
	fsub	$f8, $f8, $f9
	fmul	$f8, $f8, $f2
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f2
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f1, $f2, $f1
	fneg	$f1, $f1
	j	beq_cont.29169
beq_else.29168:
	fmul	$f2, $f1, $f1
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.24621
	flw	$f4, 0($t8)
	la	$t8, l.24622
	flw	$f5, 0($t8)
	la	$t8, l.24623
	flw	$f6, 0($t8)
	la	$t8, l.24624
	flw	$f7, 0($t8)
	la	$t8, l.24625
	flw	$f8, 0($t8)
	la	$t8, l.24626
	flw	$f9, 0($t8)
	fmul	$f9, $f9, $f2
	fsub	$f8, $f8, $f9
	fmul	$f8, $f8, $f2
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f2
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f1, $f2, $f1
beq_cont.29169:
fbt_cont.29161:
	flw	$f2, -32($sp)
	fmul	$f1, $f1, $f2
	la	$t8, l.23884
	flw	$f3, 0($t8)
	fle	$f3, $f1
	fbf	fbt_else.29170
	addi	$v0, $zero, 1
	j	fbt_cont.29171
fbt_else.29170:
	addi	$v0, $zero, 0
fbt_cont.29171:
	bne	$zero, $v0, beq_else.29172
	fneg	$f3, $f1
	j	beq_cont.29173
beq_else.29172:
	fmove	$f3, $f1
beq_cont.29173:
	la	$t8, l.23875
	flw	$f4, 0($t8)
	fsw	$f0, -36($sp)
	fsw	$f1, -40($sp)
	sw	$v0, -44($sp)
	fsw	$f3, -48($sp)
	fmove	$f1, $f4
	fmove	$f0, $f3
	sw	$ra, -52($sp)
	subi	$sp, $sp, 56
	jal	adjust_exp.2562
	addi	$sp, $sp, 56
	lw	$ra, -52($sp)
	fmove	$f1, $f0
	flw	$f0, -48($sp)
	sw	$ra, -52($sp)
	subi	$sp, $sp, 56
	jal	sub_iter.2565
	addi	$sp, $sp, 56
	lw	$ra, -52($sp)
	flw	$f1, -28($sp)
	fle	$f1, $f0
	fbf	fbt_else.29174
	lw	$v0, -44($sp)
	bne	$zero, $v0, beq_else.29176
	addi	$v0, $zero, 1
	j	beq_cont.29177
beq_else.29176:
	addi	$v0, $zero, 0
beq_cont.29177:
	fsub	$f0, $f0, $f1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.29175
fbt_else.29174:
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	lw	$v1, -44($sp)
	sw	$v1, 0($v0)
fbt_cont.29175:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.29178
	fsub	$f0, $f1, $f0
fbt_else.29178:
fbt_cont.29179:
	la	$t8, l.23944
	flw	$f2, 0($t8)
	fle	$f0, $f2
	fbf	fbt_else.29180
	bne	$zero, $v0, beq_else.29182
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fneg	$f0, $f0
	j	fbt_cont.29181
beq_else.29182:
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
beq_cont.29183:
	j	fbt_cont.29181
fbt_else.29180:
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	bne	$zero, $v0, beq_else.29184
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
	fneg	$f0, $f0
	j	beq_cont.29185
beq_else.29184:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
beq_cont.29185:
fbt_cont.29181:
	la	$t8, l.23884
	flw	$f2, 0($t8)
	flw	$f3, -40($sp)
	fle	$f2, $f3
	fbf	fbt_else.29186
	fmove	$f2, $f3
	j	fbt_cont.29187
fbt_else.29186:
	fneg	$f2, $f3
fbt_cont.29187:
	la	$t8, l.23875
	flw	$f3, 0($t8)
	fsw	$f0, -52($sp)
	fsw	$f2, -56($sp)
	fmove	$f1, $f3
	fmove	$f0, $f2
	sw	$ra, -60($sp)
	subi	$sp, $sp, 64
	jal	adjust_exp.2562
	addi	$sp, $sp, 64
	lw	$ra, -60($sp)
	fmove	$f1, $f0
	flw	$f0, -56($sp)
	sw	$ra, -60($sp)
	subi	$sp, $sp, 64
	jal	sub_iter.2565
	addi	$sp, $sp, 64
	lw	$ra, -60($sp)
	flw	$f1, -28($sp)
	fle	$f1, $f0
	fbf	fbt_else.29188
	fsub	$f0, $f0, $f1
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	sw	$zero, 0($v0)
	j	fbt_cont.29189
fbt_else.29188:
	addi	$v0, $zero, 1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.29189:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.29190
	bne	$zero, $v0, beq_else.29192
	addi	$v0, $zero, 1
	j	beq_cont.29193
beq_else.29192:
	addi	$v0, $zero, 0
beq_cont.29193:
	fsub	$f0, $f1, $f0
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.29191
fbt_else.29190:
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.29191:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23944
	flw	$f2, 0($t8)
	fle	$f0, $f2
	fbf	fbt_else.29194
	bne	$zero, $v0, beq_else.29196
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
	fneg	$f0, $f0
	j	fbt_cont.29195
beq_else.29196:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
beq_cont.29197:
	j	fbt_cont.29195
fbt_else.29194:
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	bne	$zero, $v0, beq_else.29198
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fneg	$f0, $f0
	j	beq_cont.29199
beq_else.29198:
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
beq_cont.29199:
fbt_cont.29195:
	flw	$f2, -52($sp)
	fdiv	$f0, $f2, $f0
	flw	$f2, -36($sp)
	fmul	$f0, $f0, $f2
	lw	$v0, -24($sp)
	addi	$v0, $v0, 1
	fmul	$f2, $f0, $f0
	la	$t8, l.24761
	flw	$f3, 0($t8)
	fadd	$f2, $f2, $f3
	fsw	$f0, -60($sp)
	sw	$v0, -64($sp)
	fmove	$f0, $f2
	sw	$ra, -68($sp)
	subi	$sp, $sp, 72
	jal	min_caml_sqrt
	addi	$sp, $sp, 72
	lw	$ra, -68($sp)
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fdiv	$f1, $f1, $f0
	la	$t8, l.23884
	flw	$f2, 0($t8)
	fle	$f2, $f1
	fbf	fbt_else.29200
	addi	$v0, $zero, 1
	j	fbt_cont.29201
fbt_else.29200:
	addi	$v0, $zero, 0
fbt_cont.29201:
	bne	$zero, $v0, beq_else.29202
	fneg	$f1, $f1
beq_else.29202:
beq_cont.29203:
	la	$t8, l.24620
	flw	$f2, 0($t8)
	fle	$f2, $f1
	fbf	fbt_else.29204
	la	$t8, l.24627
	flw	$f2, 0($t8)
	fle	$f2, $f1
	fbf	fbt_else.29206
	bne	$zero, $v0, beq_else.29208
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fdiv	$f1, $f2, $f1
	fmul	$f2, $f1, $f1
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.24621
	flw	$f4, 0($t8)
	la	$t8, l.24622
	flw	$f5, 0($t8)
	la	$t8, l.24623
	flw	$f6, 0($t8)
	la	$t8, l.24624
	flw	$f7, 0($t8)
	la	$t8, l.24625
	flw	$f8, 0($t8)
	la	$t8, l.24626
	flw	$f9, 0($t8)
	fmul	$f9, $f9, $f2
	fsub	$f8, $f8, $f9
	fmul	$f8, $f8, $f2
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f2
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f1, $f2, $f1
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fsub	$f1, $f1, $f2
	j	fbt_cont.29205
beq_else.29208:
	la	$t8, l.23937
	flw	$f2, 0($t8)
	la	$t8, l.23916
	flw	$f3, 0($t8)
	fdiv	$f1, $f3, $f1
	fmul	$f3, $f1, $f1
	la	$t8, l.23916
	flw	$f4, 0($t8)
	la	$t8, l.24621
	flw	$f5, 0($t8)
	la	$t8, l.24622
	flw	$f6, 0($t8)
	la	$t8, l.24623
	flw	$f7, 0($t8)
	la	$t8, l.24624
	flw	$f8, 0($t8)
	la	$t8, l.24625
	flw	$f9, 0($t8)
	la	$t8, l.24626
	flw	$f10, 0($t8)
	fmul	$f10, $f10, $f3
	fsub	$f9, $f9, $f10
	fmul	$f9, $f9, $f3
	fsub	$f8, $f8, $f9
	fmul	$f8, $f8, $f3
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f3
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f3
	fsub	$f5, $f5, $f6
	fmul	$f3, $f5, $f3
	fsub	$f3, $f4, $f3
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
beq_cont.29209:
	j	fbt_cont.29205
fbt_else.29206:
	la	$t8, l.23916
	flw	$f2, 0($t8)
	fsub	$f2, $f1, $f2
	la	$t8, l.23916
	flw	$f3, 0($t8)
	fadd	$f1, $f1, $f3
	fdiv	$f1, $f2, $f1
	fmul	$f2, $f1, $f1
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.24621
	flw	$f4, 0($t8)
	la	$t8, l.24622
	flw	$f5, 0($t8)
	la	$t8, l.24623
	flw	$f6, 0($t8)
	la	$t8, l.24624
	flw	$f7, 0($t8)
	la	$t8, l.24625
	flw	$f8, 0($t8)
	la	$t8, l.24626
	flw	$f9, 0($t8)
	fmul	$f9, $f9, $f2
	fsub	$f8, $f8, $f9
	fmul	$f8, $f8, $f2
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f2
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f1, $f2, $f1
	bne	$zero, $v0, beq_else.29210
	la	$t8, l.24628
	flw	$f2, 0($t8)
	fsub	$f1, $f2, $f1
	j	fbt_cont.29205
beq_else.29210:
	la	$t8, l.23944
	flw	$f2, 0($t8)
	fadd	$f1, $f2, $f1
beq_cont.29211:
fbt_cont.29207:
	j	fbt_cont.29205
fbt_else.29204:
	bne	$zero, $v0, beq_else.29212
	fmul	$f2, $f1, $f1
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.24621
	flw	$f4, 0($t8)
	la	$t8, l.24622
	flw	$f5, 0($t8)
	la	$t8, l.24623
	flw	$f6, 0($t8)
	la	$t8, l.24624
	flw	$f7, 0($t8)
	la	$t8, l.24625
	flw	$f8, 0($t8)
	la	$t8, l.24626
	flw	$f9, 0($t8)
	fmul	$f9, $f9, $f2
	fsub	$f8, $f8, $f9
	fmul	$f8, $f8, $f2
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f2
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f1, $f2, $f1
	fneg	$f1, $f1
	j	beq_cont.29213
beq_else.29212:
	fmul	$f2, $f1, $f1
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.24621
	flw	$f4, 0($t8)
	la	$t8, l.24622
	flw	$f5, 0($t8)
	la	$t8, l.24623
	flw	$f6, 0($t8)
	la	$t8, l.24624
	flw	$f7, 0($t8)
	la	$t8, l.24625
	flw	$f8, 0($t8)
	la	$t8, l.24626
	flw	$f9, 0($t8)
	fmul	$f9, $f9, $f2
	fsub	$f8, $f8, $f9
	fmul	$f8, $f8, $f2
	fsub	$f7, $f7, $f8
	fmul	$f7, $f7, $f2
	fsub	$f6, $f6, $f7
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f1, $f2, $f1
beq_cont.29213:
fbt_cont.29205:
	flw	$f2, -20($sp)
	fmul	$f1, $f1, $f2
	la	$t8, l.23884
	flw	$f3, 0($t8)
	fle	$f3, $f1
	fbf	fbt_else.29214
	addi	$v0, $zero, 1
	j	fbt_cont.29215
fbt_else.29214:
	addi	$v0, $zero, 0
fbt_cont.29215:
	bne	$zero, $v0, beq_else.29216
	fneg	$f3, $f1
	j	beq_cont.29217
beq_else.29216:
	fmove	$f3, $f1
beq_cont.29217:
	la	$t8, l.23875
	flw	$f4, 0($t8)
	fsw	$f0, -68($sp)
	fsw	$f1, -72($sp)
	sw	$v0, -76($sp)
	fsw	$f3, -80($sp)
	fmove	$f1, $f4
	fmove	$f0, $f3
	sw	$ra, -84($sp)
	subi	$sp, $sp, 88
	jal	adjust_exp.2562
	addi	$sp, $sp, 88
	lw	$ra, -84($sp)
	fmove	$f1, $f0
	flw	$f0, -80($sp)
	sw	$ra, -84($sp)
	subi	$sp, $sp, 88
	jal	sub_iter.2565
	addi	$sp, $sp, 88
	lw	$ra, -84($sp)
	flw	$f1, -28($sp)
	fle	$f1, $f0
	fbf	fbt_else.29218
	lw	$v0, -76($sp)
	bne	$zero, $v0, beq_else.29220
	addi	$v0, $zero, 1
	j	beq_cont.29221
beq_else.29220:
	addi	$v0, $zero, 0
beq_cont.29221:
	fsub	$f0, $f0, $f1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.29219
fbt_else.29218:
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	lw	$v1, -76($sp)
	sw	$v1, 0($v0)
fbt_cont.29219:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.29222
	fsub	$f0, $f1, $f0
fbt_else.29222:
fbt_cont.29223:
	la	$t8, l.23944
	flw	$f2, 0($t8)
	fle	$f0, $f2
	fbf	fbt_else.29224
	bne	$zero, $v0, beq_else.29226
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fneg	$f0, $f0
	j	fbt_cont.29225
beq_else.29226:
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
beq_cont.29227:
	j	fbt_cont.29225
fbt_else.29224:
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	bne	$zero, $v0, beq_else.29228
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
	fneg	$f0, $f0
	j	beq_cont.29229
beq_else.29228:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
beq_cont.29229:
fbt_cont.29225:
	la	$t8, l.23884
	flw	$f2, 0($t8)
	flw	$f3, -72($sp)
	fle	$f2, $f3
	fbf	fbt_else.29230
	fmove	$f2, $f3
	j	fbt_cont.29231
fbt_else.29230:
	fneg	$f2, $f3
fbt_cont.29231:
	la	$t8, l.23875
	flw	$f3, 0($t8)
	fsw	$f0, -84($sp)
	fsw	$f2, -88($sp)
	fmove	$f1, $f3
	fmove	$f0, $f2
	sw	$ra, -92($sp)
	subi	$sp, $sp, 96
	jal	adjust_exp.2562
	addi	$sp, $sp, 96
	lw	$ra, -92($sp)
	fmove	$f1, $f0
	flw	$f0, -88($sp)
	sw	$ra, -92($sp)
	subi	$sp, $sp, 96
	jal	sub_iter.2565
	addi	$sp, $sp, 96
	lw	$ra, -92($sp)
	flw	$f1, -28($sp)
	fle	$f1, $f0
	fbf	fbt_else.29232
	fsub	$f0, $f0, $f1
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	sw	$zero, 0($v0)
	j	fbt_cont.29233
fbt_else.29232:
	addi	$v0, $zero, 1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.29233:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.29234
	bne	$zero, $v0, beq_else.29236
	addi	$v0, $zero, 1
	j	beq_cont.29237
beq_else.29236:
	addi	$v0, $zero, 0
beq_cont.29237:
	fsub	$f0, $f1, $f0
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.29235
fbt_else.29234:
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.29235:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23944
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.29238
	bne	$zero, $v0, beq_else.29240
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
	fneg	$f0, $f0
	j	fbt_cont.29239
beq_else.29240:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
beq_cont.29241:
	j	fbt_cont.29239
fbt_else.29238:
	la	$t8, l.23937
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	bne	$zero, $v0, beq_else.29242
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	fneg	$f0, $f0
	j	beq_cont.29243
beq_else.29242:
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
beq_cont.29243:
fbt_cont.29239:
	flw	$f1, -84($sp)
	fdiv	$f0, $f1, $f0
	flw	$f1, -68($sp)
	fmul	$f1, $f0, $f1
	flw	$f0, -60($sp)
	flw	$f2, -32($sp)
	flw	$f3, -20($sp)
	lw	$v0, -64($sp)
	lw	$v1, -8($sp)
	lw	$a0, 0($sp)
	j	calc_dirvec.3050
calc_dirvecs.3058:
	slti	$t8, $v0, 0
	bne	$t8, $zero, beq_else.29244
	sw	$v0, 0($sp)
	fsw	$f0, -4($sp)
	sw	$a0, -8($sp)
	sw	$v1, -12($sp)
	sw	$ra, -16($sp)
	subi	$sp, $sp, 20
	jal	min_caml_float_of_int
	addi	$sp, $sp, 20
	lw	$ra, -16($sp)
	la	$t8, l.24622
	flw	$f1, 0($t8)
	fmul	$f1, $f0, $f1
	la	$t8, l.25334
	flw	$f2, 0($t8)
	fsub	$f2, $f1, $f2
	la	$t8, l.23884
	flw	$f1, 0($t8)
	la	$t8, l.23884
	flw	$f3, 0($t8)
	flw	$f4, -4($sp)
	lw	$v1, -12($sp)
	lw	$a0, -8($sp)
	fsw	$f0, -16($sp)
	move	$v0, $zero
	fmove	$f0, $f1
	fmove	$f1, $f3
	fmove	$f3, $f4
	sw	$ra, -20($sp)
	subi	$sp, $sp, 24
	jal	calc_dirvec.3050
	addi	$sp, $sp, 24
	lw	$ra, -20($sp)
	la	$t8, l.24622
	flw	$f0, 0($t8)
	flw	$f1, -16($sp)
	fmul	$f0, $f1, $f0
	la	$t8, l.24761
	flw	$f1, 0($t8)
	fadd	$f2, $f0, $f1
	la	$t8, l.23884
	flw	$f0, 0($t8)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	lw	$v0, -8($sp)
	addi	$a0, $v0, 2
	flw	$f3, -4($sp)
	lw	$v1, -12($sp)
	move	$v0, $zero
	sw	$ra, -20($sp)
	subi	$sp, $sp, 24
	jal	calc_dirvec.3050
	addi	$sp, $sp, 24
	lw	$ra, -20($sp)
	lw	$v0, 0($sp)
	subi	$v0, $v0, 1
	lw	$v1, -12($sp)
	addi	$v1, $v1, 1
	slti	$t8, $v1, 5
	bne	$t8, $zero, beq_else.29245
	subi	$v1, $v1, 5
beq_else.29245:
beq_cont.29246:
	flw	$f0, -4($sp)
	lw	$a0, -8($sp)
	j	calc_dirvecs.3058
beq_else.29244:
	jr	$ra
calc_dirvec_rows.3063:
	slti	$t8, $v0, 0
	bne	$t8, $zero, beq_else.29248
	sw	$v0, 0($sp)
	sw	$a0, -4($sp)
	sw	$v1, -8($sp)
	sw	$ra, -12($sp)
	subi	$sp, $sp, 16
	jal	min_caml_float_of_int
	addi	$sp, $sp, 16
	lw	$ra, -12($sp)
	la	$t8, l.24622
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	la	$t8, l.25334
	flw	$f1, 0($t8)
	fsub	$f0, $f0, $f1
	addi	$v0, $zero, 4
	lw	$v1, -8($sp)
	lw	$a0, -4($sp)
	sw	$ra, -12($sp)
	subi	$sp, $sp, 16
	jal	calc_dirvecs.3058
	addi	$sp, $sp, 16
	lw	$ra, -12($sp)
	lw	$v0, 0($sp)
	subi	$v0, $v0, 1
	lw	$v1, -8($sp)
	addi	$v1, $v1, 2
	slti	$t8, $v1, 5
	bne	$t8, $zero, beq_else.29249
	subi	$v1, $v1, 5
beq_else.29249:
beq_cont.29250:
	lw	$a0, -4($sp)
	addi	$a0, $a0, 4
	j	calc_dirvec_rows.3063
beq_else.29248:
	jr	$ra
create_dirvec_elements.3069:
	lui	$a0, 512
	slti	$t8, $v1, 0
	bne	$t8, $zero, beq_else.29252
	addi	$a1, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$v0, 0($sp)
	sw	$v1, -4($sp)
	sw	$a0, -8($sp)
	move	$v0, $a1
	sw	$ra, -12($sp)
	subi	$sp, $sp, 16
	jal	min_caml_create_float_array
	addi	$sp, $sp, 16
	lw	$ra, -12($sp)
	move	$v1, $v0
	lw	$v0, -8($sp)
	lw	$v0, 0($v0)
	sw	$v1, -12($sp)
	sw	$ra, -16($sp)
	subi	$sp, $sp, 20
	jal	min_caml_create_array
	addi	$sp, $sp, 20
	lw	$ra, -16($sp)
	move	$v1, $t9
	addi	$t9, $t9, 8
	sw	$v0, 4($v1)
	lw	$v0, -12($sp)
	sw	$v0, 0($v1)
	move	$v0, $v1
	lw	$v1, -4($sp)
	sll	$a0, $v1, 2
	lw	$a1, 0($sp)
	add	$t8, $a1, $a0
	sw	$v0, 0($t8)
	subi	$v1, $v1, 1
	move	$v0, $a1
	j	create_dirvec_elements.3069
beq_else.29252:
	jr	$ra
create_dirvecs.3072:
	lui	$v1, 512
	ori	$v1, $v1, 716
	lui	$a0, 512
	slti	$t8, $v0, 0
	bne	$t8, $zero, beq_else.29254
	addi	$a1, $zero, 120
	addi	$a2, $zero, 3
	la	$t8, l.23884
	flw	$f0, 0($t8)
	sw	$v1, 0($sp)
	sw	$v0, -4($sp)
	sw	$a1, -8($sp)
	sw	$a0, -12($sp)
	move	$v0, $a2
	sw	$ra, -16($sp)
	subi	$sp, $sp, 20
	jal	min_caml_create_float_array
	addi	$sp, $sp, 20
	lw	$ra, -16($sp)
	move	$v1, $v0
	lw	$v0, -12($sp)
	lw	$v0, 0($v0)
	sw	$v1, -16($sp)
	sw	$ra, -20($sp)
	subi	$sp, $sp, 24
	jal	min_caml_create_array
	addi	$sp, $sp, 24
	lw	$ra, -20($sp)
	move	$v1, $t9
	addi	$t9, $t9, 8
	sw	$v0, 4($v1)
	lw	$v0, -16($sp)
	sw	$v0, 0($v1)
	lw	$v0, -8($sp)
	sw	$ra, -20($sp)
	subi	$sp, $sp, 24
	jal	min_caml_create_array
	addi	$sp, $sp, 24
	lw	$ra, -20($sp)
	lw	$v1, -4($sp)
	sll	$a0, $v1, 2
	lw	$a1, 0($sp)
	add	$t8, $a1, $a0
	sw	$v0, 0($t8)
	sll	$v0, $v1, 2
	add	$t8, $a1, $v0
	lw	$v0, 0($t8)
	addi	$a0, $zero, 118
	move	$v1, $a0
	sw	$ra, -20($sp)
	subi	$sp, $sp, 24
	jal	create_dirvec_elements.3069
	addi	$sp, $sp, 24
	lw	$ra, -20($sp)
	lw	$v0, -4($sp)
	subi	$v0, $v0, 1
	j	create_dirvecs.3072
beq_else.29254:
	jr	$ra
init_dirvec_constants.3074:
	lui	$a0, 512
	slti	$t8, $v1, 0
	bne	$t8, $zero, beq_else.29256
	sll	$a1, $v1, 2
	add	$t8, $v0, $a1
	lw	$a1, 0($t8)
	lw	$a0, 0($a0)
	subi	$a0, $a0, 1
	sw	$v0, 0($sp)
	sw	$v1, -4($sp)
	move	$v1, $a0
	move	$v0, $a1
	sw	$ra, -8($sp)
	subi	$sp, $sp, 12
	jal	iter_setup_dirvec_constants.2852
	addi	$sp, $sp, 12
	lw	$ra, -8($sp)
	lw	$v0, -4($sp)
	subi	$v1, $v0, 1
	lw	$v0, 0($sp)
	j	init_dirvec_constants.3074
beq_else.29256:
	jr	$ra
init_vecset_constants.3077:
	lui	$v1, 512
	ori	$v1, $v1, 716
	slti	$t8, $v0, 0
	bne	$t8, $zero, beq_else.29258
	sll	$a0, $v0, 2
	add	$t8, $v1, $a0
	lw	$v1, 0($t8)
	addi	$a0, $zero, 119
	sw	$v0, 0($sp)
	move	$v0, $v1
	move	$v1, $a0
	sw	$ra, -4($sp)
	subi	$sp, $sp, 8
	jal	init_dirvec_constants.3074
	addi	$sp, $sp, 8
	lw	$ra, -4($sp)
	lw	$v0, 0($sp)
	subi	$v0, $v0, 1
	j	init_vecset_constants.3077
beq_else.29258:
	jr	$ra
min_caml_create_array:
	move	$a0, $t9
create_array_loop:
	beq	$v0, $zero, create_array_exit
	sw	$v1, 0($t9)
	subi	$v0, $v0, 1
	addi	$t9, $t9, 4
	j	create_array_loop
create_array_exit:
	move	$v0, $a0
	jr	$ra
min_caml_create_float_array:
	move	$v1, $t9
create_float_array_loop:
	beq	$v0, $zero, create_float_array_exit
	fsw	$f0, 0($t9)
	subi	$v0, $v0, 1
	addi	$t9, $t9, 4
	j	create_float_array_loop
create_float_array_exit:
	move	$v0, $v1
	jr	$ra
min_caml_abs_float:
min_caml_fabs:
	fabs	$f0, $f0
	jr	$ra
min_caml_sqrt:
	fsqrt	$f0, $f0
	jr	$ra
min_caml_floor:
	floor	$f0, $f0
	jr	$ra
min_caml_float_of_int:
	itof	$f0, $v0
	jr	$ra
min_caml_int_of_float:
min_caml_truncate:
	ftoi	$v0, $f0
	jr	$ra
min_caml_print_char:
	sw	$v0, 0($t7)
	jr	$ra
min_caml_read_int:
	lw	$v0, 0($t7)
	jr	$ra
min_caml_read_float:
	flw	$f0, 0($t7)
	jr	$ra
_min_caml_start:
	lui	$t7, 65535
	lui	$sp, 1791
	ori	$sp, $sp, 65532
	lui	$t9, 512
	sw	$zero, 0($t9)
	sw	$zero, 4($t9)
	sw	$zero, 8($t9)
	sw	$zero, 12($t9)
	sw	$zero, 16($t9)
	lui	$v0, 512
	ori	$v0, $v0, 4
	sw	$v0, 20($t9)
	lui	$v0, 512
	ori	$v0, $v0, 4
	sw	$v0, 24($t9)
	sw	$zero, 28($t9)
	lui	$v0, 512
	ori	$v0, $v0, 4
	sw	$v0, 32($t9)
	lui	$v0, 512
	ori	$v0, $v0, 4
	sw	$v0, 36($t9)
	lui	$v0, 512
	ori	$v0, $v0, 4
	sw	$v0, 40($t9)
	lui	$v0, 512
	ori	$v0, $v0, 4
	sw	$v0, 44($t9)
	lui	$v0, 512
	ori	$v0, $v0, 4
	sw	$v0, 48($t9)
	sw	$v0, 52($t9)
	sw	$v0, 56($t9)
	sw	$v0, 60($t9)
	sw	$v0, 64($t9)
	sw	$v0, 68($t9)
	sw	$v0, 72($t9)
	sw	$v0, 76($t9)
	sw	$v0, 80($t9)
	sw	$v0, 84($t9)
	sw	$v0, 88($t9)
	sw	$v0, 92($t9)
	sw	$v0, 96($t9)
	sw	$v0, 100($t9)
	sw	$v0, 104($t9)
	sw	$v0, 108($t9)
	sw	$v0, 112($t9)
	sw	$v0, 116($t9)
	sw	$v0, 120($t9)
	sw	$v0, 124($t9)
	sw	$v0, 128($t9)
	sw	$v0, 132($t9)
	sw	$v0, 136($t9)
	sw	$v0, 140($t9)
	sw	$v0, 144($t9)
	sw	$v0, 148($t9)
	sw	$v0, 152($t9)
	sw	$v0, 156($t9)
	sw	$v0, 160($t9)
	sw	$v0, 164($t9)
	sw	$v0, 168($t9)
	sw	$v0, 172($t9)
	sw	$v0, 176($t9)
	sw	$v0, 180($t9)
	sw	$v0, 184($t9)
	sw	$v0, 188($t9)
	sw	$v0, 192($t9)
	sw	$v0, 196($t9)
	sw	$v0, 200($t9)
	sw	$v0, 204($t9)
	sw	$v0, 208($t9)
	sw	$v0, 212($t9)
	sw	$v0, 216($t9)
	sw	$v0, 220($t9)
	sw	$v0, 224($t9)
	sw	$v0, 228($t9)
	sw	$v0, 232($t9)
	sw	$v0, 236($t9)
	sw	$v0, 240($t9)
	sw	$v0, 244($t9)
	sw	$v0, 248($t9)
	sw	$v0, 252($t9)
	sw	$v0, 256($t9)
	sw	$v0, 260($t9)
	sw	$v0, 264($t9)
	sw	$v0, 268($t9)
	sw	$v0, 272($t9)
	sw	$v0, 276($t9)
	sw	$v0, 280($t9)
	sw	$v0, 284($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 288($t9)
	fsw	$f0, 292($t9)
	fsw	$f0, 296($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 300($t9)
	fsw	$f0, 304($t9)
	fsw	$f0, 308($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 312($t9)
	fsw	$f0, 316($t9)
	fsw	$f0, 320($t9)
	la	$t8, l.24635
	flw	$f0, 0($t8)
	fsw	$f0, 324($t9)
	addi	$v0, $zero, -1
	sw	$v0, 328($t9)
	lui	$v0, 512
	ori	$v0, $v0, 328
	sw	$v0, 332($t9)
	sw	$v0, 336($t9)
	sw	$v0, 340($t9)
	sw	$v0, 344($t9)
	sw	$v0, 348($t9)
	sw	$v0, 352($t9)
	sw	$v0, 356($t9)
	sw	$v0, 360($t9)
	sw	$v0, 364($t9)
	sw	$v0, 368($t9)
	sw	$v0, 372($t9)
	sw	$v0, 376($t9)
	sw	$v0, 380($t9)
	sw	$v0, 384($t9)
	sw	$v0, 388($t9)
	sw	$v0, 392($t9)
	sw	$v0, 396($t9)
	sw	$v0, 400($t9)
	sw	$v0, 404($t9)
	sw	$v0, 408($t9)
	sw	$v0, 412($t9)
	sw	$v0, 416($t9)
	sw	$v0, 420($t9)
	sw	$v0, 424($t9)
	sw	$v0, 428($t9)
	sw	$v0, 432($t9)
	sw	$v0, 436($t9)
	sw	$v0, 440($t9)
	sw	$v0, 444($t9)
	sw	$v0, 448($t9)
	sw	$v0, 452($t9)
	sw	$v0, 456($t9)
	sw	$v0, 460($t9)
	sw	$v0, 464($t9)
	sw	$v0, 468($t9)
	sw	$v0, 472($t9)
	sw	$v0, 476($t9)
	sw	$v0, 480($t9)
	sw	$v0, 484($t9)
	sw	$v0, 488($t9)
	sw	$v0, 492($t9)
	sw	$v0, 496($t9)
	sw	$v0, 500($t9)
	sw	$v0, 504($t9)
	sw	$v0, 508($t9)
	sw	$v0, 512($t9)
	sw	$v0, 516($t9)
	sw	$v0, 520($t9)
	sw	$v0, 524($t9)
	sw	$v0, 528($t9)
	lw	$v0, 332($t9)
	sw	$v0, 532($t9)
	lui	$v0, 512
	ori	$v0, $v0, 532
	sw	$v0, 536($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 540($t9)
	sw	$zero, 544($t9)
	la	$t8, l.24517
	flw	$f0, 0($t8)
	fsw	$f0, 548($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 552($t9)
	fsw	$f0, 556($t9)
	fsw	$f0, 560($t9)
	sw	$zero, 564($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 568($t9)
	fsw	$f0, 572($t9)
	fsw	$f0, 576($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 580($t9)
	fsw	$f0, 584($t9)
	fsw	$f0, 588($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 592($t9)
	fsw	$f0, 596($t9)
	fsw	$f0, 600($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 604($t9)
	fsw	$f0, 608($t9)
	fsw	$f0, 612($t9)
	sw	$zero, 616($t9)
	sw	$zero, 620($t9)
	sw	$zero, 624($t9)
	sw	$zero, 628($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 632($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 636($t9)
	fsw	$f0, 640($t9)
	fsw	$f0, 644($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 648($t9)
	fsw	$f0, 652($t9)
	fsw	$f0, 656($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 660($t9)
	fsw	$f0, 664($t9)
	fsw	$f0, 668($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 672($t9)
	fsw	$f0, 676($t9)
	fsw	$f0, 680($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 684($t9)
	fsw	$f0, 688($t9)
	fsw	$f0, 692($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 696($t9)
	fsw	$f0, 700($t9)
	fsw	$f0, 704($t9)
	lui	$v0, 512
	ori	$v0, $v0, 708
	sw	$v0, 708($t9)
	lui	$v0, 512
	ori	$v0, $v0, 708
	sw	$v0, 712($t9)
	lui	$v0, 512
	ori	$v0, $v0, 716
	sw	$v0, 716($t9)
	sw	$v0, 720($t9)
	sw	$v0, 724($t9)
	sw	$v0, 728($t9)
	sw	$v0, 732($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 736($t9)
	fsw	$f0, 740($t9)
	fsw	$f0, 744($t9)
	lui	$v0, 512
	ori	$v0, $v0, 736
	sw	$v0, 748($t9)
	sw	$v0, 752($t9)
	sw	$v0, 756($t9)
	sw	$v0, 760($t9)
	sw	$v0, 764($t9)
	sw	$v0, 768($t9)
	sw	$v0, 772($t9)
	sw	$v0, 776($t9)
	sw	$v0, 780($t9)
	sw	$v0, 784($t9)
	sw	$v0, 788($t9)
	sw	$v0, 792($t9)
	sw	$v0, 796($t9)
	sw	$v0, 800($t9)
	sw	$v0, 804($t9)
	sw	$v0, 808($t9)
	sw	$v0, 812($t9)
	sw	$v0, 816($t9)
	sw	$v0, 820($t9)
	sw	$v0, 824($t9)
	sw	$v0, 828($t9)
	sw	$v0, 832($t9)
	sw	$v0, 836($t9)
	sw	$v0, 840($t9)
	sw	$v0, 844($t9)
	sw	$v0, 848($t9)
	sw	$v0, 852($t9)
	sw	$v0, 856($t9)
	sw	$v0, 860($t9)
	sw	$v0, 864($t9)
	sw	$v0, 868($t9)
	sw	$v0, 872($t9)
	sw	$v0, 876($t9)
	sw	$v0, 880($t9)
	sw	$v0, 884($t9)
	sw	$v0, 888($t9)
	sw	$v0, 892($t9)
	sw	$v0, 896($t9)
	sw	$v0, 900($t9)
	sw	$v0, 904($t9)
	sw	$v0, 908($t9)
	sw	$v0, 912($t9)
	sw	$v0, 916($t9)
	sw	$v0, 920($t9)
	sw	$v0, 924($t9)
	sw	$v0, 928($t9)
	sw	$v0, 932($t9)
	sw	$v0, 936($t9)
	sw	$v0, 940($t9)
	sw	$v0, 944($t9)
	sw	$v0, 948($t9)
	sw	$v0, 952($t9)
	sw	$v0, 956($t9)
	sw	$v0, 960($t9)
	sw	$v0, 964($t9)
	sw	$v0, 968($t9)
	sw	$v0, 972($t9)
	sw	$v0, 976($t9)
	sw	$v0, 980($t9)
	sw	$v0, 984($t9)
	lui	$v0, 512
	ori	$v0, $v0, 736
	sw	$v0, 988($t9)
	lui	$v0, 512
	ori	$v0, $v0, 748
	sw	$v0, 992($t9)
	lui	$v0, 512
	ori	$v0, $v0, 996
	sw	$v0, 996($t9)
	lui	$v0, 512
	ori	$v0, $v0, 996
	sw	$v0, 1000($t9)
	sw	$zero, 1004($t9)
	lui	$v0, 512
	ori	$v0, $v0, 996
	sw	$v0, 1008($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 1012($t9)
	lui	$v0, 512
	ori	$v0, $v0, 1004
	sw	$v0, 1016($t9)
	sw	$v0, 1020($t9)
	sw	$v0, 1024($t9)
	sw	$v0, 1028($t9)
	sw	$v0, 1032($t9)
	sw	$v0, 1036($t9)
	sw	$v0, 1040($t9)
	sw	$v0, 1044($t9)
	sw	$v0, 1048($t9)
	sw	$v0, 1052($t9)
	sw	$v0, 1056($t9)
	sw	$v0, 1060($t9)
	sw	$v0, 1064($t9)
	sw	$v0, 1068($t9)
	sw	$v0, 1072($t9)
	sw	$v0, 1076($t9)
	sw	$v0, 1080($t9)
	sw	$v0, 1084($t9)
	sw	$v0, 1088($t9)
	sw	$v0, 1092($t9)
	sw	$v0, 1096($t9)
	sw	$v0, 1100($t9)
	sw	$v0, 1104($t9)
	sw	$v0, 1108($t9)
	sw	$v0, 1112($t9)
	sw	$v0, 1116($t9)
	sw	$v0, 1120($t9)
	sw	$v0, 1124($t9)
	sw	$v0, 1128($t9)
	sw	$v0, 1132($t9)
	sw	$v0, 1136($t9)
	sw	$v0, 1140($t9)
	sw	$v0, 1144($t9)
	sw	$v0, 1148($t9)
	sw	$v0, 1152($t9)
	sw	$v0, 1156($t9)
	sw	$v0, 1160($t9)
	sw	$v0, 1164($t9)
	sw	$v0, 1168($t9)
	sw	$v0, 1172($t9)
	sw	$v0, 1176($t9)
	sw	$v0, 1180($t9)
	sw	$v0, 1184($t9)
	sw	$v0, 1188($t9)
	sw	$v0, 1192($t9)
	sw	$v0, 1196($t9)
	sw	$v0, 1200($t9)
	sw	$v0, 1204($t9)
	sw	$v0, 1208($t9)
	sw	$v0, 1212($t9)
	sw	$v0, 1216($t9)
	sw	$v0, 1220($t9)
	sw	$v0, 1224($t9)
	sw	$v0, 1228($t9)
	sw	$v0, 1232($t9)
	sw	$v0, 1236($t9)
	sw	$v0, 1240($t9)
	sw	$v0, 1244($t9)
	sw	$v0, 1248($t9)
	sw	$v0, 1252($t9)
	sw	$v0, 1256($t9)
	sw	$v0, 1260($t9)
	sw	$v0, 1264($t9)
	sw	$v0, 1268($t9)
	sw	$v0, 1272($t9)
	sw	$v0, 1276($t9)
	sw	$v0, 1280($t9)
	sw	$v0, 1284($t9)
	sw	$v0, 1288($t9)
	sw	$v0, 1292($t9)
	sw	$v0, 1296($t9)
	sw	$v0, 1300($t9)
	sw	$v0, 1304($t9)
	sw	$v0, 1308($t9)
	sw	$v0, 1312($t9)
	sw	$v0, 1316($t9)
	sw	$v0, 1320($t9)
	sw	$v0, 1324($t9)
	sw	$v0, 1328($t9)
	sw	$v0, 1332($t9)
	sw	$v0, 1336($t9)
	sw	$v0, 1340($t9)
	sw	$v0, 1344($t9)
	sw	$v0, 1348($t9)
	sw	$v0, 1352($t9)
	sw	$v0, 1356($t9)
	sw	$v0, 1360($t9)
	sw	$v0, 1364($t9)
	sw	$v0, 1368($t9)
	sw	$v0, 1372($t9)
	sw	$v0, 1376($t9)
	sw	$v0, 1380($t9)
	sw	$v0, 1384($t9)
	sw	$v0, 1388($t9)
	sw	$v0, 1392($t9)
	sw	$v0, 1396($t9)
	sw	$v0, 1400($t9)
	sw	$v0, 1404($t9)
	sw	$v0, 1408($t9)
	sw	$v0, 1412($t9)
	sw	$v0, 1416($t9)
	sw	$v0, 1420($t9)
	sw	$v0, 1424($t9)
	sw	$v0, 1428($t9)
	sw	$v0, 1432($t9)
	sw	$v0, 1436($t9)
	sw	$v0, 1440($t9)
	sw	$v0, 1444($t9)
	sw	$v0, 1448($t9)
	sw	$v0, 1452($t9)
	sw	$v0, 1456($t9)
	sw	$v0, 1460($t9)
	sw	$v0, 1464($t9)
	sw	$v0, 1468($t9)
	sw	$v0, 1472($t9)
	sw	$v0, 1476($t9)
	sw	$v0, 1480($t9)
	sw	$v0, 1484($t9)
	sw	$v0, 1488($t9)
	sw	$v0, 1492($t9)
	sw	$v0, 1496($t9)
	sw	$v0, 1500($t9)
	sw	$v0, 1504($t9)
	sw	$v0, 1508($t9)
	sw	$v0, 1512($t9)
	sw	$v0, 1516($t9)
	sw	$v0, 1520($t9)
	sw	$v0, 1524($t9)
	sw	$v0, 1528($t9)
	sw	$v0, 1532($t9)
	sw	$v0, 1536($t9)
	sw	$v0, 1540($t9)
	sw	$v0, 1544($t9)
	sw	$v0, 1548($t9)
	sw	$v0, 1552($t9)
	sw	$v0, 1556($t9)
	sw	$v0, 1560($t9)
	sw	$v0, 1564($t9)
	sw	$v0, 1568($t9)
	sw	$v0, 1572($t9)
	sw	$v0, 1576($t9)
	sw	$v0, 1580($t9)
	sw	$v0, 1584($t9)
	sw	$v0, 1588($t9)
	sw	$v0, 1592($t9)
	sw	$v0, 1596($t9)
	sw	$v0, 1600($t9)
	sw	$v0, 1604($t9)
	sw	$v0, 1608($t9)
	sw	$v0, 1612($t9)
	sw	$v0, 1616($t9)
	sw	$v0, 1620($t9)
	sw	$v0, 1624($t9)
	sw	$v0, 1628($t9)
	sw	$v0, 1632($t9)
	sw	$v0, 1636($t9)
	sw	$v0, 1640($t9)
	sw	$v0, 1644($t9)
	sw	$v0, 1648($t9)
	sw	$v0, 1652($t9)
	sw	$v0, 1656($t9)
	sw	$v0, 1660($t9)
	sw	$v0, 1664($t9)
	sw	$v0, 1668($t9)
	sw	$v0, 1672($t9)
	sw	$v0, 1676($t9)
	sw	$v0, 1680($t9)
	sw	$v0, 1684($t9)
	sw	$v0, 1688($t9)
	sw	$v0, 1692($t9)
	sw	$v0, 1696($t9)
	sw	$v0, 1700($t9)
	sw	$v0, 1704($t9)
	sw	$v0, 1708($t9)
	sw	$v0, 1712($t9)
	sw	$v0, 1716($t9)
	sw	$v0, 1720($t9)
	sw	$v0, 1724($t9)
	sw	$v0, 1728($t9)
	sw	$v0, 1732($t9)
	sw	$zero, 1736($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 1740($t9)
	fsw	$f0, 1744($t9)
	fsw	$f0, 1748($t9)
	sw	$zero, 1752($t9)
	sw	$zero, 1756($t9)
	sw	$zero, 1760($t9)
	sw	$zero, 1764($t9)
	sw	$zero, 1768($t9)
	sw	$zero, 1772($t9)
	sw	$zero, 1776($t9)
	sw	$zero, 1780($t9)
	sw	$zero, 1784($t9)
	sw	$zero, 1788($t9)
	sw	$zero, 1792($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 1796($t9)
	fsw	$f0, 1800($t9)
	fsw	$f0, 1804($t9)
	sw	$zero, 1808($t9)
	sw	$zero, 1812($t9)
	sw	$zero, 1816($t9)
	sw	$zero, 1820($t9)
	sw	$zero, 1824($t9)
	sw	$zero, 1828($t9)
	sw	$zero, 1832($t9)
	sw	$zero, 1836($t9)
	sw	$zero, 1840($t9)
	sw	$zero, 1844($t9)
	sw	$zero, 1848($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 1852($t9)
	fsw	$f0, 1856($t9)
	fsw	$f0, 1860($t9)
	sw	$zero, 1864($t9)
	sw	$zero, 1868($t9)
	sw	$zero, 1872($t9)
	sw	$zero, 1876($t9)
	sw	$zero, 1880($t9)
	sw	$zero, 1884($t9)
	sw	$zero, 1888($t9)
	sw	$zero, 1892($t9)
	sw	$zero, 1896($t9)
	sw	$zero, 1900($t9)
	sw	$zero, 1904($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 1908($t9)
	fsw	$f0, 1912($t9)
	fsw	$f0, 1916($t9)
	lui	$v0, 512
	ori	$v0, $v0, 1908
	sw	$v0, 1920($t9)
	sw	$v0, 1924($t9)
	sw	$v0, 1928($t9)
	sw	$v0, 1932($t9)
	sw	$v0, 1936($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 1940($t9)
	fsw	$f0, 1944($t9)
	fsw	$f0, 1948($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 1952($t9)
	fsw	$f0, 1956($t9)
	fsw	$f0, 1960($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 1964($t9)
	fsw	$f0, 1968($t9)
	fsw	$f0, 1972($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 1976($t9)
	fsw	$f0, 1980($t9)
	fsw	$f0, 1984($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 1988($t9)
	fsw	$f0, 1992($t9)
	fsw	$f0, 1996($t9)
	lui	$v0, 512
	ori	$v0, $v0, 1988
	sw	$v0, 2000($t9)
	sw	$v0, 2004($t9)
	sw	$v0, 2008($t9)
	sw	$v0, 2012($t9)
	sw	$v0, 2016($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2020($t9)
	fsw	$f0, 2024($t9)
	fsw	$f0, 2028($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2032($t9)
	fsw	$f0, 2036($t9)
	fsw	$f0, 2040($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2044($t9)
	fsw	$f0, 2048($t9)
	fsw	$f0, 2052($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2056($t9)
	fsw	$f0, 2060($t9)
	fsw	$f0, 2064($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2068($t9)
	fsw	$f0, 2072($t9)
	fsw	$f0, 2076($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2068
	sw	$v0, 2080($t9)
	sw	$v0, 2084($t9)
	sw	$v0, 2088($t9)
	sw	$v0, 2092($t9)
	sw	$v0, 2096($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2100($t9)
	fsw	$f0, 2104($t9)
	fsw	$f0, 2108($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2112($t9)
	fsw	$f0, 2116($t9)
	fsw	$f0, 2120($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2124($t9)
	fsw	$f0, 2128($t9)
	fsw	$f0, 2132($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2136($t9)
	fsw	$f0, 2140($t9)
	fsw	$f0, 2144($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2148($t9)
	fsw	$f0, 2152($t9)
	fsw	$f0, 2156($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2148
	sw	$v0, 2160($t9)
	sw	$v0, 2164($t9)
	sw	$v0, 2168($t9)
	sw	$v0, 2172($t9)
	sw	$v0, 2176($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2180($t9)
	fsw	$f0, 2184($t9)
	fsw	$f0, 2188($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2192($t9)
	fsw	$f0, 2196($t9)
	fsw	$f0, 2200($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2204($t9)
	fsw	$f0, 2208($t9)
	fsw	$f0, 2212($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2216($t9)
	fsw	$f0, 2220($t9)
	fsw	$f0, 2224($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2228($t9)
	fsw	$f0, 2232($t9)
	fsw	$f0, 2236($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2228
	sw	$v0, 2240($t9)
	sw	$v0, 2244($t9)
	sw	$v0, 2248($t9)
	sw	$v0, 2252($t9)
	sw	$v0, 2256($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2260($t9)
	fsw	$f0, 2264($t9)
	fsw	$f0, 2268($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2272($t9)
	fsw	$f0, 2276($t9)
	fsw	$f0, 2280($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2284($t9)
	fsw	$f0, 2288($t9)
	fsw	$f0, 2292($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2296($t9)
	fsw	$f0, 2300($t9)
	fsw	$f0, 2304($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2308($t9)
	fsw	$f0, 2312($t9)
	fsw	$f0, 2316($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2308
	sw	$v0, 2320($t9)
	sw	$v0, 2324($t9)
	sw	$v0, 2328($t9)
	sw	$v0, 2332($t9)
	sw	$v0, 2336($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2340($t9)
	fsw	$f0, 2344($t9)
	fsw	$f0, 2348($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2352($t9)
	fsw	$f0, 2356($t9)
	fsw	$f0, 2360($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2364($t9)
	fsw	$f0, 2368($t9)
	fsw	$f0, 2372($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2376($t9)
	fsw	$f0, 2380($t9)
	fsw	$f0, 2384($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2388($t9)
	fsw	$f0, 2392($t9)
	fsw	$f0, 2396($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2388
	sw	$v0, 2400($t9)
	sw	$v0, 2404($t9)
	sw	$v0, 2408($t9)
	sw	$v0, 2412($t9)
	sw	$v0, 2416($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2420($t9)
	fsw	$f0, 2424($t9)
	fsw	$f0, 2428($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2432($t9)
	fsw	$f0, 2436($t9)
	fsw	$f0, 2440($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2444($t9)
	fsw	$f0, 2448($t9)
	fsw	$f0, 2452($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2456($t9)
	fsw	$f0, 2460($t9)
	fsw	$f0, 2464($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2468($t9)
	fsw	$f0, 2472($t9)
	fsw	$f0, 2476($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2468
	sw	$v0, 2480($t9)
	sw	$v0, 2484($t9)
	sw	$v0, 2488($t9)
	sw	$v0, 2492($t9)
	sw	$v0, 2496($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2500($t9)
	fsw	$f0, 2504($t9)
	fsw	$f0, 2508($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2512($t9)
	fsw	$f0, 2516($t9)
	fsw	$f0, 2520($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2524($t9)
	fsw	$f0, 2528($t9)
	fsw	$f0, 2532($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2536($t9)
	fsw	$f0, 2540($t9)
	fsw	$f0, 2544($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2548($t9)
	fsw	$f0, 2552($t9)
	fsw	$f0, 2556($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2548
	sw	$v0, 2560($t9)
	sw	$v0, 2564($t9)
	sw	$v0, 2568($t9)
	sw	$v0, 2572($t9)
	sw	$v0, 2576($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2580($t9)
	fsw	$f0, 2584($t9)
	fsw	$f0, 2588($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2592($t9)
	fsw	$f0, 2596($t9)
	fsw	$f0, 2600($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2604($t9)
	fsw	$f0, 2608($t9)
	fsw	$f0, 2612($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2616($t9)
	fsw	$f0, 2620($t9)
	fsw	$f0, 2624($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2628($t9)
	fsw	$f0, 2632($t9)
	fsw	$f0, 2636($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2628
	sw	$v0, 2640($t9)
	sw	$v0, 2644($t9)
	sw	$v0, 2648($t9)
	sw	$v0, 2652($t9)
	sw	$v0, 2656($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2660($t9)
	fsw	$f0, 2664($t9)
	fsw	$f0, 2668($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2672($t9)
	fsw	$f0, 2676($t9)
	fsw	$f0, 2680($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2684($t9)
	fsw	$f0, 2688($t9)
	fsw	$f0, 2692($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2696($t9)
	fsw	$f0, 2700($t9)
	fsw	$f0, 2704($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2708($t9)
	fsw	$f0, 2712($t9)
	fsw	$f0, 2716($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2708
	sw	$v0, 2720($t9)
	sw	$v0, 2724($t9)
	sw	$v0, 2728($t9)
	sw	$v0, 2732($t9)
	sw	$v0, 2736($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2740($t9)
	fsw	$f0, 2744($t9)
	fsw	$f0, 2748($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2752($t9)
	fsw	$f0, 2756($t9)
	fsw	$f0, 2760($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2764($t9)
	fsw	$f0, 2768($t9)
	fsw	$f0, 2772($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2776($t9)
	fsw	$f0, 2780($t9)
	fsw	$f0, 2784($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2788($t9)
	fsw	$f0, 2792($t9)
	fsw	$f0, 2796($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2788
	sw	$v0, 2800($t9)
	sw	$v0, 2804($t9)
	sw	$v0, 2808($t9)
	sw	$v0, 2812($t9)
	sw	$v0, 2816($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2820($t9)
	fsw	$f0, 2824($t9)
	fsw	$f0, 2828($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2832($t9)
	fsw	$f0, 2836($t9)
	fsw	$f0, 2840($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2844($t9)
	fsw	$f0, 2848($t9)
	fsw	$f0, 2852($t9)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	fsw	$f0, 2856($t9)
	fsw	$f0, 2860($t9)
	fsw	$f0, 2864($t9)
	lui	$v0, 512
	ori	$v0, $v0, 1740
	sw	$v0, 2868($t9)
	lui	$v0, 512
	ori	$v0, $v0, 1920
	sw	$v0, 2872($t9)
	lui	$v0, 512
	ori	$v0, $v0, 1752
	sw	$v0, 2876($t9)
	lui	$v0, 512
	ori	$v0, $v0, 1772
	sw	$v0, 2880($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2000
	sw	$v0, 2884($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2080
	sw	$v0, 2888($t9)
	lui	$v0, 512
	ori	$v0, $v0, 1792
	sw	$v0, 2892($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2160
	sw	$v0, 2896($t9)
	lui	$v0, 512
	ori	$v0, $v0, 1796
	sw	$v0, 2900($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2240
	sw	$v0, 2904($t9)
	lui	$v0, 512
	ori	$v0, $v0, 1808
	sw	$v0, 2908($t9)
	lui	$v0, 512
	ori	$v0, $v0, 1828
	sw	$v0, 2912($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2320
	sw	$v0, 2916($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2400
	sw	$v0, 2920($t9)
	lui	$v0, 512
	ori	$v0, $v0, 1848
	sw	$v0, 2924($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2480
	sw	$v0, 2928($t9)
	lui	$v0, 512
	ori	$v0, $v0, 1852
	sw	$v0, 2932($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2560
	sw	$v0, 2936($t9)
	lui	$v0, 512
	ori	$v0, $v0, 1864
	sw	$v0, 2940($t9)
	lui	$v0, 512
	ori	$v0, $v0, 1884
	sw	$v0, 2944($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2640
	sw	$v0, 2948($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2720
	sw	$v0, 2952($t9)
	lui	$v0, 512
	ori	$v0, $v0, 1904
	sw	$v0, 2956($t9)
	lui	$v0, 512
	ori	$v0, $v0, 2800
	sw	$v0, 2960($t9)
	addi	$t9, $t9, 2964
	addi	$v0, $zero, 256
	lui	$v1, 512
	ori	$v1, $v1, 616
	sw	$v0, 0($v1)
	addi	$a0, $zero, 256
	sw	$a0, 4($v1)
	addi	$v1, $zero, 128
	lui	$a0, 512
	ori	$a0, $a0, 624
	sw	$v1, 0($a0)
	addi	$v1, $zero, 128
	sw	$v1, 4($a0)
	sw	$ra, 0($sp)
	subi	$sp, $sp, 4
	jal	min_caml_float_of_int
	addi	$sp, $sp, 4
	lw	$ra, 0($sp)
	la	$t8, l.25353
	flw	$f1, 0($t8)
	fdiv	$f0, $f1, $f0
	lui	$v0, 512
	ori	$v0, $v0, 632
	fsw	$f0, 0($v0)
	lui	$v0, 512
	ori	$v0, $v0, 616
	lw	$v0, 0($v0)
	lui	$v1, 512
	ori	$v1, $v1, 1940
	lui	$a0, 512
	ori	$a0, $a0, 1920
	sw	$v1, 4($a0)
	lui	$v1, 512
	ori	$v1, $v1, 1952
	sw	$v1, 8($a0)
	lui	$v1, 512
	ori	$v1, $v1, 1964
	sw	$v1, 12($a0)
	lui	$v1, 512
	ori	$v1, $v1, 1976
	sw	$v1, 16($a0)
	lui	$v1, 512
	ori	$v1, $v1, 2020
	lui	$a0, 512
	ori	$a0, $a0, 2000
	sw	$v1, 4($a0)
	lui	$v1, 512
	ori	$v1, $v1, 2032
	sw	$v1, 8($a0)
	lui	$v1, 512
	ori	$v1, $v1, 2044
	sw	$v1, 12($a0)
	lui	$v1, 512
	ori	$v1, $v1, 2056
	sw	$v1, 16($a0)
	lui	$v1, 512
	ori	$v1, $v1, 2100
	lui	$a0, 512
	ori	$a0, $a0, 2080
	sw	$v1, 4($a0)
	lui	$v1, 512
	ori	$v1, $v1, 2112
	sw	$v1, 8($a0)
	lui	$v1, 512
	ori	$v1, $v1, 2124
	sw	$v1, 12($a0)
	lui	$v1, 512
	ori	$v1, $v1, 2136
	sw	$v1, 16($a0)
	lui	$v1, 512
	ori	$v1, $v1, 2180
	lui	$a0, 512
	ori	$a0, $a0, 2160
	sw	$v1, 4($a0)
	lui	$v1, 512
	ori	$v1, $v1, 2192
	sw	$v1, 8($a0)
	lui	$v1, 512
	ori	$v1, $v1, 2204
	sw	$v1, 12($a0)
	lui	$v1, 512
	ori	$v1, $v1, 2216
	sw	$v1, 16($a0)
	lui	$v1, 512
	ori	$v1, $v1, 2868
	sw	$ra, 0($sp)
	subi	$sp, $sp, 4
	jal	min_caml_create_array
	addi	$sp, $sp, 4
	lw	$ra, 0($sp)
	lui	$v1, 512
	ori	$v1, $v1, 616
	lw	$v1, 0($v1)
	subi	$v1, $v1, 2
	sw	$ra, 0($sp)
	subi	$sp, $sp, 4
	jal	init_line_elements.3040
	addi	$sp, $sp, 4
	lw	$ra, 0($sp)
	lui	$v1, 512
	ori	$v1, $v1, 616
	lw	$v1, 0($v1)
	lui	$a0, 512
	ori	$a0, $a0, 2260
	lui	$a1, 512
	ori	$a1, $a1, 2240
	sw	$a0, 4($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2272
	sw	$a0, 8($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2284
	sw	$a0, 12($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2296
	sw	$a0, 16($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2340
	lui	$a1, 512
	ori	$a1, $a1, 2320
	sw	$a0, 4($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2352
	sw	$a0, 8($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2364
	sw	$a0, 12($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2376
	sw	$a0, 16($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2420
	lui	$a1, 512
	ori	$a1, $a1, 2400
	sw	$a0, 4($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2432
	sw	$a0, 8($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2444
	sw	$a0, 12($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2456
	sw	$a0, 16($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2500
	lui	$a1, 512
	ori	$a1, $a1, 2480
	sw	$a0, 4($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2512
	sw	$a0, 8($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2524
	sw	$a0, 12($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2536
	sw	$a0, 16($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2900
	sw	$v0, 0($sp)
	move	$v0, $v1
	move	$v1, $a0
	sw	$ra, -4($sp)
	subi	$sp, $sp, 8
	jal	min_caml_create_array
	addi	$sp, $sp, 8
	lw	$ra, -4($sp)
	lui	$v1, 512
	ori	$v1, $v1, 616
	lw	$v1, 0($v1)
	subi	$v1, $v1, 2
	sw	$ra, -4($sp)
	subi	$sp, $sp, 8
	jal	init_line_elements.3040
	addi	$sp, $sp, 8
	lw	$ra, -4($sp)
	lui	$v1, 512
	ori	$v1, $v1, 616
	lw	$v1, 0($v1)
	lui	$a0, 512
	ori	$a0, $a0, 2580
	lui	$a1, 512
	ori	$a1, $a1, 2560
	sw	$a0, 4($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2592
	sw	$a0, 8($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2604
	sw	$a0, 12($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2616
	sw	$a0, 16($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2660
	lui	$a1, 512
	ori	$a1, $a1, 2640
	sw	$a0, 4($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2672
	sw	$a0, 8($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2684
	sw	$a0, 12($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2696
	sw	$a0, 16($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2740
	lui	$a1, 512
	ori	$a1, $a1, 2720
	sw	$a0, 4($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2752
	sw	$a0, 8($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2764
	sw	$a0, 12($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2776
	sw	$a0, 16($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2820
	lui	$a1, 512
	ori	$a1, $a1, 2800
	sw	$a0, 4($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2832
	sw	$a0, 8($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2844
	sw	$a0, 12($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2856
	sw	$a0, 16($a1)
	lui	$a0, 512
	ori	$a0, $a0, 2932
	sw	$v0, -4($sp)
	move	$v0, $v1
	move	$v1, $a0
	sw	$ra, -8($sp)
	subi	$sp, $sp, 12
	jal	min_caml_create_array
	addi	$sp, $sp, 12
	lw	$ra, -8($sp)
	lui	$v1, 512
	ori	$v1, $v1, 616
	lw	$v1, 0($v1)
	subi	$v1, $v1, 2
	sw	$ra, -8($sp)
	subi	$sp, $sp, 12
	jal	init_line_elements.3040
	addi	$sp, $sp, 12
	lw	$ra, -8($sp)
	sw	$v0, -8($sp)
	sw	$ra, -12($sp)
	subi	$sp, $sp, 16
	jal	min_caml_read_float
	addi	$sp, $sp, 16
	lw	$ra, -12($sp)
	lui	$v0, 512
	ori	$v0, $v0, 288
	fsw	$f0, 0($v0)
	sw	$v0, -12($sp)
	sw	$ra, -16($sp)
	subi	$sp, $sp, 20
	jal	min_caml_read_float
	addi	$sp, $sp, 20
	lw	$ra, -16($sp)
	lw	$v0, -12($sp)
	fsw	$f0, 4($v0)
	sw	$ra, -16($sp)
	subi	$sp, $sp, 20
	jal	min_caml_read_float
	addi	$sp, $sp, 20
	lw	$ra, -16($sp)
	lw	$v0, -12($sp)
	fsw	$f0, 8($v0)
	sw	$ra, -16($sp)
	subi	$sp, $sp, 20
	jal	min_caml_read_float
	addi	$sp, $sp, 20
	lw	$ra, -16($sp)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	la	$t8, l.23896
	flw	$f2, 0($t8)
	fmul	$f0, $f0, $f2
	fle	$f1, $f0
	fbf	fbt_else.29260
	fmove	$f1, $f0
	j	fbt_cont.29261
fbt_else.29260:
	fneg	$f1, $f0
fbt_cont.29261:
	la	$t8, l.23875
	flw	$f2, 0($t8)
	fsw	$f0, -16($sp)
	fsw	$f1, -20($sp)
	fmove	$f0, $f1
	fmove	$f1, $f2
	sw	$ra, -24($sp)
	subi	$sp, $sp, 28
	jal	adjust_exp.2562
	addi	$sp, $sp, 28
	lw	$ra, -24($sp)
	fmove	$f1, $f0
	flw	$f0, -20($sp)
	sw	$ra, -24($sp)
	subi	$sp, $sp, 28
	jal	sub_iter.2565
	addi	$sp, $sp, 28
	lw	$ra, -24($sp)
	la	$t8, l.23883
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.29262
	fsub	$f0, $f0, $f1
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	sw	$zero, 0($v0)
	j	fbt_cont.29263
fbt_else.29262:
	addi	$v0, $zero, 1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.29263:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.29264
	bne	$zero, $v0, beq_else.29266
	addi	$v0, $zero, 1
	j	beq_cont.29267
beq_else.29266:
	addi	$v0, $zero, 0
beq_cont.29267:
	fsub	$f0, $f1, $f0
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.29265
fbt_else.29264:
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.29265:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23944
	flw	$f2, 0($t8)
	fle	$f0, $f2
	fbf	fbt_else.29268
	bne	$zero, $v0, beq_else.29270
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
	fneg	$f0, $f0
	j	fbt_cont.29269
beq_else.29270:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
beq_cont.29271:
	j	fbt_cont.29269
fbt_else.29268:
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	bne	$zero, $v0, beq_else.29272
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fneg	$f0, $f0
	j	beq_cont.29273
beq_else.29272:
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
beq_cont.29273:
fbt_cont.29269:
	la	$t8, l.23884
	flw	$f2, 0($t8)
	flw	$f3, -16($sp)
	fle	$f2, $f3
	fbf	fbt_else.29274
	addi	$v0, $zero, 1
	j	fbt_cont.29275
fbt_else.29274:
	addi	$v0, $zero, 0
fbt_cont.29275:
	bne	$zero, $v0, beq_else.29276
	fneg	$f2, $f3
	j	beq_cont.29277
beq_else.29276:
	fmove	$f2, $f3
beq_cont.29277:
	la	$t8, l.23875
	flw	$f3, 0($t8)
	fsw	$f0, -24($sp)
	sw	$v0, -28($sp)
	fsw	$f1, -32($sp)
	fsw	$f2, -36($sp)
	fmove	$f1, $f3
	fmove	$f0, $f2
	sw	$ra, -40($sp)
	subi	$sp, $sp, 44
	jal	adjust_exp.2562
	addi	$sp, $sp, 44
	lw	$ra, -40($sp)
	fmove	$f1, $f0
	flw	$f0, -36($sp)
	sw	$ra, -40($sp)
	subi	$sp, $sp, 44
	jal	sub_iter.2565
	addi	$sp, $sp, 44
	lw	$ra, -40($sp)
	flw	$f1, -32($sp)
	fle	$f1, $f0
	fbf	fbt_else.29278
	lw	$v0, -28($sp)
	bne	$zero, $v0, beq_else.29280
	addi	$v0, $zero, 1
	j	beq_cont.29281
beq_else.29280:
	addi	$v0, $zero, 0
beq_cont.29281:
	fsub	$f0, $f0, $f1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.29279
fbt_else.29278:
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	lw	$v1, -28($sp)
	sw	$v1, 0($v0)
fbt_cont.29279:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.29282
	fsub	$f0, $f1, $f0
fbt_else.29282:
fbt_cont.29283:
	la	$t8, l.23944
	flw	$f2, 0($t8)
	fle	$f0, $f2
	fbf	fbt_else.29284
	bne	$zero, $v0, beq_else.29286
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fneg	$f0, $f0
	j	fbt_cont.29285
beq_else.29286:
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
beq_cont.29287:
	j	fbt_cont.29285
fbt_else.29284:
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	bne	$zero, $v0, beq_else.29288
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
	fneg	$f0, $f0
	j	beq_cont.29289
beq_else.29288:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
beq_cont.29289:
fbt_cont.29285:
	fsw	$f0, -40($sp)
	sw	$ra, -44($sp)
	subi	$sp, $sp, 48
	jal	min_caml_read_float
	addi	$sp, $sp, 48
	lw	$ra, -44($sp)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	la	$t8, l.23896
	flw	$f2, 0($t8)
	fmul	$f0, $f0, $f2
	fle	$f1, $f0
	fbf	fbt_else.29290
	fmove	$f1, $f0
	j	fbt_cont.29291
fbt_else.29290:
	fneg	$f1, $f0
fbt_cont.29291:
	la	$t8, l.23875
	flw	$f2, 0($t8)
	fsw	$f0, -44($sp)
	fsw	$f1, -48($sp)
	fmove	$f0, $f1
	fmove	$f1, $f2
	sw	$ra, -52($sp)
	subi	$sp, $sp, 56
	jal	adjust_exp.2562
	addi	$sp, $sp, 56
	lw	$ra, -52($sp)
	fmove	$f1, $f0
	flw	$f0, -48($sp)
	sw	$ra, -52($sp)
	subi	$sp, $sp, 56
	jal	sub_iter.2565
	addi	$sp, $sp, 56
	lw	$ra, -52($sp)
	flw	$f1, -32($sp)
	fle	$f1, $f0
	fbf	fbt_else.29292
	fsub	$f0, $f0, $f1
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	sw	$zero, 0($v0)
	j	fbt_cont.29293
fbt_else.29292:
	addi	$v0, $zero, 1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.29293:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.29294
	bne	$zero, $v0, beq_else.29296
	addi	$v0, $zero, 1
	j	beq_cont.29297
beq_else.29296:
	addi	$v0, $zero, 0
beq_cont.29297:
	fsub	$f0, $f1, $f0
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.29295
fbt_else.29294:
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.29295:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23944
	flw	$f2, 0($t8)
	fle	$f0, $f2
	fbf	fbt_else.29298
	bne	$zero, $v0, beq_else.29300
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
	fneg	$f0, $f0
	j	fbt_cont.29299
beq_else.29300:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
beq_cont.29301:
	j	fbt_cont.29299
fbt_else.29298:
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	bne	$zero, $v0, beq_else.29302
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fneg	$f0, $f0
	j	beq_cont.29303
beq_else.29302:
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
beq_cont.29303:
fbt_cont.29299:
	la	$t8, l.23884
	flw	$f2, 0($t8)
	flw	$f3, -44($sp)
	fle	$f2, $f3
	fbf	fbt_else.29304
	addi	$v0, $zero, 1
	j	fbt_cont.29305
fbt_else.29304:
	addi	$v0, $zero, 0
fbt_cont.29305:
	bne	$zero, $v0, beq_else.29306
	fneg	$f2, $f3
	j	beq_cont.29307
beq_else.29306:
	fmove	$f2, $f3
beq_cont.29307:
	la	$t8, l.23875
	flw	$f3, 0($t8)
	fsw	$f0, -52($sp)
	sw	$v0, -56($sp)
	fsw	$f2, -60($sp)
	fmove	$f1, $f3
	fmove	$f0, $f2
	sw	$ra, -64($sp)
	subi	$sp, $sp, 68
	jal	adjust_exp.2562
	addi	$sp, $sp, 68
	lw	$ra, -64($sp)
	fmove	$f1, $f0
	flw	$f0, -60($sp)
	sw	$ra, -64($sp)
	subi	$sp, $sp, 68
	jal	sub_iter.2565
	addi	$sp, $sp, 68
	lw	$ra, -64($sp)
	flw	$f1, -32($sp)
	fle	$f1, $f0
	fbf	fbt_else.29308
	lw	$v0, -56($sp)
	bne	$zero, $v0, beq_else.29310
	addi	$v0, $zero, 1
	j	beq_cont.29311
beq_else.29310:
	addi	$v0, $zero, 0
beq_cont.29311:
	fsub	$f0, $f0, $f1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.29309
fbt_else.29308:
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	lw	$v1, -56($sp)
	sw	$v1, 0($v0)
fbt_cont.29309:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.29312
	fsub	$f0, $f1, $f0
fbt_else.29312:
fbt_cont.29313:
	la	$t8, l.23944
	flw	$f2, 0($t8)
	fle	$f0, $f2
	fbf	fbt_else.29314
	bne	$zero, $v0, beq_else.29316
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fneg	$f0, $f0
	j	fbt_cont.29315
beq_else.29316:
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
beq_cont.29317:
	j	fbt_cont.29315
fbt_else.29314:
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	bne	$zero, $v0, beq_else.29318
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
	fneg	$f0, $f0
	j	beq_cont.29319
beq_else.29318:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
beq_cont.29319:
fbt_cont.29315:
	la	$t8, l.25448
	flw	$f2, 0($t8)
	flw	$f3, -24($sp)
	fmul	$f4, $f3, $f0
	fmul	$f2, $f4, $f2
	lui	$v0, 512
	ori	$v0, $v0, 684
	fsw	$f2, 0($v0)
	la	$t8, l.25450
	flw	$f2, 0($t8)
	flw	$f4, -40($sp)
	fmul	$f2, $f4, $f2
	fsw	$f2, 4($v0)
	la	$t8, l.25448
	flw	$f2, 0($t8)
	flw	$f5, -52($sp)
	fmul	$f6, $f3, $f5
	fmul	$f2, $f6, $f2
	fsw	$f2, 8($v0)
	lui	$v0, 512
	ori	$v0, $v0, 660
	fsw	$f5, 0($v0)
	la	$t8, l.23884
	flw	$f2, 0($t8)
	fsw	$f2, 4($v0)
	fneg	$f2, $f0
	fsw	$f2, 8($v0)
	fneg	$f2, $f4
	fmul	$f0, $f2, $f0
	lui	$v0, 512
	ori	$v0, $v0, 672
	fsw	$f0, 0($v0)
	fneg	$f0, $f3
	fsw	$f0, 4($v0)
	fmul	$f0, $f2, $f5
	fsw	$f0, 8($v0)
	lui	$v0, 512
	ori	$v0, $v0, 288
	flw	$f0, 0($v0)
	lui	$v0, 512
	ori	$v0, $v0, 684
	flw	$f2, 0($v0)
	fsub	$f0, $f0, $f2
	lui	$v0, 512
	ori	$v0, $v0, 300
	fsw	$f0, 0($v0)
	lui	$v1, 512
	ori	$v1, $v1, 292
	flw	$f0, 0($v1)
	lui	$v1, 512
	ori	$v1, $v1, 688
	flw	$f2, 0($v1)
	fsub	$f0, $f0, $f2
	fsw	$f0, 4($v0)
	lui	$v1, 512
	ori	$v1, $v1, 296
	flw	$f0, 0($v1)
	lui	$v1, 512
	ori	$v1, $v1, 692
	flw	$f2, 0($v1)
	fsub	$f0, $f0, $f2
	fsw	$f0, 8($v0)
	sw	$ra, -64($sp)
	subi	$sp, $sp, 68
	jal	min_caml_read_int
	addi	$sp, $sp, 68
	lw	$ra, -64($sp)
	sw	$ra, -64($sp)
	subi	$sp, $sp, 68
	jal	min_caml_read_float
	addi	$sp, $sp, 68
	lw	$ra, -64($sp)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	la	$t8, l.23896
	flw	$f2, 0($t8)
	fmul	$f0, $f0, $f2
	fle	$f1, $f0
	fbf	fbt_else.29320
	addi	$v0, $zero, 1
	j	fbt_cont.29321
fbt_else.29320:
	addi	$v0, $zero, 0
fbt_cont.29321:
	bne	$zero, $v0, beq_else.29322
	fneg	$f1, $f0
	j	beq_cont.29323
beq_else.29322:
	fmove	$f1, $f0
beq_cont.29323:
	la	$t8, l.23875
	flw	$f2, 0($t8)
	fsw	$f0, -64($sp)
	sw	$v0, -68($sp)
	fsw	$f1, -72($sp)
	fmove	$f0, $f1
	fmove	$f1, $f2
	sw	$ra, -76($sp)
	subi	$sp, $sp, 80
	jal	adjust_exp.2562
	addi	$sp, $sp, 80
	lw	$ra, -76($sp)
	fmove	$f1, $f0
	flw	$f0, -72($sp)
	sw	$ra, -76($sp)
	subi	$sp, $sp, 80
	jal	sub_iter.2565
	addi	$sp, $sp, 80
	lw	$ra, -76($sp)
	flw	$f1, -32($sp)
	fle	$f1, $f0
	fbf	fbt_else.29324
	lw	$v0, -68($sp)
	bne	$zero, $v0, beq_else.29326
	addi	$v0, $zero, 1
	j	beq_cont.29327
beq_else.29326:
	addi	$v0, $zero, 0
beq_cont.29327:
	fsub	$f0, $f0, $f1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.29325
fbt_else.29324:
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	lw	$v1, -68($sp)
	sw	$v1, 0($v0)
fbt_cont.29325:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.29328
	fsub	$f0, $f1, $f0
fbt_else.29328:
fbt_cont.29329:
	la	$t8, l.23944
	flw	$f2, 0($t8)
	fle	$f0, $f2
	fbf	fbt_else.29330
	bne	$zero, $v0, beq_else.29332
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fneg	$f0, $f0
	j	fbt_cont.29331
beq_else.29332:
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
beq_cont.29333:
	j	fbt_cont.29331
fbt_else.29330:
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	bne	$zero, $v0, beq_else.29334
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
	fneg	$f0, $f0
	j	beq_cont.29335
beq_else.29334:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
beq_cont.29335:
fbt_cont.29331:
	fneg	$f0, $f0
	lui	$v0, 512
	ori	$v0, $v0, 312
	fsw	$f0, 4($v0)
	sw	$v0, -76($sp)
	sw	$ra, -80($sp)
	subi	$sp, $sp, 84
	jal	min_caml_read_float
	addi	$sp, $sp, 84
	lw	$ra, -80($sp)
	la	$t8, l.23884
	flw	$f1, 0($t8)
	flw	$f2, -64($sp)
	fle	$f1, $f2
	fbf	fbt_else.29336
	fmove	$f1, $f2
	j	fbt_cont.29337
fbt_else.29336:
	fneg	$f1, $f2
fbt_cont.29337:
	la	$t8, l.23875
	flw	$f2, 0($t8)
	fsw	$f0, -80($sp)
	fsw	$f1, -84($sp)
	fmove	$f0, $f1
	fmove	$f1, $f2
	sw	$ra, -88($sp)
	subi	$sp, $sp, 92
	jal	adjust_exp.2562
	addi	$sp, $sp, 92
	lw	$ra, -88($sp)
	fmove	$f1, $f0
	flw	$f0, -84($sp)
	sw	$ra, -88($sp)
	subi	$sp, $sp, 92
	jal	sub_iter.2565
	addi	$sp, $sp, 92
	lw	$ra, -88($sp)
	flw	$f1, -32($sp)
	fle	$f1, $f0
	fbf	fbt_else.29338
	fsub	$f0, $f0, $f1
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	sw	$zero, 0($v0)
	j	fbt_cont.29339
fbt_else.29338:
	addi	$v0, $zero, 1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.29339:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.29340
	bne	$zero, $v0, beq_else.29342
	addi	$v0, $zero, 1
	j	beq_cont.29343
beq_else.29342:
	addi	$v0, $zero, 0
beq_cont.29343:
	fsub	$f0, $f1, $f0
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.29341
fbt_else.29340:
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.29341:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23944
	flw	$f2, 0($t8)
	fle	$f0, $f2
	fbf	fbt_else.29344
	bne	$zero, $v0, beq_else.29346
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
	fneg	$f0, $f0
	j	fbt_cont.29345
beq_else.29346:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
beq_cont.29347:
	j	fbt_cont.29345
fbt_else.29344:
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	bne	$zero, $v0, beq_else.29348
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fneg	$f0, $f0
	j	beq_cont.29349
beq_else.29348:
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
beq_cont.29349:
fbt_cont.29345:
	la	$t8, l.23884
	flw	$f2, 0($t8)
	la	$t8, l.23896
	flw	$f3, 0($t8)
	flw	$f4, -80($sp)
	fmul	$f3, $f4, $f3
	fle	$f2, $f3
	fbf	fbt_else.29350
	addi	$v0, $zero, 1
	j	fbt_cont.29351
fbt_else.29350:
	addi	$v0, $zero, 0
fbt_cont.29351:
	bne	$zero, $v0, beq_else.29352
	fneg	$f2, $f3
	j	beq_cont.29353
beq_else.29352:
	fmove	$f2, $f3
beq_cont.29353:
	la	$t8, l.23875
	flw	$f4, 0($t8)
	fsw	$f3, -88($sp)
	fsw	$f0, -92($sp)
	sw	$v0, -96($sp)
	fsw	$f2, -100($sp)
	fmove	$f1, $f4
	fmove	$f0, $f2
	sw	$ra, -104($sp)
	subi	$sp, $sp, 108
	jal	adjust_exp.2562
	addi	$sp, $sp, 108
	lw	$ra, -104($sp)
	fmove	$f1, $f0
	flw	$f0, -100($sp)
	sw	$ra, -104($sp)
	subi	$sp, $sp, 108
	jal	sub_iter.2565
	addi	$sp, $sp, 108
	lw	$ra, -104($sp)
	flw	$f1, -32($sp)
	fle	$f1, $f0
	fbf	fbt_else.29354
	lw	$v0, -96($sp)
	bne	$zero, $v0, beq_else.29356
	addi	$v0, $zero, 1
	j	beq_cont.29357
beq_else.29356:
	addi	$v0, $zero, 0
beq_cont.29357:
	fsub	$f0, $f0, $f1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.29355
fbt_else.29354:
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	lw	$v1, -96($sp)
	sw	$v1, 0($v0)
fbt_cont.29355:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.29358
	fsub	$f0, $f1, $f0
fbt_else.29358:
fbt_cont.29359:
	la	$t8, l.23944
	flw	$f2, 0($t8)
	fle	$f0, $f2
	fbf	fbt_else.29360
	bne	$zero, $v0, beq_else.29362
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
	fneg	$f0, $f0
	j	fbt_cont.29361
beq_else.29362:
	fmul	$f2, $f0, $f0
	la	$t8, l.23916
	flw	$f3, 0($t8)
	la	$t8, l.23945
	flw	$f4, 0($t8)
	la	$t8, l.23946
	flw	$f5, 0($t8)
	la	$t8, l.23947
	flw	$f6, 0($t8)
	fmul	$f6, $f6, $f2
	fsub	$f5, $f5, $f6
	fmul	$f5, $f5, $f2
	fsub	$f4, $f4, $f5
	fmul	$f2, $f4, $f2
	fsub	$f2, $f3, $f2
	fmul	$f0, $f2, $f0
beq_cont.29363:
	j	fbt_cont.29361
fbt_else.29360:
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fsub	$f0, $f2, $f0
	bne	$zero, $v0, beq_else.29364
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
	fneg	$f0, $f0
	j	beq_cont.29365
beq_else.29364:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23876
	flw	$f3, 0($t8)
	la	$t8, l.23948
	flw	$f4, 0($t8)
	la	$t8, l.23949
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f0
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f0, $f3, $f0
	fsub	$f0, $f2, $f0
beq_cont.29365:
fbt_cont.29361:
	flw	$f2, -92($sp)
	fmul	$f0, $f2, $f0
	lw	$v0, -76($sp)
	fsw	$f0, 0($v0)
	la	$t8, l.23884
	flw	$f0, 0($t8)
	flw	$f3, -88($sp)
	fle	$f0, $f3
	fbf	fbt_else.29366
	fmove	$f0, $f3
	j	fbt_cont.29367
fbt_else.29366:
	fneg	$f0, $f3
fbt_cont.29367:
	la	$t8, l.23875
	flw	$f3, 0($t8)
	fsw	$f0, -104($sp)
	fmove	$f1, $f3
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	adjust_exp.2562
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	fmove	$f1, $f0
	flw	$f0, -104($sp)
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	sub_iter.2565
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	flw	$f1, -32($sp)
	fle	$f1, $f0
	fbf	fbt_else.29368
	fsub	$f0, $f0, $f1
	move	$v0, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v0)
	sw	$zero, 0($v0)
	j	fbt_cont.29369
fbt_else.29368:
	addi	$v0, $zero, 1
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.29369:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23937
	flw	$f2, 0($t8)
	fle	$f2, $f0
	fbf	fbt_else.29370
	bne	$zero, $v0, beq_else.29372
	addi	$v0, $zero, 1
	j	beq_cont.29373
beq_else.29372:
	addi	$v0, $zero, 0
beq_cont.29373:
	fsub	$f0, $f1, $f0
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
	j	fbt_cont.29371
fbt_else.29370:
	move	$v1, $t9
	addi	$t9, $t9, 8
	fsw	$f0, 4($v1)
	sw	$v0, 0($v1)
	move	$v0, $v1
fbt_cont.29371:
	flw	$f0, 4($v0)
	lw	$v0, 0($v0)
	la	$t8, l.23944
	flw	$f1, 0($t8)
	fle	$f0, $f1
	fbf	fbt_else.29374
	bne	$zero, $v0, beq_else.29376
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
	fneg	$f0, $f0
	j	fbt_cont.29375
beq_else.29376:
	fmul	$f0, $f0, $f0
	la	$t8, l.23916
	flw	$f1, 0($t8)
	la	$t8, l.23876
	flw	$f2, 0($t8)
	la	$t8, l.23948
	flw	$f3, 0($t8)
	la	$t8, l.23949
	flw	$f4, 0($t8)
	fmul	$f4, $f4, $f0
	fsub	$f3, $f3, $f4
	fmul	$f3, $f3, $f0
	fsub	$f2, $f2, $f3
	fmul	$f0, $f2, $f0
	fsub	$f0, $f1, $f0
beq_cont.29377:
	j	fbt_cont.29375
fbt_else.29374:
	la	$t8, l.23937
	flw	$f1, 0($t8)
	fsub	$f0, $f1, $f0
	bne	$zero, $v0, beq_else.29378
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
	fneg	$f0, $f0
	j	beq_cont.29379
beq_else.29378:
	fmul	$f1, $f0, $f0
	la	$t8, l.23916
	flw	$f2, 0($t8)
	la	$t8, l.23945
	flw	$f3, 0($t8)
	la	$t8, l.23946
	flw	$f4, 0($t8)
	la	$t8, l.23947
	flw	$f5, 0($t8)
	fmul	$f5, $f5, $f1
	fsub	$f4, $f4, $f5
	fmul	$f4, $f4, $f1
	fsub	$f3, $f3, $f4
	fmul	$f1, $f3, $f1
	fsub	$f1, $f2, $f1
	fmul	$f0, $f1, $f0
beq_cont.29379:
fbt_cont.29375:
	flw	$f1, -92($sp)
	fmul	$f0, $f1, $f0
	lw	$v0, -76($sp)
	fsw	$f0, 8($v0)
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	min_caml_read_float
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	lui	$v0, 512
	ori	$v0, $v0, 324
	fsw	$f0, 0($v0)
	move	$v0, $zero
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	read_object.2747
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	move	$v0, $zero
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	read_and_network.2755
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	move	$v0, $zero
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	read_or_network.2753
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	lui	$v1, 512
	ori	$v1, $v1, 536
	sw	$v0, 0($v1)
	addi	$v0, $zero, 80
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	min_caml_print_char
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	addi	$v0, $zero, 51
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	min_caml_print_char
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	addi	$v0, $zero, 10
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	min_caml_print_char
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	lui	$v0, 512
	ori	$v0, $v0, 616
	lw	$v0, 0($v0)
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	print_int.2612
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	addi	$v0, $zero, 32
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	min_caml_print_char
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	lui	$v0, 512
	ori	$v0, $v0, 620
	lw	$v0, 0($v0)
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	print_int.2612
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	addi	$v0, $zero, 32
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	min_caml_print_char
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	addi	$v0, $zero, 255
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	print_int.2612
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	addi	$v0, $zero, 10
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	min_caml_print_char
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	addi	$v0, $zero, 4
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	create_dirvecs.3072
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	addi	$v0, $zero, 9
	move	$a0, $zero
	move	$v1, $zero
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	calc_dirvec_rows.3063
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	addi	$v0, $zero, 4
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	init_vecset_constants.3077
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	lui	$v0, 512
	ori	$v0, $v0, 988
	lw	$v0, 0($v0)
	lui	$v1, 512
	ori	$v1, $v1, 312
	flw	$f0, 0($v1)
	fsw	$f0, 0($v0)
	lui	$v1, 512
	ori	$v1, $v1, 316
	flw	$f0, 0($v1)
	fsw	$f0, 4($v0)
	lui	$v1, 512
	ori	$v1, $v1, 320
	flw	$f0, 0($v1)
	fsw	$f0, 8($v0)
	lui	$v0, 512
	lw	$v0, 0($v0)
	subi	$v1, $v0, 1
	lui	$v0, 512
	ori	$v0, $v0, 988
	sw	$ra, -108($sp)
	subi	$sp, $sp, 112
	jal	iter_setup_dirvec_constants.2852
	addi	$sp, $sp, 112
	lw	$ra, -108($sp)
	lui	$v0, 512
	lw	$v0, 0($v0)
	subi	$v0, $v0, 1
	lui	$v1, 512
	ori	$v1, $v1, 1736
	lui	$a0, 512
	ori	$a0, $a0, 1016
	lui	$a1, 512
	ori	$a1, $a1, 48
	lui	$a2, 512
	slti	$t8, $v0, 0
	bne	$t8, $zero, beq_else.29380
	sll	$a3, $v0, 2
	add	$t8, $a1, $a3
	lw	$a1, 0($t8)
	lw	$a3, 8($a1)
	addi	$t8, $zero, 2
	bne	$t8, $a3, beq_else.29382
	lw	$a3, 28($a1)
	flw	$f0, 0($a3)
	la	$t8, l.23916
	flw	$f1, 0($t8)
	fle	$f1, $f0
	fbf	fbt_else.29384
	addi	$a3, $zero, 0
	j	fbt_cont.29385
fbt_else.29384:
	addi	$a3, $zero, 1
fbt_cont.29385:
	bne	$zero, $a3, beq_else.29386
	j	beq_cont.29387
beq_else.29386:
	lw	$a3, 4($a1)
	addi	$t8, $zero, 1
	bne	$t8, $a3, beq_else.29388
	sll	$v0, $v0, 2
	lw	$a3, 0($v1)
	la	$t8, l.23916
	flw	$f0, 0($t8)
	lw	$a1, 28($a1)
	flw	$f1, 0($a1)
	fsub	$f0, $f0, $f1
	lw	$a1, -76($sp)
	flw	$f1, 0($a1)
	fneg	$f1, $f1
	flw	$f2, 4($a1)
	fneg	$f2, $f2
	flw	$f3, 8($a1)
	fneg	$f3, $f3
	addi	$t0, $v0, 1
	flw	$f4, 0($a1)
	addi	$t1, $zero, 3
	la	$t8, l.23884
	flw	$f5, 0($t8)
	sw	$v1, -108($sp)
	fsw	$f1, -112($sp)
	sw	$v0, -116($sp)
	sw	$a0, -120($sp)
	sw	$a3, -124($sp)
	sw	$t0, -128($sp)
	fsw	$f0, -132($sp)
	fsw	$f3, -136($sp)
	fsw	$f2, -140($sp)
	fsw	$f4, -144($sp)
	sw	$a2, -148($sp)
	move	$v0, $t1
	fmove	$f0, $f5
	sw	$ra, -152($sp)
	subi	$sp, $sp, 156
	jal	min_caml_create_float_array
	addi	$sp, $sp, 156
	lw	$ra, -152($sp)
	move	$v1, $v0
	lw	$v0, -148($sp)
	lw	$a0, 0($v0)
	sw	$v1, -152($sp)
	move	$v0, $a0
	sw	$ra, -156($sp)
	subi	$sp, $sp, 160
	jal	min_caml_create_array
	addi	$sp, $sp, 160
	lw	$ra, -156($sp)
	move	$v1, $t9
	addi	$t9, $t9, 8
	sw	$v0, 4($v1)
	lw	$v0, -152($sp)
	sw	$v0, 0($v1)
	flw	$f0, -144($sp)
	fsw	$f0, 0($v0)
	flw	$f0, -140($sp)
	fsw	$f0, 4($v0)
	flw	$f1, -136($sp)
	fsw	$f1, 8($v0)
	lw	$v0, -148($sp)
	lw	$a0, 0($v0)
	subi	$a0, $a0, 1
	sw	$v1, -156($sp)
	move	$v0, $v1
	move	$v1, $a0
	sw	$ra, -160($sp)
	subi	$sp, $sp, 164
	jal	iter_setup_dirvec_constants.2852
	addi	$sp, $sp, 164
	lw	$ra, -160($sp)
	move	$v0, $t9
	addi	$t9, $t9, 12
	flw	$f0, -132($sp)
	fsw	$f0, 8($v0)
	lw	$v1, -156($sp)
	sw	$v1, 4($v0)
	lw	$v1, -128($sp)
	sw	$v1, 0($v0)
	lw	$v1, -124($sp)
	sll	$a0, $v1, 2
	lw	$a1, -120($sp)
	add	$t8, $a1, $a0
	sw	$v0, 0($t8)
	addi	$v0, $v1, 1
	lw	$a0, -116($sp)
	addi	$a2, $a0, 2
	lw	$a3, -76($sp)
	flw	$f1, 4($a3)
	addi	$t0, $zero, 3
	la	$t8, l.23884
	flw	$f2, 0($t8)
	sw	$v0, -160($sp)
	sw	$a2, -164($sp)
	fsw	$f1, -168($sp)
	move	$v0, $t0
	fmove	$f0, $f2
	sw	$ra, -172($sp)
	subi	$sp, $sp, 176
	jal	min_caml_create_float_array
	addi	$sp, $sp, 176
	lw	$ra, -172($sp)
	move	$v1, $v0
	lw	$v0, -148($sp)
	lw	$a0, 0($v0)
	sw	$v1, -172($sp)
	move	$v0, $a0
	sw	$ra, -176($sp)
	subi	$sp, $sp, 180
	jal	min_caml_create_array
	addi	$sp, $sp, 180
	lw	$ra, -176($sp)
	move	$v1, $t9
	addi	$t9, $t9, 8
	sw	$v0, 4($v1)
	lw	$v0, -172($sp)
	sw	$v0, 0($v1)
	flw	$f0, -112($sp)
	fsw	$f0, 0($v0)
	flw	$f1, -168($sp)
	fsw	$f1, 4($v0)
	flw	$f1, -136($sp)
	fsw	$f1, 8($v0)
	lw	$v0, -148($sp)
	lw	$a0, 0($v0)
	subi	$a0, $a0, 1
	sw	$v1, -176($sp)
	move	$v0, $v1
	move	$v1, $a0
	sw	$ra, -180($sp)
	subi	$sp, $sp, 184
	jal	iter_setup_dirvec_constants.2852
	addi	$sp, $sp, 184
	lw	$ra, -180($sp)
	move	$v0, $t9
	addi	$t9, $t9, 12
	flw	$f0, -132($sp)
	fsw	$f0, 8($v0)
	lw	$v1, -176($sp)
	sw	$v1, 4($v0)
	lw	$v1, -164($sp)
	sw	$v1, 0($v0)
	lw	$v1, -160($sp)
	sll	$v1, $v1, 2
	lw	$a0, -120($sp)
	add	$t8, $a0, $v1
	sw	$v0, 0($t8)
	lw	$v0, -124($sp)
	addi	$v1, $v0, 2
	lw	$a1, -116($sp)
	addi	$a1, $a1, 3
	lw	$a2, -76($sp)
	flw	$f1, 8($a2)
	addi	$a2, $zero, 3
	la	$t8, l.23884
	flw	$f2, 0($t8)
	sw	$v1, -180($sp)
	sw	$a1, -184($sp)
	fsw	$f1, -188($sp)
	move	$v0, $a2
	fmove	$f0, $f2
	sw	$ra, -192($sp)
	subi	$sp, $sp, 196
	jal	min_caml_create_float_array
	addi	$sp, $sp, 196
	lw	$ra, -192($sp)
	move	$v1, $v0
	lw	$v0, -148($sp)
	lw	$a0, 0($v0)
	sw	$v1, -192($sp)
	move	$v0, $a0
	sw	$ra, -196($sp)
	subi	$sp, $sp, 200
	jal	min_caml_create_array
	addi	$sp, $sp, 200
	lw	$ra, -196($sp)
	move	$v1, $t9
	addi	$t9, $t9, 8
	sw	$v0, 4($v1)
	lw	$v0, -192($sp)
	sw	$v0, 0($v1)
	flw	$f0, -112($sp)
	fsw	$f0, 0($v0)
	flw	$f0, -140($sp)
	fsw	$f0, 4($v0)
	flw	$f0, -188($sp)
	fsw	$f0, 8($v0)
	lw	$v0, -148($sp)
	lw	$v0, 0($v0)
	subi	$v0, $v0, 1
	sw	$v1, -196($sp)
	move	$gp, $v1
	move	$v1, $v0
	move	$v0, $gp
	sw	$ra, -200($sp)
	subi	$sp, $sp, 204
	jal	iter_setup_dirvec_constants.2852
	addi	$sp, $sp, 204
	lw	$ra, -200($sp)
	move	$v0, $t9
	addi	$t9, $t9, 12
	flw	$f0, -132($sp)
	fsw	$f0, 8($v0)
	lw	$v1, -196($sp)
	sw	$v1, 4($v0)
	lw	$v1, -184($sp)
	sw	$v1, 0($v0)
	lw	$v1, -180($sp)
	sll	$v1, $v1, 2
	lw	$a0, -120($sp)
	add	$t8, $a0, $v1
	sw	$v0, 0($t8)
	lw	$v0, -124($sp)
	addi	$v0, $v0, 3
	lw	$v1, -108($sp)
	sw	$v0, 0($v1)
	j	beq_cont.29389
beq_else.29388:
	addi	$t8, $zero, 2
	bne	$t8, $a3, beq_else.29390
	sll	$v0, $v0, 2
	addi	$v0, $v0, 1
	lw	$a3, 0($v1)
	la	$t8, l.23916
	flw	$f0, 0($t8)
	lw	$t0, 28($a1)
	flw	$f1, 0($t0)
	fsub	$f0, $f0, $f1
	lw	$t0, 16($a1)
	lw	$t1, -76($sp)
	flw	$f1, 0($t1)
	flw	$f2, 0($t0)
	fmul	$f1, $f1, $f2
	flw	$f2, 4($t1)
	flw	$f3, 4($t0)
	fmul	$f2, $f2, $f3
	fadd	$f1, $f1, $f2
	flw	$f2, 8($t1)
	flw	$f3, 8($t0)
	fmul	$f2, $f2, $f3
	fadd	$f1, $f1, $f2
	la	$t8, l.23874
	flw	$f2, 0($t8)
	lw	$t0, 16($a1)
	flw	$f3, 0($t0)
	fmul	$f2, $f2, $f3
	fmul	$f2, $f2, $f1
	flw	$f3, 0($t1)
	fsub	$f2, $f2, $f3
	la	$t8, l.23874
	flw	$f3, 0($t8)
	lw	$t0, 16($a1)
	flw	$f4, 4($t0)
	fmul	$f3, $f3, $f4
	fmul	$f3, $f3, $f1
	flw	$f4, 4($t1)
	fsub	$f3, $f3, $f4
	la	$t8, l.23874
	flw	$f4, 0($t8)
	lw	$a1, 16($a1)
	flw	$f5, 8($a1)
	fmul	$f4, $f4, $f5
	fmul	$f1, $f4, $f1
	flw	$f4, 8($t1)
	fsub	$f1, $f1, $f4
	addi	$a1, $zero, 3
	la	$t8, l.23884
	flw	$f4, 0($t8)
	sw	$v1, -108($sp)
	sw	$a0, -120($sp)
	sw	$a3, -200($sp)
	sw	$v0, -204($sp)
	fsw	$f0, -208($sp)
	fsw	$f1, -212($sp)
	fsw	$f3, -216($sp)
	fsw	$f2, -220($sp)
	sw	$a2, -148($sp)
	move	$v0, $a1
	fmove	$f0, $f4
	sw	$ra, -224($sp)
	subi	$sp, $sp, 228
	jal	min_caml_create_float_array
	addi	$sp, $sp, 228
	lw	$ra, -224($sp)
	move	$v1, $v0
	lw	$v0, -148($sp)
	lw	$a0, 0($v0)
	sw	$v1, -224($sp)
	move	$v0, $a0
	sw	$ra, -228($sp)
	subi	$sp, $sp, 232
	jal	min_caml_create_array
	addi	$sp, $sp, 232
	lw	$ra, -228($sp)
	move	$v1, $t9
	addi	$t9, $t9, 8
	sw	$v0, 4($v1)
	lw	$v0, -224($sp)
	sw	$v0, 0($v1)
	flw	$f0, -220($sp)
	fsw	$f0, 0($v0)
	flw	$f0, -216($sp)
	fsw	$f0, 4($v0)
	flw	$f0, -212($sp)
	fsw	$f0, 8($v0)
	lw	$v0, -148($sp)
	lw	$v0, 0($v0)
	subi	$v0, $v0, 1
	sw	$v1, -228($sp)
	move	$gp, $v1
	move	$v1, $v0
	move	$v0, $gp
	sw	$ra, -232($sp)
	subi	$sp, $sp, 236
	jal	iter_setup_dirvec_constants.2852
	addi	$sp, $sp, 236
	lw	$ra, -232($sp)
	move	$v0, $t9
	addi	$t9, $t9, 12
	flw	$f0, -208($sp)
	fsw	$f0, 8($v0)
	lw	$v1, -228($sp)
	sw	$v1, 4($v0)
	lw	$v1, -204($sp)
	sw	$v1, 0($v0)
	lw	$v1, -200($sp)
	sll	$a0, $v1, 2
	lw	$a1, -120($sp)
	add	$t8, $a1, $a0
	sw	$v0, 0($t8)
	addi	$v0, $v1, 1
	lw	$v1, -108($sp)
	sw	$v0, 0($v1)
beq_else.29390:
beq_cont.29391:
beq_cont.29389:
beq_cont.29387:
beq_else.29382:
beq_cont.29383:
beq_else.29380:
beq_cont.29381:
	lui	$v0, 512
	ori	$v0, $v0, 632
	flw	$f0, 0($v0)
	lui	$v0, 512
	ori	$v0, $v0, 628
	lw	$v0, 0($v0)
	sub	$v0, $zero, $v0
	fsw	$f0, -232($sp)
	sw	$ra, -236($sp)
	subi	$sp, $sp, 240
	jal	min_caml_float_of_int
	addi	$sp, $sp, 240
	lw	$ra, -236($sp)
	lui	$v0, 512
	ori	$v0, $v0, 672
	flw	$f1, 0($v0)
	lui	$v0, 512
	ori	$v0, $v0, 684
	flw	$f2, 0($v0)
	lui	$v0, 512
	ori	$v0, $v0, 676
	flw	$f3, 0($v0)
	lui	$v0, 512
	ori	$v0, $v0, 688
	flw	$f4, 0($v0)
	lui	$v0, 512
	ori	$v0, $v0, 680
	flw	$f5, 0($v0)
	lui	$v0, 512
	ori	$v0, $v0, 692
	flw	$f6, 0($v0)
	lui	$v0, 512
	ori	$v0, $v0, 616
	lw	$v0, 0($v0)
	subi	$v1, $v0, 1
	flw	$f7, -232($sp)
	fmul	$f0, $f7, $f0
	fmul	$f5, $f0, $f5
	fadd	$f5, $f5, $f6
	fmul	$f3, $f0, $f3
	fadd	$f3, $f3, $f4
	fmul	$f0, $f0, $f1
	fadd	$f0, $f0, $f2
	lw	$v0, -4($sp)
	move	$a0, $zero
	fmove	$f2, $f5
	fmove	$f1, $f3
	sw	$ra, -236($sp)
	subi	$sp, $sp, 240
	jal	pretrace_pixels.3011
	addi	$sp, $sp, 240
	lw	$ra, -236($sp)
	addi	$a2, $zero, 2
	addi	$a3, $zero, 3
	lw	$v1, 0($sp)
	lw	$a0, -4($sp)
	lw	$a1, -8($sp)
	move	$v0, $zero
	sw	$ra, -236($sp)
	subi	$sp, $sp, 240
	jal	scan_line.3029
	addi	$sp, $sp, 240
	lw	$ra, -236($sp)
#	main program ends
_halt:
	j	_halt
