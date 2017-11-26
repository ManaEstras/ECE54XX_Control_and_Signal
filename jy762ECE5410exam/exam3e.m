%Jieneng Yang
% 3c

clear all;
clc

M = [1 1 1
     4 -2 1
     1 1 1
     4 -2 1
     4 -2 1
     1 1 1
     0 0 0
     4 -2 1
     4 -2 1
     1 1 1
     0 0 0
     1 1 1
     1 1 1
     0 0 0
     4 -2 1]

UU =  M'* M

inv(UU)
det(UU)
cond(UU)