/* Entry point symbol */
ENTRY(_start)

SECTIONS {
    /* Load kernel at 1MB in memory */
    . = 1M;

    /* Text section: executable code */
    .text : {
        *(.multiboot)  /* Multiboot header first */
        *(.text*)     /* All executable code */
    }

     /* Read-only data section */
    .rodata : { *(.rodata*) }

    /* Initialized data section */
    .data : { *(.data*) }

    /* Uninitialized data section */
    .bss : {
        *(.bss*)
        *(COMMON)
    }
}