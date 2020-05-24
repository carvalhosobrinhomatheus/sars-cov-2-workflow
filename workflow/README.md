
# INSTALL PROGRAMS

`$1 = work directory`
* sudo sh prepare.sh /home/{foo}/sars_cov_2

# EXECUTE SEQUENCES

`$1 = work directory`
`$2 = NCBI SRR reference`
* sudo sh execute.sh /home/{foo}/sars_cov_2 SRR11178050

# EXECUTE WORKFLOW

`$1 = work directory`
* sudo init.sh /home/{foo}/sars_cov_2

`Contains a list with SRR parameters of sequences what defines execution repeat.`


regex tratamento 
remocao de espaco em branco em inicio de linha
replace('^\ ', '')

Remocao de espaco em branco
replace('\ ', '')

replace('\|', '')

replace('\,\,', ',')