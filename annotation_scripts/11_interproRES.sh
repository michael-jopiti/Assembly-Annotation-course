#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=25G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=RESinterpro
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/interproRES_output%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/interproRES_error%j.e
#SBATCH --partition=pibu_el8

COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation/
WORKDIR=/data/users/mjopiti/annotation-course/script
FINAL=/data/users/mjopiti/annotation-course/script/final
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"

gff="assembly.all.maker.noseq.gff"

cd $FINAL

$MAKERBIN/ipr_update_gff ${gff}.renamed.gff output.iprscan > ${gff}.renamed.iprscan.gff