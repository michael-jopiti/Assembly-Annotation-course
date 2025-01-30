#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=50G
#SBATCH --time=3:00:00
#SBATCH --job-name=lja_complete
#SBATCH --partition=pibu_el8
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --output=/data/users/mjopiti/assembly-course/scripts/outputs/output_%j.o
#SBATCH --error=/data/users/mjopiti/assembly-course/scripts/errors/error_%j.e


WORKDIR="/data/users/mjopiti/assembly-course/"
READS=/data/users/mjopiti/assembly-course/Ishikawa/ERR11437319.fastq.gz

# # rerun the LJA assembler
# WORKDIR="/data/users/mjopiti/assembly-course/"

# ASSEMBLIES_DIR="$WORKDIR/assemblies"

# echo "Starting LJA assembly"

# apptainer exec --bind /data /containers/apptainer/lja-0.2.sif lja -o $ASSEMBLIES_DIR/lja/ --reads $READS --diploid -t 64

# echo " "
# echo " "
# echo " "
# echo "---------------------------------------------------------------------------------------"
# echo " "
# echo " "
# echo "[$(date)] LJA assembly done"
# echo " "
# echo " "
# echo "---------------------------------------------------------------------------------------"
# echo " "
# echo " "
# echo " "

# Rerun the MERQURY
ASSEMBLY_LJA=/data/users/mjopiti/assembly-course/assemblies/lja/assembly.fasta
OUTPUT_DIR=/data/users/mjopiti/assembly-course/Merqury/Lja
MERYL=/data/users/mjopiti/assembly-course/scripts/meryl/test.meryl

export MERQURY="/usr/local/share/merqury"

cd $OUTPUT_DIR

echo " "
echo " "
echo " "
echo "---------------------------------------------------------------------------------------"
echo " "
echo " "
echo "[$(date)] Starting Lja MERQURY"
echo " "
echo " "
echo "---------------------------------------------------------------------------------------"
echo " "
echo " "
echo " "

apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif merqury.sh $MERYL $ASSEMBLY_LJA lja_eval

echo " "
echo " "
echo " "
echo "---------------------------------------------------------------------------------------"
echo " "
echo " "
echo "MERQURY LJA done"
echo " "
echo " "
echo "---------------------------------------------------------------------------------------"
echo " "
echo " "
echo " "

# Rerun the QUAST 
# ASSEMBLY_FILE=/data/users/mjopiti/assembly-course/assemblies/lja/assembly.fasta
# OUTPUT_DIR=/data/users/mjopiti/assembly-course/QUAST/Lja
# REFERENCES=/data/courses/assembly-annotation-course/references

# module load QUAST/5.0.2-foss-2021a

# echo "[$(date)] Starting Lja QUAST"

# quast $ASSEMBLY_FILE -o $OUTPUT_DIR -r $REFERENCES/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa -g $REFERENCES/Arabidopsis_thaliana.TAIR10.57.gff3  --eukaryote --large -t 64 

# echo " "
# echo " "
# echo " "
# echo "---------------------------------------------------------------------------------------"
# echo " "
# echo " "
# echo "QUAST LJA done"
# echo " "
# echo " "
# echo "---------------------------------------------------------------------------------------"
# echo " "
# echo " "
# echo " "