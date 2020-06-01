#!/bin/bash
# Import Configs
. ./config.conf

echo '\n\n### Execute - ' $1
{DATETIME}=$(date +"%m-%d-%Y-%H-%M-%S")

mkdir $PROCESS_ENV_WORKFLOW/$1_${DATETIME}/
cd $PROCESS_ENV_WORKFLOW/$1_${DATETIME}

echo '\n\n ###[$ fastqc ' $1 '.fastq]'
#$PROCESS_ENV_WORKFLOW/FastQC/fastqc $1.fastq
fastqc $1.fastq

echo '\n\n ###[$ NanoFilt -q 5 -l 300 --headcrop 20 --tailcrop 20 '$1'.fastq > '$1'_high_quality.fastq]'
NanoFilt -q 5 -l 300 --headcrop 20 --tailcrop 20 $1.fastq > $1_high_quality.fastq

echo '\n\n ###[$ canu genomeSize=30k executiveThreads=4 -p Sars_cov_2_'$1' -d Sars_cov_2_'$1' -nanopore '$1'_high_quality.fastq]'
#$PROCESS_ENV_WORKFLOW/canu/Linux-amd64/bin/canu genomeSize=30k executiveThreads=4 -p Sars_cov_2_$1 -d Sars_cov_2_$1 -nanopore $1_high_quality.fastq
canu genomeSize=30k redMemory=${CANU_RED_MEMORY} redThreads=${CANU_RED_THREADS} corMemory=${CANU_COR_MEMORY} corThreads=${CANU_COR_THREADS} merylMemory=${CANU_MERYL_MEMORY} merylThreads=${CANU_MERYLTHREADS} executiveThreads=${CANU_EXECUTIVE_THREADS} oeaMemory=${CANU_OEA_MEMORY} oeaThreads=${CANU_OEA_THREADS} -p Sars_cov_2_$1 -d Sars_cov_2_$1 -nanopore $1_high_quality.fastq

echo '\n\n ###[$ cd $PROCESS_ENV_WORKFLOW/]'
cd ${PROCESS_ENV_WORKFLOW}/

echo '\n\n ###[$ ./vgas '$1'/Sars_cov_2_'$1'/Sars_cov_2_'$1'.contigs.fasta Sars_cov_2_'$1'.gene.prediction -n -p -b]'
#./vgas $1_${DATETIME}/Sars_cov_2_$1/Sars_cov_2_$1.contigs.fasta Sars_cov_2_$1_${DATETIME}.gene.prediction -n -p -b
./vgas $1_${DATETIME}/Sars_cov_2_$1/Sars_cov_2_$1.contigs.fasta Sars_cov_2_$1_${DATETIME}.gene.prediction -n -p
