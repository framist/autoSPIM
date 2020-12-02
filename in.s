scan_int:
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        sw      $4,8($fp)
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
        nop
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $31
        nop

$LC0:
        .ascii  "Input the first num (d):\000"
$LC1:
        .ascii  "Input the second num (d):\000"
$LC2:
        .ascii  " * \000"
$LC3:
        .ascii  " = \000"
main:
        addiu   $sp,$sp,-56
        sw      $31,52($sp)
        sw      $fp,48($sp)
        move    $fp,$sp
        lui     $2,%hi($LC0)
        addiu   $4,$2,%lo($LC0)
        jal     print_string
        nop

        addiu   $2,$fp,32
        move    $4,$2
        jal     scan_double
        nop

        lui     $2,%hi($LC1)
        addiu   $4,$2,%lo($LC1)
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

        lui     $2,%hi($LC2)
        addiu   $4,$2,%lo($LC2)
        jal     print_string
        nop

        lwc1    $f0,40($fp)
        nop
        lwc1    $f1,44($fp)
        nop
        mov.d   $f12,$f0
        jal     print_double
        nop

        lui     $2,%hi($LC3)
        addiu   $4,$2,%lo($LC3)
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