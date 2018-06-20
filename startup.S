/*Startup Code for ARMv8
*/


/*.equ UART, 0x09000000
*/

.extern _stack_start	
.extern UART
.global EL3_EXCEPTION

.global RESET
.type RESET, @function

.align 2
.section .text

RESET:
mov x0, #255
mov x1, 0x80000000
mov x2, 0x40000000
ldr x6, UART
MOV x8, #66
	#	ASR X9, X9, #2
STR X8, [X6]
MRS X9, CurrentEL
nop
nop
#MOV SP, #0x80000000
LDR x0, =isr
MOV x5, #0x8010000
ldr x1,[x5]
nop


MRS X9, CurrentEL
MSR SPSel, #1
MRS X3, VBAR_EL1
MRS X9, CurrentEL
MSR VBAR_EL1, x0
LDR x5, =user
MSR ELR_EL1,x5
MSR SPSel, #0
eret


.align 11
.section .vectors
.global isr

/* Current EL Level with SP_EL0 */
/* Suppose If an IRQ occurs at level EL1 and SP =SP_EL0, then */
/* IRQ label in this section is triggered */

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

/* Current EL Level with SP_ELn */
/* If IRQ occurs within same exception level and SP=SP_ELn, then IRQ_X is triggered */
	.align 7
	SYNC_X:
	/* ESR_ELn : exception syndrome registers tells about the exception which occured */
		MRS X13, CurrentEL ; /* Copy System Register CurrentEL into X9 */
		MSR SPSel, #0 ; /* Use EL0 Stack Pointer */
		svc #13  // triggers sync exception with SP=SP_EL0
		MSR ELR_EL1, x5 ; /* Copy General Purpose X5 into ELR_EL1 sys reg */
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

/* When exception occurs from EL0 to EL1 in AARCH64 */
/* these exceptions are triggered */
/* Lower EL Level in AARCH64 */	

	.align 7
	SYNC_64:
		MRS X12, CurrentEL
		svc #10 // triggers an exception with SP=SP_ELn
		B SYNC_64	
	.align 7
	IRQ_64:
		B IRQ_64
	.align 7
	FIQ_64:
		B FIQ_64
	.align 7
	SERROR_64:
		B SERROR_64

/* When exception occurs from EL0 to EL1 in AARCH32 */
/* these exceptions are triggered */
/* Lower EL Level in AARCH32 */			

	.align 7
	SYNC_32:
		B SYNC_32
	.align 7
		IRQ_32:
			B IRQ_32
	.align 7
	FIQ_32:
		B FIQ_32
	.align 7
	SERROR_32:
		B SERROR_32

/* End of Exception table */

user:
	
	ldr x6, UART
#	MOV x8, #66
	#	ASR X9, X9, #2
#	STR X8, [X6]
	
	SVC #12 /* synchrnous exception */
#	NOP
#	NOP
	#LDR X5, =0x80100000
	LDR X5, =0x80000000
	MOV SP, X5
	
	BL c_entry
	WFI

