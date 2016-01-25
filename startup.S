/*Startup Code for ARMv8
*/

.section .text

.align 3

.extern c_entry
.type c_entry, @function

.global RESET
.type RESET, @function

RESET:
mov sp, #0x80000000
LDR x0, =EL3_EXCEPTION
MSR VBAR_EL3, x0
svc #0x12
BL c_entry
B RESET

.section .text
.global EL3_EXCEPTION
.type EL3_EXCEPTION, @function
EL3_EXCEPTION:
ldr x6, #0x64
B EL3_EXCEPTION



