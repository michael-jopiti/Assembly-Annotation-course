#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=100G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=lja_quast
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=end
#SBATCH --partition=pibu_el8


ASSEMBLY_FILE=/data/users/mjopiti/assembly-course/assemblies/lja/assembly.fasta
OUTPUT_DIR=/data/users/mjopiti/assembly-course/QUAST/Lja
REFERENCES=/data/courses/assembly-annotation-course/references

module load QUAST/5.0.2-foss-2021a

quast\
 $ASSEMBLY_FILE \
-o $OUTPUT_DIR \
-r $REFERENCES/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa \
-g $REFERENCES/Arabidopsis_thaliana.TAIR10.57.gff3  \
--eukaryote \
--large \
-t 16 