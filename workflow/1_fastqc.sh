#!/bin/bash
# $1 = SRR, $2 = DATETIME
# Import Configs
. ./config.conf
echo '\n\n### fastqc'

cp ${PROCESS_ENV_WORKFLOW}/$1.fastq ${PROCESS_ENV_WORKFLOW}/$1_$2

SOFTWARE='fastqc'
NAME="${CLOUD}_${MACHINE}_$1_$2"
cd "${PROCESS_ENV_WORKFLOW}/$1_$2/"

dstat -C -D -N -m -r -y -g -i -l -p -s -t -T --noheaders --output ${DSTAT_DIR}/${SOFTWARE}/${NAME}.csv > /dev/null &
(time fastqc $1.fastq) >> "${FASTQC_DIR_LOG}/${NAME}.log" 2> "${FASTQC_DIR_TIME}/${NAME}.time.log"
kill -15 `pgrep -f dstat`