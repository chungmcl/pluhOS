SRC_DIR=src
BUILD_DIR=build
NAME=pluhOS

all:
	mkdir -p $(BUILD_DIR)

# https://lld.llvm.org
# https://lld.llvm.org/ELF/linker_script.html
# -T <script>             Specify <script> as linker script
# Note that -T only works with ELF, not with MachO -- hence the need for --target=aarch64-unknown-linux-gnu
	clang -g -o $(BUILD_DIR)/$(NAME) $(SRC_DIR)/start.asm $(SRC_DIR)/main.c -T $(SRC_DIR)/link.lds --target=aarch64-unknown-linux-gnu -nostdlib -static -v
	
# for some reason --only-section doesn't work but --dump-section does...? 
# but I still have to specify an output file even with --dump-section, so using a throwaway file named "_"
	llvm-objcopy --dump-section ".text=$(BUILD_DIR)/$(NAME).bin" $(BUILD_DIR)/$(NAME) $(BUILD_DIR)/_

	rm $(BUILD_DIR)/_

clean:
	rm -rf $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)
