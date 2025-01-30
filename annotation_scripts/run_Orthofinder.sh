#!/bin/bash

#SBATCH --time=01:00:00
#SBATCH --mem=5G
#SBATCH --cpus-per-task=5
#SBATCH --job-name=genespace
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/orthofinder_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/orthofinder_%j.e
#SBATCH --partition=pibu_el8

module load R/4.1.0-foss-2021a

Rscript 27-parse_Orthofinder.R