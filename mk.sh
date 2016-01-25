#!/bin/bash

aarch64-none-elf-gcc -c -g startup.S
aarch64-none-elf-gcc -c -g main.c

aarch64-none-elf-ld -g -T linker.ld startup.o main.o -o main.elf -nostdlib
