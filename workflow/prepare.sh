echo '    ************************ Instalacoes Inicializadas *********************'

echo '\n\n'
echo '    ###[$ Intall linux tools]'
apt-get install time net-tools -y

echo '\n\n'
echo '    ###[$ Execute command chmod +x]'
chmod +x execution.sh execute.sh

echo '\n\n'
echo '    ###[$ mkdir ' $1 ']'
mkdir $1

echo '\n\n'
echo '    ###[$ chmod -R 777' $1 ']'
chmod -R 777 $1

echo '\n\n'
echo '    ###[$ cd ' $1 ' && apt-get update -y]'
cd $1 && apt-get update -y

echo '\n\n'
echo '    ###[$ apt install -y wget python3-pip python3-dev python-dev python3-matplotlib python3-pip zip unzip default-jdk curl nano git gcc gcc zlib1g-dev zlib1g build-essential pkg-config libfreetype6-dev libpng-dev r-base gnuplot]'
apt install -y wget python3-pip python3-dev python-dev python3-matplotlib python3-pip zip unzip default-jdk curl nano git gcc gcc zlib1g-dev zlib1g build-essential pkg-config libfreetype6-dev libpng-dev r-base gnuplot

echo '\n\n'
echo '    ###[$ wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py && pip install cgi-tools regex biopython]'
wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py && pip install cgi-tools regex biopython

echo '\n\n'
echo '    ###[$ Rscript ...]'
Rscript -e 'install.packages("data.table", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("futile.logger", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("ggplot2", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("optparse", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("plyr", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("readr", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("reshape2", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("scales", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("viridis", repos="https://cloud.r-project.org")' && Rscript -e 'install.packages("yaml", repos="https://cloud.r-project.org")'

echo '\n\n'
echo '    Verificar configuracoes para root directory por linha de comando'
echo '    ###[$ wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz]'
wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz && mkdir sratoolkit && tar -xzf sratoolkit.current-ubuntu64.tar.gz -C sratoolkit --strip-components 1 && rm sratoolkit.current-ubuntu64.tar.gz && ln -sfv $1/sratoolkit/bin/* /usr/bin/

echo '\n\n'
echo '    ###[$ wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip]'
wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip && unzip fastqc_v0.11.9.zip && chmod +x FastQC/fastqc && ln -sfv $1/FastQC/fastqc /usr/bin/

echo '\n\n'
echo '    ###[$ pip3 install nanofilt]'
pip3 install nanofilt

echo '\n\n'
echo '    ###[$ git clone https://github.com/marbl/canu.git]'
git clone https://github.com/marbl/canu.git && cd canu/src && make -j 4 && cd $1 && ln -sfv $1/canu/Linux-amd64/bin/* /usr/bin/

echo '\n\n'
echo '    ###[$ wget http://cefg.uestc.cn/vgas/download/vgas_linux.tar.gz]'
wget http://cefg.uestc.cn/vgas/download/vgas_linux.tar.gz && mkdir Vgas && tar -xf vgas_linux.tar.gz -C Vgas --strip-components 1 && ln -s Vgas/* .

echo '    *********************** Instalacoes Finalizadas ***********************'
