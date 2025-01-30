#!/bin/bash

#SBATCH --time=1-0
#SBATCH --mem=64G
#SBATCH -p pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --job-name=seqStat
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/seqStat_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/seqStat_%j.e

module load SeqKit/2.6.1

seqkit stats /data/users/mjopiti/assembly-course/assemblies/flye-assembly/assembly.fasta
