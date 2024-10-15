.text
.global _start

_start:
  // Set the stack pointer to a specific memory address
  LDR X0, =0x40010000
  MOV SP, X0

  // Jump to main.c
  BL main

.end