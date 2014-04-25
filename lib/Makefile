OPT_FLAGS	= -for-pack Mj
SUB_LIBS	=	\
	utils.cmx	\
	scoring.cmx	\
	cli.cmx		\
	wind.cmx	\
	player.cmx	\
	field.cmx	\
	action.cmx
PACKS = batteries

mj.cmx: $(SUB_LIBS)
	ocamlfind opt -pack -o $@ $+

include ../Makeroot
