OPT_FLAGS	= -thread -I ../lib
MJ_LIB 		= mj.cmx
PACKS		= batteries oUnit

TESTS =				\
	scoring_test.cmx	\
	field_test.cmx		\
        player_test.cmx		\
	action_test.cmx

test: runner.out
	./$<

%.out: $(MJ_LIB) $(TESTS) %.cmx
	ocamlfind opt -I ../lib -thread -linkpkg -package '$(PACKS)' -o $@ $+

$(MJ_LIB):
	make -C ../lib $@

.PHONY: test
.PHONY: $(MJ_LIB)

include ../Makeroot
