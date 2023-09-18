# source: https://pixelclear.github.io/technical/post/2021/01/09/x86-Assembly-tutorial-part2.html
# Modified from source to fix bugs.

.section .data
output:
    .asciz "The value at index 1 is %d\n"
values:
    .int 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60
.section .text
.globl _start
_start:
    movl $values, %edi
    movl $100, 4(%edi)
    movl 4(%edi), %eax
    pushl %eax
    pushl $output
    call printf
    addl $8, %esp
    movl $0, %ebx
    movl $1, %eax
    int $0x80
