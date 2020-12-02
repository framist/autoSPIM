# SPIM:
.data
LC0:
        .asciiz  "Input the first num (d):"
LC1:
        .asciiz  "Input the second num (d):"
LC2:
        .asciiz  " * "
LC3:
        .asciiz  " = "
.text
.globl main   # 防止出错
scan_int:
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        sw      $4,8($fp)

        # 读取int
        lw      $3,8($fp)
        li      $v0, 5
        syscall
        # 存入数据到$3的指针
        sw      $2,0($3)
        
        nop
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $31
        nop

scan_float:
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        sw      $4,8($fp)

        # 读取float
        lw      $3,8($fp)
        li      $v0, 6
        syscall
        # 存入数据到$3的指针
        swc1    $f0,0($3)
        
        nop
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $31
        nop

scan_double:
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        sw      $4,8($fp)

        # 读取double
        lw      $3,8($fp)
        li      $v0, 7
        syscall
        # 存入数据到$3的指针
        swc1    $f0,0($3)
        swc1    $f1,4($3)
        
        nop
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $31
        nop

print_string:
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        sw      $4,8($fp)

        # 打印string
        li      $v0, 4
        syscall
        
        nop
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $31
        nop

print_int:
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        sw      $4,8($fp)

        # 打印int
        li      $v0, 1
        syscall
        
        nop
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $31
        nop

print_float:
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        swc1    $f12,8($fp)

        # 打印float
        li      $v0, 2
        syscall
        
        nop
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $31
        nop

print_double:
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        swc1    $f12,8($fp)
        swc1    $f13,12($fp)

        # 打印double
        li      $v0, 3
        syscall
        
        nop
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $31
        nop

main:
        addiu   $sp,$sp,-56
        sw      $31,52($sp)
        sw      $fp,48($sp)
        move    $fp,$sp

        la      $4,LC0
        jal     print_string
        nop

        addiu   $2,$fp,32
        move    $4,$2
        jal     scan_double
        nop


        la      $4,LC1
        jal     print_string
        nop

        addiu   $2,$fp,40
        move    $4,$2
        jal     scan_double
        nop

        lwc1    $f2,32($fp)
        nop
        lwc1    $f3,36($fp)
        lwc1    $f0,40($fp)
        nop
        lwc1    $f1,44($fp)
        nop
        mul.d   $f0,$f2,$f0
        swc1    $f0,24($fp)
        swc1    $f1,28($fp)
        lwc1    $f0,32($fp)
        nop
        lwc1    $f1,36($fp)
        nop
        mov.d   $f12,$f0
        jal     print_double
        nop


        la      $4,LC2
        jal     print_string
        nop

        lwc1    $f0,40($fp)
        nop
        lwc1    $f1,44($fp)
        nop
        mov.d   $f12,$f0
        jal     print_double
        nop


        la      $4,LC3
        jal     print_string
        nop

        lwc1    $f12,24($fp)
        nop
        lwc1    $f13,28($fp)
        jal     print_double
        nop

        nop
        move    $sp,$fp
        lw      $31,52($sp)
        lw      $fp,48($sp)
        addiu   $sp,$sp,56
        j       $31
        nop
