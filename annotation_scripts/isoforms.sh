#!/bin/bash
#SBATCH --time=1-0
#SBATCH --mem=64G
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --job-name=isoforms
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/isoforms_output%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/isoforms_error%j.e
#SBATCH --partition=pibu_el8


# Input file
input_file=/data/users/mjopiti/annotation-course/script/final/filtered.genes.renamed.final.gff3

# Output file
output_file=/data/users/mjopiti/annotation-course/omark_output/isoform_list.txt

# Process the file to group isoforms by gene
awk '
BEGIN { OFS="\t" }
# Skip header lines
/^#/ { next }

# For gene lines, extract the gene ID
$3 == "gene" {
    split($9, attributes, ";")
    for (i in attributes) {
        if (attributes[i] ~ /^ID=/) {
            gene_id = substr(attributes[i], 4)
        }
    }
}

# For mRNA lines, extract the mRNA ID and associate with the parent gene ID
$3 == "mRNA" {
    split($9, attributes, ";")
    mRNA_id = ""
    parent_id = ""
    for (i in attributes) {
        if (attributes[i] ~ /^ID=/) {
            mRNA_id = substr(attributes[i], 4)
        } else if (attributes[i] ~ /^Parent=/) {
            parent_id = substr(attributes[i], 8)
        }
    }
    if (parent_id == gene_id) {
        isoforms[gene_id] = isoforms[gene_id] ? isoforms[gene_id] ";" mRNA_id : mRNA_id
    }
}

# After processing the file, print the grouped isoforms
END {
    for (gene in isoforms) {
        print isoforms[gene]
    }
}' "$input_file" > "$output_file"