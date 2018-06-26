/*Startup Code for ARMv8
*/

.extern _stack_start	
.extern UART
.extern isr_el1_ns

.align 4
.section .text

.globl KERNEL_NS
.type KERNEL_NS, %function

KERNEL_NS:
	MSR SCTLR_EL1, XZR
	ldr x6, UART
	MOV x8, #67
	STR X8, [X6]
	MRS X17, CurrentEL
	LDR x0, =isr_el1_ns
	MSR VBAR_EL1, x0
	LDR X5, =0xA0000000
	MOV SP, X5
	LDR x0, =c_entry
	MSR ELR_EL1,x0
	eret