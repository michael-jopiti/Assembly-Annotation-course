#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=20
#SBATCH --job-name=EDTA
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/output_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/error_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mjopiti/annotation-course/
ASSEMBLY=/data/users/mjopiti/assembly-course/assemblies/flye-assembly/assembly.fasta

OUTDIR=$WORKDIR/output/EDTA_annotation 
mkdir -p $OUTDIR 
cd $OUTDIR 

apptainer exec -C -H $WORKDIR -H ${pwd}:/work \
--writable-tmpfs -u /data/courses/assembly-annotation-course/containers2/EDTA_v1.9.6.sif \
EDTA.pl \
--genome $ASSEMBLY \
--species others \
--step all \
--cds "/data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated" \
--anno 1 \
--threads 20