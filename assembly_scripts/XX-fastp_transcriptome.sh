#!/usr/bin/env bash

#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --output=/home/mjopiti/assembly_course/scripts/outputs/output_%j.o
#SBATCH --error=/home/mjopiti/assembly_course/scripts/errors/error_%j.e

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=trans_fastp
#SBATCH --partition=pibu_el8

WORKDIR="/home/mjopiti/assembly_course"

TRANSCRIPTOMIC_INPUT_DIR="/data/users/mjopiti/assembly-course/RNAseq_Sha"
TRANSCRIPTOMIC_FASTP_OUTPUT_READS="/data/users/mjopiti/assembly-course/read_QC/trascriptomic/reads"
TRANSCRIPTOMIC_FASTP_OUTPUT_HTML="/data/users/mjopiti/assembly-course/read_QC/trascriptomic/html"

module load fastp/0.23.4-GCC-10.3.0

fastp -i $TRANSCRIPTOMIC_INPUT_DIR/ERR754081_1.fastq.gz  -I $TRANSCRIPTOMIC_INPUT_DIR/ERR754081_2.fastq.gz \
    -o $TRANSCRIPTOMIC_FASTP_OUTPUT_READS/R1_fastp_.fastq.gz -O $TRANSCRIPTOMIC_FASTP_OUTPUT_READS/R2_fastp.fastq.gz
    ## move the output in correct transcriptomic directory
