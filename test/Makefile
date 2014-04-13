OPT_FLAGS	= -thread -I ../lib
EXECUTABLE	= run_test.out
MJ_LIB 		= mj.cmx
TESTS		= scoring_test.cmx field_test.cmx player_test.cmx

test: runner.out
	./$<

%.out: $(MJ_LIB) $(TESTS) %.cmx
	ocamlfind opt -I ../lib -thread -linkpkg -package $(PACKS) -o $@ $+

$(MJ_LIB):
	make -C ../lib $@

.PHONY: test
.PHONY: $(MJ_LIB)

include ../Makeroot
