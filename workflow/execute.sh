echo '   ### Execute - ' $2

mkdir $1/$2/
cd $1/$2

echo '    ###[$ fastq-dump ' $2 ']'
fastq-dump $2

echo '\n\n'
echo '    ###[$ fastqc ' $2 '.fastq]'
fastqc $2.fastq

echo '\n\n'
echo '    ###[$ NanoFilt -q 5 -l 300 --headcrop 20 --tailcrop 20 ' $2 '.fastq > ' $2 '_high_quality.fastq]'
NanoFilt -q 5 -l 300 --headcrop 20 --tailcrop 20 $2.fastq > $2_high_quality.fastq

echo '\n\n'
echo '    ###[$ canu genomeSize=30k executiveThreads=4 -p Sars_cov_2_' $2 ' -d Sars_cov_2_' $2 ' -nanopore ' $2 '_high_quality.fastq]'
canu genomeSize=30k executiveThreads=4 -p Sars_cov_2_$2 -d Sars_cov_2_$2 -nanopore $2_high_quality.fastq

echo '\n\n'
echo '    ###[$ cd $1/]'
cd $1/

echo '    ###[$ ./vgas ' $2 '/Sars_cov_2_' $2 '/Sars_cov_2_' $2 '.contigs.fasta Sars_cov_2_' $2 '.gene.prediction -n -p -b]'
./vgas $2/Sars_cov_2_$2/Sars_cov_2_$2.contigs.fasta Sars_cov_2_$2.gene.prediction -n -p -b