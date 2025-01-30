#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=100G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=trinity_busco
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=end
#SBATCH --partition=pibu_el8

ASSEMBLY_FILE=/data/users/mjopiti/assembly-course/assemblies/trinity.Trinity.fasta
OUTPUT_DIR=/data/users/mjopiti/assembly-course/BUSCO/Trinity

module load BUSCO/5.4.2-foss-2021a

busco \
--in $ASSEMBLY_FILE \
--out_path $OUTPUT_DIR \
--out busco_transcriptome \
--mode transcriptome \
-l brassicales_odb10 \
--cpu 16