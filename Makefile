CC_PATH=aarch64-elf
#CC=aarch64-none-elf-gcc
#CC=aarch64-linux-gnu-gcc
#LD=aarch64-none-elf-ld
#LD=aarch64-linux-gnu-ld
CC=${CC_PATH}-gcc
LD=${CC_PATH}-ld
all: main_bin

startup.o: startup.S
	$(CC) -c -g -v startup.S 

vector.o: vector.S
	$(CC) -c -g -v vector.S
	
kernel_ns.o:kernel_ns.S
	$(CC) -c -g -v kernel_ns.S	

main.o: main.c
	$(CC) -c -g -v -march=armv8-a main.c -nostdlib

main:startup.o  main.o kernel_ns.o vector.o
	$(LD) -g -T linker.ld vector.o startup.o kernel_ns.o main.o -o main.elf -nostdlib

main_bin:main
	aarch64-elf-objcopy -O binary main.elf main.bin

disas:main
	aarch64-elf-objdump -D main.elf > disas.txt

hex:main.bin
	hexdump main.bin > hexdump.txt	


clean:
	rm -rf *.o *.elf *.bin disas.txt
