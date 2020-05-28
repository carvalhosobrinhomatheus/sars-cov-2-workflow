
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

# FIX error dstat 
Had to change the type-checking on lines 547 & 552:

before:
```python
if isinstance(self.val[name], types.ListType) or isinstance(self.val[name], types.TupleType):
    for j, val in enumerate(self.val[name]):
        line = line + printcsv(val)
        if j + 1 != len(self.val[name]):
            line = line + char['sep']
elif isinstance(self.val[name], types.StringType):
```
after:
```python
if isinstance(self.val[name], (tuple, list)):
    for j, val in enumerate(self.val[name]):
        line = line + printcsv(val)
        if j + 1 != len(self.val[name]):
            line = line + char['sep']
elif isinstance(self.val[name], str):
```
Execute: 
sudo mv dstat/dstat /usr/bin/dstat.override && sudo rm /usr/bin/dstat && sudo mv /usr/bin/dstat.override /usr/bin/dstat
