#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=Flye_Merqury
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/assembly-course/scripts/outputs/output_%j.o
#SBATCH --error=/data/users/mjopiti/assembly-course/scripts/errors/error_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mjopiti/assembly-course
READS=/data/users/mjopiti/assembly-course/Ishikawa/ERR11437319.fastq.gz
ASSEMBLY_FLYE=/data/users/mjopiti/assembly-course/assemblies/flye-assembly/assembly.fasta
OUTPUT_DIR=/data/users/mjopiti/assembly-course/Merqury/Flye
MERYL=/data/users/mjopiti/assembly-course/scripts/meryl/.meryl
export MERQURY="/usr/local/share/merqury"

cd /data/users/mjopiti/assembly-course/Merqury/Flye

apptainer exec\
 --bind /data\
 /containers/apptainer/merqury_1.3.sif\
 merqury.sh $MERYL $ASSEMBLY_FLYE flye_eval