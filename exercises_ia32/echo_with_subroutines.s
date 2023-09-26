.section .bss
    .lcomm buffer, 128
.section .text
.globl _start
_start:
    movl $128, %eax
    pushl %eax
    pushl $buffer
    call subr_read             
    pushl %eax                  # eax now stores the number of bytes
                                #   that were read.
    pushl $buffer
    call subr_print
    movl $0, %ebx
    movl $1, %eax
    int $0x80
