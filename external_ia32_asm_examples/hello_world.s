# source: https://pixelclear.github.io/technical/post/2021/01/02/x86-Assembly-tutorial-part1.html 

.section .data
output:
        .ascii "Hello World!\n"
.section .text 
.globl _start
_start:
        movl $4, %eax 
        movl $1, %ebx
        movl $output, %ecx
        movl $14, %edx
        int $0x80
        movl $1, %eax
        movl $0, %ebx
        int $0x80
