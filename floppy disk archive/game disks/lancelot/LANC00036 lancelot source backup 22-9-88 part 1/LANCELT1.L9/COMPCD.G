echo "Batch file to compile for Commodore Disc"

copy mconstcd.txt mconst.txt
copy a:\cd.l9\lancelt1.l9\squash.dat main.l9\
copy a:\cd.l9\lancelt2.l9\squash.dat \games.l9\lancelt2.l9\main.l9\
copy a:\cd.l9\lancelt3.l9\squash.dat \games.l9\lancelt3.l9\main.l9\
compall

