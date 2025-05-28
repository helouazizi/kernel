# Makefile

NASM = nasm
CC = gcc
LD = ld
OBJCOPY = objcopy
QEMU = qemu-system-i386

all: os-image

boot.o: boot.asm
	$(NASM) -f elf32 boot.asm -o boot.o

kernel.o: kernel.c
	$(CC) -m32 -ffreestanding -c kernel.c -o kernel.o

kernel.elf: boot.o kernel.o linker.ld
	$(LD) -m elf_i386 -T linker.ld -o kernel.elf boot.o kernel.o

kernel.bin: kernel.elf
	$(OBJCOPY) -O binary kernel.elf kernel.bin

os-image: kernel.bin
	cp kernel.bin os-image.img

run: os-image
	$(QEMU) -drive format=raw,file=os-image.img

clean:
	rm -f *.bin *.o *.elf os-image.img
