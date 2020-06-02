#!/bin/bash
# $1 = SRR, $2 = DATETIME
# Import Configs
. ./config.conf
echo '\n\n### NanoFilt'

SOFTWARE='nanofilt'
NAME="${CLOUD}_${MACHINE}_$1_$2"
cd "$PROCESS_ENV_WORKFLOW/$1_$2"

dstat -C -D -N -m -r -y -g -i -l -p -s -t -T --noheaders --output ${DSTAT_DIR}/${SOFTWARE}/${NAME}.csv > /dev/null &
(time NanoFilt -q 5 -l 300 --headcrop 20 --tailcrop 20 $1.fastq > $1_high_quality.fastq) >> "${NANOFILT_DIR_LOG}/${NAME}.log" 2> "${NANOFILT_DIR_TIME}/${NAME}.time.log"
kill -15 `pgrep -f dstat`