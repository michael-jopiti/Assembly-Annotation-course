#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=20
#SBATCH --job-name=FL_LTR
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/Visualizing_output_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/Visualizing_error_%j.e
#SBATCH --partition=pibu_el8

#Extract Percent identity of two LTRs from full length LTR-RTs: Use the file 
FL_LTR=/data/users/mjopiti/annotation-course/output/EDTA_annotation/assembly.fasta.mod.EDTA.raw/LTR/assembly.fasta.mod.LTR.intact.fa

apptainer exec --bind /data /data/courses/assembly-annotation-course/containers2/TEsorter_1.3.0.sif TEsorter $FL_LTR -db rexdb-plant
