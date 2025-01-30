#!/bin/bash
#SBATCH --time=1-0
#SBATCH --mem=50G
#SBATCH -p pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=clustalo
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/clustalo_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/clustalo_%j.e


OUTPUT_DIR=/data/users/mjopiti/annotation-course/script

module load Clustal-Omega/1.2.4-GCC-10.3.0

clustalo -i /data/users/mjopiti/annotation-course/script/Copia_sequences.fa -o $OUTPUT_DIR/Copia/Copia_aligned.fasta

clustalo -i /data/users/mjopiti/annotation-course/script/Gypsy_sequences.fa -o $OUTPUT_DIR/Gypsy/Gypsy_aligned.fasta