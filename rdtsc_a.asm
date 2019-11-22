; rdtsc_a - Reads and outputs the RDTSC instruction contents.
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
global main
extern printf

section .rodata
msg:    db "%llu", 10, 0    ; C string needs 0 terminator

section .text
main:                       ; for gdb
    rdtsc                   ; read time stamp counter
    shl rdx, 32             ; move high bits of results to low part
    or rdx, rax             ; 64 bit value from rdtsc in rdx
    xor rax, rax            ; clear rax
    lea rdi, [msg]          ; get address for message
    mov rsi, rdx            ; get rdtsc value
    call printf             ; use printf()
    ret
