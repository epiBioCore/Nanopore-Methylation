#!/bin/bash

## combine all fastq files into one then index the fastq files and raw signal
dir=113
date
echo "indexing reads"
nanopolish index -d ${dir}/fast5_pass/ ${dir}/113.fastq

date

echo "aligning reads..." 
date

minimap2 -a -x map-ont genome.fa ${dir}/113.fastq | samtools sort -T tmp -o ${dir}/113.bam
samtools index ${dir}/113.bam

echo "calling methylation .."
date
nanopolish call-methylation -t 10 -r ${dir}/113.fastq -b ${dir}/113.bam -g genome.fa > 113_methylation_calls.tsv

echo "calculating methylation frequency"
date
calculate_methylation_frequency.py 113_methylation_calls.tsv > 113_methylation_frequency.tsv

echo "finished!"
date
