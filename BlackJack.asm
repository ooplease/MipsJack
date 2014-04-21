.data
	player1: .asciiz "-----------"
	dealer:  .asciiz "-----------"
	dealerStand: .word 0
	player1Stand: .word 0
	
	yourHand: .asciiz "Your cards:\n"
	dealerHand: .asciiz "Dealer cards:\n-----\n"
	dealerHandNoHide: .asciiz "Dealer cards:\n"
	
	values: .word 10,2,3,4,5,6,7,8,9,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,10,10,0,0,0,0,0,10
	
	hitOrStand: .asciiz "Hit(0) or stand(1)?\n"
	
	youwin: .asciiz "You win!\n"
	youlose: .asciiz "You lose :(\n"
	youtie: .asciiz "You tied.\n"
	
	playAgain: .asciiz "Play Again? (0 for no, 1 for yes)\n"

.text
.globl blackJack

blackJack:
	addi $sp,$sp,-4
	sw $ra,($sp)
	
	reshuffle:
		jal shuffle
	initialize:
		jal deal
		la $a0,player1
		jal calculateTotal
		move $s1,$s0
		la $a0,dealer
		jal calculateTotal
		
		seq $t1,$s0,21
		seq $t2,$s1,21
		and $t3,$t1,$t2
		bnez $t3,tie
		bnez $t1,lose
		bnez $t2,win
		
	gameLoop:
		jal showHands
		jal playerTurn
		jal dealerTurn
		
		la $a0,player1
		jal calculateTotal
		move $s1,$s0
		la $a0,dealer
		jal calculateTotal
		
		beq $s1,$s0,tie
		bgt $s0,$s1,lose
	win:
		jal showHandsNoHide
		la $a0,youwin
		j reset
	lose:
		jal showHandsNoHide
		la $a0,youlose
		j reset
	tie:
		jal showHandsNoHide
		la $a0,youtie
	reset:
		li $v0,4
		syscall
		la $a0,playAgain
		syscall
		
		li $v0,5
		syscall
		beqz $v0,endgame
		
		la $t0,player1
		la $t1,dealer
		li $t2,'-'
		li $t3,0
		
		while8:
			sb $t2,($t0)
			sb $t2,($t1)
			addi $t0,$t0,1
			addi $t1,$t1,1
			addi $t3,$t3,1
			bne $t3,11 while8
		jal resetDeck
		jal initialize
		
endgame:
	jal resetDeck
	j mainMenu
	
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
	dealerturnstart:
	
	la $a0,player1
	jal calculateTotal
	move $s1,$s0
	la $a0,dealer
	jal calculateTotal
	bgt $s0,16,dealerstand
	bgt $s1,$s0,dealerhit
	
	dealerstand:
		lw $ra,($sp)
		addi $sp,$sp,4
		jr $ra
	dealerhit:
		la $a0,dealer
		li $a1,1
		jal draw
		la $a0,dealerHand
		li $v0,4
		syscall
		la $a0,dealer
		jal printCards
		la $a0,dealer
		jal calculateTotal
		bgt $s0,21,win
		beq $s0,21,dealerstand
		j dealerturnstart
	
	endDealerTurn:
		lw $ra,($sp)
		addi $sp,$sp,4
		jr $ra

playerTurn:
	addi $sp,$sp,-4
	sw $ra,($sp)
	playerturnstart:
	li $v0,4
	la $a0,hitOrStand
	syscall
	li $v0,5
	syscall
	beqz $v0,playerhit
	playerstand:
		lw $ra,($sp)
		addi $sp,$sp,4
		jr $ra
	playerhit:
		la $a0,player1
		li $a1,1
		jal draw
		la $a0,yourHand
		li $v0,4
		syscall
		la $a0,player1
		jal printCards
		la $a0,player1
		jal calculateTotal
		bgt $s0,21,lose
		beq $s0,21,playerstand
		j playerturnstart

calculateTotal: # $a0 is the address of the hand $s0 will contain the total
	li $t5,0
	li $t6,0
	while4:
		lb $t0,($a0)
		beqz $t0,endwhile4
		beq $t0,'-',endwhile4
		addi $t0,$t0,-49
		mul $t0,$t0,4
		
		lw $t1,values($t0)
		bne $t1,-1,else4
		addi $t6,$t6,1
		li $t1,0
		else4:
		add $t5,$t5,$t1
		addi $a0,$a0,1
		b while4
		
	endwhile4:
	beqz $t6,returnTotal
		addi $t7,$t6,10
		add $t7,$t7,$t5
		bgt $t7,21,allOnes
		addi $t5,$t5,10
		allOnes:
		add $t5,$t5,$t6
	returnTotal:	
	move $s0,$t5
	jr $ra
	
showHands:
	addi $sp,$sp,-4
	sw $ra,($sp)
	
	li $v0,4
	la $a0,dealerHand
	syscall
	la $a0,dealer+1
	jal printCards
	
	li $v0,4
	la $a0,yourHand
	syscall
	la $a0,player1
	jal printCards
	
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
	
showHandsNoHide:
	addi $sp,$sp,-4
	sw $ra,($sp)
	
	li $v0,4
	la $a0,dealerHandNoHide
	syscall
	la $a0,dealer
	jal printCards
	
	li $v0,4
	la $a0,yourHand
	syscall
	la $a0,player1
	jal printCards
	
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra