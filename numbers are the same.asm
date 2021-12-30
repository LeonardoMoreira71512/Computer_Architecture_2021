.data
newline: .asciiz "\n"
number1: .asciiz "first number is: "
number2: .asciiz "second number is: "
different: .asciiz "they are different"
same: .asciiz "they are the same"

.text

#escreve o 1 input
la $a0, number1
li $v0, 4
syscall
la $a0, newline
li $v0, 5
syscall
move $s0 $v0

#escreve o 2input
la $a0, number2
li $v0, 4
syscall
la $a0, newline
li $v0, 5
syscall
move $s1 $v0

startloop:
  beq $s0 $s1, exitloop
  la $a0 different
  li $v0 4
  syscall
  li $v0 10
  syscall
exitloop:
  la $a0 same
  li $v0 4
  syscall
  j exitloop2
exitloop2:










