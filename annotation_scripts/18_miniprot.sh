#!/bin/bash
#SBATCH --time=1-0
#SBATCH --mem=64G
#SBATCH -p pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --job-name=MiniProt
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/miniprot_output_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/miniprot_error_%j.e
#SBATCH --partition=pibu_el8

ASSEMBLY=/data/users/mjopiti/assembly-course/assemblies/flye-assembly/assembly.fasta
MISSING=/data/users/mjopiti/annotation-course/script/missing_output.fa

OUTDIR=/data/users/mjopiti/annotation-course/miniprot_output

mkdir -p $OUTDIR

./miniprot/miniprot -I --gff --outs=0.95 $ASSEMBLY $MISSING > $OUTDIR/missing.gff