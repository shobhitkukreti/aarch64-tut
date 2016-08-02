/*Startup Code for ARMv8
*/


.equ UART, 0x09000000

.global EL3_EXCEPTION

.global RESET
.type RESET, @function

.align 2
.section .text

RESET:
MOV SP, #0x40000
LDR x0, =isr

MRS X3, VBAR_EL1
MRS X9, CurrentEL
ASR X9, X9, #2
MSR VBAR_EL1, x0
LDR x5, =user
MSR ELR_EL1,x5
eret



.align 11
.section .vectors
.global isr

isr:
	.align 7
	SYNC:
		B SYNC
	.align 7
	IRQ:
		B IRQ
	.align 7
	FIQ:
		B FIQ
	.align 7
	SERROR:
		B SERROR
	.align 7
	SYNC_X:
		ADD X7, X7, #1
		MRS X9, CurrentEL
		ASR X9, X9, #2
		MSR ELR_EL1, x5
		NOP
		NOP
		ERET
	
	.align 7
	IRQ_X:
		B IRQ_X
	.align 7
	FIQ_X:
		B FIQ_X;
	.align 7
	SERROR_X:
		B SERROR_X	
	
	
user:
	NOP
	mov x6, UART
	MOV x8, #66
	MRS X9, CurrentEL
	ASR X9, X9, #2
	STR X8, [X6]
	SVC #12 /* synchrnous exception */
	NOP
	NOP
	B user

