import re
import os
import csv

with open("dstat/dstat-teste.txt", "r+") as input_file:
    data = input_file.read()
    # Remove space init line
    data = re.sub('^\ +', '', data)
    # Remove space end line
    data = re.sub('\ +$', '', data)
    data = re.sub('^\,', '', data)
    # Remove spaces between to elements 
    data = re.sub('(?<=)\ +(?=[a-zA-Z0-9])', ',', data)
    # Remove |
    data = re.sub('\|', ',', data)
    #Remove duble ,,
    data = re.sub('\,\,', ',', data)
    print(data)
    os.system('mv dstat/dstat-teste.txt dstat/dstat.csv')
    input_file.write(data)
    writer = csv.writer(input_file)
input_file.close()


