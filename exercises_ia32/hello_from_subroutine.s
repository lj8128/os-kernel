.section .data
msg:
    .ascii "Hello, from subroutine!\n"
.section .text
.globl _start
_start:
    movl $24, %eax
    pushl %eax
    pushl $msg 
    call subr_print
    movl $0, %ebx
    movl $1, %eax
    int  $0x80
