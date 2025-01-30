#!/usr/bin/env bash

#SBATCH --time=1-10:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=BLAST
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/blast_output%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/blast_error%j.e
#SBATCH --partition=pibu_el8

PROTEINS=/data/users/mjopiti/annotation-course/script/final/assembly.all.maker.proteins.fasta.renamed.fasta
OUTDIR=/data/users/mjopiti/annotation-course/blastp_output

mkdir -p $OUTDIR

module load BLAST+/2.15.0-gompi-2021a

blastp -query $PROTEINS -db /data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa -num_threads 10 -outfmt 6 -evalue 1e-10 -out $OUTDIR/blastp