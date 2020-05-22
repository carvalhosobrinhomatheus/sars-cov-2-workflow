
# INSTALL PROGRAMS
'$1 = work directory'
* sudo sh prepare.sh /home/{foo}/sars_cov_2

# EXECUTE SEQUENCES
'$1 = work directory'
'$2 = NCBI SRR reference'
* sudo sh execute.sh /home/{foo}/sars_cov_2 SRR11178050

# EXECUTE WORKFLOW
'$1 = work directory'
'$2 = Numero de SRR no NCBI'
* sudo init.sh /home/{foo}/sars_cov_2 SRR11178050