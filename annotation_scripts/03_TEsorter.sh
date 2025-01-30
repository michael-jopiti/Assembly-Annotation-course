#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=20
#SBATCH --job-name=TEsorter
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/TEsorter_output_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/TEsorter_error_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mjopiti/annotation-course/script
EDTA_OUTPUT=/data/users/mjopiti/annotation-course/output/EDTA_annotation
TE_LIB=$EDTA_OUTPUT/assembly.fasta.mod.EDTA.TElib.fa

module load SeqKit/2.6.1

# Extract Copia sequences
seqkit grep -r -p "Copia" $TE_LIB > Copia_sequences.fa
# Extract Gypsy sequences
seqkit grep -r -p "Gypsy" $TE_LIB > Gypsy_sequences.fa

# Run TEsorter on Copia
apptainer exec -C -H $WORKDIR -H ${pwd}:/work --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter Copia_sequences.fa -db rexdb-plant
# Run TEsorter on Gypsy
apptainer exec -C -H $WORKDIR -H ${pwd}:/work --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter Gypsy_sequences.fa -db rexdb-plant