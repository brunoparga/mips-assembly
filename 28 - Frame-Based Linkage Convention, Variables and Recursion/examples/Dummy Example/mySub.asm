#  int mysub( int arg )
#  {
#    int b, c;                    // b: 0($fp)
#                                 // c: 4($fp)
#    b = arg*2;
#    c = b + 7;
#
#    return c;
#  }
	.text
	.globl	mysub
mysub:
	# prolog
	sub	$sp, $sp, 4	#   1. Push return address
	sw	$ra, ($sp)
	sub	$sp, $sp, 4	#   2. Push caller's frame pointer
	sw	$fp, ($sp)
	sub	$sp, $sp, 4	#   3. Push register $s1
	sw	$s1, ($sp)
	sub	$fp, $sp, 8	#   4. $fp = $sp - space_for_variables
	move	$sp, $fp 	#   5. $sp = $fp

	# body of subroutine
	mul	$s1, $a0, 2	#     arg*2
	sw	$s1, 0($fp)	# b = "   "

	lw	$t0, 0($fp)	# get b
	nop
	add	$t0, $t0, 7	#     b+7
	sw	$t0, 4($fp)	# c = "  "

	# epilog
	lw	$v0, 4($fp)	#   1. Put return value in $v0
	add	$sp, $fp, 8	#   2. $sp = $fp + space_for_variables
	lw	$s1, ($sp)	#   3. Pop register $s1
	add	$sp, $sp, 4	#
	lw	$fp, ($sp)	#   4. Pop $fp
	add	$sp, $sp, 4	#
	lw	$ra, ($sp)	#   5. Pop $ra
	add	$sp, $sp, 4	#
	jr	$ra     	#   6. return to caller
	nop
