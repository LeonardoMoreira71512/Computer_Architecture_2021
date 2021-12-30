.data

question: .asciiz "Give a number: "
newline: .asciiz "\n"
sum: .asciiz "The sum is: "
dif: .asciiz "The diference is: "
pro: .asciiz "The product is: "
quo: .asciiz "The quocient is: "
sumfortherest: .asciiz " + "
rest: .asciiz "/"

.text

la $a0, question
li $v0, 4    #vou dar print a question
syscall
li $v0, 5   #para obter o primeiro num a ser lido
syscall
move $s0, $v0 #vou agrupar no s0 a primeira questao

#repeat

la $a0, question
li $v0, 4    #vou dar print a question
syscall
li $v0, 5   #para obter o segundo num a ser lido
syscall
move $s1, $v0 #vou agrupar no s1 a segunda questao

#newline

li $v0 4
la $a0 newline
syscall

#start asking asking the sum

li $v0 4
la $a0 sum
syscall
#answer
li $v0 1 #print ao resultado
add $a0, $s0, $s1 #vai adicionar o valor de s1 e s0 e meter em a0
syscall
#newline
li $v0, 4
la $a0, newline
syscall

#start asking the difference

li $v0 4
la $a0 newline #baixar de linha
li $v0 4
la $a0 dif
syscall
li $v0 1
sub $a0, $s0, $s1
abs $a0, $a0#mete o modulo 
syscall

#newline

li $v0 4
la $a0 newline
syscall

#start asking the product

li $v0, 4
la $a0, pro
syscall
mult $s1, $s0
li $v0, 1
mul $a0, $s0, $s1
syscall

#newline

li $v0, 4
la $a0, newline
syscall

#start asking the quocient
li $v0, 4
la $a0, quo
syscall

#get the answer
div $s0, $s1
mflo $a0
li $v0, 1
syscall #print integer
la $a0, sumfortherest
li $v0, 4
syscall
mfhi $a0
li $v0, 1
syscall
la $a0, rest
li $v0, 4
syscall
or $a0, $t0, $s1
li $v0, 1
syscall
 
#end program
li $v0 10
syscall




