.data
chooseGame:		.asciiz "Please Choose which game you would like to play:\n0 - Black Jack\n1 - Go Fish\n2 - Exit\n"
nextline:		.asciiz "\n"
gameInventory:		.word 0,0,0
gameNum:		.word 0
testHand:		.asciiz "--------------------------------------"
yourHand:		.asciiz "Player Hand:\n"
deck:			.asciiz "Deck:\n"

.text
.globl main
.globl mainMenu

main:
	
	#Set Games
	la $t1,blackJack
	la $t2,goFish
	la $t3,exit
	sw $t1,gameInventory
	sw $t2,gameInventory+4
	sw $t3,gameInventory+8

mainMenu:
	#getNum
	li $v0, 4
	la $a0, chooseGame
	syscall
	
	li $v0, 5
	syscall
	#Mult integer b4, then add to gameInventory
	
	mul $t0,$v0,4
	lw $t5,gameInventory($t0)
	
	jalr $t5

exit:
	li $v0, 10
	syscall

deckTest:
	jal shuffle
	
	li $v0,4
	la $a0,deck
	syscall
	
	jal showDeck
	
	li $a1,30
	la $a0,testHand
	jal draw
	
	li $v0,4
	la $a0,yourHand
	syscall
	
	la $a0,testHand
	jal printCards
	
	li $v0,4
	la $a0,deck
	syscall
	jal showDeck
	
	la $a0,testHand
	li $a1, 26
	jal discard
	
	li $v0,4
	la $a0,yourHand
	syscall
	la $a0,testHand
	jal printCards
	
	li $v0,4
	la $a0,deck
	syscall
	jal showDeck
	
	li $a1,25
	la $a0,testHand
	jal draw
	
	li $v0,4
	la $a0,yourHand
	syscall
	la $a0,testHand
	jal printCards
	
	li $v0,4
	la $a0,deck
	syscall
	jal showDeck
	
	j exit