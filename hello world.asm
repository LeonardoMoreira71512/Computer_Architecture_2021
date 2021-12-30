.data
hellow: .asciiz "Hello world!"

.text
la $a0, hellow
li $v0, 4 #4 print string pointed to by $a0
syscall

mylabel:
#terminate program
li $v0, 10 #system call for exit
syscall