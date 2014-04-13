OPT_FLAGS	= -thread -I ../lib
EXECUTABLE	= run_test.out
MJ_LIB 		= ../lib/mj.cmx

PACKS += ounit

test: $(EXECUTABLE)
	./$<

$(EXECUTABLE): $(MJ_LIB) scoring_test.cmx runner.cmx
	ocamlfind opt -I ../lib -thread -linkpkg -package $(PACKS) -o $@ $+

$(MJ_LIB):
	make -C ../lib mj.cmx

.PHONY: test

include ../Makeroot
