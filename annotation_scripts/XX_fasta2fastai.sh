#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=Fasta2Fastai
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/F2FAI_output_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/F2FAI_error_%j.e
#SBATCH --partition=pibu_el8

module load SAMtools/1.13-GCC-10.3.0
ASSEMBLY_DIR=/data/users/mjopiti/assembly-course/assemblies/flye-assembly

samtools faidx $ASSEMBLY_DIR/assembly.fasta --fai-idx $ASSEMBLY_DIR/Flye.fai
