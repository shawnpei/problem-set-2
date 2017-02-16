#! /usr/bin/env bash

# Define file path
datasets='/Users/shanshan_pei/Documents/MOLB7621/data-sets'
TFBS="$datasets/bed/encode.tfbs.chr22.bed.gz"
H3K4ME3="$datasets/bed/encode.h3k4me3.hela.chr22.bed.gz"
CTCF="$datasets/bedtools/ctcf.hela.chr22.bg.gz"
hg19chr22="$datasets/fasta/hg19.chr22.fa"
chr22TSS="$datasets/bed/tss.hg19.chr22.bed.gz"
hg19genes="$datasets/bed/genes.hg19.bed.gz"

# Question 1: Use BEDtools intersect to identify the size of the largest
# overlap between CTCF and H3K4me3 locations.
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
    | bedtools nuc -fi $hg19chr22 -bed - \
    | cut -f5 \
    | tail -1)
echo "answer-2: $answer_2"

# Question 3: Use BEDtools to identify the length of the CTCF ChIP-seq peak (i.e., interval)
# that has the largest mean signal in ctcf.hela.chr22.bg.gz.
answer_3=$(bedtools map -a $TFBS -b $CTCF -c 4 -o mean \
    | awk 'BEGIN {OFS="\t"} ($4 == "CTCF") {print $0, $3-$2}' \
    | sort -k5nr \
    | head -1 \
    | cut -f6)
echo "answer-3: $answer_3"

# Question 4: Use BEDtools to identify the gene promoter
# (defined as 1000 bp upstream of a TSS) with the highest median signal
# in ctcf.hela.chr22.bg.gz. Report the gene name (e.g., 'ABC123')
answer_4=$(gzcat $chr22TSS \
    | awk '{OFS="\t"} {if ($6 =="+" ) print $1,$2-1000,$2,$4,$5,$6; else print $1,$2,$2+1000,$4,$5,$6}' \
    | bedtools sort -i - \
    | bedtools map -a - -b $CTCF -c 4 -o median \
    | sort -k7nr \
    | cut -f4 \
    | head -1)
echo "answer-4: $answer_4"

# Question 5: Use BEDtools to identify the longest interval on chr22
# that is not covered by genes.hg19.bed.gz. Report the interval like chr1:100-500.
answer_5=$(echo -e "chr22\t0\t51304566" \
    | bedtools subtract -a - -b $hg19genes \
    | awk '{OFS="\t"}{print $0, $3-$2}' \
    | sort -k4nr \
    | head -1 \
    | awk '{OFS=""}{print $1,":",$2,"-",$3}')
echo "answer-5: $answer_5"


# Question 6: Use one or more BEDtools that we haven't covered in class. Be creative.
echo "answer-6: I have used the bedtools nuc and subtract functions to
answer Q2 and Q5"

