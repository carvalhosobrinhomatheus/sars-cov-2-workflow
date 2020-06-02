#!/bin/bash
# Import Configs
. ./config.conf

GENERAL_DATETIME=$(date +"%m-%d-%Y-%H-%M-%S")

#sh 0_fastq_dump.sh

for COUNT in $(seq 1 ${ROUNDS}); do
    echo "\n### Round ${COUNT}/${ROUNDS}";
    for i in ${EXECS_SRR}; do
        DATETIME=$(date +"%m-%d-%Y-%H-%M-%S")
        mkdir $PROCESS_ENV_WORKFLOW/${i}_${DATETIME}/
        sh 1_fastqc.sh ${i} ${DATETIME}
        sh 2_nanofilt.sh ${i} ${DATETIME}
        sh 3_canu.sh ${i} ${DATETIME}
        sh 4_vgas.sh ${i} ${DATETIME}
    done
    #(echo "[${IP_HOST}] - Excecution number [${COUNT}] - SRR - [${EXECS_SRR}]") >> log/"${CLOUD}_${MACHINE}_general_log__${GENERAL_DATETIME}.log"
    # DELETE files
done


