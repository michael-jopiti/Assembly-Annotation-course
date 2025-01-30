#!/usr/bin/env bash

#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --output=/data/users/mjopiti/assembly-course/scripts/outputs/flye_%j.o
#SBATCH --error=/data/users/mjopiti/assembly-course/scripts/errors/flye_%j.e

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=flye
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/mjopiti/assembly-course/"

GENOMIC_INPUT_DIR="$WORKDIR/Ishikawa"

ASSEMBLIES_DIR="$WORKDIR/assemblies"

apptainer exec \
--bind /data \
/containers/apptainer/flye_2.9.5.sif \
flye --pacbio-hifi $GENOMIC_INPUT_DIR/ERR11437319.fastq.gz -t 16 -o $WORKDIR/assemblies/flye-assembly/