#!/bin/bash
#SBATCH --time=1-0
#SBATCH --mem=1G
#SBATCH -p pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=Conda
#SBATCH --mail-user=michael.jopiti@unifr.ch
#SBATCH --mail-type=start,end
#SBATCH --output=/data/users/mjopiti/annotation-course/script/outputs/create_conda_output_%j.o
#SBATCH --error=/data/users/mjopiti/annotation-course/script/errors/create_conda_error_%j.e
#SBATCH --partition=pibu_el8

conda create -n my_env r-tidyverse