TITLE ASM Template					(template.asm)

INCLUDE Irvine32.inc

.data
v1	SDWORD	10h				
v2	SDWORD	30h
v3	SDWORD	20
r1	SDWORD	?
v4	WORD	0FFFFh
r2	WORD	?
author	BYTE	"Author: Mai Pham", 0Dh, 0AH, 0
p1		BYTE	"Part 1: r1 = -(v2 - (v3 + v1)) + 1", 0Dh, 0AH, 0
p2		BYTE	"Part 2: r2 = v4 + 10h", 0Dh, 0AH, 0
ans1	BYTE	"r1 = ", 0
ans2	BYTE	"r2 = ", 0

.code

main PROC

	mov	edx, OFFSET author	; display name
    call WriteString		; display a null-terminated string.

	mov	edx, OFFSET p1		; display part 1
    call WriteString		; display a null-terminated string.

	;r1 = -(v2 - (v3 + v1)) + 1
	mov	eax, v3				; eax = 14h (20d)
	call DumpRegs			; display the registers

	add	eax, v1				; 14h add 10h (20d + 16d), eax = 24h (36d)
	call DumpRegs			; display the registers

	sub	v2, eax				; 30h - 24h (48d - 36d), v2 = Ch (12d)
	neg v2					; v2 = FFF4h (-12d)
	add v2, 1				; v2 = FFF5h (-11d)
	mov eax, v2				; eax = FFF5h
	call DumpRegs			; display the registers
	mov r1, eax
	
	mov edx, OFFSET ans1	; display answer r1
	call WriteString
	call WriteInt			; 32 bit signed number
	call crlf				; enter
	call crlf				; enter

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	mov	edx, OFFSET p2		; display name
    call WriteString		; display a null-terminated string.

	;r2 = v4 + 10h
	mov eax, 0				; clear eax
	call DumpRegs

	add	v4, 10h				; 0FFFFh add 10h (65535d + 16d), v4 = 1000Fh (65551d)
	mov	ax, v4				; ax = 000Fh (15d)
	call DumpRegs			
	mov r2, ax				; r2 = 000Fh (15d)
	
	mov edx, OFFSET ans2	; display answer r2
	call WriteString
	call WriteDec			; 32 bit unsigned number
	call crlf

    exit
main ENDP

END main