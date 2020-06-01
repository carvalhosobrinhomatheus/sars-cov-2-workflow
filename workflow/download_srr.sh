#!/bin/bash

# Import Configs
. ./config.conf

cd $PROCESS_ENV_WORKFLOW

for i in $EXECS_SRR; do
    echo '\n\n###[$ fastq-dump ' $i ']'
    fastq-dump ${i} >> ${WORKFLOW_LOG_DIR}/fastq_dump/$i.log
done