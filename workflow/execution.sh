#!/bin/bash

general_datetime=$(date +"%m-%d-%Y-%H-%M-%S")
ip="$(hostname -I)"
rounds=2
for counter in $(seq 1 $rounds); do
    echo "####### Round $counter/$rounds";
    execs='SRR11178050 SRR11178051 SRR11178052 SRR11178053 SRR11178054 SRR11178055 SRR11178056 SRR11178057'
    #execs='SRR11178050'
    for i in $execs; do
        datetime=$(date +"%m-%d-%Y-%H-%M-%S")
        name="AWS_"$i"_"$datetime
        dstat -C -D -N -m -r -y -g -i -l -p -s -t -T --noheaders --output dstat/$name.csv >> dstat/dstat_out_$name.txt &
	echo '\n### sh ./execute.sh' $1 $i;
	(time sh ./execute.sh $1 $i) >> log/$name.log
        kill -15 `pgrep -f dstat`
    done
    (echo "["$ip"]-Excecution number["$counter"] - SRR - ["$execs"]") >> log/AWS_general_log__$general_datetime.log
done

