#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=100G
#SBATCH --cpus-per-task=32
#SBATCH --job-name=NoRef_quast
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mjopiti/assembly_course/scripts/outputs/quast_no-ref_%j.o
#SBATCH --error=/data/users/mjopiti/assembly-course/scripts/errors/quast_no-ref_%j.e
#SBATCH --partition=pibu_el8


WORKDIR=/data/users/mjopiti/assembly-course

# ASSEMBLY_FILE_HIFIASM=/data/users/mjopiti/assembly-course/assemblies/hifiasm-assembly/assembly_hifiasm.fa
ASSEMBLY_FILE_LJA=/data/users/mjopiti/assembly-course/assemblies/lja/assembly.fasta
# ASSEMBLY_FILE_FLYE=/data/users/mjopiti/assembly-course/assemblies/flye-assembly/assembly.fasta

# OUTPUT_DIR_HIFIASM=/data/users/mjopiti/assembly-course/QUAST/no_reference/Hifiasm
OUTPUT_DIR_LJA_=/data/users/mjopiti/assembly-course/QUAST/no_reference/Lja
# OUTPUT_DIR_FLYE=/data/users/mjopiti/assembly-course/QUAST/no_reference/Flye

# module load QUAST/5.0.2-foss-2021a

# quast\
#  $ASSEMBLY_FILE_HIFIASM \
# -o $OUTPUT_DIR_HIFIASM \
# --eukaryote \
# --large \
# -t 32

quast\
 $ASSEMBLY_FILE_LJA \
-o $OUTPUT_DIR_LJA \
--eukaryote \
--large \
-t 32

#lja no ref
apptainer exec --bind $WORKDIR /containers/apptainer/quast_5.2.0.sif\
 quast.py -o $OUTPUT_DIR_LJA_ --labels Ishikawa_LJA  --threads 32 --eukaryote --est-ref-size 135000000 $ASSEMBLY_FILE_LJA

# quast\
#  $ASSEMBLY_FILE_FLYE \
# -o $OUTPUT_DIR_FLYE \
# --eukaryote \
# --large \
# -t 32