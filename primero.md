---
title: "Primero"
author: "jjvelazcoa"
date: "12/10/2020"
output: pdf_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Paquetes

```{r echo=TRUE, message=TRUE}
#install.packages("R.utils")
```
Para instalar paquetes de Bioconductor:
```{r echo=TRUE, message=TRUE}
#install.packages("BiocManager")
```
Cargamos los paquetes:

```{r echo=TRUE, message=TRUE}
library(R.utils)
library(BiocManager)
```
Para alinear archivos FASTQ contra FASTA

```{r echo=TRUE, message=TRUE}
#BiocManager::install("Rbowtie2")
```

Cargamos el paquete:

```{r}
library("Rbowtie2")
```


```{r echo=TRUE, message=TRUE}
#BiocManager::install("Rsamtools")
```

Este paquete es necesario para manupular resultados de alineación (*.BAM)
Cargamos el paquete:

```{r echo=TRUE, message=TRUE}
library("Rsamtools")
```
Se organizó el directorio en tres subdirectorios: fastq, fastafile y chromosome.
con la función getwd() ubicamos el directorio en donde esté ubicado R.
```{r echo=TRUE}
getwd()
```
Probablemente esto sea por haber instalado los paquetes. Para cambiar el directorio definimos una variable con la ruta de acceso en donde están los archivos FASTQ que son los primeros a procesar.

```{r echo=TRUE}
ruta <- "C:/Users/LENOVO/Documents/UNALMED/2020-II/Bioinformática/Project/BEC/2020-03-23/chromosomes"
```

*Nota*: Se puede copiar la ruta desde la ventana de windows, pero es necesario intercambiar backslash por "/".

Ahora estableceremos el directorio de trabajo:

```{r echo=TRUE}
setwd(ruta)
```

Ya está establecido el nuevo directorio en la primera ruta de trabajo. Ahora se puede empezar a descomprimir los archivos:

```{r echo=TRUE}
dir()
```
Entramos a la carpeta *chromosomes" que es donde se encuentra el archivo comprimido toplevel.

Ahora lo descomprimimos sin eliminarlo utilizando el siguiente código.

```{r echo=TRUE}
gunzip("chromosomes/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz", remove=FALSE)
```
Confirmamos que esté en la carpeta:

```{r echo=TRUE}
dir("chromosomes/")
```

Se confirma que se encuentran los dos archivos.

## Usando la librería bowtie2

Ahora indexamos el genoma en la librería bowtie.
```{r echo=TRUE}
bowtie2_build("chromosomes/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa", bt2Index = "chromosomes/yeast")
```

Esto con el fin de que index el genoma completo y de que se guarde dentro de la carpeta con el índice para levaduras.

Esto creará seis archivos con extensión *.bt2.

Ahora descomprimimos los archivos fastq:

```{r echo=TRUE}
gunzip("fastq/1M_SRR9336468_1.fastq.gz", remove=FALSE)
gunzip("fastq/1M_SRR9336468_2.fastq.gz", remove=FALSE)
```

De esta manera obtenemos dos archivos en la carpeta fastq:
```{r echo=TRUE}
dir("fastq")
```

  Ahora realizamos el alineamiento de las secuencias:
```{r echo=TRUE}
bowtie2(bt2Index = "chromosomes/yeast", 
        samOutput = "1M_SRR9336457.sam", 
        seq1 = "fastq/1M_SRR9336468_1.fastq",
        seq2 = "fastq/1M_SRR9336468_2.fastq",
        "--threads=3")
```
  
Esto puede tardar unos minutos mientras termina el alineamiento. El comando "--threads=3" es para trabajar con tres núcleos de los disponibles.

Confirmamos la existencia del archivo *.SAM:

```{r echo=TRUE}
dir()
```
Observamos que se ha creado un archivo llamado *1M_SRR9336457.sam*. 

```{r echo=TRUE}
asBam("1M_SRR9336457.sam")
```

Este último comando convierte el archivo SAM obtenido por el paso anterior a un archivo BAM binario comprimido.

Se deben crear dos archivos, uno con extensión BAM y otro con extensión *.bam.bai

```{r echo=TRUE}
dir()
```
Ahora se puede visualizar desde IGV por ejemplo.

Cargamos el genoma que se encuentra en la carpeta **chromosomes**, luego en load from file, en la capeta genes, cargamos los genes por medio de un archivo *.gff.



