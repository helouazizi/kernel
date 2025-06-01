# Makefile

NASM = nasm

QEMU = qemu-system-i386

boot.o: boot.asm
	$(NASM) -f bin boot.asm -o boot.o

run: 
	$(QEMU) boot.o

clean:
	rm -f *.bin *.o *.elf 
