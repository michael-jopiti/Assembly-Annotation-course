#!/usr/bin/env bash

#SBATCH --time=30:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=retand
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/retand_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/retand_%j.e
#SBATCH --partition=pibu_el8

INPUT_FILE=/data/users/mjopiti/annotation-course/script/assembly.fasta.mod_output/assembly.fasta.mod.LTR.intact.fa.rexdb-plant.cls.tsv

# Extract Retand LTRs and assign them red color (#FF0000)
grep -e "Retand" $INPUT_FILE | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FF0000 Retand/' > Retand_ID.txt

# Extract Gypsy LTRs and assign them green color (#00FF00)
grep -e "Gypsy" $INPUT_FILE | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #00FF00 Gypsy/' > Gypsy_ID.txt

# Extract Copia LTRs and assign them blue color (#0000FF)
grep -e "Copia" $INPUT_FILE | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #0000FF Copia/' > Copia_ID.txt



# simplebar
grep -o 'TE_[0-9]\{8\}_INT[[:space:]]*[0-9]\+' /data/users/mjopiti/annotation-course/output/EDTA_annotation/assembly.fasta.mod.EDTA.TEanno.sum > simplebar.txt
sed 's/[[:space:]]\+/,/g' simplebar.txt > simplebar_comma.txt
