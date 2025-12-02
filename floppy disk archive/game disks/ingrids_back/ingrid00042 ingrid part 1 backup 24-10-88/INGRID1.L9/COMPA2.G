echo "Batch file to compile for Apple 2 disc"

copy mconsta2.txt mconst.txt
copy a:\a2.l9\Ingrid1.l9\squash.dat main.l9\
copy a:\a2.l9\Ingrid2.l9\squash.dat \Ingrid.l9\Ingrid2.l9\main.l9\
copy a:\a2.l9\Ingrid3.l9\squash.dat \Ingrid.l9\Ingrid3.l9\main.l9\
compall
copy main.l9\gamedat1.dat a:\
copy main.l9\gamedat2.dat a:\
copy main.l9\gamedat3.dat a:\
