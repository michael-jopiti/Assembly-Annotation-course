#!/usr/bin/env bash

#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/mjopiti/assembly_course/scripts/outputs/fastqc_%j.o
#SBATCH --error=/data/users/mjopiti/assembly-course/scripts/errors/fastqc_%j.e

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mjopiti/assembly-course

GENOMIC_INPUT_DIR=$WORKDIR/Ishikawa
GENOMIC_OUTPUT_DIR=$WORKDIR/read_QC/FastQC_results/genomic

TRANSCRIPTOMIC_INPUT_DIR=$WORKDIR/RNAseq_Sha
TRANSCRIPTOMIC_OUTPUT_DIR=$WORKDIR/read_QC/FastQC_results/transcriptomic

### to run with the apptainer, but fastqc is a module so, just run it straight

# apptainer exec \
# --bind $WORKDIR \
# /containers/apptainer/fastqc-0.12.1.sif \
# fastqc INPUT_DIR --outdir OUTPUT_DIR \
# --help


module load FastQC/0.11.9-Java-11 

mkdir -p $GENOMIC_OUTPUT_DIR
mkdir -p $TRANSCRIPTOMIC_OUTPUT_DIR

# FastQC for my personal genomic
fastqc $GENOMIC_INPUT_DIR/* -o $GENOMIC_OUTPUT_DIR


# FastQC for general transcriptomic
fastqc $TRANSCRIPTOMIC_INPUT_DIR/* -o $TRANSCRIPTOMIC_OUTPUT_DIR