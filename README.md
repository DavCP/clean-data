# SRA y curación de datos

En este repositorio encontrarán distintos scripts que les permitirán descargar datos de la base de datos Sequence Read Archive (SRA) así como los subsecuenes pasos de control de calidad, limpieza y trimming de de datos genómicos.

Los scripts se encuentran adaptados para funcionar con servidores administrados con SLURM. Para ello, hagan los ajustes necesarios en los scripts previo a someter Jobs.

Necesario cambiar la **partición** de SLURM a usar

```Shell
#SBATCH --partition=ib
```

Este repositorio propone la siguiente estructura de directorios y archivos:

```
clean-data
├── data
│   ├── raw
│   └── trimmed
├── logs
├── metadata
├── README.md
├── results
└── scripts
```

## Descarga de datos

Para descargar datos haremos uso de fasterq-dump. Existen alternativas (ie. **fastq-dump,** **parallel-fasterq-dump**), sin embargo, el software que usaremos es rápido y además distribuido por NCBI, cuenta con soporte constante. El script comprimirá los archivos .fastq descargados con pigz, resultando en archivos de lecturas con la extensión .fastq.gz.

Se ejecuta de la siguiente manera:

```Shell
sbatch scripts/1-fasterq-dump.sh
```

Puedes ajustar en caso de correr en otro servidor con distintas particiones

```Shell
sbatch --partition=bioinfo scripts/1-fasterq-dump.sh
```

Tras la descarga, los datos se encontrarán en el directorio `data/raw/`


## Limpieza de datos con fastp o trimmomatic

Ambos software son útiles para la curación de datos genómicos (i.e. filtro de lecturas por calidad y remoción de adaptadores). fastp suele tener más soporte y es considerablemente más rápido. Se pueden ejecutar de la siguiente manera:

#### fastp

```Shell
sbatch scripts/2-fastp.sh
```

#### trimmomatic

```Shell
sbatch scripts/2-trimmomatic.sh
```

Los datos resultantes de la curación de lecturas se encontrarán en `data/trim-reads/` y `data/trimmomatic-reads/`, para fastp y trimmomatic respectivamente. Para más detalles respecto a los resultados de trimmomatic, puedes revisar los archivos de salir y error `.err, .out` en el directorio `logs/`. Por otro lado, fastp genera archivos .html y .json detallando el procesamiento que pueden ser consultados en el directorio `results/fastp`.

## Control de calidad FastQC

FastQC hace un detallado control de calidad a partir de archivos de lecturas, tanto en su versión de texto plano, como archivos comprimidos (.fast o .fastq.gz). El script, buscará dentro del directorio `data/` todos aquellos archivos con la terminación .fastq.gz

```Shell
sbatch scripts/3-fastqc.sh
```

Los resultados de FastQC pueden ser consultados en `results/fastq-out/`. Por cada muestra analizada se generará un archivo con extensión .zip y .html, el archivo legible y a revisar será este último.

## Reporte de calidad con MultiQC

MultiQC generará un reporte con gráficos interactivos a partir de múltiples reportes individuales de FastQC, es de mucha utilidad para hacer comparaciones de la calidad de lecturas al momento de procesar múltiples muestras.

```Shell
sbatch scripts/4-multiqc.sh
```




