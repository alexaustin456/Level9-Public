
move_pic:
	bsr	mv_player
	bsr	mv_aliens
	bsr	mv_mssls
	bsr	mv_xplns
	rts



mv_player:
	lea	plyr_rec,a0
	btst	#0,11(a0)
	bne	mv_plyr_f
	btst	#1,11(a0)
	beq	mv_plyr0

mv_plyr_l:
	addq.b	#1,9(a0)
	lea	l_tree,a3
	clr.l	d7
	move.b	9(a0),d7
	move.b	0(a3,d7.l),10(a0)
	bpl	mv_plyr0x

	bclr	#1,c_flag1
	bclr	#1,11(a0)
	movea.l	l_save,a3
	move.w	level,d7
	sub.b	8(a3),d7
	ext.w	d7
	move.w	d7,l_dir
	move.b	8(a3),level+1
	move.b	9(a3),lift+1
	bsr	new_map
	movea.l	hold_sp,sp
	bra	main1



mv_plyr_f:
	addq.b	#1,9(a0)
	lea	f_trees,a3
	clr.w	d7
	move.b	8(a0),d7
	subq.b	#1,d7
	mulu	#10,d7
	adda.l	d7,a3

	clr.l	d7
	move.b	9(a0),d7
	move.b	0(a3,d7.l),d7
	bpl	mv_plyr0a
	clr.b	9(a0)
	clr.b	10(a0)
	bclr	#0,11(a0)
	bra	mv_plyr0x
mv_plyr0a:
	move.b	d7,10(a0)
	cmpi.b	#1,9(a0)
	bne	mv_plyr0x

	lea	pms_tab-pms_rec,a1
mv_plyr0b:
	adda.l	#pms_rec,a1
	tst.b	6(a1)
	bne	mv_plyr0b
	move.b	8(a0),8(a1)
	move.w	2(a0),(a1)
	move.w	6(a0),2(a1)
	clr.b	4(a1)
	move.b	9(a1),6(a1)
mv_plyr0x:
	rts



mv_plyr0:
	lea	j_buff,a2
	cmpi.b	#$FF,(a2)
	bne	rest_pic

	clr.l	d0
	move.b	2(a2),d0
	andi.b	#15,d0
	move.b	new_dir,old_dir
	move.b	d0,new_dir
	bne	mv_plyr0c
	bsr	rest_pic
	bra	chk_fire

mv_plyr0c:
	lea	dir_tab,a1
	adda.l	d0,a1
	move.b	(a1),d0
	cmp.b	8(a0),d0
	beq	mv_plyr1
	move.b	d0,8(a0)
	clr.b	9(a0)
	move.b	#1,10(a0)
	bsr	rest_pic
	bra	chk_fire

mv_plyr1:
	move.l	d0,d3
	subq.b	#1,d3
	lsl.w	#2,d3
	lea	add_tab,a1
	adda.l	d3,a1
	move.w	(a1),d1
	move.w	2(a1),d2
	move.w	2(a0),d3
	move.w	6(a0),d4
	move.w	d3,d5
	move.w	d4,d6
	andi.w	#15,d3
	andi.w	#15,d4

	lsr.w	#4,d5
	lsr.w	#4,d6
	mulu	#bmapw,d6
	add.w	d5,d6
	movea.l	bmap,a1
	adda.l	d6,a1

	move.w	2(a0),old_x
	move.w	6(a0),old_y
	move.w	max_flr,d7

	or.w	d1,d1
	beq	mv_plyr4
	bpl	mv_plyr2
	or.w	d3,d3
	bne	mv_plyr3
	cmp.b	-1(a1),d7
	ble	mv_plyr4
	or.w	d4,d4
	beq	mv_plyr3
	cmp.b	71(a1),d7
	ble	mv_plyr4
	bra	mv_plyr3
mv_plyr2:
	or.w	d3,d3
	bne	mv_plyr3
	cmp.b	1(a1),d7
	ble	mv_plyr4
	or.w	d4,d4
	beq	mv_plyr3
	cmp.b	73(a1),d7
	ble	mv_plyr4
mv_plyr3:
	add.w	d1,2(a0)
mv_plyr4:
	or.w	d2,d2
	beq	mv_plyr7
	bmi	mv_plyr5
	or.w	d4,d4
	bne	mv_plyr6
	cmp.b	72(a1),d7
	ble	mv_plyr7
	or.w	d3,d3
	beq	mv_plyr6
	cmp.b	73(a1),d7
	ble	mv_plyr7
	bra	mv_plyr6
mv_plyr5:
	or.w	d4,d4
	bne	mv_plyr6
	cmp.b	-72(a1),d7
	ble	mv_plyr7
	or.w	d3,d3
	beq	mv_plyr6
	cmp.b	-71(a1),d7
	ble	mv_plyr7
mv_plyr6:
	add.w	d2,6(a0)
mv_plyr7:
	clr.l	d0
	move.w	old_x,d1
	sub.w	2(a0),d1
	beq	mv_plyr7b
	bpl	mv_plyr7a
	or.w	#8,d0
	bra	mv_plyr7b
mv_plyr7a:
	or.w	#4,d0
mv_plyr7b:
	move.w	old_y,d1
	sub.w	6(a0),d1
	beq	mv_plyr7d
	bpl	mv_plyr7c
	or.w	#2,d0
	bra	mv_plyr7d
mv_plyr7c:
	or.w	#1,d0
mv_plyr7d:
	or.w	d0,d0
	beq	mv_plyr0x
	lea	dir_tab,a1
	adda.l	d0,a1
	move.b	(a1),d0
	move.b	d0,8(a0)

mv_plyr8:
	bsr	calc_zone
	ext.l	d3
	lea	z1a_cnt-2,a1
	lsl.w	#1,d3
	adda.l	d3,a1
	move.w	(a1),d1
	lea	z1a_lst-4,a1
	lsl.w	#1,d3
	adda.l	d3,a1
	movea.l	(a1),a1
mv_plyr8a:
	move.w	(a1),d2
	sub.w	2(a0),d2
	bpl	mv_plyr8b
	neg.w	d2
mv_plyr8b:
	cmpi.w	#8,d2
	bgt	mv_plyr8d
	move.w	2(a1),d2
	sub.w	6(a0),d2
	bpl	mv_plyr8c
	neg.w	d2
mv_plyr8c:
	cmpi.w	#8,d2
	ble	mv_plyr8e
mv_plyr8d:
	adda.l	#aln_rec,a1
	dbra	d1,mv_plyr8a
	bra	mv_plyr8f

mv_plyr8e:
	move.w	old_x,2(a0)
	move.w	old_y,6(a0)
	bra	rest_pic

mv_plyr8f:
	move.w	2(a0),d1
	move.w	6(a0),d2

	move.w	level,d3
	subq.w	#1,d3
	moveq	#lft_rec*4,d4
	mulu	d3,d4
	lea	lft_tab,a1
	adda.l	d4,a1
	move.w	zone,d3
	move.w	#3,d4
mv_plyr9:
	cmp.b	5(a1),d3
	beq	mv_plyr9a
	adda.l	#lft_rec,a1
	dbra	d4,mv_plyr9
	bra	mv_plyr15
mv_plyr9a:
	move.w	d1,d3
	sub.w	(a1),d3
	bmi	mv_plyr15
	cmpi.w	#31,d3
	bgt	mv_plyr15

	move.w	d2,d3
	btst	#2,7(a1)
	bne	mv_plyr9b

	sub.w	2(a1),d3
	bmi	mv_plyr15
	cmpi.w	#16,d3
	bge	mv_plyr15
	bra	mv_plyr9c
mv_plyr9b:
	sub.w	2(a1),d3
	cmpi.w	#8,d3
	blt	mv_plyr15
	cmpi.w	#24,d3
	bgt	mv_plyr15
mv_plyr9c:
	btst	#0,s_flag1
	bne	mv_plyr23

	clr.l	d3
	move.b	4(a1),d3
	lea	l_pass1-1,a2
	tst.b	0(a2,d3.l)
	beq	mv_plyr23

	bset	#0,s_flag1
	bset	#1,11(a0)
	bset	#1,c_flag1
	clr.b	9(a0)
	move.b	l_tree,10(a0)
	move.l	a1,l_save
	rts



mv_plyr15:
	bclr	#0,s_flag1		* objects

	lea	obj_tab,a1
	move.w	level,d3
	moveq	#obj_cnt,d4
mv_plyr16:
	cmp.b	4(a1),d3
	bne	mv_plyr19

	move.w	(a1),d5
	sub.w	d1,d5
	cmpi.w	#-8,d5
	blt	mv_plyr19
	cmpi.w	#8,d5
	bge	mv_plyr19

	move.w	2(a1),d5
	sub.w	d2,d5
	cmpi.w	#-8,d5
	blt	mv_plyr19
	cmpi.w	#8,d5
	blt	mv_plyr20

mv_plyr19:
	bclr	#5,6(a1)
mv_plyr19a:
	adda.l	#obj_rec,a1
	dbra	d4,mv_plyr16
	bra	mv_plyr23

mv_plyr20:
	btst	#5,6(a1)			* player = object
	bne	mv_plyr19a

	bset	#6,6(a1)
	cmpi.b	#4,8(a1)
	bgt	mv_plyr20a

	clr.l	d5
	move.b	8(a1),d5
	lea	l_pass1-1,a2
	st	0(a2,d5.l)

mv_plyr20a:
	cmpi.w	#6,14(a0)
	blt	mv_plyr21

	move.b	20(a0),d5
	bsr	find_obj
	move.w	2(a0),(a2)
	move.w	6(a0),2(a2)
	bset	#5,6(a2)
	bra	mv_plyr22
mv_plyr21:
	addq.b	#1,14(a0)
mv_plyr22:
	move.b	19(a0),20(a0)
	move.b	18(a0),19(a0)
	move.b	17(a0),18(a0)
	move.b	16(a0),17(a0)
	move.b	15(a0),16(a0)
	move.b	8(a1),15(a0)



mv_plyr23:
	bsr	calc_zone
	move.w	d3,zone
	bsr	w_cords

	lea	m_trees,a1
	clr.l	d0
	move.b	9(a0),d0
	move.b	0(a1,d0.l),d0
	bpl	mv_plyr25
	clr.b	9(a0)
	move.b	(a1),d0
mv_plyr25:
	addq.b	#1,9(a0)
	move.b	d0,10(a0)


chk_fire:
	lea	plyr_rec,a0
	move.b	j_buff+2,d0
	bpl	chk_firx
	cmpi.b	#pms_max,22(a0)
	bge	chk_firx
	addq.b	#1,22(a0)

	subq.w	#1,shot_cnt
	bne	chk_fir1
	tst.w	mag_cnt
	beq	chk_firx
	move.w	#2,shot_cnt
	subq.w	#1,mag_cnt
	bne	chk_fir1
	tst.w	spr_mags
	beq	chk_firx
	move.w	#188,mag_cnt
	subq.w	#1,spr_mags
chk_fir1:
	clr.b	9(a0)
	bset	#0,11(a0)
	lea	f_trees-10,a3
	clr.w	d7
	move.b	8(a0),d7
	mulu	#10,d7
	move.b	0(a3,d7.l),10(a0)
chk_firx:
	rts



calc_zone:
	move.w	plyr_rec+2,d1
	move.w	plyr_rec+6,d2
c_zonea:
	moveq	#1,d3
	subi.w	#384,d1
	bmi	c_zone1
	addq.w	#1,d3
	subi.w	#384,d1
	bmi	c_zone1
	addq.w	#1,d3
c_zone1:
	subi.w	#528,d2
	bmi	c_zone2
	addq.w	#3,d3
c_zone2:
	rts



********* move aliens **********

mv_aliens:
	lea	z1a_lst,a5
	lea	z1a_cnt,a6
	moveq	#5,d7
mv_alien1:
	movea.l	(a5)+,a0
	move.w	(a6)+,d0
	movem.l	d7/a5/a6,-(sp)
	bsr	mv_alnzn
	movem.l	(sp)+,d7/a5/a6
	dbra	d7,mv_alien1
	rts


mv_alnzn:
	move.l	a0,a_list
	move.w	d0,a_cnt

	clr.w	mv_flag
	move.w	zone,d1
	cmp.b	13(a0),d1
	bne	mv_alnr0


mv_alna0:
	tst.b	8(a0)
	bpl	mv_alna1
	bsr	ald_seq
	bra	mv_alna7

mv_alna1:
	btst	#6,8(a0)
	beq	mv_alna8

	addq.b	#1,5(a0)
	lea	f_trees,a3
	clr.w	d7
	move.b	7(a0),d7
	mulu	#80,d7
	adda.l	d7,a3
	clr.w	d7
	move.b	4(a0),d7
	subq.b	#1,d7
	mulu	#10,d7
	adda.l	d7,a3

	clr.l	d7
	move.b	5(a0),d7
	move.b	0(a3,d7.l),d7
	bpl	mv_alna9
	clr.b	5(a0)
	clr.b	6(a0)
	bclr	#6,8(a0)
	bra	mv_alna8
mv_alna9:
	move.b	d7,6(a0)
	cmpi.b	#1,5(a0)
	bne	mv_alna7
	move.b	21(a0),20(a0)
	bra	mv_alna7

mv_alna8:
	bsr	abg_hit

	move.w	a_cnt,d1
	movea.l	a_list,a1
mv_alna2:
	move.w	(a1),d2
	move.w	2(a1),d3
	bsr	aln_hit
	adda.l	#aln_rec,a1
	dbra	d1,mv_alna2

	lea	plyr_rec,a1
	move.w	2(a1),d2
	move.w	6(a1),d3
	bsr	aln_hit

	bsr	ap_dir
	bsr	af_move
	bsr	aln_fire
mv_alna7:
	adda.l	#aln_rec,a0
	dbra	d0,mv_alna0
	rts




mv_alnr0:
	bclr	#6,8(a0)
	tst.b	8(a0)
	bpl	mv_alnr1
	bsr	ald_seq
	bra	mv_alnr3

mv_alnr1:
	bsr	abg_hit

	subq.b	#1,12(a0)
	bne	mv_alnr2

	move.b	v_low,d1
	move.b	1(a0),d2
	eor.b	d1,d2
	andi.b	#31,d2
	addq.b	#1,d2
	move.b	d2,12(a0)

	move.b	v_mid,d1
	move.b	3(a0),d2
	eor.b	d1,d2
	andi.b	#7,d2
	addq.b	#1,d2
	move.b	d2,4(a0)
mv_alnr2:
	clr.l	d3
	move.b	4(a0),d3
	bsr	af_move
mv_alnr3:
	adda.l	#aln_rec,a0
	dbra	d0,mv_alnr0
	rts


ap_dir:
	move.l	d2,-(sp)
	lea	plyr_rec,a1
	clr.l	d3
	move.w	2(a1),d2
	sub.w	(a0),d2
	beq	ap_dir2
	bpl	ap_dir1
	or.w	#4,d3
	bra	ap_dir2
ap_dir1:
	or.w	#8,d3
ap_dir2:
	move.w	6(a1),d2
	sub.w	2(a0),d2
	beq	ap_dir4
	bpl	ap_dir3
	or.w	#1,d3
	bra	ap_dir4
ap_dir3:
	or.w	#2,d3
ap_dir4:
	lea	dir_tab,a3
	adda.l	d3,a3
	move.b	(a3),d3
	move.l	(sp)+,d2
	rts



abg_hit:
	move.w	d7,-(sp)
	move.w	max_flr,d7

	lea	d_flags,a2
	clr.l	(a2)
	clr.l	4(a2)
	move.w	(a0),d1
	move.w	2(a0),d2
	move.w	d1,d3
	move.w	d2,d4
	lsr.w	#4,d3
	lsr.w	#4,d4
	mulu	#bmapw,d4
	add.w	d3,d4
	movea.l	bmap,a1
	adda.l	d4,a1
	move.w	d1,d3
	move.w	d2,d4
	andi.w	#15,d3
	andi.w	#15,d4

	or.w	d3,d3
	bne	abg_hit4
	or.w	d4,d4
	beq	abg_hit8

	cmp.b	-1(a1),d7
	bgt	abg_hit1
	st	6(a2)
	st	7(a2)
abg_hit1:
	cmp.b	71(a1),d7
	bgt	abg_hit2
	st	7(a2)
	st	6(a2)
abg_hit2:
	cmp.b	1(a1),d7
	bgt	abg_hit3
	st	2(a2)
	st	1(a2)
abg_hit3:
	cmp.b	73(a1),d7
	bgt	abg_hit16
	st	1(a2)
	st	2(a2)
	bra	abg_hit16

abg_hit4:
	or.w	d4,d4
	bne	abg_hit16

	cmp.b	-72(a1),d7
	bgt	abg_hit5
	st	4(a2)
	st	3(a2)
abg_hit5:
	cmp.b	-71(a1),d7
	bgt	abg_hit6
	st	3(a2)
	st	4(a2)
abg_hit6:
	cmp.b	72(a1),d7
	bgt	abg_hit7
	st	(a2)
	st	1(a2)
abg_hit7:
	cmp.b	73(a1),d7
	bgt	abg_hit16
	st	1(a2)
	st	(a2)
	bra	abg_hit16

abg_hit8:
	cmp.b	72(a1),d7
	bgt	abg_hit9
	st	(a2)
abg_hit9:
	cmp.b	73(a1),d7
	bgt	abg_hit10
	st	1(a2)
abg_hit10:
	cmp.b	1(a1),d7
	bgt	abg_hit11
	st	2(a2)
abg_hit11:
	cmp.b	-71(a1),d7
	bgt	abg_hit12
	st	3(a2)
abg_hit12:
	cmp.b	-72(a1),d7
	bgt	abg_hit13
	st	4(a2)
abg_hit13:
	cmp.b	-73(a1),d7
	bgt	abg_hit14
	st	5(a2)
abg_hit14:
	cmp.b	-1(a1),d7
	bgt	abg_hit15
	st	6(a2)
abg_hit15:
	cmp.b	71(a1),d7
	bgt	abg_hit16
	st	7(a2)


abg_hit16:
	move.b	13(a0),d2
	subq.b	#1,d2
	bne	abg_hit18

	cmpi.w	#368,(a0)
	blt	abg_hit17
	st	2(a2)
abg_hit17:
	cmpi.w	#512,2(a0)
	blt	abg_hitx
	st	(a2)
	bra	abg_hitx
abg_hit18:
	subq.b	#1,d2
	bne	abg_hit21
	cmpi.w	#396,(a0)
	bgt	abg_hit19
	st	6(a2)
abg_hit19:
	cmpi.w	#752,(a0)
	blt	abg_hit20
	st	2(a2)
abg_hit20:
	cmpi.w	#512,2(a0)
	blt	abg_hitx
	st	(a2)
	bra	abg_hitx
abg_hit21:
	subq.b	#1,d2
	bne	abg_hit23
	cmpi.w	#780,(a0)
	bgt	abg_hit22
	st	6(a2)
abg_hit22:
	cmpi.w	#512,2(a0)
	blt	abg_hitx
	st	(a2)
	bra	abg_hitx
abg_hit23:
	subq.b	#1,d2
	bne	abg_hit25
	cmpi.w	#368,(a0)
	blt	abg_hit24
	st	2(a2)
abg_hit24:
	cmpi.w	#540,2(a0)
	bgt	abg_hitx
	st	4(a2)
	bra	abg_hitx
abg_hit25:
	subq.b	#1,d2
	bne	abg_hit28
	cmpi.w	#396,(a0)
	bgt	abg_hit26
	st	6(a2)
abg_hit26:
	cmpi.w	#752,(a0)
	blt	abg_hit27
	st	2(a2)
abg_hit27:
	cmpi.w	#540,2(a0)
	bgt	abg_hitx
	st	4(a2)
	bra	abg_hitx
abg_hit28:
	cmpi.w	#780,(a0)
	bgt	abg_hit29
	st	6(a2)
abg_hit29:
	cmpi.w	#540,2(a0)
	bgt	abg_hitx
	st	4(a2)
abg_hitx:
	move.w	(sp)+,d7
	rts




af_move:
	move.l	d3,d4
	addq.w	#1,mv_flag
af_mv01:
	move.l	d4,d7
	lea	ts_tab,a3
	move.w	d4,d5
	add.w	d4,d4
	add.w	d5,d4
	adda.l	d4,a3
	tst.b	1(a3)
	bpl	af_mv02

	move.b	(a3),d4
	tst.b	0(a2,d4.l)
	beq	af_mv05
	bra	af_mv03

af_mv02:
	move.b	(a3)+,d4
	tst.b	0(a2,d4.l)
	bne	af_mv03
	move.b	(a3)+,d4
	tst.b	0(a2,d4.l)
	bne	af_mv03
	move.b	(a3),d4
	tst.b	0(a2,d4.l)
	beq	af_mv05

af_mv03:
	move.l	d7,d4
	btst	#0,mv_flag+1
	bne	af_mv03a

	subq.w	#1,d4
	bne	af_mv04
	moveq	#8,d4
	bra	af_mv04
af_mv03a:
	addq.w	#1,d4
	cmpi.w	#9,d4
	blt	af_mv04
	moveq	#1,d4
af_mv04:
	cmp.w	d4,d3
	bne	af_mv01
	bra	af_mv08

af_mv05:
	move.b	d7,4(a0)
	subq.b	#1,d7
	lsl.w	#2,d7
	lea	add_tab,a3
	adda.l	d7,a3
	clr.w	d7
	move.b	24(a0),d7
	tst.w	(a3)
	beq	af_mv10
	bpl	af_mv09
	neg.w	d7
af_mv09:
	add.w	d7,(a0)
af_mv10:
	clr.w	d7
	move.b	24(a0),d7
	tst.w	2(a3)
	beq	af_mv12
	bpl	af_mv11
	neg.w	d7
af_mv11:
	add.w	d7,2(a0)
af_mv12:
	lea	m_trees,a3
	clr.w	d7
	move.b	7(a0),d7
	mulu	#10,d7
	adda.l	d7,a3
	clr.w	d7
	move.b	5(a0),d7
	move.b	0(a3,d7.l),d7
	bpl	af_mv06

	clr.b	5(a0)
	move.b	(a3),d7
af_mv06:
	addq.b	#1,5(a0)
	move.b	d7,6(a0)

af_mv08:
	rts






aln_fire:
	cmpi.b	#2,7(a0)		* aliens 1 + 2 shoot
	bgt	aln_firx		* with this code

	tst.b	20(a0)
	bne	aln_firx
	cmpi.w	#40,abm_max
	bge	aln_firx

	lea	plyr_rec,a1
	move.w	2(a1),d1
	sub.w	(a0),d1
	move.w	d1,d3
	bpl	aln_fir1
	neg.w	d1
aln_fir1:
	cmpi.w	#a_rnge,d1
	bgt	aln_firx
	move.w	6(a1),d2
	sub.w	2(a0),d2
	move.w	d2,d4
	bpl	aln_fir2
	neg.w	d2
aln_fir2:
	cmpi.w	#a_rnge,d2
	bgt	aln_firx

	move.l	d3,d6
	bsr	ap_dir
	clr.l	d5
	move.b	4(a0),d5
	subq.b	#1,d5
	lea	af_tab,a1
	cmp.b	0(a1,d5.l),d3
	beq	aln_fir2a
	cmp.b	1(a1,d5.l),d3
	beq	aln_fir2a
	cmp.b	2(a1,d5.l),d3
	bne	aln_firx
aln_fir2a:
	move.l	d6,d3
	addq.w	#1,abm_max
aln_fir3:
	lsr.w	#1,d1
	lsr.w	#1,d2
	cmpi.w	#8,d1
	bgt	aln_fir3
	cmpi.w	#8,d2
	bgt	aln_fir3

	tst.w	d3
	bpl	aln_fir4
	neg.b	d1
aln_fir4:
	tst.w	d4
	bpl	aln_fir5
	neg.b	d2
aln_fir5:
	move.b	d1,22(a0)
	move.b	d2,23(a0)
	move.w	(a0),14(a0)
	move.w	2(a0),16(a0)
	st	18(a0)

	bset	#6,8(a0)
	clr.b	5(a0)
	lea	f_trees,a3
	clr.w	d7
	move.b	7(a0),d7
	mulu	#80,d7
	adda.l	d7,a3
	clr.w	d7
	move.b	4(a0),d7
	subq.b	#1,d7
	mulu	#10,d7
	move.b	0(a3,d7.l),6(a0)
aln_firx:
	rts


aln_hit:
	move.w	d0,-(sp)

	sub.w	(a0),d2
	move.w	d2,d4
	bpl	aln_hit1
	neg.w	d4
aln_hit1:
	cmpi.w	#16,d4
	bgt	aln_hitx
	move	sr,d0
	swap	d0

	sub.w	2(a0),d3
	move.w	d3,d4
	bpl	aln_hit2
	neg.w	d4
aln_hit2:
	cmpi.w	#16,d4
	bgt	aln_hitx
	move	sr,d0

	lea	x_zer,a3
	tst.w	d2
	beq	aln_hit3
	addq.l	#3,a3
	bpl	aln_hit3
	addq.l	#3,a3
aln_hit3:
	lea	y_zer,a4
	tst.w	d3
	beq	aln_hit4
	addq.l	#3,a4
	bpl	aln_hit4
	addq.l	#3,a4
aln_hit4:
	move.b	(a3)+,d3
	cmp.b	(a4),d3
	beq	aln_hit5
	cmp.b	1(a4),d3
	beq	aln_hit5
	cmp.b	2(a4),d3
	bne	aln_hit4
aln_hit5:
	tst.b	d3
	bmi	aln_hitx

	clr.l	d2
	move.b	d3,d2
	st	0(a2,d2.l)
	lea	yt_tab,a3
	tst.w	d0
	beq	aln_hit6
	swap	d0
	tst.w	d0
	bne	aln_hit7		* both < 16 !!
	lea	xt_tab,a3
aln_hit6:
	cmp.b	(a3)+,d3
	bne	aln_hit6
	move.b	(a3),d2
	st	0(a2,d2.l)
	bra	aln_hitx
aln_hit7:
	subq.b	#1,d2
	st	0(a2,d2.l)
	addq.b	#2,d2
	cmpi.b	#8,d2
	blt	aln_hit8
	clr.b	d2
aln_hit8:
	st	0(a2,d2.l)
aln_hitx:
	move.w	(sp)+,d0
	rts


ald_seq:
	lea	d_trees,a3
	clr.l	d7
	move.b	7(a0),d7
	mulu	#10,d7
	adda.l	d7,a3
	move.b	5(a0),d7
	move.b	0(a3,d7.l),d7
	bmi	ald_seq4
	addi.b	#24,d7
	move.b	d7,6(a0)
	addq.b	#1,5(a0)
	bra	ald_seqx
ald_seq4:
	clr.b	5(a0)
	clr.b	6(a0)
	bclr	#7,8(a0)
	moveq	#s_stam,d1
	btst	#5,8(a0)
	beq	ald_seq3
	moveq	#b_stam,d1
ald_seq3:
	move.b	d1,11(a0)

	move.b	13(a0),d1
	subq.b	#1,d1
	lsl.w	#4,d1
	movea.l	sf_tab,a1
	adda.l	d1,a1
ald_seq1:
	move.w	(a1),d1
	sub.w	windxb+2,d1
	bmi	ald_seq5
	cmpi.w	#12,d1
	blt	ald_seq6
ald_seq5:
	move.w	2(a1),d1
	sub.w	windyb+2,d1
	bmi	ald_seq2
	cmpi.w	#11,d1
	bge	ald_seq2
ald_seq6:
	addq.l	#4,a1
	bra	ald_seq1
ald_seq2:
	move.w	(a1),d1
	lsl.w	#4,d1
	move.w	d1,(a0)
	move.w	2(a1),d1
	lsl.w	#4,d1
	move.w	d1,2(a0)
ald_seqx:
	rts
 


mv_mssls:
	bsr	mv_pmsls
	bsr	mv_amsls
	bsr	mv_tmsls
	rts



mv_pmsls:
	lea	plyr_rec,a0
	lea	pms_tab,a1
	moveq	#pms_max-1,d0
mv_pmsl1:
	tst.b	6(a1)
	beq	mv_pmsl2

	bsr	pms_hit
mv_pmsl2:
	adda.l	#pms_rec,a1
	dbra	d0,mv_pmsl1
	rts


pms_hit:
	move.w	(a1),d1
	move.w	2(a1),d2
	bsr	c_zonea
	move.b	d3,5(a1)

	lea	z1a_lst-4,a3
	lea	z1a_cnt-2,a4
	lsl.w	#1,d3
	adda.l	d3,a4
	lsl.w	#1,d3
	adda.l	d3,a3
	move.w	(a4),d3
	movea.l	(a3),a3
	lea	exp_tab-exp_rec,a4
pms_ht0:
	adda.l	#exp_rec,a4
	tst.b	8(a4)
	bne	pms_ht0

	clr.w	4(a4)
	move.b	#2,7(a4)
	move.b	7(a4),6(a4)
	clr.b	9(a4)

	move.w	(a1),d1
	move.w	2(a1),d2
pms_ht1:
	move.w	(a3),d4
	sub.w	d1,d4
	bpl	pms_ht2
	neg.w	d4
pms_ht2:
	cmpi.w	#8,d4
	bgt	pms_ht5
	move.w	2(a3),d4
	sub.w	d2,d4
	bpl	pms_ht4
	neg.w	d4
pms_ht4:
	cmpi.w	#8,d4
	ble	pms_ht6
pms_ht5:
	move.w	zone,d4
	cmp.b	13(a3),d4
	bne	pms_ht5d
	tst.b	20(a3)
	beq	pms_ht5d

	move.w	14(a3),d4
	sub.w	d1,d4
	bpl	pms_ht5a
	neg.w	d4
pms_ht5a:
	cmpi.w	#4,d4
	bgt	pms_ht5d
	move.w	16(a3),d4
	sub.w	d2,d4
	bpl	pms_ht5b
	neg.w	d4
pms_ht5b:
	cmpi.w	#4,d4
	bgt	pms_ht5d

	bset	#0,8(a4)
	clr.b	20(a3)
	clr.b	6(a1)
	move.w	(a1),(a4)
	move.w	2(a1),2(a4)
	bset	#1,c_flag3
	subq.b	#1,22(a0)
	subq.w	#1,abm_max
	rts

pms_ht5d:
	adda.l	#aln_rec,a3
	dbra	d3,pms_ht1
	bra	pms_ht10

pms_ht6:
	clr.b	6(a1)
	move.w	(a1),(a4)
	move.w	2(a1),2(a4)
	bset	#2,c_flag3
	bset	#0,8(a4)
	subq.b	#1,22(a0)

	tst.b	11(a3)
	bmi	pms_ht7

	sub.b	#2,11(a3)
	bpl	pms_ht7
	bset	#7,8(a3)
	clr.b	5(a3)
	move.b	10(a3),9(a3)
	bset	#7,c_flag2
pms_ht7:
	rts


pms_ht10:
	lea	obj_tab,a3
	moveq	#obj_cnt-1,d3
	move.w	level,d4
pms_ht11:
	cmp.b	4(a3),d4
	bne	pms_ht15

	move.w	(a3),d5
	sub.w	d1,d5
	bpl	pms_ht12
	neg.w	d5
	cmpi.w	#12,d5
	bgt	pms_ht15
	bra	pms_ht13
pms_ht12:
	cmpi.w	#4,d5
	bgt	pms_ht15
pms_ht13:
	move.w	2(a3),d5
	sub.w	d2,d5
	bpl	pms_ht14
	neg.w	d5
	cmpi.w	#4,d5
	bgt	pms_ht15
	bra	pms_ht16
pms_ht14:
	cmpi.w	#12,d5
	ble	pms_ht16
pms_ht15:
	adda.l	#obj_rec,a3
	dbra	d3,pms_ht11
	bra	pms_ht20

pms_ht16:
	clr.b	6(a1)
	bset	#7,6(a3)
	move.w	(a3),(a4)
	move.w	2(a3),2(a4)
	bset	#0,8(a4)
	bset	#0,c_flag3
	subq.b	#1,22(a0)
	rts


pms_ht20:
	move.w	d1,d3
	move.w	d2,d4
	lsr.w	#4,d3
	lsr.w	#4,d4
	mulu	#bmapw,d4
	add.w	d3,d4
	movea.l	bmap,a3
	adda.l	d4,a3
	move.w	max_flr,d4

	cmp.b	(a3),d4
	blt	pms_ht22
	move.w	d1,d3
	andi.w	#15,d3
	beq	pms_ht21
	cmp.b	1(a3),d4
	ble	pms_ht22
pms_ht21:
	subq.b	#1,6(a1)
	beq	pms_ht22

	clr.l	d4
	move.b	8(a1),d4
	lsl.w	#2,d4
	lea	ms_add-4,a3
	add.w	0(a3,d4.l),d1
	add.w	2(a3,d4.l),d2
	move.w	d1,(a1)
	move.w	d2,2(a1)

	lea	m_trees+110,a3
	move.b	4(a1),d4
	move.b	0(a3,d4.l),d4
	bpl	pms_ht23
	clr.b	4(a1)
	move.b	(a3),d4
pms_ht23:
	addq.b	#1,4(a1)
	move.b	d4,10(a1)
	rts

pms_ht22:
	bset	#0,8(a4)
	clr.b	6(a1)
	move.w	(a1),(a4)
	move.w	2(a1),2(a4)
	bset	#3,c_flag3
	subq.b	#1,22(a0)
	rts


mv_amsls:
	movea.l	z1a_lst,a0
	move.w	aln_tot,d0
	subq.w	#1,d0
	lea	plyr_rec,a1
mv_amsl1:
	tst.b	20(a0)
	beq	mv_amsl8

	lea	exp_tab-exp_rec,a4
mv_amsl2:
	adda.l	#exp_rec,a4
	tst.b	8(a4)
	bne	mv_amsl2

	clr.w	4(a4)
	move.b	#2,7(a4)
	move.b	7(a4),6(a4)
	move.b	7(a0),9(a4)

	move.w	2(a1),d1
	sub.w	14(a0),d1
	bpl	mv_amsl3
	neg.w	d1
mv_amsl3:
	cmpi.w	#8,d1
	bge	mv_amsl5
	move.w	6(a1),d1
	sub.w	16(a0),d1
	bpl	mv_amsl4
	neg.w	d1
mv_amsl4:
	cmpi.w	#8,d1
	bge	mv_amsl5

	subq.w	#1,abm_max
	clr.b	20(a0)
	bset	#0,8(a4)
	bset	#5,c_flag1
	move.w	2(a1),(a4)
	move.w	6(a1),2(a4)

	subq.w	#1,suit
	bpl	mv_amsl8

* player death explosion
	move.w	#1440,suit
	bra	mv_amsl8

mv_amsl5:
	subq.b	#1,20(a0)
	beq	mv_amsl7

	clr.w	d1
	move.b	22(a0),d1
	ext.w	d1
	add.w	d1,14(a0)
	clr.w	d1
	move.b	23(a0),d1
	ext.w	d1
	add.w	d1,16(a0)

	lea	m_trees+110,a3
	clr.w	d1
	move.b	7(a0),d1
	mulu	#10,d1
	adda.l	d1,a3
	clr.l	d1
	addq.b	#1,18(a0)
	move.b	18(a0),d1
	move.b	0(a3,d1.l),d1
	bpl	mv_amsl6

	clr.b	18(a0)
	move.b	(a3),d1
mv_amsl6:
	move.b	d1,19(a0)
	bra	mv_amsl8

mv_amsl7:
	subq.w	#1,abm_max
	bset	#0,8(a4)
	move.w	14(a0),(a4)
	move.w	16(a0),2(a4)

mv_amsl8:
	adda.l	#aln_rec,a0
	dbra	d0,mv_amsl1
	rts


mv_tmsls:
	rts



mv_xplns:
	moveq	#exp_rec,d1
	move.w	#exp_max-1,d0
	lea	exp_tab,a2
mv_xpln1:
	tst.b	8(a2)
	beq	mv_xpln2

	lea	m_trees,a3
	clr.w	d7
	move.b	9(a2),d7
	addi.b	#18,d7
	mulu	#10,d7
	adda.l	d7,a3

	clr.w	d7
	move.b	4(a2),d7
	move.b	0(a3,d7.l),d7
	bmi	mv_xpln3
	addq.b	#1,4(a2)
	move.b	d7,5(a2)
	bra	mv_xpln2
mv_xpln3:
	clr.b	8(a2)
mv_xpln2:
	adda.l	d1,a2
	dbra	d0,mv_xpln1
	rts




