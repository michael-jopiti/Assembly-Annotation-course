#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=100G
#SBATCH --cpus-per-task=32
#SBATCH --job-name=hifiasm_busco
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --partition=pibu_el8


ASSEMBLY_FILE=/data/users/mjopiti/assembly-course/assemblies/hifiasm-assembly/assembly_hifiasm.fa
OUTPUT_DIR=/data/users/mjopiti/assembly-course/BUSCO/Hifiasm

module load BUSCO/5.4.2-foss-2021a

busco --in $ASSEMBLY_FILE --out_path $OUTPUT_DIR --out busco_hifiasm --mode genome -l brassicales_odb10 --cpu 16
