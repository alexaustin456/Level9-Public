echo "Batch file to compile Scapeghost part 1!"

cd c:\ghost.l9\part1.l9
comp.prg
copy main.l9\gamedata.dat c:\ghost.l9\ghost.l9\gamedat1.dat
copy main.l9\gamedata.dat main.l9\gamedat1.dat

cd c:\ghost.l9