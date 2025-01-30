#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=5
#SBATCH --job-name=meryl_prep
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/assembly-course/scripts/outputs/output_%j.o
#SBATCH --error=/data/users/mjopiti/assembly-course/scripts/errors/error_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mjopiti/assembly-course

READS_FILE=/data/users/mjopiti/assembly-course/Ishikawa/ERR11437319.fastq.gz

MERYL=$WORKDIR/scripts/meryl

export MERQURY="/usr/local/share/merqury"

# find best kmer size

# apptainer exec --bind /data\
#  /containers/apptainer/merqury_1.3.sif\
#  $MERQURY/best_k.sh 135000000 

# genome: 135000000
# tolerable collision rate: 0.001
# 18.4864
k=18

# build kmer dbs
apptainer exec --bind /data\
 /containers/apptainer/merqury_1.3.sif\
 meryl k=$k count $READS_FILE output $MERYL/.meryl
