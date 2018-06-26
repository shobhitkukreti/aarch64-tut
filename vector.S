/* Exception Tables */

.globl isr_el3_s
.globl isr_el1_s
.globl isr_el1_ns

.align 11
.section .vectors
/* Current EL Level with SP_EL0 */
/* Suppose If an IRQ occurs at level EL1 and SP =SP_EL0, then */
/* IRQ label in this section is triggered */

isr_el3_s:
	.align 7
	SYNC_EL3S:
		MRS x10, ESR_EL3
		B SYNC_EL3S
	.align 7
	IRQ_EL3S:
		B IRQ_EL3S
	.align 7
	FIQ_EL3S:
		B FIQ_EL3S
	.align 7
	SERROR_EL3S:
		B SERROR_EL3S

/* Current EL Level with SP_ELn */
/* If IRQ occurs within same exception level and SP=SP_ELn, then IRQ_X is triggered */
	.align 7
	SYNC_X_EL3S:
	/* ESR_ELn : exception syndrome registers tells about the exception which occured */
		MRS X13, CurrentEL ; /* Copy System Register CurrentEL into X9 */
		MSR SPSel, #0 ; /* Use EL0 Stack Pointer */
		svc #13  // triggers sync exception with SP=SP_EL0
		MSR ELR_EL1, x5 ; /* Copy General Purpose X5 into ELR_EL1 sys reg */
		ERET
	
	.align 7
	IRQ_X_EL3S:
		B IRQ_X_EL3S
	.align 7
	FIQ_X_EL3S:
		B FIQ_X_EL3S;
	.align 7
	SERROR_X_EL3S:
		B SERROR_X_EL3S	

/* When exception occurs from EL0 to EL1 in AARCH64 */
/* these exceptions are triggered */
/* Lower EL Level in AARCH64 */	

	.align 7
	SYNC_64_EL3S:
		MRS X12, CurrentEL
		svc #10 // triggers an exception with SP=SP_ELn
		B SYNC_64_EL3S	
	.align 7
	IRQ_64_EL3S:
		B IRQ_64_EL3S
	.align 7
	FIQ_64_EL3S:
		B FIQ_64_EL3S
	.align 7
	SERROR_64_EL3S:
		B SERROR_64_EL3S

/* When exception occurs from EL0 to EL1 in AARCH32 */
/* these exceptions are triggered */
/* Lower EL Level in AARCH32 */			

	.align 7
	SYNC_32_EL3S:
		B SYNC_32_EL3S
	.align 7
		IRQ_32_EL3S:
			B IRQ_32_EL3S
	.align 7
	FIQ_32_EL3S:
		B FIQ_32_EL3S
	.align 7
	SERROR_32_EL3S:
		B SERROR_32_EL3S


/* EL1 Secure VBAR */
.align 11
.section .vectors
/* Current EL Level with SP_EL0 */
/* Suppose If an IRQ occurs at level EL1 and SP =SP_EL0, then */
/* IRQ label in this section is triggered */

isr_el1_s:
	.align 7
	SYNC_EL1S:
		B SYNC_EL1S
	.align 7
	IRQ_EL1S:
		B IRQ_EL1S
	.align 7
	FIQ_EL1S:
		B FIQ_EL1S
	.align 7
	SERROR_EL1S:
		B SERROR_EL1S

/* Current EL Level with SP_ELn */
/* If IRQ occurs within same exception level and SP=SP_ELn, then IRQ_X is triggered */
	.align 7
	SYNC_X_EL1S:
	/* ESR_ELn : exception syndrome registers tells about the exception which occured */
		MRS X13, CurrentEL ; /* Copy System Register CurrentEL into X9 */
		MSR SPSel, #0 ; /* Use EL0 Stack Pointer */
		svc #13  // triggers sync exception with SP=SP_EL0
		MSR ELR_EL1, x5 ; /* Copy General Purpose X5 into ELR_EL1 sys reg */
		ERET
	
	.align 7
	IRQ_X_EL1S:
		B IRQ_X_EL1S
	.align 7
	FIQ_X_EL1S:
		B FIQ_X_EL1S;
	.align 7
	SERROR_X_EL1S:
		B SERROR_X_EL1S	

/* When exception occurs from EL0 to EL1 in AARCH64 */
/* these exceptions are triggered */
/* Lower EL Level in AARCH64 */	

	.align 7
	SYNC_64_EL1S:
		MRS X12, CurrentEL
		svc #10 // triggers an exception with SP=SP_ELn
		B SYNC_64_EL1S	
	.align 7
	IRQ_64_EL1S:
		B IRQ_64_EL1S
	.align 7
	FIQ_64_EL1S:
		B FIQ_64_EL1S
	.align 7
	SERROR_64_EL1S:
		B SERROR_64_EL1S

/* When exception occurs from EL0 to EL1 in AARCH32 */
/* these exceptions are triggered */
/* Lower EL Level in AARCH32 */			

	.align 7
	SYNC_32_EL1S:
		B SYNC_32_EL1S
	.align 7
		IRQ_32_EL1S:
			B IRQ_32_EL1S
	.align 7
	FIQ_32_EL1S:
		B FIQ_32_EL1S
	.align 7
	SERROR_32_EL1S:
		B SERROR_32_EL1S


/* Exception table for EL1_NS */

.align 11
.section .vectors
/* Current EL Level with SP_EL0 */
/* Suppose If an IRQ occurs at level EL1 and SP =SP_EL0, then */
/* IRQ label in this section is triggered */

isr_el1_ns:
	.align 7
	SYNC_EL1_NS:
		B SYNC_EL1_NS
	.align 7
	IRQ_EL1_NS:
		B IRQ_EL1_NS
	.align 7
	FIQ_EL1_NS:
		B FIQ_EL1_NS
	.align 7
	SERROR_EL1_NS:
		B SERROR_EL1_NS

/* Current EL Level with SP_ELn */
/* If IRQ occurs within same exception level and SP=SP_ELn, then IRQ_X is triggered */
	.align 7
	SYNC_X_EL1_NS:
	/* ESR_ELn : exception syndrome registers tells about the exception which occured */
		MRS X13, CurrentEL ; /* Copy System Register CurrentEL into X9 */
		MSR SPSel, #0 ; /* Use EL0 Stack Pointer */
		svc #13  // triggers sync exception with SP=SP_EL0
		MSR ELR_EL1, x5 ; /* Copy General Purpose X5 into ELR_EL1 sys reg */
		ERET
	
	.align 7
	IRQ_X_EL1_NS:
		B IRQ_X_EL1_NS
	.align 7
	FIQ_X_EL1_NS:
		B FIQ_X_EL1_NS;
	.align 7
	SERROR_X_EL1_NS:
		B SERROR_X_EL1_NS	

/* When exception occurs from EL0 to EL1 in AARCH64 */
/* these exceptions are triggered */
/* Lower EL Level in AARCH64 */	

	.align 7
	SYNC_64_EL1_NS:
		MRS X12, CurrentEL
		svc #10 // triggers an exception with SP=SP_ELn
		B SYNC_64_EL1_NS	
	.align 7
	IRQ_64_EL1_NS:
		B IRQ_64_EL1_NS
	.align 7
	FIQ_64_EL1_NS:
		B FIQ_64_EL1_NS
	.align 7
	SERROR_64_EL1_NS:
		B SERROR_64_EL1_NS

/* When exception occurs from EL0 to EL1 in AARCH32 */
/* these exceptions are triggered */
/* Lower EL Level in AARCH32 */			

	.align 7
	SYNC_32_EL1_NS:
		B SYNC_32_EL1_NS
	.align 7
		IRQ_32_EL1_NS:
			B IRQ_32_EL1_NS
	.align 7
	FIQ_32_EL1_NS:
		B FIQ_32_EL1_NS
	.align 7
	SERROR_32_EL1_NS:
		B SERROR_32_EL1_NS


/* End of Exception table */
