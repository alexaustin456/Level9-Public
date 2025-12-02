

*******  game master control routines  *******


gm_mast:
	addq.l	#1,frames

	bsr	do_air
	bsr	f_lfts
*	bsr	mv_tiles
	rts

do_air:
	subq.w	#1,air_cnt
	bne	do_air1
	move.w	#50,air_cnt
	clr.l	d0
	move.w	air_num,d0
	lea	air01,a0
	subq.w	#1,0(a0,d0.l)
	bne	do_air1
	addq.w	#2,d0
	move.w	d0,air_num
	cmpi.w	#8,d0
	blt	do_air1
* player runs out of air
	clr.w	air_num
	move.w	#192,air01
	move.w	#192,air02
	move.w	#192,air03
	move.w	#192,air04
do_air1:
	rts


f_lfts:
	subq.w	#1,l_dlay
	bne	f_lftx
	move.w	#2,l_dlay

	clr.l	d0
	move.w	l_cycle,d0
	lsl.w	#2,d0
	lea	lft_lst,a0
	adda.l	d0,a0
	move.w	level,d0
	lsl.w	#3,d0
	lea	lft_offs-8,a2
	adda.l	d0,a2
	movea.l	bmap,a1
	moveq	#3,d7
f_lft1:
	move.w	(a2)+,d0
	move.b	(a0),0(a1,d0.l)
	move.b	1(a0),1(a1,d0.l)
	move.b	2(a0),73(a1,d0.l)
	move.b	3(a0),72(a1,d0.l)
	dbra	d7,f_lft1

	addq.w	#1,l_cycle
	cmpi.w	#3,l_cycle
	blt	f_lftx
	clr.w	l_cycle
f_lftx:
	rts


mv_tiles:
	movea.l	flick,a0
	movea.l	bmap,a1
mv_tile1:
	clr.l	d0
	move.w	(a0),d0
	beq	mv_tilex

	clr.l	d1
	move.w	2(a0),d1
	subq.b	#1,4(a0)
	bpl	mv_tile3

	addq.b	#1,4(a0)
	clr.l	d2
	move.b	5(a0),d2
	tst.b	6(a0,d2.l)
	bpl	mv_tile2

	clr.b	5(a0)
	move.b	v_low,d3
	andi.b	#31,d3
	move.b	d3,4(a0)
	move.b	#$5e,0(a1,d1.l)
	bra	mv_tile3
mv_tile2:
	move.b	6(a0,d2.l),0(a1,d1.l)
	addq.b	#1,5(a0)
mv_tile3:
	adda.l	d0,a0
	bra	mv_tile1
mv_tilex:
	rts







	
	
