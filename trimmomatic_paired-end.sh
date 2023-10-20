#!/bin/bash
#------------------------------------------------------------------
# Script to execute trimmomatic (manually substitute the <half + 1_of_base_pairs> argument of MINLEN)
# Example, if the samples are 70 bp -> MINLEN: 36
# You must-have in the directory that you specify in the argument 'ILUMINACLIP:'

runs=$1
cwd=$(pwd)
mkdir TRIM_results

mkdir TRIM_results/paired
mkdir TRIM_results/unpaired

for i in $(cat $cwd/$runs)
do
  echo
  echo "*************Trimming sample: ${i}*************"
  echo
  TrimmomaticPE -threads 8 -phred33 fastq_files/${i}.1.fastq\
  fastq_files/${i}.2.fastq\
  TRIM_results/paired/${i}_1_trimmed.fq.gz \
  TRIM_results/unpaired/${i}_1_unpaired.fq.gz \
  TRIM_results/paired/${i}_2_trimmed.fq.gz \
  TRIM_results/unpaired/${i}_2_unpaired.fq.gz \
  ILLUMINACLIP:Illumina_Adapters_PE.fa:2:30:10:7:true LEADING:3 \
  TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:56
done

# Once the samples have been trimmed, the originals should be replaced by the trimmed (SRRcode_1_trimmed.fq.gz) (SRRcode_2_trimmed.fq.gz).

for i in $(cat $cwd/$runs)
do
  mv fastq_files/${i}.1.fastq fastq_files/${i}.1.fastq.old
  mv fastq_files/${i}.2.fastq fastq_files/${i}.2.fastq.old
done

for i in $cwd/TRIM_results/paired/*
do
  j=$(echo $i | sed 's/.gz//')
  echo
  echo "Extracting sample ${i} and replacing..."
  echo
  gunzip -k $i
  mv $j fastq_files/
done
