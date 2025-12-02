echo "Batch file to compile spectrum S128 tape!"

cd c:\ghost.l9\part1.l9
copy mconsts1.txt mconst.txt

echo "Compile part 1!"
copy b:\s1.l9\part1.l9\squash.dat main.l9\squash.dat
comp.prg
copy main.l9\gamedata.dat c:\ghost.l9\ghost.l9\gamedat1.dat

echo "Finish part 1!"
copy acode.acd c:\ghost.l9\ghost.l9\acode1.acd
copy c:\ghost.l9\acode.sml acode.acd
finish.prg
copy main.l9\gamedata.dat c:\ghost.l9\ghost.l9\smallgd1.dat

echo "Compile part 2!"
cd c:\ghost.l9\part2.l9
copy b:\s1.l9\part2.l9\squash.dat main.l9\squash.dat
comp.prg
copy main.l9\gamedata.dat c:\ghost.l9\ghost.l9\gamedat2.dat

echo "Finish part 2!"
copy acode.acd c:\ghost.l9\ghost.l9\acode2.acd
copy c:\ghost.l9\acode.sml acode.acd
finish.prg
copy main.l9\gamedata.dat c:\ghost.l9\ghost.l9\smallgd2.dat

echo "Compile part 3!"
cd c:\ghost.l9\part3.l9
copy b:\s1.l9\part3.l9\squash.dat main.l9\squash.dat
comp.prg
copy main.l9\gamedata.dat c:\ghost.l9\ghost.l9\gamedat3.dat

echo "Finish part 3!"
copy acode.acd c:\ghost.l9\ghost.l9\acode3.acd
copy c:\ghost.l9\acode.sml acode.acd
finish.prg
copy main.l9\gamedata.dat c:\ghost.l9\ghost.l9\smallgd3.dat

echo "Copy files to floppy!"
cd c:\ghost.l9\ghost.l9
copy gamedat1.dat b:\s1.l9\ghost.l9\gamedat1.dat
copy gamedat2.dat b:\s1.l9\ghost.l9\gamedat2.dat
copy gamedat3.dat b:\s1.l9\ghost.l9\gamedat3.dat
copy acode1.acd b:\s1.l9\ghost.l9\acode1.acd
copy acode2.acd b:\s1.l9\ghost.l9\acode2.acd
copy acode3.acd b:\s1.l9\ghost.l9\acode3.acd
copy smallgd1.dat b:\s1.l9\ghost.l9\smallgd1.dat
copy smallgd2.dat b:\s1.l9\ghost.l9\smallgd2.dat
copy smallgd3.dat b:\s1.l9\ghost.l9\smallgd3.dat

cd c:\ghost.l9
