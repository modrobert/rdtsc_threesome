; rdtsc_a2 - Reads and outputs the RDTSC instruction contents in hex.
; Copyright (C) 2019  Robert V. <modrobert@gmail.com>
;
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>.

; For reference:
;
; 64-bit Linux fastcall convention
;    ints/longs/ptrs: RDI, RSI, RDX, RCX, R8, R9
;     floats/doubles: XMM0 to XMM7
;
; The first six integer arguments (from the left) are passed in
; RDI, RSI, RDX, RCX, R8, and R9, in that order. 
; Additional integer arguments are passed on the stack. 
; These registers, plus RAX, R10 and R11 are destroyed by function calls,
; and thus are available for use by the function without saving. 

global _start

section .data
msg1:   db "0x"             ; first part of string
buffer: times 16 db 0x30    ; string buffer for hex value
blen    equ $-buffer        ; length of buffer
msg2:   db 10               ; end with line feed
tlen    equ $-msg1          ; length of complete string
        
section .text
_start:
main:                       ; for gdb
    rdtsc                   ; read time stamp counter
    shl rdx, 32             ; move high bits of results to low part
    or rdx,rax              ; 64 bit value from rdtsc in rdx
    call hex_string         ; create hex string
    mov rax, 1              ; system call for write
    mov rdi, 1              ; file handle 1 is stdout
    lea rsi, [msg1]         ; address of message
    mov rdx, tlen           ; toal number of bytes
    syscall                 ; system write
    mov rax, 60             ; system call for exit
    xor rdi, rdi            ; exit code 0
    syscall                 ; system exit

hex_string:
    push rax                ; saving registers we use
    push rsi
    push r8
    push r9
    push rdx
    mov rax, rdx            ; rdx contains number to convert
    lea rsi, [buffer+blen]  ; start at end of buffer
    mov r8, rax             ; save number
    lea r9, [buffer]
    xor rdx, rdx            ; result will be in rdx
.convert_loop:
    mov rax, r8
    and rax, 0xf            ; mask out the lowest 4 bits
    cmp rax, 0x9            ; check what modifier to use
    ja .greater_than_9
    add rax, 0x30           ; modifier, '0' + rax
    jmp .converted
.greater_than_9:
    add rax, 0x57           ; modifier, "rax = 10" gives 'a'
.converted:
    dec rsi                 ; decrease first to align with buffer
    mov [rsi], al
    shr r8, 4               ; shift 4 bits to the next part
    cmp rsi, r9
    jg .convert_loop
    pop rdx                 ; restoring registers we used
    pop r9
    pop r8
    pop rsi
    pop rax
    ret

