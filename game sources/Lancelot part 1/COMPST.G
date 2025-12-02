echo "Batch file to compile for Spectrum 48 Tape"

copy mconstst.txt mconst.txt
copy a:\st.l9\lancelt1.l9\squash.dat main.l9\
copy a:\st.l9\lancelt2.l9\squash.dat \games.l9\lancelt2.l9\main.l9\
copy a:\st.l9\lancelt3.l9\squash.dat \games.l9\lancelt3.l9\main.l9\
compall

