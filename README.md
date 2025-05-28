# Minimal Kernel Development Project

This project guides you through building a minimal operating system kernel from scratch using **C**, **Assembly**, and running it on **QEMU**. It is designed for Linux users (tested on Parrot OS) and helps you understand how kernels work under the hood and how they manage computer resources.

---

## Overview

A **kernel** is the core software component of an operating system that manages hardware, memory, processes, and system calls. This project breaks down kernel development into manageable phases to get hands-on experience:

### Phase 1: Environment Setup
- Install necessary tools: GCC, NASM, QEMU, Make.
- Setup a working directory and version control.

### Phase 2: Bootloader and First Kernel
- Write a minimal bootloader (assembly) to switch CPU from real mode to protected mode.
- Write a simple kernel in C that prints "Hello, Kernel!" to the screen.
- Compile and run using QEMU emulator.

### Phase 3: CPU Modes and Interrupts
- Learn about CPU modes: real mode, protected mode, long mode.
- Setup Interrupt Descriptor Table (IDT) and handle timer and keyboard interrupts.

### Phase 4: Memory Management
- Implement paging.
- Create a simple heap allocator for kernel memory management.

### Phase 5: Process Management and Scheduling
- Implement context switching.
- Basic task scheduling and process management.

### Phase 6 (Optional): Filesystem and Shell
- Implement reading from a simple filesystem.
- Write a basic shell to accept commands.

---

## How to Build and Run

Basic steps to build and run your kernel image:

```bash
# Assemble bootloader
nasm -f bin bootloader/boot.asm -o bootloader/boot.bin

# Compile kernel
gcc -m32 -ffreestanding -c kernel/kernel.c -o kernel/kernel.o

# Link kernel
ld -m elf_i386 -T linker.ld -o kernel/kernel.bin kernel/kernel.o

# Create combined bootable image
cat bootloader/boot.bin kernel/kernel.bin > os-image.bin

# Run in QEMU
qemu-system-i386 -drive format=raw,file=os-image.bin
