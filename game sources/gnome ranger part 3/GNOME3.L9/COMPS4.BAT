echo "Batch file to compile all parts of Gnome Ranger for Spectrum 48 Tape"

cd \games.l9\gnome3.l9\
copy mconsts4.txt mconst.txt

echo "compiling part 1. "
cd \games.l9\gnome1.l9\
\comp
copy s48.l9\gamedata.dat \games.l9\gnome3.l9\s48.l9\gamedat1.dat

echo "compiling part 2. "
cd \games.l9\gnome2.l9\
\comp
copy s48.l9\gamedata.dat \games.l9\gnome3.l9\s48.l9\gamedat2.dat

echo "compiling part 3. "
cd \games.l9\gnome3.l9\
\comp
copy s48.l9\gamedata.dat s48.l9\gamedat3.dat

