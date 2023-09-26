# subr_read(address of input buffer, input buffer size): reads an input 
#   string from stdin and stores the starting address of the string in 
#   eax for the caller routine.

.section .text
.global subr_read
.type subr_read, @function
subr_read:
    push %ebp
    movl %esp, %ebp
    push %ebx               # Recall: ebx is a callee-saved register.
   
    movl 8(%ebp), %ecx      # Retrieve the first parameter (address of
                            #   input buffer).
    movl 12(%ebp), %edx     # Retrieve the second parameter (size of
                            #   input buffer).
    movl $3, %eax           # Store `read` system call's number.
    movl $0, %ebx           # Store `stdin`'s file number.
    int $0x80               # Trigger a system-call interrupt.
    pop %ebx                # Restore value of ebx register for the
                            #   caller. 
    movl %ebp, %esp         # Move stack pointer so that it points to
                            #   the value of the base pointer.
    pop %ebp                # Restore the base pointer for the caller.
    ret
