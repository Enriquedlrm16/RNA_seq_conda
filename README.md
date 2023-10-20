# RNA_seq_conda
This repository is just to show the five most important lines in Bash scripting (Linux) to perform an alignment of a paired-end/single-end RNA-seq example using conda for salmon. 
<br><br>

> bash quality_control_paired-end.sh SRR_Acc_List.txt <br>
> bash trimmomatic_paired-end.sh SRR_Acc_List.txt <br>
> bash quality_control_single-end_trimmed.sh SRR_Acc_List.txt <br>
> conda activate salmon <br>
> bash salmon_index.sh <br>
> bash salmon_alignment.sh SRR_Acc_List.txt






