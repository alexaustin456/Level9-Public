
	even

plyr_rec:
	dc.l	0,0
	dc.b	1,0,0,0
	dc.w	200
	dc.b	0,0,0,0,0,0,0,200,0,$FF


	even

obj_tab:
	dc.w	1

	dc.w	64,64
	dc.b	2,1,0,100,1,$FF


lft_tab:
	dc.w	240,32		* level 1
	dc.b	1,1,$FF,1,2,3
	dc.w	848,32
	dc.b	1,3,$FF,1,2,4
	dc.w	1024,1008
	dc.b	1,6,$FF,5,3,1
	dc.w	64,608
	dc.b	1,4,$FF,1,3,3

	dc.w	256,48		* level 2
	dc.b	1,1,$FF,1,1,4
	dc.w	832,32
	dc.b	1,3,$FF,1,3,4
	dc.w	1072,944
	dc.b	1,6,$FF,5,2,4
	dc.w	256,992
	dc.b	1,4,$FF,5,1,1

	dc.w	512,32		* level 3
	dc.b	1,2,$FF,1,3,2
	dc.w	912,32
	dc.b	1,3,$FF,1,2,1
	dc.w	928,1008
	dc.b	1,6,$FF,5,2,2
	dc.w	496,992
	dc.b	1,5,$FF,5,1,3




	even

*			player missile records
pms_tab:
	dc.w	0,0
	dc.b	0,0,0,0,1,12,0,0
	dc.w	0,0
	dc.b	0,0,0,0,1,12,0,0
	dc.w	0,0
	dc.b	0,0,0,0,1,12,0,0
	dc.w	0,0
	dc.b	0,0,0,0,1,12,0,0


*			explosion records
exp_tab:
	ds.b	2000


