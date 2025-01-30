#!/bin/bash
#SBATCH --time=1-0
#SBATCH --mem=50G
#SBATCH -p pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=perl
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/perl_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/perl_%j.e


INPUT_FILE=/data/users/mjopiti/annotation-course/output/EDTA_annotation/assembly.fasta.mod.EDTA.anno/assembly.fasta.mod.out
OUTDIR=/data/users/mjopiti/annotation-course/perl_output
parseRM=/data/courses/assembly-annotation-course/CDS_annotation/scripts/05-parseRM.pl 
WORKDIR=/data/users/mjopiti/annotation-course/perl

mkdir -p $OUTDIR
mkdir -p $WORKDIR

cd $OUTDIR

module add BioPerl/1.7.8-GCCcore-10.3.0

perl $parseRM -i $INPUT_FILE -l 50,1 -v