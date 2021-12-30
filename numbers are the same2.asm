.data

newline: .asciiz "\n"
input: .asciiz "input a number: "
output: .asciiz "EM LEI É QUE ESTÁ O GUITO!!"

.text

la $a0 input
li $v0 4
syscall
li $v0 5
syscall
move $t0 $zero #meto o valor zero em t0 como se fosse o i = 0; 
move $t1 $v0    #t1 vai ser o n do for loop, neste caso ponho o valor de v0 em t1 para assim fazer o loop

startloop:
  beq $t0 $t1 exitloop
  la $a0 output
  li $v0 4
  syscall
  la $a0 newline
  li $v0 4
  syscall
  addi $t0 $t0 1
  j startloop
exitloop:


