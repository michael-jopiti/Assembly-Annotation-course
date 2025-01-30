#!/usr/bin/env bash

#SBATCH --cpus-per-task=64
#SBATCH --mem=100G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=LJA
#SBATCH --partition=pibu_el8
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --output=/data/users/mjopiti/assembly-course/scripts/outputs/lja_%j.o
#SBATCH --error=/data/users/mjopiti/assembly-course/scripts/errors/lja_%j.e

WORKDIR="/data/users/mjopiti/assembly-course/"

GENOMIC_INPUT_DIR="$WORKDIR/Ishikawa"

ASSEMBLIES_DIR="$WORKDIR/assemblies"

WORKDIR=/data/users/mjopiti/assembly_course

apptainer exec --bind /data /containers/apptainer/lja-0.2.sif lja -o $ASSEMBLIES_DIR/lja/ --reads $GENOMIC_INPUT_DIR/ERR11437319.fastq.gz --diploid -t 64
