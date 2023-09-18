# code source: https://pixelclear.github.io/technical/post/2021/01/02/x86-Assembly-tutorial-part1.html
# Comments are my own.
#
# General Notes:
#    1. The pattern for invoking a system call is to store its
#       representative number in the eax register, its parameters in
#       other registers (e.g., ebx, ecx, etc.), and invoke the `int
#       $0x80` interrupt instruction.
#    2. The mapping of system calls to their representative numbers
#       (for IA-32) is in `/usr/include/asm/unistd_32.h`.
#    3. The mapping of stdin to 0, stdout to 1, and stderr to 2 is in
#       `/usr/include/unistd.h`.

.section .data              
greeting:
    .ascii "Hello, World!\n"
.section .text
.globl _start
_start:
    movl $4, %eax           # Store the `write` system call's number in
                            #     the eax register.
    movl $1, %ebx           # Store stdout's file number in ebx (fd
                            #     parameter of `write`).
    movl $greeting, %ecx    # Store the address where the "Hello
                            #     World!\n" string starts in ecx (buf 
                            #     parameter of `write`). 
    movl $14, %edx          # Store the number of bytes in the greeting
                            #     string (count parameter of `write`).
                            #     Each character equals one byte, since
                            #     we are using the ASCII encoding.
    int $0x80               # Trigger a software interrupt with `int`.
                            #     The number after `int` specifies 
                            #     which software interrupt is being 
                            #     issued. The interrupt vector 
                            #     (implemented as the Interrupt
                            #     Descriptor Table by operating systems
                            #     using the x86 architecture), for each
                            #     number `n` representing an interrupt,  
                            #     maps `n` to a corresponding handler,
                            #     or Interrupt Service Routine(ISR). In 
                            # 	  our case, `0x80` represents a 
                            #     system-call interrupt, and its ISR
                            #     knows to check the eax register for
                            #     the system call being requested, and
                            #     other registers (such as ebx, ecx,
                            #     and edx) for the parameters. For
                            #     us, the requested system call is 
                            # 	  `write`, represented by 4. 
    movl $1, %eax           # Store the process `exit` system call's 
                            #     number in the eax register.
    movl $0, %ebx           # Store 0 in ebx (status parameter of
                            #     `exit`)
    int $0x80               # Trigger a system-call interrupt.

