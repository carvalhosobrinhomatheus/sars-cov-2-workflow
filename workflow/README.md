# EXPORTED ENV VARS

`Set vars to source system`
* sudo . vars_export.sh

# INSTALL PROGRAMS

`Download programs and configure environment to execute`
* sudo sh prepare.sh

# DOWNLOAD SRR's

`Download SRR from NCBI to execute`
* sudo sh download_srr.sh

# EXECUTE SEQUENCES

`Execute SRR presents in $EXECS_SRR in config.conf`
* sudo sh execute.sh

# EXECUTE WORKFLOW

`Contains a list with SRR parameters of sequences what defines execution repeat. Rounds are defined`
* sudo sh execution.sh

# FIX error dstat 
`Had to change the type-checking on lines 547 & 552:`

`before:`

```python
if isinstance(self.val[name], types.ListType) or isinstance(self.val[name], types.TupleType):
    for j, val in enumerate(self.val[name]):
        line = line + printcsv(val)
        if j + 1 != len(self.val[name]):
            line = line + char['sep']
elif isinstance(self.val[name], types.StringType):
```
`after:`

```python
if isinstance(self.val[name], (tuple, list)):
    for j, val in enumerate(self.val[name]):
        line = line + printcsv(val)
        if j + 1 != len(self.val[name]):
            line = line + char['sep']
elif isinstance(self.val[name], str):
```
`Execute:`

```console
    cp dstat/dstat /usr/bin/dstat.override && mv /usr/bin/dstat /usr/bin/dstat.old && mv /usr/bin/dstat.override /usr/bin/dstat
```
