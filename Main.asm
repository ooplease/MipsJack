.data
gameInventory:		.word 0,0,0
chooseGame:		.asciiz "Please Choose which game you would like to play:"
nextline:		.asciiz "\n"
Blackjack:		.asciiz "j BlackJack"
Goldfish:		.asciiz "j GoldFish"
gameNum:		.word 0 

.globl main

main:

	la $t1, gameInventory
	
	#setGames
	lw $t1, BlackJack
	sw $t1, gameInventory
	
	lw $t2, GoldFish
	sw $t2, gameInventory

	#getNum
	li $v0, 4
	la $a0, chooseGame
	syscall
	
	li $v0, 5
	syscall
	sw $t1, gameNum
	lw $t1, gameNum
	sw $t1, ($s0)
	
Deck:

BlackJack:

GoldFish:

exit:
	li $v0, 10
	syscall