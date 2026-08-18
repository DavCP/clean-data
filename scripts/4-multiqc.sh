#!/bin/bash
#SBATCH --job-name=multiqc
#SBATCH --partition=ripley
#SBATCH --output=logs/%j_%x.out
#SBATCH --error=logs/%j_%x.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20G
#SBATCH --time=01:00:00

# Definir variable
CONTAINER="docker://quay.io/biocontainers/multiqc:1.35--pyhdfd78af_1"

FASTQC_OUT="results/fastqc-out/"
OUTDIR="results/multiqc-out"

# Crear directior de datos de salida
mkdir -p $OUTDIR

apptainer exec $CONTAINER \
    multiqc $FASTQC_OUT \
    --outdir ${OUTDIR}/ 