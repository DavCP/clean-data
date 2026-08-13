# SRA y curaciónd de datos

En este repositorio encontrarán distintos scripts que les permitirán descargar datos de la base de datos Sequence Read Archive (SRA) así como los subsecuenes pasos de control de calidad, limpieza y trimming de de datos genómicos.

Los scripts se encuentran adaptados para funcionar con servidores administrados con SLURM. Para ello, hagan los ajustes necesarios en los scripts previo a someter Jobs.

Necesario cambiar la **partición** de SLURM a usar

```Shell
#SBATCH --partition=ib
```

Este repositorio propone la siguiente estructura de directorios y archivos:

```
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

Para descargar datos haremos uso de fasterq-dump. Existen alternativas (ie. **fastq-dump,** **parallel-fasterq-dump**), sin embargo, el software que usaremos es rápido y además distribuido por NCBI, cuenta con soporte constante.
