#!/usr/bin/env bash

#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --output=/data/users/mjopiti/assembly-course/scripts/outputs/hifiasm_%j.o
#SBATCH --error=/data/users/mjopiti/assembly-course/scripts/errors/hifiasm_%j.e

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=hifiasm
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/mjopiti/assembly-course/"

GENOMIC_INPUT_DIR="$WORKDIR/Ishikawa"

ASSEMBLIES_DIR="$WORKDIR/assemblies"

WORKDIR=/data/users/mjopiti/assembly_course

apptainer exec \
--bind /data \
/containers/apptainer/hifiasm_0.19.8.sif \
hifiasm -o $ASSEMBLIES_DIR/hifiasm-assembly/ERR11437319.asm -t 16 $GENOMIC_INPUT_DIR/ERR11437319.fastq.gz

# cd $ASSEMBLIES_DIR/hifiasm-assembly/

# awk '/^S/{print ">"$2;print $3}' ERR11437319.asm.bp.p_ctg.gfa > assembly_hifiasm.fa