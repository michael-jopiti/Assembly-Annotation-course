#!/bin/bash
#SBATCH --time=20:00
#SBATCH --mem=5G
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=5
#SBATCH --job-name=install
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/install_omadb-gffutils_output_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/install_omadb-gffutils_error_%j.e
#SBATCH --partition=pibu_el8

pip install gffutils
pip install omadb

echo "installed :D"