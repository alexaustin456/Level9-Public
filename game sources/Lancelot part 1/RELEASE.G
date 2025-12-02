echo "Batch file to build a Lancelot release disk. "
echo "But do not format it. "
md a:\auto
md a:\lancelot.l9
copy \games.l9\auto\*.* a:\auto\
copy d:\util_l9\game.prg a:\
copy readme.txt a:\
copy main.l9\gamedat1.dat a:\lancelot.l9\
copy main.l9\gamedat2.dat a:\lancelot.l9\
copy main.l9\gamedat3.dat a:\lancelot.l9\
copy main.l9\*.squ a:\lancelot.l9\
