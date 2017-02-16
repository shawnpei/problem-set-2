#! /usr/bin/env bash

datasets='/Users/shanshan_pei/Documents/MOLB7621/data-sets'

# Question 1: Use BEDtools intersect to identify the size of the largest overlap
# between CTCF and H3K4me3 locations.
TFBS="$datasets/bed/encode.tfbs.chr22.bed.gz"
H3K4ME3="$datasets/bed/encode.h3k4me3.hela.chr22.bed.gz"

answer_1=$(bedtools intersect -wo -a $TFBS -b $H3K4ME3 \
    | grep -w 'CTCF' \
    | sort -k15rn \
    | cut -f15 \
    | head -1)
echo "answer-1: $answer_1"

# Question 2: Use BEDtools to calculate the GC content of nucleotides 19,000,000
# to 19,000,500 on chr22 of hg19 genome build.
# Report the GC content as a fraction (e.g., 0.50)
answer_2=$(echo -e "chr22\t19000000\t19000500" \
    | bedtools nuc -fi $datasets/fasta/hg19.chr22.fa -bed - \
    | cut -f5 \
    | tail -1 )
echo "answer-2: $answer_2"

# Question 3: Use BEDtools to identify the length of the CTCF ChIP-seq peak (i.e., interval)
# that has the largest mean signal in ctcf.hela.chr22.bg.gz.


# Question 4: Use BEDtools to identify the gene promoter
# (defined as 1000 bp upstream of a TSS) with the highest median signal
# in ctcf.hela.chr22.bg.gz. Report the gene name (e.g., 'ABC123')


# Question 5: Use BEDtools to identify the longest interval on chr22
# that is not covered by genes.hg19.bed.gz. Report the interval like chr1:100-500.



# Question 6: Use one or more BEDtools that we haven't covered in class. Be creative.


