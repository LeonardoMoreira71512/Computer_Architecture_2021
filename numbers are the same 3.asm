.data

number1: .asciiz "enter the first number: "
number2: .asciiz "enter the second number: "
result: .asciiz "the multiplication of this numbers is equal to: "
newline: .asciiz "\n"

.text

la $a0, number1
li $v0, 4
syscall
la $a0, newline
li $v0, 5
syscall
move $t0 $v0

la $a0, number2
li $v0, 4
syscall
la $a0, newline
li $v0, 5
syscall
move $t1 $v0

#start the operation

move $t2 $zero #set result (t2) to 0
startloop:
  beqz $t1, exit# if $t1 is 0 then exit the loop and print 0
  andi $t3 $t1 1#set t3 to mask to only have LSB of t1
  beqz $t3, skip #if left shift bit (LSB) = 0 no adding needed
  add $t2 $t2 $t0 #add t0 to result
skip:
  sra $t1 $t1 1 #divide t1 by 2
  sll $t0, $t0, 1 #multiply t0 by 2
  j startloop

exit:
  la $a0 result
  li $v0, 4 
  syscall
  move $a0, $t2
  li $v0 1
  syscall
#end program

li $v0 10
syscall

































