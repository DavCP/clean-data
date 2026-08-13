# SRA y curaciónd de datos

En este repositorio encontrarán distintos scripts que les permitirán descargar datos de la base de datos Sequence Read Archive (SRA) así como los subsecuenes pasos de control de calidad, limpieza y trimming de de datos genómicos.

Los scripts se encuentran adaptados para funcionar con servidores administrados con SLURM. Para ello, hagan los ajustes necesarios en los scripts previo a someter Jobs.

Necesario cambiar la **partición** de SLURM a usar

```Shell
#SBATCH --partition=ib
```


## * Descarga de datos
