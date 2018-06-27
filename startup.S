/*Startup Code for ARMv8
*/

.extern _stack_start	
.extern UART
.extern KERNEL_NS
.extern c_entry
.extern isr_el3_s
.globl RESET


.type RESET, %function

.align 4
.section .text

RESET:
ldr x6, UART

/* PL011 program for FVP
add x0, x6, #0x30
ldr x1, [x0]
ORR x1, x1, #(1<<0)
str x1, [x0]
*/


MOV x8, #66
STR X8, [X6]

ADR x0, isr_el3_s /* Load address into x0 */
MSR VBAR_EL3, x0

MSR SCTLR_EL3, XZR
MSR SCTLR_EL2, XZR
MSR SCTLR_EL1, XZR

/* Check EL Level */
MRS X9, CurrentEL


/* Setup SCR_EL3 */
ORR x0,x0,  #(1<<10) 
/*ORR x0,x0,  #(1<< 0)*/
MSR SCR_EL3, x0

/* Setup HCR_EL2 */
MSR HCR_EL2, XZR
MOV X12, #(1<<31)
MSR HCR_EL2, X12
//MOV X0, #0b01001 // DAIF=0000 // EL2h
MOV X0, #0b00101 // DAIF=0000 // EL1h
MSR SPSR_EL3, X0

ADR x5, KERNEL_NS
MSR ELR_EL3,x5
ISB
MSR SPSel, #0
LDR X5, =0xA0000000
MOV SP, X5
eret



