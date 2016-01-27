/*Startup Code for ARMv8
*/




.global EL3_EXCEPTION

.global RESET
.type RESET, @function

.align 2
.section .text

RESET:
mov sp, #0x40000
LDR x0, =isr

MRS X3, VBAR_EL1
MSR VBAR_EL1, x0
LDR x5, =user
MSR ELR_EL1,x5
B user
B RESET



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
		mov x7, #0x55
		eret
	.align 7
	IRQ_X:
		B IRQ_X
	.align 7
	FIQ_X:
		B FIQ_X;
	.align 7
	SERROR_X:
		B SERROR_X	
	
	
	
_sync:
ldr x6, #0x64
B _sync


user:
	NOP
	svc #12
	
