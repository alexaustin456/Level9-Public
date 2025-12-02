cd \Ingrid.l9\Ingrid1.l9\
rm main.l9\gamedat*.dat
comp
ren main.l9\gamedata.dat main.l9\gamedat1.dat

echo "Compile part 2. "
cd \Ingrid.l9\Ingrid2.l9 
comp
copy main.l9\gamedata.dat \Ingrid.l9\Ingrid1.l9\main.l9\gamedat2.dat
cd \Ingrid.l9\Ingrid1.l9

echo "Compile part 3. "
cd \Ingrid.l9\Ingrid3.l9
comp
copy main.l9\gamedata.dat \Ingrid.l9\Ingrid1.l9\main.l9\gamedat3.dat
cd \Ingrid.l9\Ingrid1.l9

dir main.l9\gamedat*.dat
if -e main.l9\gamedat1.dat
 ef echo "We have a problem"
if -e main.l9\gamedat2.dat
 ef echo "We have a problem"
if -e main.l9\gamedat3.dat
 ef echo "We have a problem"
