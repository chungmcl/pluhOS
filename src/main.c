#include <stdint.h>

int main() {
  uint8_t* device_tree_address;
  asm volatile (
      "mov %0, x3" // Get the device tree's address out of x3
      : "=r"(device_tree_address) // Output operand
      : // No input operands
      : // No clobbered registers
  );

  return 0;
}