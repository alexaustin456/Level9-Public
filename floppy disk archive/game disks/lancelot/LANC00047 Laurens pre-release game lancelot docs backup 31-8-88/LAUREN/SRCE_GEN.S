
************** set up prog start **************


main:
	clr.l	-(sp)		* supervisor mode
	move.w	#$20,-(sp)
	trap	#1
	addq.l	#6,sp

	clr.w	-(sp)		* set low res
	move.l	#-1,-(sp)
	move.l	#-1,-(sp)
	move.w	#5,-(sp)
	trap	#14
	adda.l	#12,sp

	move.w	#2,-(sp)		* set screen pointers
	trap	#14
	addq.l	#2,sp
	move.l	d0,p_scrn
	subi.l	#$8000,d0
	move.l	d0,l_scrn

	move.w	#34,-(sp)		* set joystick vector
	trap	#14
	addq.l	#2,sp
	move.l	d0,a0
	move.l	#do_joy,24(a0)

	pea	j_init		* set joystick mode
	move.w	#1,-(sp)
	move.w	#25,-(sp)
	trap	#14
	addq.l	#8,sp

	movea.l	l_scrn,sp		* set game stack
	subq.l	#2,sp
	move.l	sp,hold_sp

	bsr	clr_both
	bsr	rd_files
	bsr	new_map
	bset	#0,s_flag1



********** main control loop **********


main1:
	bsr	draw_pic		* draw picture
	bsr	rest_pic		* stabilize it
	bsr	move_pic		* move picture
	bsr	do_sounds		* kick sound queue
	bsr	gm_mast		* game master code
	bra	main1		* loop



********* support routines ************



delay:
	move.w	#$2000,d0
dlay1:
	nop
	dbra	d0,dlay1
	rts



new_map:
	lea	d_area+char_len+28,a0
	lea	d_area,a1

	move.w	level,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	ext.l	d0
	move.l	0(a0,d0.l),d0
	adda.l	d0,a0		* reqd map start

	move.w	(a0)+,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	ext.l	d0
	move.l	0(a1,d0.l),d0
	adda.l	d0,a1
	move.w	(a1)+,max_flr	* max floor code
	addq.w	#1,max_flr
	move.l	a1,b_chars	* reqd char set

	bsr	set_alns
	move.l	a0,sf_tab
	adda.l	#96,a0
	move.l	a0,palet
	adda.l	#32,a0
	move.l	a0,bmap
	bsr	set_wind
	bsr	calc_zone
	move.w	d3,zone
	move.w	#120,aln_tot

	clr.l	d0
	move.w	level,d0
	lea	fl_tab,a0
	lsl.w	#2,d0
	move.l	0(a0,d0.l),flick

	move.l	palet,-(sp)
	move.w	#6,-(sp)
	trap	#14
	addq.l	#6,sp
	rts




do_sounds:
	rts


w_cords:
	move.l	windx,d1
	move.l	windy,d2
	move.w	d1,d3
	move.w	d2,d4
	lsl.w	#1,d3
	neg.w	d3
	add.w	2(a0),d3
	neg.w	d4
	add.w	6(a0),d4

	cmpi.w	#48,d3
	bgt	w_cord1
	cmpi.w	#wxmin,d1
	ble	w_cord2
	subq.w	#2,d1
	bra	w_cord2
w_cord1:
	cmpi.w	#144,d3
	blt	w_cord2
	cmpi.w	#wxmax,d1
	bge	w_cord2
	addq.w	#2,d1
w_cord2:
	cmpi.w	#48,d4
	bgt	w_cord3
	cmpi.w	#wymin,d2
	ble	w_cord4
	subq.w	#4,d2
	bra	w_cord4
w_cord3:
	cmpi.w	#128,d4
	blt	w_cord4
	cmpi.w	#wymax,d2
	bge	w_cord4
	addq.w	#4,d2
w_cord4:
	move.l	d2,windy
	move.w	d2,d0
	lsr.w	#4,d2
	move.l	d2,windyb
	andi.w	#15,d0
	move.w	d0,vshft
w_cord5:
	move.l	d1,windx
	move.w	d1,d0
	lsr.w	#3,d1
	move.l	d1,windxb
	andi.w	#7,d0
	move.w	d0,hshft
	rts



rest_pic:
	move.w	hshft,d0		* if h-shift = 0
	beq	rest_pcx		* exit
	move.b	old_dir,d0	* previous dir
	andi.b	#12,d0		* only left - right values
	beq	rest_pcx		* exit if no l - r bits
	move.b	new_dir,d2	* current dir
	andi.b	#12,d2		* left - right only
	eor.b	d0,d2		* change in base dir ?
	beq	rest_pcx		* exit if not
	cmpi.b	#8,d0		* move window right ?
	bne	rest_pcl		* left if not
rest_pcr:
	move.l	windx,d1
	addq.l	#2,d1		* move window right
	bsr	w_cord5
	bsr	draw_pic
	bsr	delay
	move.w	hshft,d0
	bne	rest_pcr
	bra	rest_pcx
rest_pcl:
	move.l	windx,d1
	subq.l	#2,d1		* move window left
	bsr	w_cord5
	bsr	draw_pic
	bsr	delay
	move.w	hshft,d0
	bne	rest_pcl
rest_pcx:
	rts

	
find_obj:
	lea	obj_tab-obj_rec,a2
find_ob1:
	adda.l	#obj_rec,a2
	cmp.b	8(a2),d5
	bne	find_ob1
	rts


do_joy:
	move.b	(a0)+,j_buff
	move.b	(a0)+,j_buff+1
	move.b	(a0)+,j_buff+2
	rts


flip_scrn:
	move.w	#-1,-(sp)		* same res
	move.l	l_scrn,-(sp)	* new phys
	move.l	p_scrn,-(sp)	* new log
	move.w	#5,-(sp)
	trap	#14
	move.l	2(sp),l_scrn	* new log pointer
	move.l	6(sp),p_scrn	* new phys pointer
	adda.l	#12,sp
	rts



rd_files:
	lea	b_file,a2
	lea	d_area+16,a3
	bsr	rd_file
	lea	m_file,a2
	lea	d_area+char_len,a3
	bsr	rd_file
	lea	s_file,a2
	lea	d_area+char_len+map_len,a3
	bsr	rd_file

	lea	d_area,a0
	lea	d_area+16,a1
	moveq	#3,d0
rd_fls1:
	move.w	(a1)+,d1
	movea.l	a1,a2
	suba.l	#d_area,a2
	move.l	a2,(a0)+
	mulu	#128,d1
	addq.l	#2,d1
	adda.l	d1,a1
	dbra	d0,rd_fls1
	rts

rd_file:
	clr.w	-(sp)
	move.l	a2,-(sp)
	move.w	#$3D,-(sp)
	trap	#1
	addq.l	#8,sp
	tst.l	d0
	bmi	op_err
	move.w	d0,handle

	move.l	a3,-(sp)
	move.l	#100000,-(sp)
	move.w	handle,-(sp)
	move.w	#$3F,-(sp)
	trap	#1
	adda.l	#12,sp
	tst.l	d0
	bmi	rd_err

	move.w	handle,-(sp)
	move.w	#$3E,-(sp)
	trap	#1
	addq.l	#4,sp
	rts

op_err:
	pea	op_mess
	bra	rd_file1
rd_err:
	pea	rd_mess
rd_file1:
	move.w	#9,-(sp)
	trap	#1
	addq.l	#6,sp
rd_file2:
	nop
	bra	rd_file2




set_alns:
	lea	r_area,a2
	movea.l	a2,a1
	move.w	#874,d0
set_aln1:
	clr.l	(a1)+
	dbra	d0,set_aln1

	moveq	#5,d7
	move.w	#1,zone
	move.w	#16,aln_flg

	lea	step_tab,a1
	lea	z1a_cnt,a4
	lea	z1a_lst,a3

set_aln2:
	moveq	#19,d6
	move.l	a2,(a3)+
	move.w	d6,(a4)+

set_aln3:
	clr.l	d0
	move.b	(a0)+,d0
	lsl.w	#4,d0
	move.w	d0,(a2)
	clr.w	d0
	move.b	(a0)+,d0
	lsl.w	#4,d0
	move.w	d0,2(a2)
	clr.l	d0
	move.b	(a0)+,d0
	move.b	d0,7(a2)

	move.b	11(a1,d0.l),8(a2)
	bne	set_aln4

	move.b	#s_stam,11(a2)
	move.b	#s_miss,21(a2)
	bra	set_aln5
set_aln4:
	move.b	#b_stam,11(a2)
	move.b	#b_miss,21(a2)
set_aln5:
	move.b	zone+1,13(a2)
	move.b	0(a1,d0.l),24(a2)
	move.b	#1,12(a2)
*	move.w	aln_flg,d0
*	or.b	d0,8(a2)
*	eori.w	#16,aln_flg

	move.b	v_low,d0
	andi.b	#7,d0
	addq.b	#1,d0
	move.b	d0,4(a2)

	adda.l	#aln_rec,a2
	dbra	d6,set_aln3

	addq.w	#1,zone
	dbra	d7,set_aln2
	rts


set_wind:
	lea	plyr_rec,a3
	move.w	level,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	add.w	lift,d0
	subq.w	#1,d0
	mulu	#lft_rec,d0
	lea	lft_tab,a0
	adda.l	d0,a0

	move.b	7(a0),8(a3)
	move.b	#1,9(a3)
	move.b	#1,10(a3)

	move.w	(a0),2(a3)
	addq.w	#8,2(a3)

	clr.l	d0
	move.w	(a0),d0
	lsr.w	#1,d0
	andi.w	#$FFF8,d0
	subi.w	#48,d0
	cmpi.w	#wxmin,d0
	bge	set_wnd1
	move.w	#wxmin,d0
	bra	set_wnd2
set_wnd1:
	cmpi.w	#wxmax,d0
	ble	set_wnd2
	move.w	#wxmax,d0
set_wnd2:
	move.l	d0,windx
	lsr.w	#3,d0
	move.l	d0,windxb
	clr.w	hshft
	
	move.w	2(a0),6(a3)
	addq.w	#4,6(a3)

	clr.l	d0
	move.w	2(a0),d0
	andi.w	#$FFF0,d0
	subi.w	#80,d0
	cmpi.w	#wymin,d0
	bge	set_wnd3
	move.w	#wymin,d0
	bra	set_wnd4
set_wnd3:
	cmpi.w	#wymax,d0
	ble	set_wnd4
	move.w	#wymax,d0
set_wnd4:
	move.l	d0,windy
	lsr.w	#4,d0
	move.l	d0,windyb
	clr.w	vshft
	rts



