#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH --partition=ib
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20G
#SBATCH --time=01:00:00

cd $SLURM_SUBMIT_DIR

# Definir variable
CONTAINER="docker://quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0"

READS="data"
OUTDIR="results/fastqc-out"

# Crear directior de datos de salida
mkdir -p $OUTDIR

apptainer exec $CONTAINER \
    fastqc $(find ${READS}/ -name "*.fastq.gz") \    #En caso de tener múltiples directorios con datos usar: $(find ${READS}/ -name "*.fastq.gz")
    --outdir ${OUTDIR}/ \
    --threads $SLURM_CPUS_PER_TASK



####!/bin/bash
####SBATCH --job-name=fastqc
####SBATCH --partition=ib
####SBATCH --output=logs/%x_%j.out
####SBATCH --error=logs/%x_%j.err
####SBATCH --ntasks=1
####SBATCH --cpus-per-task=4
####SBATCH --mem=20G
####SBATCH --time=01:00:00
###
###cd $SLURM_SUBMIT_DIR
###
#### Definir variable
###CONTAINER="docker://quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0"
###
###READS="data/raw"
###OUTDIR="results/fastqc-out"
###
#### Crear directior de datos de salida
###mkdir -p $OUTDIR
###
###apptainer exec $CONTAINER \
###    fastqc ${READS}/*.fastq.gz \
###    --outdir ${OUTDIR}/ \
###    --threads $SLURM_CPUS_PER_TASK