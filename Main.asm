.data
chooseGame:		.asciiz "Please Choose which game you would like to play:\n0 - Black Jack\n1 - Go Fish\n2 - Exit\n"
nextline:		.asciiz "\n"
gameInventory:		.word 0,0,0
gameNum:		.word 0
testHand:		.asciiz "-----"

.text
.globl main

main:
	jal deckTest
	j exit
	
	#Set Games
	la $t1, blackJack
	#la $t2, GoldFish
	la $t3,exit
	sw $t1, gameInventory
	#sw $t2, gameInventory+4
	sw $t3,gameInventory+8

	#getNum
	li $v0, 4
	la $a0, chooseGame
	syscall
	
	li $v0, 5
	syscall
	#Mult integer b4, then add to gameInventory
	
	mul $t0,$v0,4
	la $t5,gameInventory
	add $t0,$t5,$t0
	
	jalr $t0

exit:
	li $v0, 10
	syscall

deckTest:
	jal shuffle
	jal showDeck
	
	li $a1,5
	la $a0,testHand
	jal draw
	
	la $a0,testHand
	jal printCards
	
	jal showDeck
	j exit