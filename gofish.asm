.data
	player:		.asciiz "-------"
	computer:	.asciiz "-------"
	doYouHave:	.asciiz "Do you have a "
	dontHave:	.asciiz "Go Fish!"
	
	playerPoints:	.word 0
	computerPoints:	.word 0

.text
.globl goFish

goFish:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	
reshuffle:	
	jal shuffle
	
gameLoop:
	li $t0, 0
	blt $t0, 26, turn
	
	j end

turn:
	addi $sp, $sp, -4
	sw $ra ($sp)
	
	#player 
	la $a0, player
	li $a1, 7
	jal draw
	
	#computer
	la $a0, computer
	li $a1 7
	jal draw
	
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra

	#ask if they have a:
	li $v0, 4
	la $a0, doYouHave
	#missing number
	
	j compareCards

compareCards:
	#if(player/dealer has card, point to player/dealer +1)
	#else if(doesn't have,card +1, display go fish! player/dealer +0)
	
	#compare two values to see if even
	

	li $v0, 4
	la $a0, dontHave
	
	
end:
	lw $ra, ($sp)
	addi $sp, $sp, -4
	jr $ra
	


	
	
