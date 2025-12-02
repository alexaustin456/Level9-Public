
	opt	s-
	opt	c+
	opt	d+

	nolist

start:
	jmp	main

	include	recs.s
	include	f_lists.s
	include	lvars.s
	include	dtabs.s
	include	dvars.s
	include	trees.s
	include	i_grphs.s

	include	srce_gen.s
	include	srce_mv.s
	include	srce_drw.s
	include	gm_mast.s

	even

	dc.l	0
d_area:
	dc.l	0


*	list

	end

