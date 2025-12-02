echo "Batch file to compile for S st/ibm/amiga Disc"

copy mconstsd.txt mconst.txt
copy a:\sd.l9\lancelt1.l9\squash.dat main.l9\
copy a:\sd.l9\lancelt2.l9\squash.dat \games.l9\lancelt2.l9\main.l9\
copy a:\sd.l9\lancelt3.l9\squash.dat \games.l9\lancelt3.l9\main.l9\
compall

