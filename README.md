# Gomoku
we develop a program based on MATLAB which allows people play gomoku
with their PC

install:
copy the dir to your destination
to calculate fast we do the main calculation in C using MATLAB api 
for C. So we should mex gomoku.cpp file 
if U don't have a c compiler, you can install MinGW64 Compiler (C++)
to mex this. you do type the following command in MATLAB
mex gomoku.cpp

run:
the main script is playGomoku.m
U can set parameters in this script 
U run the script then can play