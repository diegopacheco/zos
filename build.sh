#!/bin/bash

zig build-obj src/main.zig -target x86-freestanding -O ReleaseSmall -femit-bin=kernel.o
as --32 boot.s -o boot.o
ld -m elf_i386 -T link.ld -o kernel.bin boot.o kernel.o