

char_len:	equ	15000		* b_cahrs file len
map_len:	equ	20000		* maps file len


v_low:	equ	$FF8209
v_mid:	equ	$FF8207
f_add:	equ	28		* file pointer offset

aln_rec:	equ	26		* alien reclen
obj_rec:	equ	10		* object reclen
lft_rec:	equ	10		* lift reclen
pms_rec:	equ	12		* player missile rec len
exp_rec:	equ	10		* explosion rec len

obj_cnt:	equ	2		* no. objects
pms_max:	equ	4		* max no. player missiles
exp_max:	equ	200		* no. explosion recs

bmapw:	equ	72		* byte map width
bmaph:	equ	66		* byte map height
lwindw:	equ	12		* log window width - bytes
lwindh:	equ	11		* logical window height
pwindw:	equ	12		* phys window width - words
pwindh:	equ	11		* physical window height

wxmin:	equ	8		* min xcord window - pixels
wxmax:	equ	480		* max xcord
wymax:	equ	880		* max ycord
wymin:	equ	16		* min ycord


*** collision detection values ***


pim_len:	equ	352		* player image length


s_stam:	equ	2		* small alien stamina
b_stam:	equ	4		* big alien stamina
s_miss:	equ	8		* small alien missile range
b_miss:	equ	12		* big alien missile range

a_rnge:	equ	70		* abm launch range




