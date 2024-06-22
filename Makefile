# An example make file for code completion for AVR in vim.
# Can be adapted for use with another target architecture.
# run make complete
#
# This will generate tags .clang_complete and compile_commands.json
# You should have clang (libclang) + vim-clang-complete, vim-ale + clangd
# installed for this to work well in vim.
#
# Also check the vimrc file if you want vim-ale to use  avr-gcc
#
# Consider adding auto generated files to your .gitignore file
# See target clean and dist-clean in this make file
#
# File is part of https://github.com/ernestesene/vimrc.git
# (c) Ernest Esene <eroken1@gmail.com>
# See LICENSE file


.PHONY: complete

CC ?= avr-gcc
OFLAG ?= -Os -flto
DEBUG ?= -ggdb
INCLUDES ?= -I /usr/include/simavr/avr

DEVICE = attiny13
CLOCK = 1000000

CFLAGS += -std=c11 -Wpedantic -Wextra -Wall $(INCLUDES) $(DEBUG) $(OFLAG) -DF_CPU=$(CLOCK) -mmcu=$(DEVICE) -fshort-enums

tags: *.c *.h built_in_defs.h
	ctags -R --kinds-C=+pxD $^
TAGS:
	ctags -R  --kinds-C=+pxD -f TAGS /usr/avr/include /usr/include/simavr/avr

built_in_defs.h: Makefile
	$(CC) -E -dM -mmcu=$(DEVICE) <<<aa - -o $@

# for code completion and language servers (libclang clangd)
complete: compile_commands.json .clang_complete tags

AVR_DEFINES = -imacros built_in_defs.h -I /usr/avr/include
# for completer .clang_complete
.clang_complete: built_in_defs.h
	echo -ne "$(CFLAGS)\n$(AVR_DEFINES)\n" > $@

# for clangd
compile_commands.json: built_in_defs.h
	echo [{"directory": "'$(PWD)'","command": "'$(CC) $(CFLAGS) $(AVR_DEFINES)'","file": "'*.c sim/gdb/*.c'"}] > $@


clean:
	rm -f *.elf *.o *.hex	*.s *.pre

dist-clean: clean
	rm  tags TAGS compile_commands.json .clang_complete built_in_defs.h
