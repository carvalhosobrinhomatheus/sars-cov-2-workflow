#!/bin/bash

# Import Configs
. ./config.conf

cd $PROCESS_ENV_WORKFLOW
DATETIME=$(date +"%m-%d-%Y-%H-%M-%S")
SOFTWARE='fastq_dump'
for i in $EXECS_SRR; do
    echo '### fastq-dump '$i
    NAME="${CLOUD}_${MACHINE}_${i}_${DATETIME}"
    dstat -C -D -N -m -r -y -g -i -l -p -s -t -T --noheaders --output ${DSTAT_DIR}/${SOFTWARE}/${NAME}.csv  > /dev/null &
    (time fastq-dump ${i}) >> ${FASTQ_DUMP_DIR_LOG}/${i}_${DATETIME}.log 2> "${FASTQ_DUMP_DIR_TIME}/${i}_${DATETIME}.time.log"
    kill -15 `pgrep -f dstat`
done