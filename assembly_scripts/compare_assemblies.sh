#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=5
#SBATCH --job-name=meryl_prep
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/assembly-course/scripts/outputs/output_%j.o
#SBATCH --error=/data/users/mjopiti/assembly-course/scripts/errors/error_%j.e
#SBATCH --partition=pibu_el


WORK_DIR=/data/users/mjopiti/assembly-course/
INPUT_DIR=$WORK_DIR/assemblies
OUTPUT_DIR=$WORK_DIR/mummer/comparison
REFERENCE_DIR=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
CONTAINER_DIR=/containers/apptainer/mummer4_gnuplot.sif


# # compare each assembly to the reference and plot
# apptainer exec --bind /data $CONTAINER_DIR \
# nucmer --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/flye.delta $REFERENCE_DIR $INPUT_DIR/flye/assembly.fasta
# apptainer exec --bind /data $CONTAINER_DIR \
# mummerplot -R $REFERENCE_DIR -Q $INPUT_DIR/flye/assembly.fasta --fat --layout --filter --breaklen 1000 -t png --large -p $OUTPUT_DIR/flye $WORK_DIR/nucmer/Flye/flye_nucmer.delta

# apptainer exec --bind /data $CONTAINER_DIR \
# nucmer --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/hifiasm.delta $REFERENCE_DIR $INPUT_DIR/hifiasm/Abd-0.asm.bp.p_ctg.fa
# apptainer exec --bind /data $CONTAINER_DIR \
# mummerplot -R $REFERENCE_DIR -Q $INPUT_DIR/hifiasm/assembly_hifiasm.fa --fat --layout --filter --breaklen 1000 -t png --large -p $OUTPUT_DIR/hifiasm $WORK_DIR/Hifiasm/hifiasm_nucmer.delta

# apptainer exec --bind /data $CONTAINER_DIR \
# nucmer --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/LJA.delta $REFERENCE_DIR $INPUT_DIR/lja/assembly.fasta
# apptainer exec --bind /data $CONTAINER_DIR \
# mummerplot -R $REFERENCE_DIR -Q $INPUT_DIR/lja/assembly.fasta --fat --layout --filter --breaklen 1000 -t png --large -p $OUTPUT_DIR/lja $WORK_DIR/Lja/lja_nucmer.delta

# # compare the assemblies against each other and plot
# apptainer exec --bind $WORK_DIR $CONTAINER_DIR \
# nucmer --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/flye_vs_hifiasm.delta $INPUT_DIR/flye/assembly.fasta $INPUT_DIR/hifiasm/Abd-0.asm.bp.p_ctg.fa
# apptainer exec --bind $WORK_DIR $CONTAINER_DIR \
# mummerplot -R $INPUT_DIR/flye/assembly.fasta -Q $INPUT_DIR/hifiasm/Abd-0
# .asm.bp.p_ctg.fa --fat --layout --filter --breaklen 1000 -t png --large 
# -p $OUTPUT_DIR/flye_vs_hifiasm_plot $OUTPUT_DIR/flye_vs_hifiasm.delta

# apptainer exec --bind $WORK_DIR $CONTAINER_DIR \
# nucmer --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/flye_vs_lja
# .delta $INPUT_DIR/flye/assembly.fasta $INPUT_DIR/lja/assembly.fasta
# apptainer exec --bind $WORK_DIR $CONTAINER_DIR \
# mummerplot -R $INPUT_DIR/flye/assembly.fasta -Q $INPUT_DIR/lja/assembly.
# fasta --fat --layout --filter --breaklen 1000 -t png --large -p $OUTPUT_
# DIR/flye_vs_lja_plot $OUTPUT_DIR/flye_vs_lja.delta

# apptainer exec --bind $WORK_DIR $CONTAINER_DIR \
# nucmer --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/hifiasm_vs_
# lja.delta $INPUT_DIR/hifiasm/Abd-0.asm.bp.p_ctg.fa $INPUT_DIR/lja/assemb
# ly.fasta
# apptainer exec --bind $WORK_DIR $CONTAINER_DIR \
# mummerplot -R $INPUT_DIR/hifiasm/Abd-0.asm.bp.p_ctg.fa -Q $INPUT_DIR/lja
# /assembly.fasta --fat --layout --filter --breaklen 1000 -t png --large -
# p $OUTPUT_DIR/hifiasm_vs_lja_plot $OUTPUT_DIR/hifiasm_vs_lja.delta