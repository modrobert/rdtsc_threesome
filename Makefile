CC = gcc
CFLAGS = -O2 -Wpedantic
CASFLAGS = -Wpedantic -no-pie
AS = nasm
ASFLAGS = -f elf64
LD = ld
LDFLAGS = -m elf_x86_64

default: all

all: rdtsc
all: rdtsc_a
all: rdtsc_a2

debug: CFLAGS = -g -Wpedantic
debug: ASFLAGS = -f elf64 -F dwarf -g
debug: CASFLAGS = -Wpedantic -no-pie -g
debug: rdtsc
debug: rdtsc_a
debug: rdtsc_a2

strip: CFLAGS = -O2 -Wpedantic -s
strip: LDFLAGS = -m elf_x86_64 -s
strip: CASFLAGS = -Wpedantic -no-pie -s
strip: rdtsc
strip: rdtsc_a
strip: rdtsc_a2

rdtsc.o: rdtsc.c
	$(CC) $(CFLAGS) -c rdtsc.c -o rdtsc.o

rdtsc: rdtsc.o
	$(CC) $(CFLAGS) rdtsc.o -o rdtsc

rdtsc_a.o: rdtsc_a.asm
	$(AS) $(ASFLAGS) rdtsc_a.asm -o rdtsc_a.o

rdtsc_a: rdtsc_a.o
	$(CC) $(CASFLAGS) rdtsc_a.o -o rdtsc_a

rdtsc_a2.o: rdtsc_a2.asm
	$(AS) $(ASFLAGS) rdtsc_a2.asm -o rdtsc_a2.o

rdtsc_a2: rdtsc_a2.o
	$(LD) $(LDFLAGS) rdtsc_a2.o -o rdtsc_a2

clean:
	-rm -f rdtsc.o
	-rm -f rdtsc
	-rm -f rdtsc_a.o
	-rm -f rdtsc_a
	-rm -f rdtsc_a2.o
	-rm -f rdtsc_a2

