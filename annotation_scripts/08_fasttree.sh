#!/usr/bin/env bash

#SBATCH --time=30:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=FastTree
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/fasttree_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/fasttree_%j.e
#SBATCH --partition=pibu_el8

OUTPUT_DIR=/data/users/mjopiti/annotation-course/script
COPIA=/data/users/mjopiti/annotation-course/script/Copia_aligned.fasta
GYPSY=/data/users/mjopiti/annotation-course/script/Gypsy_aligned.fasta

module load FastTree/2.1.11-GCCcore-10.3.0

FastTree -out $OUTPUT_DIR/Copia_tree $COPIA

FastTree -out $OUTPUT_DIR/Gypsy_tree $GYPSY