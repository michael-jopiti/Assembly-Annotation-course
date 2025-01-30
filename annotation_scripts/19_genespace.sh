#!/bin/bash

#SBATCH --time=02:00:00
#SBATCH --mem=20G
#SBATCH --cpus-per-task=20
#SBATCH --job-name=genespace
#SBATCH --partition=pibu_el8
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/genespace_output_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/genespace_error_%j.e
#SBATCH --partition=pibu_el8

COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
WORKDIR=/data/users/mjopiti/annotation-course
GENESPACE=/data/users/mjopiti/annotation-course/genespace

mkdir -p $GENESPACE

apptainer exec --bind $COURSEDIR --bind "$WORKDIR" --bind "$SCRATCH:/temp" "$COURSEDIR/containers/genespace_latest.sif" Rscript "$WORKDIR/script/25-Genespace.R" $GENESPACE  