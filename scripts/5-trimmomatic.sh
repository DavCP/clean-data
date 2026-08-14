#!/bin/bash
#SBATCH --job-name=trimmomatic
#SBATCH --partition=ib
#SBATCH --output=logs/%j_%x.out
#SBATCH --error=logs/%j_%x.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=2G
#SBATCH --time=01:00:00

# Definir variable
CONTAINER="docker://quay.io/biocontainers/trimmomatic:0.41--hdfd78af_0"

INPUT="data/raw"
OUTDIR="data/trimmomatic-reads"

# Crear directior de datos de salida
mkdir -p $OUTDIR

# Ejecutar un loop while
while read ID; do
   apptainer exec $CONTAINER \
   trimmomatic PE \
   ${INPUT}/${ID}_1.fastq.gz ${INPUT}/${ID}_2.fastq.gz \
   ${OUTDIR}/trim-${ID}_1_paired.fastq.gz ${OUTDIR}/trim-${ID}_1_unpaired.fastq.gz \
   ${OUTDIR}/trim-${ID}_2_paired.fastq.gz ${OUTDIR}/trim-${ID}_2_unpaired.fastq.gz \
   ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done < metadata/list.txt 
