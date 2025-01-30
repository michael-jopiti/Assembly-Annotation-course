#!/bin/bash
#SBATCH --time=1-0
#SBATCH --mem=50G
#SBATCH -p pibu_el8
#SBATCH --nodes=15
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=Augustus
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/Augustus_output_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/Augustus_error_%j.e

# Output Preparation [5]

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
ASSEMBLY_MAKER_OUTPUT="/data/users/mjopiti/annotation-course/gene-annotation/assembly.maker.output"
REPEATMASKER_DIR=/data/courses/assembly-annotation-course/CDS_annotation/softwares/RepeatMasker

export PATH=$PATH:"/data/courses/assembly-annotation-course/CDS_annotation/softwares/RepeatMasker"
module load OpenMPI/4.1.1-GCC-10.3.0
module load AUGUSTUS/3.4.0-foss-2021a
mpiexec --oversubscribe -n 50 apptainer exec --bind $SCRATCH:/TMP --bind $COURSEDIR --bind $AUGUSTUS_CONFIG_PATH --bind $REPEATMASKER_DIR ${COURSEDIR}/containers/MAKER_3.01.03.sif maker -mpi --ignore_nfs_tmp -TMP /TMP maker_opts.ctl maker_bopts.ctl maker_evm.ctl maker_exe.ctl
