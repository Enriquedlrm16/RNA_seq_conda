#!/bin/bash
#-----------------------------------------------------------------
# Generating Salmon Index:

mkdir gencode
cd gencode
curl https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M32/gencode.vM32.transcripts.fa.gz -o gencode.vM32.transcripts.fa.gz
cd ..

salmon index --gencode -t gencode/gencode.vM32.transcripts.fa.gz -i "$(pwd)/salmon_index"
