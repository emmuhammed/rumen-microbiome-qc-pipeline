# 01_import_metadata.R
# Purpose: Import and check rumen microbiome metadata

# Load required packages
library(tidyverse)

# Import metadata
metadata <- read_csv("data/example_metadata.csv")

# View structure
glimpse(metadata)

# Check number of samples
cat("Number of samples:", nrow(metadata), "\n")

# Check missing values
missing_summary <- metadata %>%
  summarise(across(everything(), ~ sum(is.na(.))))

print(missing_summary)

# Check sample distribution by group
group_summary <- metadata %>%
  count(group)

print(group_summary)

# Check sample distribution by parity
parity_summary <- metadata %>%
  count(parity)

print(parity_summary)

# Save summary output
dir.create("results", showWarnings = FALSE)

write_csv(group_summary, "results/group_summary.csv")
write_csv(parity_summary, "results/parity_summary.csv")
write_csv(missing_summary, "results/missing_value_summary.csv")
