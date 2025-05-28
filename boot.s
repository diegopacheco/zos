
# Bootloader assembly file that makes your kernel 
# compatible with the Multiboot specification 
# (used by GRUB and other bootloaders)
.set MAGIC, 0x1BADB002           # Magic Multiboot ID
.set FLAGS, 0                    # Flags - no special features
.set CHECKSUM, -(MAGIC + FLAGS)  # guarantee integrity by MAGIC + FLAGS + CHECKSUM = 0


# Contains the three 32-bit values in the exact order required by the Multiboot spec
# This header must be in the first 8KB of the kernel file
# link.ld places this section first with *(.multiboot)
#
.section .multiboot
    .long MAGIC
    .long FLAGS
    .long CHECKSUM

#
# The kernel entry point code
#
.section .text
.global _start  # .global _start exports the _start symbol (making it visible to the linker)

# _start is the entry point defined in your link.ld with ENTRY(_start)
# 1: is a local label
# jmp 1b creates an infinite loop (jump backwards to label 1) in case kmain ever returns (which it shouldn't since it's noreturn)
_start: 
    call kmain
1:
    jmp 1b