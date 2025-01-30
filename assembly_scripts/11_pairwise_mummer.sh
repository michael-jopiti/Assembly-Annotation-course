#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=100G
#SBATCH --cpus-per-task=32
#SBATCH --job-name=pw_mum
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mjopiti/assembly-course/scripts/outputs/pairwise_mummer_%j.o
#SBATCH --error=/data/users/mjopiti/assembly-course/scripts/errors/pairwise_mummer_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mjopiti/assembly-course

ASSEMBLY_FLYE=$WORKDIR/assemblies/flye-assembly/assembly.fasta
ASSEMBLY_LJA=$WORKDIR/assemblies/lja/assembly.fasta  
ASSEMBLY_HIFIASM=$WORKDIR/assemblies/hifiasm-assembly/assembly_hifiasm.fa

OUTPUT_DIR=$WORKDIR/mummer/comparison

OUTPUT_NUCMER_FLYE_HIFIASM=$OUTPUT_DIR/flye_hifiasm
OUTPUT_NUCMER_HIFIASM_LJA=$OUTPUT_DIR/hifiasm_lja
OUTPUT_NUCMER_LJA_FLYE=$OUTPUT_DIR/lja_flye

# # Run nucmer for pairwise comparisons
# apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif nucmer --breaklen 1000 --mincluster 1000 -p $OUTPUT_NUCMER_FLYE_HIFIASM/flye_hifiasm_nucmer -t 32 $ASSEMBLY_FLYE $ASSEMBLY_HIFIASM
# apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif nucmer --breaklen 1000 --mincluster 1000 -p $OUTPUT_NUCMER_HIFIASM_LJA/hifiasm_lja_nucmer -t 32 $ASSEMBLY_HIFIASM $ASSEMBLY_LJA
# apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif nucmer --breaklen 1000 --mincluster 1000 -p $OUTPUT_NUCMER_LJA_FLYE/lja_flye_nucmer -t 32 $ASSEMBLY_LJA $ASSEMBLY_FLYE

# Run mummerplot for pairwise comparisons
apptainer exec --bind $WORKDIR --bind /data /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $ASSEMBLY_FLYE -Q $ASSEMBLY_HIFIASM -breaklen 1000 --filter -t png --large --layout --fat -p $OUTPUT_MUMMER_FLYE_HIFIASM/flye_hifiasm_mummer $OUTPUT_NUCMER_FLYE_HIFIASM/flye_hifiasm_nucmer.delta
apptainer exec --bind $WORKDIR --bind /data /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $ASSEMBLY_HIFIASM -Q $ASSEMBLY_LJA -breaklen 1000 --filter -t png --large --layout --fat -p $OUTPUT_MUMMER_HIFIASM_LJA/hifiasm_lja_mummer $OUTPUT_NUCMER_HIFIASM_LJA/hifiasm_lja_nucmer.delta
apptainer exec --bind $WORKDIR --bind /data /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $ASSEMBLY_LJA -Q $ASSEMBLY_FLYE -breaklen 1000 --filter -t png --large --layout --fat -p $OUTPUT_MUMMER_LJA_FLYE/lja_flye_mummer $OUTPUT_NUCMER_LJA_FLYE/lja_flye_nucmer.delta
