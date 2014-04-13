SUB_DIRS = lib test

mj.out: lib/mj.cmx main.ml
	ocamlfind opt -thread -linkpkg -I lib -o $@ -package $(PACKS) $+
lib/mj.cmx:
	make -C lib mj.cmx

all: test mj.out

test:
	make -C test test

.PHONY: all test

include ./Makeroot
