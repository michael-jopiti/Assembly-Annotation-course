#!/usr/bin/env bash

#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --output=/data/users/mjopiti/assembly-course/scripts/outputs/jelly_%j.o
#SBATCH --error=/data/users/mjopiti/assembly-course/scripts/errors/jelly_%j.e

#SBATCH --cpus-per-task=4
#SBATCH --mem=100G
#SBATCH --time=01:00:00
#SBATCH --job-name=k-mers
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mjopiti/assembly-course

GENOMIC_INPUT_DIR=$WORKDIR/Ishikawa
GENOMIC_FASTP_READS_OUTPUT_DIR=$WORKDIR/read_QC/Fastp_results/genomic/reads
GENOMIC_JELLY_OUTPUT_DIR=$WORKDIR/read_QC/Jelly_results/genomic

TRANSCRIPTOMIC_INPUT_DIR=$WORKDIR/RNAseq_Sha
TRANSCRIPTOMIC_FASTP_READS_OUTPUT_DIR=$WORKDIR/read_QC/FastQC_results/transcriptomic
TRANSCRIPTOMIC_JELLY_OUTPUT_DIR=$WORKDIR/read_QC/Jelly_results/transcriptomic

### to run with the apptainer, but jellyfish is a module so, just run it straight

# apptainer exec \
# --bind $WORKDIR \
# /containers/apptainer/fastqc-0.12.1.sif \
# jellyfish \
# --help

module load Jellyfish/2.3.0-GCC-10.3.0

mkdir -p $GENOMIC_JELLY_OUTPUT_DIR
mkdir -p $TRANSCRIPTOMIC_JELLY_OUTPUT_DIR

    ## run k-mers count with jellyfish count (example from http://genomescope.org/)
# jellyfish count -C -m 21 -s 1000000000 -t 10 *.fastq -o reads.jf
    ## modify according to SBATCH memory and cores, adding path to files
        ### -m is the kmers-length
        ### -s is the ram
        ### -t it's the cores


# jellyfish count -C -m 21 -s 10G -t 4 -o $GENOMIC_JELLY_OUTPUT_DIR/genomic_reads.jf <(zcat $GENOMIC_INPUT_DIR/*.fastq.gz)
# jellyfish histo -t 4 $GENOMIC_JELLY_OUTPUT_DIR/genomic_reads.jf > $GENOMIC_JELLY_OUTPUT_DIR/reads.histo

jellyfish count -C -m 21 -s 10G -t 4 -o $TRANSCRIPTOMIC_JELLY_OUTPUT_DIR/genomic_reads.jf <(zcat $TRANSCRIPTOMIC_INPUT_DIR/*.fastq.gz)
jellyfish histo -t 4 $TRANSCRIPTOMIC_JELLY_OUTPUT_DIR/genomic_reads.jf > $TRANSCRIPTOMIC_JELLY_OUTPUT_DIR/reads.histo