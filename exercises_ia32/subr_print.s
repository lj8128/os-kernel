# subr_print(address of msg, msg size in bytes)  

.section .text
.global subr_print
.type subr_print, @function
subr_print:    
    push %ebp                   # Store the caller's base pointer on
                                #   the stack. 
    movl %esp, %ebp             # The stack pointer currently points to
                                #   to the stored base pointer (above
                                #   which is the return address; 
                                #   remember, the stack grows down, not
                                #   up). We want this location to serve 
                                #   as the base pointer for this 
                                #   subroutine. 
    push %ebx                   # ebx is a callee-saved register; that
                                #   is, the callee (this subroutine) is
                                #   responsible for restoring the value
                                #   of ebx if it modifies it, as it
                                #   does below.
    movl 8(%ebp), %ecx          # Retrieve the first parameter (address 
                                #   of msg). Note that we add 8 bytes 
                                #   to ebp. This is because the base
                                #   pointer currently points at the 
                                #   caller's ebp that was pushed at the 
                                #   start of this subroutine. Adding 4 
                                #   bytes to the base pointer thus 
                                #   gives us the return address. We 
                                #   must therefore add 8 bytes to 
                                #   access the first parameter. Recall 
                                #   that the parameters were pushed in 
                                #   reverse order by the caller, so the 
                                #   parameter at 8(%ebp) is the first 
                                #   parameter.
    movl 12(%ebp), %edx         # Store the second parameter (msg size 
                                #   in bytes).
    movl $4, %eax               # Store `write` system call's number.
    movl $1, %ebx               # Store stdout's file number.
    int $0x80                   # Trigger a system-call interrupt.
    
    pop %ebx                    # Restore value of ebx register.
    movl %ebp, %esp             # Move stack pointer so that it points
                                #   to the value of the base pointer
                                #   that was pushed at the beginning of
                                #   this subroutine.
    pop %ebp                    # This restores the base pointer to
                                #   that of the caller function. The
                                #   stack pointer now points to the
                                #   return address. 
    ret                         # The `ret` instruction pops the return
                                #   address which the stack pointer is
                                #   pointing to, and stores it in the
                                #   instruction pointer. This causes
                                #   the instruction stored at the
                                #   return address to be the next
                                #   instruction that is executed by the
                                #   CPU. 

