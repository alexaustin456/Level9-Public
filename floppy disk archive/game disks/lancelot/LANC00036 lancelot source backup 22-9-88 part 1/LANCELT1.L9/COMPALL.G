cd \games.l9\lancelt1.l9\
rm main.l9\gamedat*.dat
comp
ren main.l9\gamedata.dat main.l9\gamedat1.dat

echo "Compile part 2. "
cd \games.l9\lancelt2.l9
copy \games.l9\lancelt1.l9\table.dat \games.l9\lancelt2.l9\
copy \games.l9\lancelt1.l9\exit.txt \games.l9\lancelt2.l9\
comp
copy main.l9\gamedata.dat \games.l9\lancelt1.l9\main.l9\gamedat2.dat
rm table.dat
rm exit.txt
cd \games.l9\lancelt1.l9
echo "Compile part 3. "
cd \games.l9\lancelt3.l9
comp
copy main.l9\gamedata.dat \games.l9\lancelt1.l9\main.l9\gamedat3.dat
cd \games.l9\lancelt1.l9
dir main.l9\gamedat*.dat
if -e main.l9\gamedat1.dat
 ef echo "We have a problem"
if -e main.l9\gamedat2.dat
 ef echo "We have a problem"
if -e main.l9\gamedat3.dat
 ef echo "We have a problem"
