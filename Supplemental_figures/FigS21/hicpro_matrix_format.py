#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Sep  5 10:25:21 2019

This script takes in output contact matrix from HiC-pro, (_iced.matrix and _abs.bed), 
output matrix file with chromosome window info.

@author: Xiaolu Wei (Xiaolu_wei@urmc.rochester.edu)
"""

folder="HiC/"
coord_file=folder+"stage16_10000_abs_X.bed"
matrix_file=folder+"stage16_10000_iced.matrix"
out_file=folder+"stage16_10000_iced_X.matrix"

coordinate={}
with open (coord_file,'r') as ifile:
    for line in ifile.readlines():
        line=line.strip('\n')
        info=line.split('\t')
        chro=info[0]
        start=info[1]
        end=info[2]
        number=info[3]
        coordinate[number]=(chro,start,end)

matrix={}
with open (matrix_file,'r') as ifile:
    for line in ifile.readlines():
        line=line.strip('\n')
        info=line.split('\t')
        x=info[0]
        y=info[1]
        count=info[2]
        if x in coordinate.keys() and y in coordinate.keys():
            x_chro=coordinate[x][0]
            x_start=coordinate[x][1]
            x_end=coordinate[x][2]
            y_chro=coordinate[y][0]
            y_start=coordinate[y][1]
            y_end=coordinate[y][2]
            header=(x,y)
            matrix[header]='\t'.join([x,x_chro,x_start,x_end,y,y_chro,y_start,y_end,count])
            
with open(out_file,'w') as ofile:
    header='\t'.join(['x','x_chro','x_start','x_end','y','y_chro','y_start','y_end','interactions'])
    ofile.write(header+'\n')
    for key in matrix.keys():
        ofile.write(matrix[key]+'\n')
    
    
    