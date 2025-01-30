#!/bin/bash
#SBATCH --time=1-0
#SBATCH --mem=64G
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --job-name=OMARK
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/omark_output%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/omark_error%j.e
#SBATCH --partition=pibu_el8

COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation/
WORKDIR=/data/users/mjopiti/annotation-course/script

protein=/data/users/mjopiti/annotation-course/script/final/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
OMArk="/data/courses/assembly-annotation-course/CDS_annotation/softwares/OMArk-0.3.0/"

ISOFORMS=/data/users/mjopiti/annotation-course/omark_output/isoform_list.txt

cd $WORKDIR

wget https://omabrowser.org/All/LUCA.h5

omamer search --db  LUCA.h5 --query ${protein} --out ${protein}.omamer

omark -f ${protein}.omamer -of ${protein} -i $ISOFORMS -d LUCA.h5 -o omark_output