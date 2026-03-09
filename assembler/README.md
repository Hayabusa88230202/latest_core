# MIPSアセンブラ

CPU実験2025第7班専用のMIPSアセンブラです。２パスアセンブラであり、ラベルに対応しています。

## 対応命令

[7班現行ISA](https://docs.google.com/spreadsheets/d/1Fh1RrgWITBiWIzRu-9uR-0sdNd5owhdfcugUg5QE2_4/edit?pli=1&gid=0#gid=0)

## 実行手順

input.sを受け取り、機械語にパースしてからoutput.hexに出力する

### rustをインストールする

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### 実行

```bash
cargo run main.rs
```

## sample code

### input

```s
addi $t0, $zero, 40
addi $t1, $zero, 0
addi $t2, $zero, 1
addi $t3, $zero, 2
loop: slt $at, $t0, $t3
bne $at, $zero, end
add $t4, $t1, $t2
add $t1, $t2, $zero
add $t2, $t4, $zero
addi $t3, $t3, 1
j loop
end: add $a0, $t2, $zero
addi $v0, $zero, 10
syscall
```
### output
```hex
20080028
20090000
200A0001
200B0002
010B082A
14200005
012A6020
01404820
01805020
216B0001
```

# Fib
```s
j _min_caml_start
fib.10:
    sgti    $t8, $v0, 1
    bne    $t8, $zero, beq_else.24
    jr $ra
beq_else.24:
    subi    $v1, $v0, 1
    sw    $v0, 0($sp)
    move    $v0, $v1
    sw    $ra, 4($sp)
    addi    $sp, $sp, 8
    jal    fib.10
    subi    $sp, $sp, 8
    lw    $ra, 4($sp)
    lw    $v1, 0($sp)
    subi    $v1, $v1, 2
    sw    $v0, 4($sp)
    move    $v0, $v1
    sw    $ra, 8($sp)
    addi    $sp, $sp, 12
    jal    fib.10
    subi    $sp, $sp, 12
    lw    $ra, 8($sp)
    lw    $v1, 4($sp)
    add    $v0, $v1, $v0
    jr $ra
_min_caml_start:
    li    $v0, 30
    sw    $ra, 0($sp)
    addi    $sp, $sp, 4
    jal    fib.10
    subi    $sp, $sp, 4
    lw    $ra, 0($sp)
    sw    $ra, 0($sp)
    addi    $sp, $sp, 4
    subi    $sp, $sp, 4
    lw    $ra, 0($sp)
    syscall
```

# Taylor展開

```s
	.data
	.literal8
	.align 2
l.77:	 # 1.570796
	.long	1070141403
	.align 2
l.76:	 # 0.166667
	.long	1042983595
	.align 2
l.75:	 # 0.008333
	.long	1007192201
	.align 2
l.74:	 # 0.000198
	.long	961547521
	.align 2
l.73:	 # 0.000003
	.long	909700893
	.align 2
l.72:	 # 1.000000
	.long	1065353216
	.text
	.globl _min_caml_start
	.align 2
pow.34:
	subi	$t8, $v0, 0
	bne	$t8, $zero, beq_else.91
	la	$t8, l.72
	flw	$f0, 0($t8)
	jr $ra
beq_else.91:
	subi	$v0, $v0, 1
	fsw	$f0, 0($sp)
	sw	$ra, 4($sp)
	addi	$sp, $sp, 8
	jal	pow.34
	subi	$sp, $sp, 8
	lw	$ra, 4($sp)
	flw	$f1, 0($sp)
	fmul	$f0, $f1, $f0
	jr $ra
sin.37:
	la	$t8, l.73
	flw	$f1, 0($t8)
	li	$v0, 9
	fsw	$f0, 0($sp)
	fsw	$f1, 4($sp)
	sw	$ra, 8($sp)
	addi	$sp, $sp, 12
	jal	pow.34
	subi	$sp, $sp, 12
	lw	$ra, 8($sp)
	flw	$f1, 4($sp)
	fmul	$f0, $f1, $f0
	la	$t8, l.74
	flw	$f1, 0($t8)
	li	$v0, 7
	flw	$f2, 0($sp)
	fsw	$f0, 8($sp)
	fsw	$f1, 12($sp)
	fmove	$f0, $f2
	sw	$ra, 16($sp)
	addi	$sp, $sp, 20
	jal	pow.34
	subi	$sp, $sp, 20
	lw	$ra, 16($sp)
	flw	$f1, 12($sp)
	fmul	$f0, $f1, $f0
	flw	$f1, 8($sp)
	fsub	$f0, $f1, $f0
	la	$t8, l.75
	flw	$f1, 0($t8)
	li	$v0, 5
	flw	$f2, 0($sp)
	fsw	$f0, 16($sp)
	fsw	$f1, 20($sp)
	fmove	$f0, $f2
	sw	$ra, 24($sp)
	addi	$sp, $sp, 28
	jal	pow.34
	subi	$sp, $sp, 28
	lw	$ra, 24($sp)
	flw	$f1, 20($sp)
	fmul	$f0, $f1, $f0
	flw	$f1, 16($sp)
	fadd	$f0, $f1, $f0
	la	$t8, l.76
	flw	$f1, 0($t8)
	li	$v0, 3
	flw	$f2, 0($sp)
	fsw	$f0, 24($sp)
	fsw	$f1, 28($sp)
	fmove	$f0, $f2
	sw	$ra, 32($sp)
	addi	$sp, $sp, 36
	jal	pow.34
	subi	$sp, $sp, 36
	lw	$ra, 32($sp)
	flw	$f1, 28($sp)
	fmul	$f0, $f1, $f0
	flw	$f1, 24($sp)
	fsub	$f0, $f1, $f0
	flw	$f1, 0($sp)
	fadd	$f0, $f0, $f1
	jr $ra
_min_caml_start:
	la	$t8, l.77
	flw	$f0, 0($t8)
	sw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jal	sin.37
	subi	$sp, $sp, 4
	lw	$ra, 0($sp)
	sw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jal	min_caml_prerr_float
	subi	$sp, $sp, 4
	lw	$ra, 0($sp)
	li $v0, 10
	syscall
min_caml_prerr_float:
    li $v0, 2
    syscall
    jr $ra
```

# Newton法

```s
	.data
l.91:	 # 1000000.000000
	.long	1232348160
l.90:	 # 10.000000
	.long	1092616192
l.85:	 # 3.000000
	.long	1077936128
l.84:	 # 8.000000
	.long	1090519040
l.80:	 # 0.000100
	.long	953267991
	.text
	.globl _min_caml_start
newton.33:
	fsw	$f0, 0($sp)
	sw	$v1, 4($sp)
	move	$fp, $v0
	sw	$ra, 8($sp)
	subi	$sp, $sp, 12
	lw	$t8, 0($fp)
	jalr	$ra, $t8
	addi	$sp, $sp, 12
	lw	$ra, 8($sp)
	flw	$f1, 0($sp)
	lw	$fp, 4($sp)
	fsw	$f0, 8($sp)
	fmove	$f0, $f1
	sw	$ra, 12($sp)
	subi	$sp, $sp, 16
	lw	$t8, 0($fp)
	jalr	$ra, $t8
	addi	$sp, $sp, 16
	lw	$ra, 12($sp)
	flw	$f1, 8($sp)
	fdiv	$f0, $f1, $f0
	flw	$f1, 0($sp)
	fsub	$f0, $f1, $f0
	jr $ra
iter.37:
	la	$t8, l.80
	flw	$f1, 0($t8)
	sw	$v1, 0($sp)
	sw	$v0, 4($sp)
	fsw	$f1, 8($sp)
	fsw	$f0, 12($sp)
	move	$fp, $v0
	sw	$ra, 16($sp)
	subi	$sp, $sp, 20
	lw	$t8, 0($fp)
	jalr	$ra, $t8
	addi	$sp, $sp, 20
	lw	$ra, 16($sp)
	flw	$f1, 12($sp)
	fsub	$f0, $f0, $f1
	flw	$f2, 8($sp)
	fle	$f2, $f0
	fbf	fbt_else.114
	lw	$fp, 4($sp)
	fmove	$f0, $f1
	sw	$ra, 16($sp)
	subi	$sp, $sp, 20
	lw	$t8, 0($fp)
	jalr	$ra, $t8
	addi	$sp, $sp, 20
	lw	$ra, 16($sp)
	lw	$v0, 0($sp)
	addi	$v1, $v0, 1
	lw	$v0, 4($sp)
	j	iter.37
fbt_else.114:
	lw	$fp, 4($sp)
	fmove	$f0, $f1
	sw	$ra, 16($sp)
	subi	$sp, $sp, 20
	lw	$t8, 0($fp)
	jalr	$ra, $t8
	addi	$sp, $sp, 20
	lw	$ra, 16($sp)
	flw	$f1, 12($sp)
	fsub	$f0, $f1, $f0
	flw	$f2, 8($sp)
	fle	$f2, $f0
	fbf	fbt_else.115
	lw	$fp, 4($sp)
	fmove	$f0, $f1
	sw	$ra, 16($sp)
	subi	$sp, $sp, 20
	lw	$t8, 0($fp)
	jalr	$ra, $t8
	addi	$sp, $sp, 20
	lw	$ra, 16($sp)
	lw	$v0, 0($sp)
	addi	$v1, $v0, 1
	lw	$v0, 4($sp)
	j	iter.37
fbt_else.115:
	move	$v0, $t9 
	addi	$t9 , $t9 , 8
	lw	$v1, 0($sp)
	sw	$v1, 4($v0)
	fsw	$f1, 0($v0)
	jr $ra
fun.1.58:
	fmul	$f1, $f0, $f0
	fmul	$f0, $f1, $f0
	la	$t8, l.84
	flw	$f1, 0($t8)
	fsub	$f0, $f0, $f1
	jr $ra
fun.2.54:
	la	$t8, l.85
	flw	$f1, 0($t8)
	fmul	$f1, $f1, $f0
	fmul	$f0, $f1, $f0
	jr $ra
fun.3.50:
	move	$v0, $t9 
	addi	$t9 , $t9 , 8
	la	$v1, fun.1.58
	sw	$v1, 0($v0)
	move	$v1, $t9 
	addi	$t9 , $t9 , 8
	la	$a0, fun.2.54
	sw	$a0, 0($v1)
	j	newton.33
@ min_caml_create_array:
@     move $v2, $t9
@ create_array_loop:
@     beq $v0, $zero, create_array_exit
@ 	sw	$v1, 0($t9)
@ 	subi  	$v0, $v0, 1
@ 	addi	$t9, $t9, 4
@ 	j   create_array_loop
@ create_array_exit:
@     move $v0, $v2
@ 	jr  $ra
@ min_caml_create_float_array:
@     move $v1, $t9
@ create_float_array_loop:
@     beq $v0, $zero, create_float_array_exit
@ 	fsw	$f0, 0($t9)
@ 	subi  	$v0, $v0, 1
@ 	addi	$t9, $t9, 4
@ 	j   create_float_array_loop
@ create_float_array_exit:
@     move $v0, $v1
@ 	jr  $ra
@ min_caml_abs_float:
@ min_caml_fabs:
@     fabs    $f0, $f0
@     jr  $ra
@ min_caml_sqrt:
@     fsqrt   $v0, $v0
@     jr  $ra
@ min_caml_floor:
@     floor   $v0, $v0
@     jr  $ra
@ min_caml_float_of_int:
@     itof    $f0, $v0
@     jr  $ra
@ min_caml_int_of_float:
@     ftoi    $v0, $f0
@     jr  $ra
@ min_caml_print_char:
@     sw  $v0, 0($t6)
@     addi $t6, $t6, 4
@     jr $ra
@ min_caml_print_int:
@     addi $v0, $v0, 48
@     sw  $v0, 0($t6)
@     addi $t6, $t6, 4
@     jr $ra
@ min_caml_read_int:
@     lw  $v0, 0($t7)
@     subi $t7, $t7, 4
@     jr $ra
@ min_caml_read_float:
@     flw $f0, 0($t7)
@     subi $t7, $t7, 4
@     jr $ra
_min_caml_start: # main entry point
	li	$t6, 0x7000000
	li	$t7, 0x7FFFFEC
	li	$sp, 0x6FFFFFC
	li	$t9 , 0x2000000
#	main program starts
	move	$v0, $t9 
	addi	$t9 , $t9 , 8
	la	$v1, fun.3.50
	sw	$v1, 0($v0)
	la	$t8, l.90
	flw	$f0, 0($t8)
	li	$v1, 0
	sw	$ra, 0($sp)
	subi	$sp, $sp, 4
	jal	iter.37
	addi	$sp, $sp, 4
	lw	$ra, 0($sp)
	lw	$v1, 4($v0)
	flw	$f0, 0($v0)
	move	$v0, $v1
	la	$t8, l.91
	flw	$f1, 0($t8)
	fmul	$f0, $f0, $f1
	sw	$ra, 0($sp)
	subi	$sp, $sp, 4
	@ jal	min_caml_int_of_float
	addi	$sp, $sp, 4
	lw	$ra, 0($sp)
	sw	$ra, 0($sp)
	subi	$sp, $sp, 4
	@ jal	min_caml_print_int
	addi	$sp, $sp, 4
	lw	$ra, 0($sp)
	li $v0, 10
	syscall
#	main program ends
```

# Minrt
```s
```