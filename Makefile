SUB_DIRS	= lib test
MJ_LIB		= lib/mj.cmx

main.out:

%.out: $(MJ_LIB) %.ml
	ocamlfind opt -thread -linkpkg -I lib -o $@ -package $(PACKS) $+

$(MJ_LIB):
	make -C lib mj.cmx

all: test mj.out

test:
	make -C test test

.PHONY: all test

include ./Makeroot
