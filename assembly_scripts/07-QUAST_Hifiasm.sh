#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=Hifiasm_quast
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mjopiti/assembly_course/scripts/outputs/quast_hifiasm_%j.o
#SBATCH --error=/data/users/mjopiti/assembly-course/scripts/errors/quast_hifiasm_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mjopiti/assembly-course
ASSEMBLY_FILE=/data/users/mjopiti/assembly-course/assemblies/hifiasm-assembly/assembly_hifiasm.fa
OUTPUT_DIR=/data/users/mjopiti/assembly-course/QUAST/Hifiasm
REF_FILE=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
REF_FEATURE=/data/courses/assembly-annotation-course/references/TAIR10_GFF3_genes.gff

#REFERENCES=/data/courses/assembly-annotation-course/references

# Arabidopsis_thaliana.TAIR10.57.gff3

# module load QUAST/5.0.2-foss-2021a

# quast $ASSEMBLY_FILE -o $OUTPUT_DIR -r $REFERENCES/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa -g $REFERENCES/TAIR10_GFF3_genes.gff --eukaryote --large -t 16

# apptainer exec --bind $WORKDIR /containers/apptainer/quast_5.2.0.sif\
#  quast.py -o $OUTPUT_DIR --labels Ishikawa_Hifiasm -r $REF_FILE --features $REF_FEATURE --threads 16 --eukaryote $ASSEMBLY_FILE

apptainer exec --bind /data/courses/assembly-annotation-course/references --bind $WORKDIR /containers/apptainer/quast_5.2.0.sif\
 quast.py -o $OUTPUT_DIR --labels Ishikawa_Hifiasm -r $REF_FILE --features $REF_FEATURE --threads 16 --eukaryote $ASSEMBLY_FILE

# apptainer exec --bind $WORKDIR /containers/apptainer/quast_5.2.0.sif\
#  quast.py -o $HIFIASMRESULTS --labels Kar1_hifiasm -r $REF --features $REF_FEATURE --threads
#  16 --eukaryote $HIFIASM