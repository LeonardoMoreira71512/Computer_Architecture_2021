# TPC 2 Leonardo Moreira a71512 and Afonso Flores a71371

.eqv n 3 #number of independent variables

.data
    
spaces: .asciiz "   "
newline: .asciiz "\n"

solution:
    .double 0.0
    .double 0.0
    .double 0.0
    .double 0.0

array: .double #matriz inicial
  2.0, 1.0, -3.0, -1.0,
 -1.0, 3.0, 2.0, 12.0,
  3.0, 1.0, -3.0, 0.0
  
.text

main:
    la  $a0, array #load array
    li  $a1, 3
    jal     print_matrix #jump and link the matrix
    nop #null operation
    jal     gauss_reduct #jump and link the gauss reduction
    nop
    jal     print_matrix #jal the matrix after the reduction
    nop
    la  $a2, solution
    jal     gauss_solve #jal the solution
    nop
    jal     print_solution #jal the print_solution
    nop

exit:   
    li  $v0, 10 #terminate program
    syscall


gauss_reduct: #does the reduction of the lines and columns of the matrix
    addiu   $sp,  $sp, -24
    sw  $ra,  20($sp) #store word
    sw  $s2,  16($sp)
    sw  $s1,  12($sp)
    sw  $s0,  8($sp) 
    sw  $a1,  4($sp) 
    sw  $a0,  0($sp)

    add $t3, $a0, $zero #add a0 with $zero and store in t3
    addi    $t4, $a1, -1 #addi -1 with a1 and store in t4
    addi    $t5, $a1, 0 #add 0 with a1 and store in y5

    add $t2, $zero, $zero #set t2 with the value zero
gauss_reduct_ciclok:
    beq $t2, $t5, gauss_reduct_end #if t2 is equal to t5 go to guass_reduct_end 
    nop #else 

    add $t1, $zero, $zero #set t1 with the value zero
gauss_reduct_cicloj: #start the reduction of the columns
    beq $t1, $t5, gauss_reduct_fim_ciclo_j #if t1 is equal to t5 go to gauss_reduct_fim_ciclo_j
    nop #else

    beq $t1,$t2,gauss_reduct_cicloj_continue #if t1 is equal to t2
    nop

    move    $a0, $t1 #move t1 into a0
    move    $a1, $t2 #move t2 into a1
    jal fetchaddress
    nop
    move    $s1, $v0 #move v0 into s1

    ldc1    $f6,($s1) #load double word

    move    $a0, $t2 #move t2 into a0 
    move    $a1, $t2 #move r2 into a1
    jal fetchaddress
    nop #null operation
    move    $s1, $v0 #move v0 into s1

    ldc1    $f8,($s1)

    div.d  $f4,$f6,$f8 #floating point division with double precision

    add $t0,$zero,$zero #set t0 as zero

    move    $a0, $t1
    move    $a1, $t0
    jal fetchaddress
    nop
    move    $s1, $v0

    move    $a0, $t2
    move    $a1, $t0
    jal fetchaddress
    nop
    move    $s2, $v0

gauss_reduct_cicloi: #start the reduction of the lines
    bgt $t0, $t5,gauss_reduct_fim_ciclo_i
    nop

    ldc1    $f6,($s1)
    ldc1    $f8,($s2)

    mul.d   $f8,$f8,$f4#multiplication and subtraction with double precision
    sub.d   $f6,$f6,$f8
    sdc1    $f6,($s1)
    addiu   $t0,$t0,1

    addiu   $s1,$s1,8
    addiu   $s2,$s2,8

    j   gauss_reduct_cicloi #jump to do the complete reduction of the lines
    nop

gauss_reduct_fim_ciclo_i: #reduction of the lines is complete

gauss_reduct_cicloj_continue: #continue to do the reduction of the colums
    addiu   $t1,$t1,1
    j   gauss_reduct_cicloj #do the cicloj until all the columns are reduced
    nop

gauss_reduct_fim_ciclo_j:
    addiu   $t2,$t2,1
    j   gauss_reduct_ciclok #jump to the reduction of the ciclok
    nop

gauss_reduct_end:
    lw  $ra,  20($sp)
    lw  $s2,  16($sp)
    lw  $s1,  12($sp)
    lw  $s0,  8($sp)
    lw  $a1,  4($sp)
    lw  $a0,  0($sp)
    addiu   $sp,  $sp, 24

    jr  $ra
    nop

gauss_solve: #ciclo que faz o metodo de gauss completo
    addiu   $sp,  $sp, -24
    sw  $ra,  20($sp) #store word
    sw      $s2,  16($sp) #store word
    sw  $s1,  12($sp) #store word 
    sw  $s0,  8($sp)  #store word
    sw  $a1,  4($sp)  #store word
    sw  $a0,  0($sp) #store word

    add $t3, $a0, $zero #add zero with a0 and put in t3
    addi    $t0, $a1, -1 #addi -1 with a1 and put in t0
    addi    $t5, $a1, 0 #addi 0 with a1 and put in t5

    sll $s1, $t4, 3
    addu    $s1, $s1, $a2

    addi    $t0, $t4, 0
gauss_solve_cicloi: #start to solve the gauss method in the lines of the matrix
    blt $t0, $zero, gauss_solve_end
    nop

    # v0 = &A[i][n]
    move    $a0, $t0 #move t0 into a0
    move    $a1, $t5 #move t5 into a1
    jal fetchaddress
    nop
    # $f6 = A[i][n]
    ldc1    $f6,($v0)
    # X[i] = A[i][n]
    sdc1    $f6,($s1)
    addi    $t1, $t0, 1
    sll $s2, $t1, 3
    add $s2, $s2, $a2


   gauss_solve_cicloj: #start to solve the gauss method in the columns
 
    beq $t1, $t5, gauss_solve_fim_cicloi #if t5 is equal to t1 go to gauss_solve_fim_cicloi
    nop #null operation
    # v0 = &A[i][j]
    move    $a0, $t0 #move t0 to #a0
    move    $a1, $t1 #move t1 into a1
    jal fetchaddress
    nop
    ldc1    $f8,($v0) #load double word
    ldc1    $f4,($s2) #load double word
    mul.d   $f8,$f8,$f4 #multiplication with double precision
    sub.d   $f6,$f6,$f8 #subtraction with double precision
    sdc1    $f6,($s1)
    addi    $t1,$t1,1 #addi 1 with t1 and put in t1
    addi    $s2, $s2, 8
    j   gauss_solve_cicloj #jump to solve the columns
    nop

  gauss_solve_fim_cicloi: #do the final part of the gauss method in the lines

    # v0 = &A[i][i]
    move    $a0, $t0 #move t0 into a0
    move    $a1, $t0 #move t0 into a1
    jal fetchaddress
    nop
    # $f8 = A[i][i]
    ldc1    $f8,($v0)
    # x[i] = x[i] / A[i][i];
    div.d   $f6,$f6,$f8 #do the division with double precision
    sdc1    $f6,($s1)
    subi    $t0,$t0,1
    subi    $s1, $s1, 8
    j   gauss_solve_cicloi
    nop

  gauss_solve_end: #gauss method final part
    lw  $ra,  20($sp)
    lw  $s2,  16($sp)
    lw  $s1,  12($sp)
    lw  $s0,  8($sp)
    lw  $a1,  4($sp)
    lw  $a0,  0($sp)
    addiu   $sp,  $sp, 24
    jr  $ra
    nop

fetchaddress:
    addiu   $t5,$t5,1
    multu   $a0, $t5
    subiu   $t5,$t5,1
    mflo    $v0
    add $v0, $v0, $a1
    sll $v0, $v0, 3
    add $v0, $v0, $t3
    jr  $ra
    nop


print_matrix: #print the initial matrix
    addiu   $sp,  $sp, -24 #addi -24 with $sp and put in #sp
    sw  $ra,  20($sp) #storing words
    sw  $s2,  16($sp) #storing words
    sw  $s1,  12($sp) #storing words
    sw  $s0,  8($sp)  #storing words
    sw  $a2,  4($sp) #storing words
    sw  $a0,  0($sp) #storing words

    move    $s2,  $a0 #move a0 into s2
    move    $s1,  $zero #move zero into a1
 loop_s1:
    addi    $a2,$a1,1
    move    $s0,  $zero
 loop_s0: #escreve a matriz inicial
    l.d $f12, 0($s2)
    li  $v0,  3
    syscall
    la  $a0,  spaces
    li  $v0,  4
    syscall

    addiu   $s2,  $s2, 8

    addiu   $s0,  $s0, 1
    blt $s0,  $a2, loop_s0 #caso a linha ainda nao esteja completada volta ao loop s0
    nop
    la  $a0,  newline
    syscall
    addiu   $s1,  $s1, 1
    blt $s1,  $a1, loop_s1
    nop
    la  $a0,  newline
    syscall

    lw  $ra,  20($sp) #load word
    lw  $s2,  16($sp) #load word
    lw  $s1,  12($sp) #load word
    lw  $s0,  8($sp) #load word
    lw  $a2,  4($sp) #load word
    lw  $a0,  0($sp) #load word
    addiu   $sp,  $sp, 20 #addi 20 with $sp and put in $sp

    jr  $ra             # return
    nop


print_solution: #print the final result of x, y, and z
    addiu  $sp,  $sp, -24 #addi -24 with $sp and put in #sp
    sw  $ra,  20($sp) #store words
    sw  $s2,  16($sp) #store words
    sw  $s1,  12($sp) #store words
    sw  $s0,  8($sp)  #store words
    sw  $a2,  4($sp) #store words
    sw  $a0,  0($sp) #store words

    move    $s1,  $zero #move zero into s1
    move    $s2,  $a2 #move a2 into s2

  print_solution_loop_s0:
    ldc1    $f12, ($s2)
    li  $v0,  3 #print double
    syscall

    addiu   $s2,  $s2, 8
    addiu   $s1,  $s1, 1
    la  $a0,  newline #load adrress
    li  $v0,  4 #print string
    syscall
    blt $s1,  $a1, print_solution_loop_s0
    nop

    lw  $ra,  20($sp) #load words
    lw  $s2,  16($sp) #load words
    lw  $s1,  12($sp) #load words
    lw  $s0,  8($sp) #load words
    lw  $a2,  4($sp) #load words
    lw  $a0,  0($sp) #load words
    addiu   $sp,  $sp, 20 #load words

    jr  $ra #jump to statement whose address is  in $ra
    nop # null operation
    
  
