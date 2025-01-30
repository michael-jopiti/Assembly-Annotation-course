#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=20G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=CtrlFiles
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/ControlFiles_output_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/ControlFiles_error_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mjopiti/annotation-course/gene-annotation
mkdir -p $WORKDIR
cd $WORKDIR

apptainer exec --bind /data /data/courses/assembly-annotation-course/containers2/MAKER_3.01.03.sif maker -CTL
