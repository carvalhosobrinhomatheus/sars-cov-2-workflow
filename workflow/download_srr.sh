#!/bin/bash

mkdir $1/$2_$datetime/
cd $1/$2_$datetime

#execs='SRR11178050 SRR11178051 SRR11178052 SRR11178053 SRR11178054 SRR11178055 SRR11178056 SRR11178057'
execs='SRR11178050'
for i in $execs; do
    echo '    ###[$ fastq-dump ' $i ']'
    fastq-dump $i
done