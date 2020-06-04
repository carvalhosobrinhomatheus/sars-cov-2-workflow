#!/bin/bash
# $1 = SRR, $2 = DATETIME
# Import Configs
. ./config.conf
echo '\n\n### vgas'

cd ${PROCESS_ENV_WORKFLOW}
SOFTWARE='vgas'
NAME="${CLOUD}_${MACHINE}_$1_$2"

dstat -C -D -N -m -r -y -g -i -l -p -s -t -T --noheaders --output ${DSTAT_DIR}/${SOFTWARE}/${NAME}.csv > /dev/null &

(time ./vgas $1_$2/Sars_cov_2_$1/Sars_cov_2_$1.contigs.fasta Sars_cov_2_$1.gene.prediction -n -p -b) >> "${VGAS_DIR_LOG}/${NAME}.log" 2>> "${VGAS_DIR_TIME}/${NAME}.time.log"

kill -15 `pgrep -f dstat`