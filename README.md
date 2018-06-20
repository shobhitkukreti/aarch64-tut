The ARMv8 or AArch64 bit processor will never be used in bare metal code.This bare-metal-ish code is written for understanding the programmer's model. Since it is emulated on QEMU you will probably not burn something down or maybe you will.

1) The software runs on an emulated Cortex-A57 on QEMU

2) Tool chain is from Linaro aarch64-none-elf-gcc v4.8

3) QEMU is compiled from the Linaro repository ( find it on your own )


4) There is no stdlib, nor any crt0/1. This means, it is your responsibility to clear the BSS or copy data section from ROM to RAM.

5) linker.ld is a simple memory map with only text section and vector section, which is put in text segment (RO).

Compile :
 	aarch64-none-elf-gcc file1.S file2.c -o main.elf -nostdlib -g -T linker.ld


Emulate: qemu-system-aarch64 -M virt -cpu cortex-a57 -m 1G -kernel main.elf -s -S 

With SemiHosting and UART:
	qemu-system-aarch64 -M virt -cpu cortex-a57 -m 1G -kernel main.elf -nographic -semihosting

Run GDB:
        aarch64-none-elf-gdb main.elf
		target remote localhost:1234

		

UART: 0x09000000
DRAM: 0 -128MB 0 - 08000000
GIC_CPU: 0x08010000




Note on Exceptions

		ARMv8 has Vector Base Address which can be fixed by writing to a register VBAR_ELx. 
		Vectors have a space/offset of 128 bytes or 32 instructions.
		
		.align 7 /* gives 128 byte alignment */

		FIQ:
			B FIQ_HANDLER

		.align 7
		
		IRQ:
			B IRQ_HANDLER

	
		There is no LR. The next instruction address is saved in ELR_ELx ( Exception Link Register ) before the exception is taken.

		use "eret" to return from exception using address saved in ELR_ELx. 

		There are very few banked registers, notably SPSR, ELR. Save the registers on stack before making an exception.


		To Jump to a lower level, program the current level ELR_ELx register with the address where you want the processor to execute from. 

		e.g.
		LDR x5,=user
		MSR ELR_EL1, x5.
		This is initial value of userspace application.

		In user function, we execute 'svc', which programs the ELR_EL1 with the next instruction address.
		In SVC Handler, executing "eret" will return you back to user space.

2018:
# For SMC Mode QEMU uses -bios argument to load from ROM Boot Loader. The file format is binary
aarch64-elf-objcopy -O binary main.elf main.bin 				

# QEMU CMD Line for SMC EMulation
qemu-system-aarch64 -M virt -cpu cortex-a57 -smp cpus=4 -machine secure=on -m 1G -bios main.bin -semihosting -nographic -s -S
