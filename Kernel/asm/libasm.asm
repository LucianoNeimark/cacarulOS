GLOBAL cpuVendor
GLOBAL getSeconds
GLOBAL getMinutes
GLOBAL getHours
GLOBAL getKey
GLOBAL sys_write
GLOBAL outb
GLOBAL inb
GLOBAL hlt
GLOBAL getRDI
GLOBAL getRegisters

extern sysInterruptions
section .text
	
cpuVendor:
	push rbp
	mov rbp, rsp

	push rbx

	mov rax, 0
	cpuid


	mov [rdi], ebx
	mov [rdi + 4], edx
	mov [rdi + 8], ecx

	mov byte [rdi+13], 0

	mov rax, rdi

	pop rbx

	mov rsp, rbp
	pop rbp
	ret


	getSeconds:
	push rbp
	mov  rbp,rsp
	mov al, 0
	out 70h, al
	in al, 71h
	mov rsp,rbp
	pop rbp
	ret

	getMinutes:
	push rbp
	mov  rbp,rsp
	mov al, 2
	out 70h, al
	in al, 71h
	mov rsp,rbp
	pop rbp
	ret


	getHours:
	push rbp
	mov  rbp,rsp
	mov rax,0
	mov al, 4
	out 70h, al
	in al, 71h
	mov rsp,rbp
	pop rbp
	ret


	getKey:
	push rbp
	mov rbp,rsp
	mov rax,0
	;ciclo:
	;in al, 64h
	;and al,0x01
	;cmp al,0
	;je ciclo
	in al,60h
	mov rsp,rbp
	pop rbp
	ret

sys_write:
	push rbp
	mov rbp, rsp
	mov rax, 1
	int 80h
	mov rsp,rbp
	pop rbp
	ret

inb:
	push rbp
	mov rbp, rsp
	mov rdx, rdi
	mov rax, 0
    in al, dx
	mov rsp, rbp
	pop rbp
	ret

outb:
	push rbp
	mov rbp, rsp
	mov rax, rsi
	mov rdx, rdi
	out dx, al
	mov rsp, rbp
	pop rbp
	ret

hlt:
	sti
	hlt
	ret

;int getRDI();
getRDI:
    push rbp
    mov rbp, rsp
    mov rax, rdi
    mov rsp, rbp
    pop rbp
    ret

;void getRegister(int * regs);
getRegisters:
; no realizamos el armado del stackframe pues necesitamos los registros del rbp y rsp
    mov [rdi], rax
    mov [rdi + 4],rbx
    mov [rdi + 8], rcx
    mov [rdi + 12], rdx
    mov [rdi + 16], rsi
    mov [rdi + 20], rbp
    mov [rdi + 24], rsp
    mov [rdi + 28], r8
    mov [rdi + 32], r9
    mov [rdi + 36], r10
    mov [rdi + 40], r11
    mov [rdi + 44], r12
    mov [rdi + 48], r13
    mov [rdi + 52], r14
    mov [rdi + 56], r15
ret



