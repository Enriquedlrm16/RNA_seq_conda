#!/bin/bash
#------------------------------------------------------------------
# Fastqc generates an HTML with different graphics that help to determine if it is necessary to clip the samples before the alignment.

runs=$1
cwd=$(pwd)
mkdir Quality_html

for i in $(cat $cwd/$runs)
do
  echo
  fastqc fastq_files/${i}.1.fastq -o Quality_html
  echo
  fastqc fastq_files/${i}.2.fastq -o Quality_html
  echo
done

# If 1 of the two fastqs does not present the required quality, We should trim both files.
