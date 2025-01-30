#!/bin/bash
#SBATCH --time=1-0
#SBATCH --mem=10G
#SBATCH -p pibu_el8
#SBATCH --nodes=5
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=Maker
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/maker_questions_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/maker_questions_%j.e

# How many genes
grep -c "gene" /data/users/mjopiti/annotation-course/script/maker_assembly_output/assembly.all.maker.gff
grep -c "gene" /data/users/mjopiti/annotation-course/script/maker_assembly_output/assembly.all.maker.noseq.gff


