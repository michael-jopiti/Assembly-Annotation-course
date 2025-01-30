#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=100G
#SBATCH --cpus-per-task=32
#SBATCH --job-name=LJA_Merqury
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/assembly-course/scripts/outputs/merqury_lja_%j.o
#SBATCH --error=/data/users/mjopiti/assembly-course/scripts/errors/merqury_lja_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mjopiti/assembly-course
READS=/data/users/mjopiti/assembly-course/Ishikawa/ERR11437319.fastq.gz
ASSEMBLY_LJA=/data/users/mjopiti/assembly-course/assemblies/lja/assembly.fasta  
OUTPUT_DIR=/data/users/mjopiti/assembly-course/Merqury/Lja
MERYL=/data/users/mjopiti/assembly-course/scripts/meryl/.meryl

export MERQURY="/usr/local/share/merqury"

mkdir -p $OUTPUT_DIR
cd $OUTPUT_DIR

# apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif merqury.sh $MERYL $ASSEMBLY_LJA lja_eval

 apptainer exec\
 --bind /data\
 /containers/apptainer/merqury_1.3.sif\
 merqury.sh $MERYL $ASSEMBLY_LJA lja_eval
