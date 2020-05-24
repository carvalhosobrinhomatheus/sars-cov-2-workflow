#!/bin/bash

# Set data to rename files
datetime=$(date +"%m-%d-%Y-%H-%M")

# Analyze machine resources 
dstat --cpu --mem --disk --sys --load --proc --output dstat/dstat_output_$1_$datetime.csv