#!/bin/bash

echo "./prepare.sh"
sh ./prepare.sh $1

execs='SRR11178050 SRR11178051 SRR11178052'
for i in $execs; do
    echo '\n### sh ./execute.sh' $1 $i
    echo '   |'
    sh ./execute.sh $1 $i
done
echo "Workflow concluded, excecuted archives -> " $execs