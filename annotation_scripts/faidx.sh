#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=faidx
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/faidx_output_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/faidx_error_%j.e
#SBATCH --partition=pibu_el8

cd final

PROTEINS=/data/users/mjopiti/annotation-course/script/final/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
TRANSCRIPTS=/data/users/mjopiti/annotation-course/script/final/assembly.all.maker.transcripts.fasta.renamed.filtered.fasta

#commands
module load SAMtools/1.13-GCC-10.3.0

samtools faidx $PROTEINS
samtools faidx $TRANSCRIPTS