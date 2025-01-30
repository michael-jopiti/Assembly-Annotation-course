#!/bin/bash
#SBATCH --time=1-0
#SBATCH --mem=50G
#SBATCH -p pibu_el8
#SBATCH --nodes=15
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=AED_Filtering
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/AED_Filtering_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/AED_Filtering_%j.e

# Filtering and Refining Gene Annotations [6]

module load UCSC-Utils/448-foss-2021a
module load BioPerl/1.7.8-GCCcore-10.3.0
module load MariaDB/10.6.4-GCC-10.3.0

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
ASSEMBLY_MAKER_OUTPUT="/data/users/mjopiti/annotation-course/gene-annotation/assembly.maker.output"

mkdir -p final

protein="assembly.all.maker.proteins.fasta"
transcript="assembly.all.maker.transcripts.fasta"
gff="assembly.all.maker.noseq.gff"

cp $gff final/${gff}.renamed.gff
cp $protein final/${protein}.renamed.fasta
cp $transcript final/${transcript}.renamed.fasta

cd final

$MAKERBIN/maker_map_ids --prefix $prefix --justify 7 ${gff}.renamed.gff > id.map
$MAKERBIN/map_gff_ids id.map ${gff}.renamed.gff
$MAKERBIN/map_fasta_ids id.map ${protein}.renamed.fasta
$MAKERBIN/map_fasta_ids id.map ${transcript}.renamed.fasta

apptainer exec \
    --bind $COURSEDIR/data/interproscan-5.70-102.0/data:/opt/interproscan/data \
    --bind $WORKDIR \
    --bind $COURSEDIR \
    --bind $SCRATCH:/temp \
    $COURSEDIR/containers/interproscan_latest.sif \
    /opt/interproscan/interproscan.sh \
    -appl pfam --disable-precalc -f TSV \
    --goterms --iprlookup --seqtype p \
    -i ${protein}.renamed.fasta -o output.iprscan

$MAKERBIN/ipr_update_gff ${gff}.renamed.gff output.iprscan > ${gff}.renamed.iprscan.gff

parseRM=/data/courses/assembly-annotation-course/CDS_annotation/scripts/04-parseRM.pl
INPUT_FILE=$WORKDIR/annotation/EDTA/assembly.fasta.mod.EDTA.anno/assembly.fasta.mod.out

perl $MAKERBIN/AED_cdf_generator.pl -b 0.025 ${gff}.renamed.gff > assembly.all.maker.renamed.gff.AED.txt


# Filter the gff file based on AED values and Pfam domains, with threshold 0.5
QUALITY_FILTER=/data/users/mjopiti/annotation-course/script/quality_filter.pl

mkdir -p ../final_annotation
cd ../final_annotation

cp ../final/$gff ${gff}.renamed.gff
cp ../final/$protein ${protein}.renamed.fasta 
cp ../final/$transcript ${transcript}.renamed.fasta

perl $QUALITY_FILTER -s ${gff}.renamed.iprscan.gff > ${gff}_iprscan_quality_filtered.gff

# The gff also contains other features like Repeats, and match hints from different sources of evidence
# Let's see what are the different types of features in the gff file
cut -f3 ${gff}_iprscan_quality_filtered.gff | sort | uniq

# We only want to keep gene features in the third column of the gff file
grep -P "\tgene\t|\tCDS\t|\texon\t|\tfive_prime_UTR\t|\tthree_prime_UTR\t|\tmRNA\t" ${gff}_iprscan_quality_filtered.gff > filtered.genes.renamed.gff3
cut -f3 filtered.genes.renamed.gff3 | sort | uniq

# We need to add back the gff3 header to the filtered gff file so that it can be used by other tools
grep "^#" ../final/${gff}_iprscan_quality_filtered.gff > header.txt
cat header.txt filtered.genes.renamed.gff3 > filtered.genes.renamed.final.gff3

# Get the names of remaining mRNAs and extract them from the transcript and and their proteins from the protein files
grep -P "\tmRNA\t" filtered.genes.renamed.final.gff3 | awk '{print $9}' | cut -d ';' -f1 | sed 's/ID=//g' >mRNA_list.txt
faSomeRecords ${transcript}.renamed.fasta mRNA_list.txt ${transcript}.renamed.filtered.fasta
faSomeRecords ${protein}.renamed.fasta mRNA_list.txt ${protein}.renamed.filtered.fasta