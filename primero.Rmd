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

```{r message=TRUE}
install.packages("R.utils")
```
Para instalar paquetes de Bioconductor:
```{r message=TRUE}
install.packages("BiocManager")
```
Cargamos los paquetes:

```{r message=TRUE}
library(R.utils)
library(BiocManager)
```
Para alinear archivos FASTQ contra FASTA

```{r message=TRUE}
BiocManager::install("Rbowtie2")
```

Cargamos el paquete:

```{r message=TRUE}
BiocManager::install("Rsamtools")a
```

Este paquete es necesario para manupular resultados de alineación (*.BAM)
Cargamos el paquete:

```{r message=TRUE}
library("Rsamtools")
```

