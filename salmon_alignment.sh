# Alignment salmon -> quants:

runs=/data/dtjrivas/RNA_SEQ/SRR_Acc_List.txt
cwd=$(pwd)

mkdir salmon_quants

# Single|Paired-end Alignment:

n_fastq_files=$(ls fastq_files/*_trimmed.fq | wc -l)

n_files=0
for i in $(cat $runs)
do
  ((n_files=n_files+1))
done

if ((n_files==n_fastq_files)); then

 printf "\nSingle-end Experment Alignment\n"

 for i in $(cat $runs)
 do
    echo
    echo "Processing sample ${i}"
    echo
    salmon quant -i salmon_index -l A \
        -r fastq_files/${i}.fastq \
        --gcBias --numGibbsSamples 20 \
        -p 8 --validateMappings \
        -o salmon_quants/${i}_quant
 done

 j=0
 cd salmon_quants
 for i in $(cat $runs)
 do
    files=($cwd/salmon_quants/*)
    mv $(echo "${files[$j]}") $i
    j=$((j+1))
 done

elif ((n_fastq_files==2*n_files)); then

 printf "\nPaired-end Experment Alignment\n"
 
 j=0
 VAR1="fastq_files/"
 VAR2="_1_trimmed.fq"
 VAR3="_2_trimmed.fq"
 for i in $(cat $runs)
 do
    echo
    echo "Processing sample ${i}"
    echo
    salmon quant -i salmon_index -l A \
      -1 $VAR1${i}$VAR2 \
      -2 $VAR1${i}$VAR3 \
      --gcBias --numGibbsSamples 20 \
      -p 8 --validateMappings -o salmon_quants/${i}
    j=$((j+2))
 done
else
 echo "There was an error in the data download step."
fi
