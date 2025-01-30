#!/bin/bash
#SBATCH --time=4-0
#SBATCH --mem=64G
#SBATCH -p pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=50
#SBATCH --job-name=Maker
#Sbatch --output=logs/Maker_gene_annotation_%j.out
#Sbatch --error=logs/Maker_gene_annotation_%j.err
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/MAKER_output_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/MAKER_error_%j.e

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
WORKDIR=/data/users/mjopiti/annotation_course/scripts/
REPEATMASKER_DIR="/data/courses/assembly-annotation-course/CDS_annotation/softwares/RepeatMasker"
ASSEMBLY_DIR="/data/users/mjopiti/assembly-course/assemblies/flye-assembly"



export PATH=$PATH:"/data/courses/assembly-annotation-course/CDS_annotation/softwares/RepeatMasker"

cd /data/users/mjopiti/annotation-course/gene-annotation/

module load OpenMPI/4.1.1-GCC-10.3.0
module load AUGUSTUS/3.4.0-foss-2021a
mpiexec --oversubscribe -n 50 apptainer exec --bind $SCRATCH:/TMP --bind /data --bind $AUGUSTUS_CONFIG_PATH --bind $REPEATMASKER_DIR /data/courses/assembly-annotation-course/containers2/MAKER_3.01.03.sif maker -mpi --ignore_nfs_tmp -TMP /TMP maker_opts.ctl maker_bopts.ctl maker_evm.ctl maker_exe.ctl
# mpiexec --oversubscribe -n 50 apptainer exec --bind $SCRATCH:/TMP --bind /data --bind $AUGUSTUS_CONFIG_PATH --bind $REPEATMASKER_DIR /data/courses/assembly-annotation-course/containers2/MAKER_3.01.03.sif maker -mpi --ignore_nfs_tmp -TMP /TMP maker_opts.ctl maker_bopts.ctl maker_evm.ctl maker_exe.ctl