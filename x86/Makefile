# If the first argument is "run"...
ifeq (build,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  BUILD_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(BUILD_ARGS):;@:)
endif

build:
	nasm -f elf -g -F dwarf -o app.o -l app.lst $(BUILD_ARGS)
	ld -m elf_i386 -o app app.o

clean:
	rm -f app*

.PHONY: build
