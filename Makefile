# Makefile

NASM = nasm

QEMU = qemu-system-i386

boot.o: boot.asm
	$(NASM) -f elf32 boot.asm -o boot.o


run: os-image
	$(QEMU) -drive format=raw,file=boot.o

clean:
	rm -f *.bin *.o *.elf 
