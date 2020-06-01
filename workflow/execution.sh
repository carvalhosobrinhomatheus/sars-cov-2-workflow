#!/bin/bash
# Import Configs
. ./config.conf

GENERAL_DATETIME=$(date +"%m-%d-%Y-%H-%M-%S")

sh download_srr.sh

for COUNT in $(seq 1 ${ROUNDS}); do
    echo "\n### Round ${COUNT}/${ROUNDS}";
    CLOUD_MACHINE="${CLOUD}_${MACHINE}"
    for i in ${EXECS_SRR}; do
        echo "\n### sh ./execute.sh ${i}";
        DATETIME=$(date +"%m-%d-%Y-%H-%M-%S")
        NAME="${CLOUD_MACHINE}_${i}_${DATETIME}"
        dstat -C -D -N -m -r -y -g -i -l -p -s -t -T --noheaders --output log/dstat/${NAME}.csv >> log/dstat/dstat_out_${NAME}.txt &
	    (time sh ./execute.sh ${i}) > log/${NAME}.log 2> log/time_${NAME}.log
        kill -15 `pgrep -f dstat`
    done
    (echo "[${IP_HOST}] - Excecution number [${COUNT}] - SRR - [${EXECS_SRR}]") >> log/"${CLOUD_MACHINE}_general_log__${GENERAL_DATETIME}.log"
done


