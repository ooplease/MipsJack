.data

	deck: .asciiz         "AAAA222233334444555566667777888899991111JJJJQQQQKKKK"
	shuffledDeck: .asciiz "----------------------------------------------------"
	
	player1Hand: .asciiz  "-----------"
	player2Hand: .asciiz  "-----------"
	dealerHand:  .asciiz  "-----------"

.text
.globl main

main:
	jal shuffle
	
	gameLoop:
	

exit:
	li $v0,10
	syscall
	
shuffle:
	li $a1,52
	li $t3,0
	addi $sp,$sp,-4
	sw $ra,($sp)
	for1:
		li $a0,0
		li $v0,42
		syscall
		la $a0,deck($a0)
		lb $t2,($a0)
		sb $t2,shuffledDeck($t3)
		addi $a1,$a1,-1
		addi $t3,$t3,1
		jal shiftAllLeft
		bnez $a1,for1
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
		
shiftAllLeft: #$a0 is position to start at
	while1:
		lb $t1,1($a0)
		sb $t1,($a0)
		addi $a0,$a0,1
		bnez $t1,while1
	jr $ra
	
getValue: #$a0 and $a1 is the card byte places value into $s0