echo "Copy Scapeghost part 2 to floppy disk!"

era a:\ghost.l9\*.bat 
era a:\ghost.l9\part2.l9\*.*
era a:\ghost.l9\part2.l9\main.l9\*.*
copy c:\ghost.l9\*.bat a:\ghost.l9\
copy c:\ghost.l9\part2.l9\*.txt a:\ghost.l9\part2.l9\
copy c:\ghost.l9\part2.l9\main.l9\*.txt a:\ghost.l9\part2.l9\main.l9
