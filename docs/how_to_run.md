# How to Run the Workflow

## Overview

This document explains how to run the example rumen microbiome analysis workflow.

The workflow uses example metadata and simulated microbiome feature data. It is designed to demonstrate reproducible statistical omics practice rather than final biological inference.

## Required software

- R
- RStudio, optional but recommended
- Git, optional for local version control

## Required R packages

The scripts use the following R packages:

```r
install.packages("tidyverse")
install.packages("vegan")
source("scripts/01_import_metadata.R")
source("scripts/02_quality_summary.R")
source("scripts/03_alpha_diversity_example.R")
source("scripts/04_beta_diversity_example.R")
source("scripts/05_differential_abundance_example.R")
results/
figures/
