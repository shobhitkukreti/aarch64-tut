CC_PATH=aarch64-elf
#CC=aarch64-none-elf-gcc
#CC=aarch64-linux-gnu-gcc
#LD=aarch64-none-elf-ld
#LD=aarch64-linux-gnu-ld
CC=${CC_PATH}-gcc
LD=${CC_PATH}-ld
all: main

startup.o: startup.S
	$(CC) -c -g  startup.S

main.o: main.c
	$(CC) -c -g main.c

main:startup.o main.o
	$(LD) -g -T linker.ld startup.o main.o -o main.elf -nostdlib

clean:
	rm -rf *.o *.elf 
