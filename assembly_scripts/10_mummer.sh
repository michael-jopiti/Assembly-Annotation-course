#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=100G
#SBATCH --cpus-per-task=32
#SBATCH --job-name=MUMmer
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=stardt,end
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mjopiti/assembly-course

READS=/data/users/mjopiti/assembly-course/Ishikawa/ERR11437319.fastq.gz

ASSEMBLY_FLYE=/data/users/mjopiti/assembly-course/assemblies/flye-assembly/assembly.fasta
ASSEMBLY_LJA=/data/users/mjopiti/assembly-course/assemblies/lja/assembly.fa  
ASSEMBLY_HIFIASM=/data/users/mjopiti/assembly-course/assemblies/hifiasm-assembly/assembly_hifiasm.fa  

OUTPUT_DIR_HIFIASM=/data/users/mjopiti/assembly-course/mummer/Hifiasm
OUTPUT_DIR_FLYE=/data/users/mjopiti/assembly-course/mummer/Flye
OUTPUT_DIR_LJA=/data/users/mjopiti/assembly-course/mummer/Lja

REF_FILE=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa


apptainer exec \
--bind $WORKDIR \
/containers/apptainer/mummer4_gnuplot.sif \
nucmer --breaklen 1000 --mincluster 1000 -p $OUTPUT_DIR_LJA/lja/lja_mummer -t 32 $REF_FILE $ASSEMBLY_LJA

apptainer exec \
--bind $WORKDIR \
/containers/apptainer/mummer4_gnuplot.sif \
nucmer --breaklen 1000 --mincluster 1000 -p $OUTPUT_DIR_FLYE/Flye/flye_mummer -t 32 $REF_FILE $ASSEMBLY_FLYE

apptainer exec \
--bind $WORKDIR \
/containers/apptainer/mummer4_gnuplot.sif \
nucmer --breaklen 1000 --mincluster 1000 -p $OUTPUT_DIR_HIFIASM/Hifiasm/Hifiasm_mummer -t 32 $REF_FILE $ASSEMBLY_HIFIASM