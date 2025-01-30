#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=12
#SBATCH --job-name=annotation
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/maker_annotation_output%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/maker_annotation_error%j.e
#SBATCH --partition=pibu_el8

COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation/
WORKDIR=/data/users/mjopiti/annotation-course/script
FINAL=/data/users/mjopiti/annotation-course/script/final
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
prefix=con

cd $WORKDIR

protein="assembly.all.maker.proteins.fasta"
transcript="assembly.all.maker.transcripts.fasta"
gff="assembly.all.maker.noseq.gff"

cp $gff $FINAL/${gff}.renamed.gff
cp $protein $FINAL/${protein}.renamed.fasta
cp $transcript $FINAL/${transcript}.renamed.fasta

cd $FINAL

$MAKERBIN/maker_map_ids --prefix $prefix --justify 7 ${gff}.renamed.gff > id.map
$MAKERBIN/map_gff_ids id.map ${gff}.renamed.gff
$MAKERBIN/map_fasta_ids id.map ${protein}.renamed.fasta
$MAKERBIN/map_fasta_ids id.map ${transcript}.renamed.fasta