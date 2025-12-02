echo "Batch file to compile part 3 of Gnome Ranger for the Amstrad. "

copy mconstad.txt mconst.txt
copy b:\ad.l9\squash.dat main.l9\
\comp
copy main.l9\gamedata.dat b:\ad.l9\gamedat3.dat
copy acode.acd b:\ad.l9\acode3.acd
copy acode.sml acode.acd
\finish
copy main.l9\gamedata.dat b:\ad.l9\smallgd3.dat
