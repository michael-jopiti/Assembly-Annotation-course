#!/bin/bash

#SBATCH --time=02:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=genespace
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/genespace_output_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/genespace_error_%j.e
#SBATCH --partition=pibu_el8

# COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
# WORKDIR=/data/users/mjopiti/annotation-course/
# GENESPACE=/data/users/mjopiti/annotation-course/script/genespace

# mkdir -p $GENESPACE
# apptainer exec --bind $COURSEDIR --bind "$WORKDIR" --bind "$SCRATCH:/temp" "$COURSEDIR/containers/genespace_latest.sif" Rscript "$WORKDIR/script/25-Genespace.R" $GENESPACE 

# load module
module load R/4.1.0-foss-2021a
module load UCSC-Utils/448-foss-2021a
module load MariaDB/10.6.4-GCC-10.3.0


# set variables
WORK_DIR=/data/users/mjopiti/annotation-course/script
SCRIPT1=/data/users/mjopiti/annotation-course/script/24-create_Genespace_folders.R
SCRIPT2=/data/users/mjopiti/annotation-course/script/25-Genespace.R
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
CONTAINER=/data/courses/assembly-annotation-course/CDS_annotation/containers/genespace_latest.sif
PEP=/data/users/amaalouf/transcriptome_assembly/annotation/output/quality/genespace/genespace/peptide
BED=/data/users/amaalouf/transcriptome_assembly/annotation/output/quality/genespace/genespace/bed

mkdir -p $PEP
mkdir -p $BED

# create dir
cd $WORK_DIR

# prepare my input files
Rscript $SCRIPT1

# add other accessions
# oriane
cp /data/users/okopp/assembly_annotation_course/genespace/bed/Kar1.bed $BED/Kar_1.bed
cp /data/users/okopp/assembly_annotation_course/genespace/peptide/Kar1.fa $PEP/Kar_1.fa
# leo
cp /data/users/okopp/assembly_annotation_course/genespace/bed/St0.bed $BED/St_0.bed
cp /data/users/okopp/assembly_annotation_course/genespace/peptide/St0.fa $PEP/St_0.fa
# rename mine
mv $BED/genome1.bed $BED/Ishikawa_1.bed
mv $PEP/genome1.fa $PEP/Ishikawa_1.fa

# run genespace
# modify manually 'wd' in $SCRIPT2 and remove arg[1] which is now useless
apptainer exec \
    --bind $COURSEDIR \
    --bind $WORK_DIR \
    --bind $SCRATCH:/temp \
    $CONTAINER\
    Rscript $SCRIPT2