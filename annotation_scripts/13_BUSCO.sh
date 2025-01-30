#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=24
#SBATCH --job-name=BUSCO
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/BUSCO_output%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/BUSCO_error%j.e
#SBATCH --partition=pibu_el8

PROTEINS=/data/users/mjopiti/annotation-course/script/final/longest_protein.fasta
OUTDIR=/data/users/mjopiti/annotation-course/BUSCO_annotation

mkdir -p $OUTDIR

module load BUSCO/5.4.2-foss-2021a

busco -i $PROTEINS -l brassicales_odb10 -o busco_prot --out_path $OUTDIR -m proteins -f --cpu 24