#!/usr/bin/env bash

#SBATCH --time=00:30:00
#SBATCH --mem=100G
#SBATCH --cpus-per-task=32
#SBATCH --job-name=nuc_mum
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/assembly-course/scripts/outputs/output_%j.o
#SBATCH --error=/data/users/mjopiti/assembly-course/scripts/errors/error_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mjopiti/assembly-course

READS=/data/users/mjopiti/assembly-course/Ishikawa/ERR11437319.fastq.gz

ASSEMBLY_FLYE=/data/users/mjopiti/assembly-course/assemblies/flye-assembly/assembly.fasta
ASSEMBLY_LJA=/data/users/mjopiti/assembly-course/assemblies/lja/assembly.fasta  
ASSEMBLY_HIFIASM=/data/users/mjopiti/assembly-course/assemblies/hifiasm-assembly/assembly_hifiasm.fa

OUTPUT_NUCMER_HIFIASM=/data/users/mjopiti/assembly-course/nucmer/Hifiasm
OUTPUT_NUCMER_FLYE=/data/users/mjopiti/assembly-course/nucmer/Flye
OUTPUT_NUCMER_LJA=/data/users/mjopiti/assembly-course/nucmer/Lja

OUTPUT_MUMMER_FLYE=/data/users/mjopiti/assembly-course/mummer/Flye
OUTPUT_MUMMER_HIFIASM=/data/users/mjopiti/assembly-course/mummer/Hifiasm
OUTPUT_MUMMER_LJA=/data/users/mjopiti/assembly-course/mummer/Lja

REF_FILE=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa


# First let's run nucmer
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif nucmer --breaklen 1000 --mincluster 1000 -p $OUTPUT_NUCMER_FLYE/flye_nucmer -t 32 $REF_FILE $ASSEMBLY_FLYE
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif nucmer --breaklen 1000 --mincluster 1000 -p $OUTPUT_NUCMER_HIFIASM/Hifiasm_nucmer -t 32 $REF_FILE $ASSEMBLY_HIFIASM
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif nucmer --breaklen 1000 --mincluster 1000 -p $OUTPUT_NUCMER_LJA/lja_nucmer -t 32 $REF_FILE $ASSEMBLY_LJA

# Then, let's run mummer
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $REF_FILE -Q $ASSEMBLY_FLYE -breaklen 1000 --filter -t png --large --layout --fat -p $OUTPUT_MUMMER_FLYE/Mummer_Flye  $OUTPUT_NUCMER_FLYE/flye_nucmer.delta
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $REF_FILE -Q $ASSEMBLY_HIFIASM -breaklen 1000 --filter -t png --large --layout --fat -p $OUTPUT_MUMMER_HIFIASM/Mummer_Hifiasm  $OUTPUT_NUCMER_HIFIASM/Hifiasm_nucmer.delta
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $REF_FILE -Q $ASSEMBLY_LJA -breaklen 1000 --filter -t png --large --layout --fat -p $OUTPUT_MUMMER_LJA/Mummer_LJA  $OUTPUT_NUCMER_LJA/lja_nucmer.delta