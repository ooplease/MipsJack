.data

	deck: .asciiz         "AAAA222233334444555566667777888899991111JJJJQQQQKKKK"
	shuffledDeck: .asciiz "----------------------------------------------------"
	discardPile:  .asciiz "----------------------------------------------------"
	cardsLeft: .word 52

.text

.globl shuffle	
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
	
.globl draw
draw: # $a0 contains the address of the hand where cards will be placed, $a1 contains the # of cards to draw
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $t0,shuffledDeck
	lw $t2,cardsLeft
	#blt $t2,$a1,error1
	for2:
		beqz $a1,endfor2 #check condition
		lb $t1,($t0)
		sb $t1,($a0)
		addi $t0,$t0,1
		addi $a0,$a0,1
		j for2
	endfor2:
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra

shuffleDiscards:
	li $t5,0
	la $t6,discardPile
	counter:
		lb $t7,($t6)
		beq $t7,'-',endcount
	endcount:
	li $a1,52
	li $t3,0
	addi $sp,$sp,-4
	sw $ra,($sp)
	for3:
		li $a0,0
		li $v0,42
		syscall
		la $a0,deck($a0)
		lb $t2,($a0)
		sb $t2,shuffledDeck($t3)
		addi $a1,$a1,-1
		addi $t3,$t3,1
		jal shiftAllLeft
		bnez $a1,for3
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
	
.globl remainingCards
remainingCards: # Number of remaining cards in $s0

.globl discard
discard: # $a0 contains address of first index of discards
