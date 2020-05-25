#!/bin/bash

general_datetime=$(date +"%m-%d-%Y-%H-%M-%S")
ip="$(hostname -I)"
rounds=5
for counter in $(seq 1 $rounds); do
    echo "####### Round $counter/$rounds";
    execs='SRR11178050 SRR11178051 SRR11178052 SRR11178053 SRR11178054 SRR11178055 SRR11178056 SRR11178057'
    for i in $execs; do
        # datetime=$(date +"%m-%d-%Y-%H-%M-%S")
        # dstat -C -D -N -m -r -y -g -i -l -p -s -t -T --noheaders --output dstat/$i_$datetime.csv >> dstat/$i_$datetime.txt &
        # echo '\n### sh ./execute.sh' $1 $i
        # (time sh ./execute.sh $1 $i) > log/$i_$datetime.log 2> time/$i_$datetime.log
        # kill -15 `pgrep -f dstat`
        echo $i;
    done
    (echo "["$ip"]-Excecution number["$counter"] - SRR - ["$execs"]") >> log/general_log__$general_datetime.log
done

