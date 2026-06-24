# 02_quality_summary.R
# Purpose: Generate simple quality-control summaries for example rumen microbiome metadata

# Load required packages
library(tidyverse)

# Import metadata
metadata <- read_csv("data/example_metadata.csv")

# Basic checks
qc_summary <- tibble(
  total_samples = nrow(metadata),
  unique_animals = n_distinct(metadata$animal_id),
  number_of_groups = n_distinct(metadata$group),
  number_of_parity_classes = n_distinct(metadata$parity),
  missing_sample_ids = sum(is.na(metadata$sample_id)),
  missing_group_values = sum(is.na(metadata$group)),
  missing_parity_values = sum(is.na(metadata$parity))
)

print(qc_summary)

# Group and parity summary
group_parity_summary <- metadata %>%
  count(group, parity)

print(group_parity_summary)

# Create results folder if not already present
dir.create("results", showWarnings = FALSE)

# Save outputs
write_csv(qc_summary, "results/qc_summary.csv")
write_csv(group_parity_summary, "results/group_parity_summary.csv")
