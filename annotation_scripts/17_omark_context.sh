#!/bin/bash
#SBATCH --time=1-0
#SBATCH --mem=64G
#SBATCH -p pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=5
#SBATCH --job-name=OMARK_context
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/omark_context_output_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/omark_context_error_%j.e
#SBATCH --partition=pibu_el8

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
OMAMEROUT=/data/users/mjopiti/annotation-course/script/final/assembly.all.maker.proteins.fasta.renamed.filtered.fasta.omamer
OUTDIR=/data/users/mjopiti/annotation-course/script/omark_output

# Download the Orthologs of fragmented and missing genes from OMArk database
# had to install omadb and gffutils manually...

$COURSEDIR/softwares/OMArk-0.3.0/utils/omark_contextualize.py fragment -m $OMAMEROUT -o $OUTDIR -f fragment_HOGs
$COURSEDIR/softwares/OMArk-0.3.0/utils/omark_contextualize.py missing -m $OMAMEROUT -o $OUTDIR