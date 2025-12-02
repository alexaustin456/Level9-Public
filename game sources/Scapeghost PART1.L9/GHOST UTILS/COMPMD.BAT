echo "Batch file to compile for Macintosh Disc!"

cd c:\ghost.l9
copy part1.l9\mconstmd.txt part1.l9\mconst.txt
copy b:\md.l9\part1.l9\squash.dat part1.l9\main.l9\squash.dat 
copy b:\md.l9\part2.l9\squash.dat part2.l9\main.l9\squash.dat 
copy b:\md.l9\part3.l9\squash.dat part3.l9\main.l9\squash.dat 

echo "Compile part 1!"
cd \ghost.l9\Part1.l9\
comp.prg
copy main.l9\gamedata.dat \ghost.l9\ghost.l9\gamedat1.dat

echo "Compile part 2!"
cd \ghost.l9\Part2.l9\
comp.prg
copy main.l9\gamedata.dat \ghost.l9\ghost.l9\gamedat2.dat

echo "Compile part 3!"
cd \ghost.l9\Part3.l9\
comp.prg
copy main.l9\gamedata.dat \ghost.l9\ghost.l9\gamedat3.dat
cd \ghost.l9

echo "Copy data to floppy disk!" 
copy ghost.l9\gamedat1.dat b:\md.l9\ghost.l9\gamedat1.dat
copy ghost.l9\gamedat2.dat b:\md.l9\ghost.l9\gamedat2.dat
copy ghost.l9\gamedat3.dat b:\md.l9\ghost.l9\gamedat3.dat
