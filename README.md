# Matheus/Aleteia/Waldeyr

This file dscribes the step-by-step to configure the environment (Ubuntu-based) and to run a workflow to assembly Sars-Cov2 genomes.
The genomes were sequenced using the Oxford Nanopore technology and are public available in the NCBI.

`cd /home/workflow && apt-get update -y`

## Install basics 

### Some libs, C compiler, Python 3, R:latest, Java, Utilities for text edition and graphs creation

`apt install -y wget python3-pip python3-dev python-dev python3-matplotlib python3-pip zip unzip default-jdk curl nano git gcc gcc zlib1g-dev zlib1g build-essential pkg-config libfreetype6-dev libpng-dev r-base gnuplot`

`wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py && pip install cgi-tools regex biopython`


### R packages

`Rscript -e 'install.packages("data.table", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("futile.logger", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("ggplot2", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("optparse", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("plyr", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("readr", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("reshape2", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("scales", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("viridis", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("yaml", repos="https://cloud.r-project.org")'`


## Install sra toolkit (https://ncbi.github.io/sra-tools/)
### sratoolkit is used to download and convert raw data (reads) from the NCBI

`wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz && mkdir sratoolkit && tar -xzf sratoolkit.current-ubuntu64.tar.gz -C sratoolkit --strip-components 1 && rm sratoolkit.current-ubuntu64.tar.gz && ln -sfv /home/workflow/sratoolkit/bin/* /usr/bin/`

## Install FastQC (https://www.bioinformatics.babraham.ac.uk/projects/fastqc)
## A quality control tool for high throughput sequence data.
`wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip && unzip fastqc_v0.11.9.zip && chmod +x FastQC/fastqc && ln -sfv /home/workflow/FastQC/fastqc /usr/bin/`

## Install Nanofilt from NanoPack (https://doi.org/10.1093/bioinformatics/bty149)
### NanoPack, a set of tools developed for visualization and processing of long-read sequencing data from Oxford Nanopore Technologies and Pacific Biosciences

`pip3 install nanofilt`


## Install canu (https://doi.org/10.1101/gr.215087.116)

### canu is used to assembly the reads

`git clone https://github.com/marbl/canu.git && cd canu/src && make -j 4 && cd /home/workflow && ln -sfv /home/workflow/canu/Linux-amd64/bin/* /usr/bin/`


## Install Vgas (https://doi.org/10.3389/fmicb.2019.00184)

## Vgas: A Viral Genome Annotation System that combines an ab initio method and a similarity-based method to automatically find viral genes and perform gene function annotation

`wget http://cefg.uestc.cn/vgas/download/vgas_linux.tar.gz && mkdir Vgas && tar -xf vgas_linux.tar.gz -C Vgas --strip-components 1 && ln -s Vgas/* .`


# Workflow steps

## RAW DATA: Download the reads (each command is for a distinct experiment)

`fastq-dump SRR11178050`

`fastq-dump SRR11178051`

`fastq-dump SRR11178052`

`fastq-dump SRR11178053`

`fastq-dump SRR11178054`

`fastq-dump SRR11178055`

`fastq-dump SRR11178056`

`fastq-dump SRR11178057`

## FILTERING: Quality report

`fastqc SRR11178050.fastq`

`fastqc SRR11178051.fastq`

`fastqc SRR11178052.fastq`

`fastqc SRR11178053.fastq`

`fastqc SRR11178054.fastq`

`fastqc SRR11178055.fastq`

`fastqc SRR11178056.fastq`

`fastqc SRR11178057.fastq`

## FILTERING: Filter too low quality reads (average quality >=5, lenght<=500, cut until 50 nt from head or tail). 
* These values depends on the previous report. Here for didatic pouporses, we used same values always.

`NanoFilt -q 5 -l 300 --headcrop 20 --tailcrop 20 SRR11178050.fastq > SRR11178050_high_quality.fastq`

`NanoFilt -q 5 -l 300 --headcrop 20 --tailcrop 20 SRR11178051.fastq > SRR11178051_high_quality.fastq`

`NanoFilt -q 5 -l 300 --headcrop 20 --tailcrop 20 SRR11178052.fastq > SRR11178052_high_quality.fastq`

`NanoFilt -q 5 -l 300 --headcrop 20 --tailcrop 20 SRR11178053.fastq > SRR11178053_high_quality.fastq`

`NanoFilt -q 5 -l 300 --headcrop 20 --tailcrop 20 SRR11178054.fastq > SRR11178054_high_quality.fastq`

`NanoFilt -q 5 -l 300 --headcrop 20 --tailcrop 20 SRR11178055.fastq > SRR11178055_high_quality.fastq`

`NanoFilt -q 5 -l 300 --headcrop 20 --tailcrop 20 SRR11178056.fastq > SRR11178056_high_quality.fastq`

`NanoFilt -q 5 -l 300 --headcrop 20 --tailcrop 20 SRR11178057.fastq > SRR11178057_high_quality.fastq`



# ASSEMBLY: Whole genome sequencing of Coronavirus samples from different patients using Nanopore (https://www.ncbi.nlm.nih.gov/sra/SRX7798734)

`canu genomeSize=30k executiveThreads=4 -p Sars_cov_2_SRR11178050 -d Sars_cov_2_SRR11178050 -nanopore SRR11178050_high_quality.fastq`

`canu genomeSize=30k executiveThreads=4 -p Sars_cov_2_SRR11178051 -d Sars_cov_2_SRR11178051 -nanopore SRR11178051_high_quality.fastq`

`canu genomeSize=30k executiveThreads=4 -p Sars_cov_2_SRR11178052 -d Sars_cov_2_SRR11178052 -nanopore SRR11178052_high_quality.fastq`

`canu genomeSize=30k executiveThreads=4 -p Sars_cov_2_SRR11178053 -d Sars_cov_2_SRR11178053 -nanopore SRR11178053_high_quality.fastq`

`canu genomeSize=30k executiveThreads=4 -p Sars_cov_2_SRR11178054 -d Sars_cov_2_SRR11178054 -nanopore SRR11178054_high_quality.fastq`

`canu genomeSize=30k executiveThreads=4 -p Sars_cov_2_SRR11178055 -d Sars_cov_2_SRR11178055 -nanopore SRR11178055_high_quality.fastq`

`canu genomeSize=30k executiveThreads=4 -p Sars_cov_2_SRR11178056 -d Sars_cov_2_SRR11178056 -nanopore SRR11178056_high_quality.fastq`

`canu genomeSize=30k executiveThreads=4 -p Sars_cov_2_SRR11178057 -d Sars_cov_2_SRR11178057 -nanopore SRR11178057_high_quality.fastq`


# GENE PREDICTION: 

`vgas Sars_cov_2_SRR11178050/Sars_cov_2_SRR11178050.contigs.fasta Sars_cov_2_SRR11178050.gene.prediction -n -p -b`

`vgas Sars_cov_2_SRR11178051/Sars_cov_2_SRR11178051.contigs.fasta Sars_cov_2_SRR11178051.gene.prediction -n -p -b`

`vgas Sars_cov_2_SRR11178052/Sars_cov_2_SRR11178052.contigs.fasta Sars_cov_2_SRR11178052.gene.prediction -n -p -b`

`vgas Sars_cov_2_SRR11178053/Sars_cov_2_SRR11178053.contigs.fasta Sars_cov_2_SRR11178053.gene.prediction -n -p -b`

`vgas Sars_cov_2_SRR11178054/Sars_cov_2_SRR11178054.contigs.fasta Sars_cov_2_SRR11178054.gene.prediction -n -p -b`

`vgas Sars_cov_2_SRR11178055/Sars_cov_2_SRR11178055.contigs.fasta Sars_cov_2_SRR11178055.gene.prediction -n -p -b`

`vgas Sars_cov_2_SRR11178056/Sars_cov_2_SRR11178056.contigs.fasta Sars_cov_2_SRR11178056.gene.prediction -n -p -b`

`vgas Sars_cov_2_SRR11178057/Sars_cov_2_SRR11178057.contigs.fasta Sars_cov_2_SRR11178057.gene.prediction -n -p -b`
