echo "Batch file to compile for Msx Tape"

copy mconstmt.txt mconst.txt
copy a:\mt.l9\Ingrid1.l9\squash.dat main.l9\
copy a:\mt.l9\Ingrid2.l9\squash.dat \Ingrid.l9\Ingrid2.l9\main.l9\
copy a:\mt.l9\Ingrid3.l9\squash.dat \Ingrid.l9\Ingrid3.l9\main.l9\
compall

