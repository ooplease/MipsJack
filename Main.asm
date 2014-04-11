.data
	hello: .asciiz "Hello World!/n"
.text
.globl main
.globl exit

main:
	li $v0,4
	la $a0,hello
	syscall
exit:
	li $v0,10
	syscall