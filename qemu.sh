make \
&& \
qemu-system-aarch64 -machine virt -cpu max -m 1G -kernel build/pluhOS.bin -S -gdb tcp::4321 -nographic