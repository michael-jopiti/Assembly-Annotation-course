#!/bin/bash
#SBATCH --time=1-0
#SBATCH --mem=50G
#SBATCH -p pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=pro-scan
#Sbatch --output=logs/pro-scan_%j.out
#Sbatch --error=logs/pro-scan%j.err
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/pro-scan_output_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/pro-scan_error_%j.e

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"

apptainer exec  --bind /data --bind $COURSEDIR/data/interproscan-5.70-102.0/data:/opt/interproscan/data --bind $WORKDIR --bind $COURSEDIR --bind $SCRATCH:/temp $COURSEDIR/containers/interproscan_latest.sif /opt/interproscan/interproscan.sh -appl pfam --disable-precalc -f TSV --goterms --iprlookup --seqtype p -i ${protein}.renamed.fasta -o output.iprscan