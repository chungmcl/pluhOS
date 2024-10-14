SRC_DIR=src
BUILD_DIR_DIR=build_dir
NAME=pluhOS

all:
	mkdir -p $(BUILD_DIR)
	clang -o $(BUILD_DIR)/$(NAME) $(SRC_DIR)/start.asm $(SRC_DIR)/main.c -nostdlib -static
# for some reason --only-section doesn't work but --dump-section does...? 
# but I still have to specify an output file even with --dump-section, so using a throwaway file named "_"
	llvm-objcopy --dump-section "__TEXT,__text=$(BUILD_DIR)/$(NAME).bin" $(BUILD_DIR)/$(NAME) $(BUILD_DIR)/_
	rm $(BUILD_DIR)/_
