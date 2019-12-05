# rdtsc_threesome

## Three ways of reading the RDTSC x86-64 instruction. ;)

### Copyright (C) 2019  Robert V. &lt;modrobert@gmail.com&gt;
### Software licensed under GPLv3.

---

### Description

Simply three ways of reading the RDTSC (Read Time-Stamp Counter) x86-64 
instruction under GNU/Linux. Using either C, assembler with printf call, or
pure assembler which outputs hex digits. The 64-bit counter increments each
CPU clock cycle.

Think of these sources as useful stubs when playing around with the RDTSC
instruction which is good for precise timing in various attacks related to
RAM, CPU cache and branch prediction, especially in conjunction with the xFENCE and CLFLUSH instructions.

---

### Usage

<pre>
$ ./rdtsc
447585918274014
$ ./rdtsc_a
447728419100158
$ ./rdtsc_a2
0x00019746544d5f59
$ printf "%llu\n" $((`./rdtsc_a2`))
448150994372265
</pre>

---

### Build

You need 'gcc' and 'nasm' to build this.  
  
Use the included Makefile which supports several targets:  
<pre>
make all        ; Default, builds all.  
make rdtsc      ; C version, outputs decimal.  
make rdtsc_a    ; Assembler version, uses printf call, outputs decimal.  
make rdtsc_a2   ; Pure assembler version, outputs hexadecimal.  
make debug      ; Builds all with debug info for 'gdb'.  
make strip      ; Builds all and strips output binaries from symbols.  
make clean      ; Deletes all output binaries.
</pre>
