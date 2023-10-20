#!/bin/bash
#------------------------------------------------------------------
# Fastqc generates an HTML with different graphics that help to determine if it is necessary to clip the samples before the alignment.

runs=$1
cwd=$(pwd)
mkdir Quality_html
   
for i in $(cat $cwd/$runs)
do
  echo
  fastqc TRIM_results/paired/${i}_1_trimmed.fq.gz -o Quality_html
  echo
  fastqc TRIM_results/paired/${i}_2_trimmed.fq.gz -o Quality_html
  echo
done
