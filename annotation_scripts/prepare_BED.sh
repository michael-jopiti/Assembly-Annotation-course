#!/bin/bash
#SBATCH --time=1-0
#SBATCH --mem=1G
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/BED_output_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/BED_error_%j.e
#SBATCH --partition=pibu_el8

mkdir -p bed

for accession in $(cat longest_contigs.txt); do
    echo "Processing $accession"
    # Reference the correct GFF3 file (assuming it's named as Accession.gff3)
    awk -v acc="$accession" 'BEGIN {OFS="\t"} $1 == acc && $3 == "gene" {print $1, $4-1, $5, $9}' "/data/users/mjopiti/annotation-course/script/final/filtered.genes.renamed.gff3" > "bed/$accession.bed"
done

mkdir -p peptide

for accession in $(cat longest_contigs.txt); do
    # Extract gene sequences from the selected contigs (using the BED file and the reference genome)
    bedtools getfasta -fi /data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10.fa -bed "$accession.bed" -name > "peptide/$accession.fa"
done