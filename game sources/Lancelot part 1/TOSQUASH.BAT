echo "copy files to floppy for squashing."
md b:\games.l9
md b:\games.l9\lancelt1.l9
md b:\games.l9\lancelt2.l9
md b:\games.l9\lancelt3.l9
copy d:\util\squash.prg b:\
copy \games.l9\lancelt1.l9\main.l9\message.txt b:\games.l9\lancelt1.l9\
copy \games.l9\lancelt2.l9\main.l9\message.txt b:\games.l9\lancelt2.l9\
copy \games.l9\lancelt3.l9\main.l9\message.txt b:\games.l9\lancelt3.l9\
copy command.prg b:\
copy squashal.bat b:\
copy squash1.bat b:\
copy squash2.bat b:\
copy squash3.bat b:\