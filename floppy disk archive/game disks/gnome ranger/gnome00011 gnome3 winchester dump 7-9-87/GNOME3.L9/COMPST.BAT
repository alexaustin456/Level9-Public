echo "Batch file to compile all parts of Gnome Ranger for ST/IBM"

echo "compiling part 1. "
cd \games.l9\gnome1.l9\
copy mconst16.txt mconst.txt
\comp
copy st.l9\gamedata.dat \games.l9\gnome3.l9\st.l9\gamedat1.dat

echo "compiling part 2. "
cd \games.l9\gnome2.l9\
\comp
copy st.l9\gamedata.dat \games.l9\gnome3.l9\st.l9\gamedat2.dat

echo "compiling part 3. "
cd \games.l9\gnome3.l9\
\comp
copy st.l9\gamedata.dat st.l9\gamedat3.dat
