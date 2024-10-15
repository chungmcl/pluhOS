SRC_DIR=src
BUILD_DIR=build
NAME=pluhOS

all:
	mkdir -p $(BUILD_DIR)

# https://lld.llvm.org
# https://lld.llvm.org/ELF/linker_script.html
# -T <script>             Specify <script> as linker script
# -z <arg>                Pass -z <arg> to the linker
	clang -g -o $(BUILD_DIR)/$(NAME) $(SRC_DIR)/start.asm $(SRC_DIR)/main.c -T $(SRC_DIR)/link.ld -nostdlib -static -v
	
# for some reason --only-section doesn't work but --dump-section does...? 
# but I still have to specify an output file even with --dump-section, so using a throwaway file named "_"
# also, unlike with ELF objects, MachO objects require you to specify both segment AND section in the format <segment>,<section>
# https://www.llvm.org/docs/CommandGuide/llvm-objcopy.html
	llvm-objcopy --dump-section "__TEXT,__text=$(BUILD_DIR)/$(NAME).bin" $(BUILD_DIR)/$(NAME) $(BUILD_DIR)/_

	rm $(BUILD_DIR)/_
