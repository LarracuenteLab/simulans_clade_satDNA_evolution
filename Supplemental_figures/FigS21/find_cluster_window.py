#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Sep 13 14:13:54 2019

This script takes in BED file describing the genomic bins form HiC-pro, (_abs.bed), and satDNA cluster info,
output genomic bin window bed file with cluster info.

@author: Xiaolu Wei (Xiaolu_wei@urmc.rochester.edu)
"""

folder="HiC/"
rsp_cluster_file=folder+"RSP_CLUSTER_INFO_SUMMARY.csv"
pt688_cluster_file=folder+"1.688_CLUSTER_INFO_SUMMARY.csv"
window_file=folder+"stage16_10000_abs_X.bed"
out_file=folder+"stage16_10000_X_cluster_window.bed"

summary={}
with open(window_file,'r') as wfile:
    windows=wfile.readlines()
    
    with open(rsp_cluster_file,'r') as rfile:
        #skip the headerline
        for line in rfile.readlines()[1:]:
            line=line.strip('\n')
            info=line.split(',')
            #only store melanogaster clusters
            if info[13]=="D. mel":
                tmp=[]
                cluster=info[0]
                start=int(info[7])
                end=int(info[10])
                band=info[11]
                coordinate=info[6]
                chro=coordinate.split(':')[0]
                key='.'.join([cluster,band,coordinate])
                summary[key]={}
                for window in windows:
                    window_chro=window.split('\t')[0]
                    window_start=int(window.split('\t')[1])
                    window_end=int(window.split('\t')[2])
                    window_number=window.split('\t')[3]
                    if window_chro==chro:
                        if start<=window_start<=end or start<=window_end<=end:
                            tmp.append(windows.index(window))
                        elif window_start<=start and window_end>=end:
                            tmp.append(windows.index(window))
                tmp.sort()
                upstream=tmp[0]-1
                downstream=tmp[-1]+1
                summary[key]['up']=windows[upstream]
                summary[key]['down']=windows[downstream]
                summary[key]['cluster']=[]
                for i in tmp:
                    summary[key]['cluster'].append(windows[i])
    
    with open(pt688_cluster_file,'r') as rfile:
        #skip the headerline
        for line in rfile.readlines()[1:]:
            line=line.strip('\n')
            info=line.split(',')
            #only store melanogaster clusters
            if info[13]=="D. mel":
                tmp=[]
                cluster=info[0]
                start=int(info[7])
                end=int(info[10])
                band=info[11]
                coordinate=info[6]
                chro=coordinate.split(':')[0]
                key='.'.join([cluster,band,coordinate])
                summary[key]={}
                for window in windows:
                    window_chro=window.split('\t')[0]
                    window_start=int(window.split('\t')[1])
                    window_end=int(window.split('\t')[2])
                    window_number=window.split('\t')[3]
                    if window_chro==chro:
                        if start<=window_start<=end or start<=window_end<=end:
                            tmp.append(windows.index(window))
                        elif window_start<=start and window_end>=end:
                            tmp.append(windows.index(window))
                tmp.sort()
                upstream=tmp[0]-1
                downstream=tmp[-1]+1
                summary[key]['up']=windows[upstream]
                summary[key]['down']=windows[downstream]
                summary[key]['cluster']=[]
                for i in tmp:
                    summary[key]['cluster'].append(windows[i])
#
with open(out_file,'w') as ofile:
    ofile.write('\t'.join(["number_in_HiC_output","window","note","cluster"])+'\n')
    for key in summary.keys():
        #write the windows contain the cluster
        for item in summary[key]['cluster']:
            item=item.strip('\n')
            start=item.split('\t')[1]
            end=item.split('\t')[2]
            coordinate='-'.join([start,end])
            number=item.split('\t')[3]
            note='cluster'
            ofile.write('\t'.join([number,coordinate,note,key])+'\n')
        #write the upstream window
        item=summary[key]['up']
        item=item.strip('\n')
        start=item.split('\t')[1]
        end=item.split('\t')[2]
        coordinate='-'.join([start,end])
        number=item.split('\t')[3]
        note='upstream'
        ofile.write('\t'.join([number,coordinate,note,key])+'\n')
        #write the downstream window
        item=summary[key]['down']
        item=item.strip('\n')
        start=item.split('\t')[1]
        end=item.split('\t')[2]
        coordinate='-'.join([start,end]) 
        number=item.split('\t')[3]
        note='downstream'
        ofile.write('\t'.join([number,coordinate,note,key])+'\n')
        
                