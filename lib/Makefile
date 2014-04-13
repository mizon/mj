SUB_DIRS = mj
SUB_LIBS := utils scoring cli
SUB_LIBS := $(SUB_LIBS:%=mj/%.cmx)

mj.cmx: $(SUB_LIBS)
	ocamlfind opt -pack -o $@ $+
$(SUB_LIBS):
	$(MAKE) -C mj $(@:mj/%=%)

include ../Makeroot
