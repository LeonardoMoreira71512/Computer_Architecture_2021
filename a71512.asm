#Afonso Flores 71371
#Leonardo Moreira 71512

.data
number1: .asciiz "OPERAND A: "
number2: .asciiz "OPERAND B: "
answer_pos: .asciiz "Result = "
sum: .asciiz " + "
rest: .asciiz "/"
dif: .asciiz " - "
answer_neg: .asciiz "Result = - "



.text

loop4:
  la $a0 number1 #load the label into $a0
  li $v0 4 #print string
  syscall
  
  li $v0 5 #read the input
  syscall
  move $t0 $v0 #$t0 vai ser o valor do operand a (dividendo)
  move $t7 $t0  #mete o t0 em t7


  la $a0 number2 #load the label into $a0
  li $v0 4 #print string
  syscall
  
  li $v0 5 #read the input
  syscall
  move $t1 $v0 #t1 vai ser o valor do operand b(divisor)


#start of the operations
  

verify2:
  slt $1 $t1 $zero
  beq $t1 1, transform2
  beq $t1, $zero, next

verify:
  slt $t6 $t0 $zero #if t0 < zero set t6 = 1 else set 0
  beq $t6, 1, transform #if t1 is equal to 1 go to transform
  beq $t6, $zero, next # if t6 is equal to zero, next
  
transform:
sub $t0 $zero $t0 #transforma o operand a em positivo
j next

transform2:
sub $t1 $zero $t1 #transforma o operand a em positivo
j next
  
next:
  ori $t2,  $zero,0 # = remainder (resto)   t2 = 0 + 0
  ori $t3,  $zero,0  
  ori $t4,  $zero,0        
  ori $t5,  $zero,32  

  beqz $t0, print0    # if operand a = 0, print 0

  beqz $t1, end_program  #if operand b = infinito, end program
  
startloop:

  sll $t2,$t2,1 #shift left 1 bit, put in $t2
  bgez $t0, loop1 # if $t0 is >= 0 go to loop1
  ori $t2,$t2, 1 #se nao soma ao t2 um bit

loop1:
  sll $t0,$t0,1 #shift operand a (dividendo)
  subu $t3,$t2,$t1 #subtrai o remainder (x) ao operand b (divisor) e mete no t3
  bgez $t3,loop2 # caso o resto seja maior ou igual a 0 vai para o loop2
 
loop3:
  addi $t4,$t4,1 #add 1 bit into t4
  beq $t4,$t5, loop5 #if t4 = t5 go to ready
  j startloop #se nao recomeca o ciclo outra vez
 
loop2:
  move $t2,$t3 
  ori $t0,1
  j loop3
  
loop5:
slt $t6 $t7 $zero #if dividendo < 0  set t6 with 1 else set 0
beq $t6, 1, negative_print #if t6 = 1, print negative
beq $t6, $zero, positive_print #if t6 = 0, print positive
  
print0:
  la $a0 answer_pos
  li $v0 4
  syscall
  move $a0 $t0
  
  li $v0 1 #print 0
  syscall
  li $v0 10 #end program
  syscall

positive_print: 
  la $a0, answer_pos
  li $v0,4    #print result
  syscall
  
  move  $a0,$t0          
  li $v0,1   #print quociente        
  syscall
  
  beqz $t2 end_program  #caso o remainder seja 0 entao da print apenas do quociente 
        
  la $a0, sum #print soma
  li $v0,4            
  syscall             
  move  $a0,$t2
         
  li $v0,1     #print remainder
  syscall
  la $a0 rest  #print " / "
  li $v0 4 
  syscall
  
  move $a0 $t1
  li $v0 1  # print operand b
  syscall
  j end_program     
  
negative_print:
  la $a0, answer_neg 
  li $v0 4  #print negative
  syscall
  
  move $a0 $t0
  li $v0 1   #print number
  syscall
  
  la $a0 dif
  li $v0 4  #print signal
  syscall
  
  move $a0 $t2
  li $v0 1
  syscall
  
  la $a0, rest
  li $v0 4
  syscall
  
  move $a0 $t1
  li $v0 1
  syscall
  j end_program    
  
end_program:

  li $v0 10
  syscall

 














