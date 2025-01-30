#!/usr/bin/env bash

#SBATCH --time=1-10:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=putative_proteins
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/putative_output%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/putative_error%j.e
#SBATCH --partition=pibu_el8


COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation/
WORKDIR=/data/users/mjopiti/annotation-course/script

MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
UNIPROT=$COURSEDIR/data/uniprot/uniprot_viridiplantae_reviewed.fa
BLAST=/data/users/mjopiti/annotation-course/blastp_output/blastp

PROTEINS=/data/users/mjopiti/annotation-course/script/final/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
FILTERED=$WORKDIR/final/filtered.genes.renamed.gff3

cp $PROTEINS $WORKDIR/final/maker_proteins.fasta.Uniprot
cp $FILTERED $WORKDIR/final/filtered.maker.gff3.Uniprot

$MAKERBIN/maker_functional_fasta $UNIPROT $BLAST $PROTEINS > $WORKDIR/final/maker_proteins.fasta.Uniprot
$MAKERBIN/maker_functional_gff $UNIPROT $BLAST $FILTERED > $WORKDIR/final/filtered.maker.gff3.Uniprot