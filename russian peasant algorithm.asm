.data

number: .asciiz "give a number: "
result: .asciiz "\nThe result of the multiplication is equal to: "

.text

la $a0, number
li $v0, 4
syscall
li $v0 5
syscall
move $t0 $v0


la $a0, number
li $v0, 4
syscall
li $v0 5
syscall
move $t1 $v0

#start the operation

move $t2 $zero	#t2 = 0 tal como no caderno, o result comeca sempre em 0
startloop:
  beqz $t1 exit #if t1 = 0 entao vai pra saida
  andi $t3 $t1 1 #mask para ter apenas o bit menos significativo (ultimo) de t1
  beqz $t3 skip #caso o bit menos significativo seja zero entao nao precisa fazer nada e passa pro proximo shifting
  add $t2 $t2 $t0 #caso o bit menos significativo seja 1 entao preciso de adicionar o operand a (t0) ao result (t2)
skip:
  sll $t0 $t0 1 #vou fazendo sempre o shifting left and right caso o bit menos significativo seja 1 entao tenho que adicionar ao result
  sra $t1 $t1 1
  j startloop 

exit:
  la $a0 result
  li $v0 4 
  syscall
  move $a0 $t2 #sendo t1 = 0 entao movo o t2 (que corresponde a 0) para a0 e dou print ao zero
  li $v0 1
  syscall
  li $v0 10
  syscall














