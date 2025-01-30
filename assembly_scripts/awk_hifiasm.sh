#!/usr/bin/env bash

#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --output=/data/users/mjopiti/assembly-course/scripts/outputs/output_%j.o
#SBATCH --error=/data/users/mjopiti/assembly-course/scripts/errors/error_%j.e

#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=00:05:00
#SBATCH --job-name=awk
#SBATCH --partition=pibu_el8

PATH="/data/users/mjopiti/assembly-course/assemblies/hifiasm-assembly"

/usr/bin/awk '/^S/{print ">"$2;print $3}' $PATH/ERR11437319.asm.bp.p_ctg.gfa > $PATH/assembly_hifiasm.fa