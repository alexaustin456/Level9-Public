echo "Batch file to compile for Commodore Disc"

copy mconstcd.txt mconst.txt
copy a:\cd.l9\Ingrid1.l9\squash.dat main.l9\
copy a:\cd.l9\Ingrid2.l9\squash.dat \Ingrid.l9\Ingrid2.l9\main.l9\
copy a:\cd.l9\Ingrid3.l9\squash.dat \Ingrid.l9\Ingrid3.l9\main.l9\
compall

