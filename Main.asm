<<<<<<< HEAD
=======
.data
chooseGame:		.asciiz "Please Choose which game you would like to play:"
nextline:		.asciiz "\n"
gameInventory:		.word 0,0,0
gameNum:		.word 0 

.globl main

main:
	#Set Games
	la $t1, BlackJack
	la $t2, GoldFish
	sw $t1, gameInventory
	sw $t2, gameInventory+4

	#getNum
	li $v0, 4
	la $a0, chooseGame
	syscall
	
	li $v0, 5
	syscall
	#Mult integer b4, then add to gameInventory
	
	

exit:
	li $v0, 10
	syscall
>>>>>>> 7ae6bfe4bc4dbb27c8c2c3305c24bfaad550a572
