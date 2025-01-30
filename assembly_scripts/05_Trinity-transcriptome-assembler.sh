#!/usr/bin/env bash

#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --output=/data/users/mjopiti/assembly-course/scripts/outputs/output_%j.oq
#SBATCH --error=/data/users/mjopiti/assembly-course/scripts/errors/error_%j.e

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=trinity
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/mjopiti/assembly-course/"
#TRANSCRIPTOMIC_FASTP_READS_OUTPUT_DIR
ASSEMBLIES_DIR="$WORKDIR/assemblies"

#Oriane's fastp trimmed transcriptome
LE_O_TRIMMED_TRANSCRIPTOME="/data/users/okopp/assembly_annotation_course/trimming"

TRINITY_OUTPUT_DIR="/data/users/mjopiti/assembly-course/assemblies/trinity"


module load Trinity/2.15.1-foss-2021a

Trinity --seqType fq --left $LE_O_TRIMMED_TRANSCRIPTOME/RNA_1.trimm.fastq.gz --right $LE_O_TRIMMED_TRANSCRIPTOME/RNA_2.trimm.fastq.gz --CPU 16 --max_memory 60G --output $TRINITY_OUTPUT_DIR