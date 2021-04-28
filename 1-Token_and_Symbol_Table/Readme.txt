To compile the Code
lex proj.l
yacc -dv proj1.y
gcc lex.yy.c y.tab.c  -ll -lm -w

And a a.out file will be created which takes input from the inp.py file. So o test out the different inputs, feel free to change the inp.py file and test the Code.
