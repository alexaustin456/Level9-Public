echo "Batch file to compile spectrum S128 tape"

cd \games.l9\lancelt1.l9\
rm main.l9\gamedat*.dat
copy mconsts1.txt mconst.txt

echo "Compile part 1. "
copy a:\s1.l9\lancelt1.l9\squash.dat main.l9\squash.dat
comp

echo "Compile part 2. "
cd \games.l9\lancelt2.l9
copy \games.l9\lancelt1.l9\table.dat \games.l9\lancelt2.l9\
copy \games.l9\lancelt1.l9\exit.txt \games.l9\lancelt2.l9\
copy a:\s1.l9\lancelt2.l9\squash.dat main.l9\squash.dat
comp

echo "Compile part 3. "
cd \games.l9\lancelt3.l9
copy a:\s1.l9\lancelt3.l9\squash.dat main.l9\squash.dat
comp

echo "Finish part 1. "
cd \games.l9\lancelt1.l9
copy acode.acd a:\s1.l9\lancelt1.l9\acode1.acd
copy main.l9\gamedata.dat a:\s1.l9\lancelt1.l9\gamedat1.dat
copy \games.l9\acode.sml acode.acd
finish
copy main.l9\gamedata.dat a:\s1.l9\lancelt1.l9\smallgd1.dat

echo "Finish part 2. "
cd \games.l9\lancelt2.l9
copy acode.acd a:\s1.l9\lancelt2.l9\acode2.acd
copy main.l9\gamedata.dat a:\s1.l9\lancelt2.l9\gamedat2.dat
copy \games.l9\acode.sml acode.acd
finish
copy main.l9\gamedata.dat a:\s1.l9\lancelt2.l9\smallgd2.dat

echo "Finish part 3. "
cd \games.l9\lancelt3.l9
copy acode.acd a:\s1.l9\lancelt3.l9\acode3.acd
copy main.l9\gamedata.dat a:\s1.l9\lancelt3.l9\gamedat3.dat
copy \games.l9\acode.sml acode.acd
finish
copy main.l9\gamedata.dat a:\s1.l9\lancelt3.l9\smallgd3.dat

cd \games.l9\lancelt2.l9
rm table.dat
rm exit.txt
home
