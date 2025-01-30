#!/usr/bin/env bash

#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --output=/data/users/mjopiti/assembly-course/scripts/outputs/fastp_%j.o
#SBATCH --error=/data/users/mjopiti/assembly-course/scripts/errors/fastp_%j.e

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastp
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mjopiti/assembly-course

GENOMIC_INPUT_DIR=$WORKDIR/Ishikawa
GENOMIC_FASTP_READS_OUTPUT_DIR=$WORKDIR/read_QC/Fastp_results/genomic/reads
GENOMIC_FASTP_HTML_OUTPUT_DIR=$WORKDIR/read_QC/Fastp_results/genomic/html

TRANSCRIPTOMIC_INPUT_DIR=$WORKDIR/RNAseq_Sha
TRANSCRIPTOMIC_FASTP_READS_OUTPUT_DIR=$WORKDIR/read_QC/Fastp_results/transcriptomic/reads
TRANSCRIPTOMIC_FASTP_HTML_OUTPUT_DIR=$WORKDIR/read_QC/Fastp_results/transcriptomic/html

### to run with the apptainer, but fastp is a module so, just run it

# apptainer exec \
# --bind $WORKDIR \
# /containers/apptainer/fastqc-0.12.1.sif \
# fastp \
# --help


module load fastp/0.23.4-GCC-10.3.0

mkdir -p $GENOMIC_FASTP_HTML_OUTPUT_DIR
mkdir -p $GENOMIC_FASTP_READS_OUTPUT_DIR

mkdir -p $TRANSCRIPTOMIC_FASTP_HTML_OUTPUT_DIR
mkdir -p $TRANSCRIPTOMIC_FASTP_READS_OUTPUT_DIR

# Fastp for my personal genomic
    ## without filtering -> -L
    ## without adapter filtering -> -A
fastp -A -L -i $GENOMIC_INPUT_DIR/ERR11437319.fastq.gz -o $GENOMIC_FASTP_READS_OUTPUT_DIR/DNA_fastp.fastq.gz 
    ## move the output in correct genomic directory
mv $WORKDIR/scripts/fastp.* $GENOMIC_FASTP_HTML_OUTPUT_DIR

# Fastp for RNA data
    ## specify with -i/-I and -o/-O the reads (1, 2)
fastp -i $TRANSCRIPTOMIC_INPUT_DIR/*_1.fastq.gz -I $TRANSCRIPTOMIC_INPUT_DIR/*_2.fastq.gz \
    -o $TRANSCRIPTOMIC_FASTP_READS_OUTPUT_DIR/R1_fastp_.fastq.gz -O $TRANSCRIPTOMIC_FASTP_READS_OUTPUT_DIR/R2_fastp.fastq.gz
    ## move the output in correct transcriptomic directory
mv $WORKDIR/scripts/fastp.* $TRANSCRIPTOMIC_FASTP_HTML_OUTPUT_DIR