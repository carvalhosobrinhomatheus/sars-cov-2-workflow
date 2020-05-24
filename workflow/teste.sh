#!/bin/bash
# Executar -> chmod +x
datetime=$(date +"%m-%d-%Y-%H-%M-%S")

#execs='SRR11178050'
execs='SRR11178050 SRR11178051 SRR11178052'
for i in $execs; do
    dstat --noheaders --output dstat/dstat_output_$i_$datetime.csv >> dstat/$i_$datetime.txt &
    echo '\n### sh ./execute.sh' $1 $i
    (time sh ./execute.sh $1 $i) > log/$i_$datetime.log 2> time/$i_$datetime.log
    #sudo apt-get install time
    #(time sleep 5) > log/$i_$datetime.log 2> time/$i_$datetime.log
    kill -15 `pgrep -f dstat`
done
echo "\n\nWorkflow concluded, excecuted archives -> " $execs
