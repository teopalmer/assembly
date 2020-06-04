section .text

global strcopy

strcopy:
    mov rcx, rdx
    cmp rdi, rsi
    jne continue

continue:
    cmp rdi, rsi
    jle copy

    mov rax, rdi
    sub rax, rsi

    cmp rax, rcx
    jge copy

arrange:
    add rdi, rcx
    dec rsi
    add rsi, rcx
    dec rdi
    std

copy:
    rep movsb
    cld

quit:
    ret
