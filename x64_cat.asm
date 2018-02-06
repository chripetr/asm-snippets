BITS 64
    GLOBAL _start
_start:
    jmp short .data

; null-byte free shellcode that 
; replicates cat command in linux
.open:
    pop rdi
    xor esi, esi
    xor eax, eax
    mov al, 0x2         ; open syscall
    syscall
    xchg ebx, eax       ; store fd to ebx

.readchar:
    ;read one char at a time
    mov edi, ebx        ; fd
    push rsp
    pop rsi             ; set rsi --> top of the stack
    mov dl, 0x1         ; read one byte
    xor eax, eax        ; sys_read syscall
    syscall

    ;write char been read till we reach EOF (0x00)

    mov edx, eax        ; number of bytes been returned from sys_read
    xor edi, edi           
    inc edi             ; stdout
    syscall

    test edx, edx       ; check EOF
    jne short .readchar ; if EOF read another char
    mov al, 0x3c        ; sys_exit syscall
    syscall

.data:
    call .open
    db 'test/file' ; simple test file