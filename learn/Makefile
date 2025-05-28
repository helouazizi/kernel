# Makefile for learn.asm assembly program

ASM = nasm
LD = ld

ASMFLAGS = -f elf64
LDFLAGS = 

SRC = learn.asm
OBJ = learn.o
EXE = learn

.PHONY: all clean run

all: $(EXE)

$(OBJ): $(SRC)
	$(ASM) $(ASMFLAGS) $< -o $@

$(EXE): $(OBJ)
	$(LD) $^ -o $@ $(LDFLAGS)

run: all
	./$(EXE)

clean:
	rm -f $(OBJ) $(EXE)
