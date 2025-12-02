

*******		Data area		*******
***********************************************

	even

windx:	dc.l	0		* bmap wind xcord - pixels
windy:	dc.l	0		* ycord
windxb:	dc.l	0		* xcord
windyb:	dc.l	0		* bmap wind ycord - bytes
vshft:	dc.w	0		* vertical shift counter
hshft:	dc.w	0		* horizontal shift counter

img_num:	dc.w	0		* drw_obj image no.
img_len:	dc.w	0		* drw_obj image len.
icn_cnt:	dc.w	2		* no. times to draw icons

s_flag1:	dc.w	0		* system flags

l_pass1:	dc.b	1		* lift pass
l_pass2:	dc.b	1		* carried
l_pass3:	dc.b	1		* flags
l_pass4:	dc.b	1		*
l_dir:	dc.w	-1		* last lift dir
l_cycle:	dc.w	0		* lifts image cycle
l_dlay:	dc.w	2		* lifts cycle delay

c_flag1:	dc.b	0		* sound flag1
c_flag2:	dc.b	0		* sound flag2
c_flag3:	dc.b	0		* sound flag3
c_flag4:	dc.b	0		* sound flag4 - unused

mv_flag:	dc.w	0		* alien motion flag

flick:	dc.l	0		* flick list pointer
l_save:	dc.l	lft_tab		* save lift record
level:	dc.w	1		* res level no.
lift:	dc.w	1		* res lift no.
zone:	dc.w	0		* active zone no.
max_flr:	dc.w	0		* max floor tile value

aln_tot:	dc.w	0		* total no. aliens / level
abm_max:	dc.w	0		* max alien missiles

a_list:	dc.l	0		* zone start pointer
a_cnt:	dc.w	0		* zone alien counter
d_flags:	dc.l	0,0		* alien motion flags

z1a_cnt:	dc.w	0
z2a_cnt:	dc.w	0
z3a_cnt:	dc.w	0
z4a_cnt:	dc.w	0
z5a_cnt:	dc.w	0
z6a_cnt:	dc.w	0

z1a_lst:	dc.l	0
z2a_lst:	dc.l	0
z3a_lst:	dc.l	0
z4a_lst:	dc.l	0
z5a_lst:	dc.l	0
z6a_lst:	dc.l	0

b_chars:	dc.l	0		* b char pointer
sf_tab:	dc.l	0		* safe tile table
palet:	dc.l	0		* palette pointer
bmap:	dc.l	0		* bmap pointer

handle:	dc.w	0		* file handle

old_x:	dc.w	0
old_y:	dc.w	0


l_scrn:	dc.l	0		* logical screen start
p_scrn:	dc.l	0		* physical screen start
hold_sp:	dc.l	0		* stack save

aln_flg:	dc.w	0

old_dir:	dc.b	0		* old player dir - sys
new_dir:	dc.b	0		* init new player dir - sys

j_init:	dc.b	$12,$14		* joystick mode
j_buff:	dc.b	0,0,0,0		* joystick data buffer

	even

air01:	dc.w	192		* air tanks
air02:	dc.w	192		* levels
air03:	dc.w	192		*
air04:	dc.w	192		*
mag_cnt:	dc.w	188		* mag level

air_cnt:	dc.w	50		* air frames counter
air_num:	dc.w	0		* current air tank
suit:	dc.w	1440		* suit damage level
shot_cnt:	dc.w	2		* shots / unit
spr_mags:	dc.w	12		* spare mags
frames:	dc.l	0		* frames counter


b_file:
	dc.b	'bchars.dat',0
m_file:
	dc.b	'maps.dat',0
s_file:
	dc.b	's_data.dat',0

op_mess:
	dc.b	27,'E','Cannot open file.',0
rd_mess:
	dc.b	27,'E','Cannot read file.',0





