echo "Batch file to compile Scapeghost!"

echo "Compile part 1!"
cd c:\ghost.l9\part1.l9
comp.prg
copy main.l9\gamedata.dat c:\ghost.l9\ghost.l9\gamedat1.dat

echo "Compile part 2!"
cd c:\ghost.l9\part2.l9
comp.prg
copy main.l9\gamedata.dat c:\ghost.l9\ghost.l9\gamedat2.dat

echo "Compile part 3!"
cd c:\ghost.l9\part3.l9
comp.prg
copy main.l9\gamedata.dat c:\ghost.l9\ghost.l9\gamedat3.dat

cd c:\ghost.l9