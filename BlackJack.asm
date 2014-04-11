.data
	player1: .asciiz "-----------"
	dealer:  .asciiz "-----------"
	dealerStand: .word 0
	player1Stand: .word 0

.text
.globl blackJack
.include "Deck.asm"

blackJack:
	addi $sp,$sp,-4
	sw $ra,($sp)
	reshuffle:
		jal shuffle
	gameLoop:
		beqz 
	
	
endgame:
	lw $ra,($sp)
	addi $sp,$sp,-4
	jr $ra
	
deal:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $a0,player1
	li $a1,2
	jal draw
	la $a0,dealer
	li $a1,2
	jal draw
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
	
dealerTurn:
	addi $sp,$sp,-4
	sw $ra,($sp)
	# If dealer total > 15 or if dealerStand != 0
	# stand
	# else if player (total + 6) > dealer total && (total + 6) < 21
	# hit
	stand:
	
	hit:
	
	endDealerTurn:
		lw $ra,($sp)
		addi $sp,$sp,4
		jr $ra
		
calculateTotal: # $a0 is the address of the hand $s0 will contain the total
	while4:
		lb $t0,($a0)
		beqz $t0,endwhile4
		addi $a0,$a0,1
		
	endwhile4:
	