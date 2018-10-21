# If the first argument is "build"...
ifeq (build,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  BUILD_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(BUILD_ARGS):;@:)
endif

build:
	nasm -f elf64 -g -F dwarf -o app.o -l app.lst $(BUILD_ARGS)
	ld -o app app.o

clean:
	rm -f app*

.PHONY: build
