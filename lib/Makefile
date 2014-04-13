OPT_FLAGS	= -for-pack Mj
SUB_LIBS	= utils.cmx scoring.cmx cli.cmx

mj.cmx: $(SUB_LIBS)
	ocamlfind opt -pack -o $@ $+

include ../Makeroot
