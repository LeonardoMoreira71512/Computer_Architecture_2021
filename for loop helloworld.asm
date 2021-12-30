.data

hellow: .asciiz "Hello World!!"
newline: .asciiz "\n"
.text

move $t0, $zero
li $t1, 10	

startloop:
 beq $t0 $t1, exitloop	
 la $a0, hellow
 li $v0, 4 
 syscall
 la $a0, newline
 li $v0, 4
 syscall
 addi $t0, $t0, 1
 j startloop
exitloop:

