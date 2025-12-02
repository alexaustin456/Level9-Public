

*******		Data Tables	*******
***********************************************

	even

dir_tab:	dc.b	0,5,1,0,7,6,8,0,3,4,2

	even

x_zer:	dc.b	0,4,$FF,1,2,3,5,6,7
y_zer:	dc.b	2,6,$FF,0,1,7,3,4,5

	even
* alien collision tables

yt_tab:	dc.b	5,6,7,7,3,2,1,1
xt_tab:	dc.b	5,4,3,3,7,0,1,1

	even
* alien move flags test sequences

ts_tab:	dc.b	$FF,$FF,$FF
	dc.b	0,$FF,$FF
	dc.b	0,1,2
	dc.b	2,$FF,$FF
	dc.b	2,3,4
	dc.b	4,$FF,$FF
	dc.b	4,5,6
	dc.b	6,$FF,$FF
	dc.b	6,7,0

	even
* motion add tables

add_tab:	dc.w	0,4,4,4,4,0,4,-4
	dc.w	0,-4,-4,-4,-4,0,-4,4

ms_add:	dc.w	0,8,8,8,8,0,8,-8
	dc.w	0,-8,-8,-8,-8,0,-8,8

	even
* alien firing direction test table

af_tab:
	dc.b	8,1,2,3,4,5,6,7,8,1

	even
* alien motion steps and size flag values

step_tab:
	dc.b	$FF,1,2,4,2,0,0,0,0,0,0
	dc.b	$FF,0,0,32,0,0,0,0,0,0,0

	even

lft_offs:
	dc.w	159,197,4600,2740
	dc.w	232,196,4315,4480
	dc.w	176,201,4594,4495

	even

lft_lst:
	dc.b	0,1,2,3,4,5,6,7,8,9,10,11

	even

icon_offs:
	dc.l	2680,9080,14200,19336,19344,25720,-1
info_offs:
	dc.l	2688,3968,5248,6528,14208
	dc.l	9088,15488
	dc.l	19320,20617
	dc.l	25728,25736,25744,28288,28296,28304


	even
* alien records area

r_area:	ds.b	3500







