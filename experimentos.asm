.text
main:
la $a0, ME
li $v0, 4
syscall

la $a0, Stallinga
li $v0, 4
syscall

li $v0, 10
syscall

.data
ME: .asciiz "ODEIO ESTA MERDA!!!"
Stallinga: .asciiz "Vai po caralho tu e a merda do assembly!!! FDP MORRE!!!"