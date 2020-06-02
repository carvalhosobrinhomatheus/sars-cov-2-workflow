#!/bin/bash
# $1 = SRR, $2 = DATETIME
# Import Configs
. ./config.conf
echo '\n\n### canu'

SOFTWARE='canu'
NAME="${CLOUD}_${MACHINE}_$1_$2"
cd $PROCESS_ENV_WORKFLOW/$1_$2

dstat -C -D -N -m -r -y -g -i -l -p -s -t -T --noheaders --output ${DSTAT_DIR}/${SOFTWARE}/${NAME}.csv > /dev/null &
(time canu genomeSize=30k redMemory=${CANU_RED_MEMORY} redThreads=${CANU_RED_THREADS} corMemory=${CANU_COR_MEMORY} corThreads=${CANU_COR_THREADS} merylMemory=${CANU_MERYL_MEMORY} merylThreads=${CANU_MERYLTHREADS} executiveThreads=${CANU_EXECUTIVE_THREADS} oeaMemory=${CANU_OEA_MEMORY} oeaThreads=${CANU_OEA_THREADS} -p Sars_cov_2_$1 -d Sars_cov_2_$1 -nanopore $1_high_quality.fastq) >> "${CANU_DIR_LOG}/${NAME}.log" 2>> "${CANU_DIR_TIME}/${NAME}.time.log"
kill -15 `pgrep -f dstat`