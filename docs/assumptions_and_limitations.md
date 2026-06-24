# Assumptions and Limitations

## Purpose

This document outlines the assumptions and limitations of the example rumen microbiome analysis workflow.

## Assumptions

- The metadata file contains one row per sample.
- Each sample has a unique `sample_id`.
- Group labels are correctly assigned as `Control` or `Treatment`.
- Parity information is available for each animal.
- Simulated feature abundance values are used only for demonstration.
- The example workflow is intended to demonstrate reproducible coding structure rather than final biological inference.

## Limitations

- The repository does not include raw sequencing files.
- The repository does not perform read-level quality filtering or denoising.
- The example feature tables are simulated and should not be interpreted biologically.
- The differential abundance script uses a simplified statistical approach.
- Real microbiome datasets require additional methods for compositional data, sequencing depth, batch effects and study design.
- Real analyses should include appropriate multiple-testing correction, model diagnostics and sensitivity analyses.

## Extension to real datasets

For real rumen microbiome studies, this workflow can be extended by adding:

- QIIME2 or DADA2 preprocessing
- taxonomy assignment
- feature table import
- rarefaction or compositional data approaches
- alpha and beta diversity testing
- differential abundance analysis using appropriate microbiome-specific methods
- integration with methane, metabolomics, diet, parity and production traits

## Relevance to statistical omics

This workflow demonstrates reproducible organisation of high-dimensional biological data analysis, including metadata checking, transparent scripting, clear documentation, statistical summaries and visualisation.
