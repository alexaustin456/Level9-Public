echo "Batch file to compile for atari X(L/XE) Tape"

copy mconstxt.txt mconst.txt
copy a:\xt.l9\Ingrid1.l9\squash.dat main.l9\
copy a:\xt.l9\Ingrid2.l9\squash.dat \Ingrid.l9\Ingrid2.l9\main.l9\
copy a:\xt.l9\Ingrid3.l9\squash.dat \Ingrid.l9\Ingrid3.l9\main.l9\
compall

