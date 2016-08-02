CC=aarch64-none-elf-gcc
LD=aarch64-none-elf-ld

all: main

startup.o: startup.S
	$(CC) -c -g  startup.S

main.o: main.c
	$(CC) -c -g main.c

main:startup.o main.o
	$(LD) -g -T linker.ld startup.o main.o -o main.elf -nostdlib

clean:
	rm -rf *.o *.elf 
