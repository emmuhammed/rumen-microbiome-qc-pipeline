# Workflow Description

## Purpose

This repository demonstrates a reproducible workflow for rumen microbiome data analysis using example metadata and simulated feature abundance data.

The workflow is intended to show transparent statistical omics practice, including data checking, quality control, diversity analysis, differential abundance testing and visualisation.

## Workflow steps

### 1. Metadata import and checking

Script:

```r
scripts/01_import_metadata.R
scripts/02_quality_summary.R
scripts/03_alpha_diversity_example.R
scripts/04_beta_diversity_example.R
scripts/05_differential_abundance_example.R
