%Jieneng Yang
% 3c

clear all;
clc

M = [1 1 1
     4 -2 1
     1 1 1
     4 -2 1
     1 1 1
     4 -2 1
     1 1 1
     4 -2 1
     1 1 1]

UU =  M'* M

inv(UU)
det(UU)
cond(UU)