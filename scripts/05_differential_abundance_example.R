# 05_differential_abundance_example.R
# Purpose: Demonstrate a simple differential abundance workflow using simulated rumen microbiome data

# Load required packages
library(tidyverse)

# Import metadata
metadata <- read_csv("data/example_metadata.csv")

# Simulate feature abundance data
set.seed(123)

feature_table <- matrix(
  sample(10:1000, size = nrow(metadata) * 20, replace = TRUE),
  nrow = nrow(metadata),
  ncol = 20
)

rownames(feature_table) <- metadata$sample_id
colnames(feature_table) <- paste0("Feature_", 1:20)

# Convert feature table to long format
feature_long <- as_tibble(feature_table, rownames = "sample_id") %>%
  pivot_longer(
    cols = starts_with("Feature_"),
    names_to = "feature",
    values_to = "abundance"
  ) %>%
  left_join(metadata, by = "sample_id")

# Simple example comparison between groups
differential_summary <- feature_long %>%
  group_by(feature) %>%
  summarise(
    mean_control = mean(abundance[group == "Control"]),
    mean_treatment = mean(abundance[group == "Treatment"]),
    log2_fold_change = log2((mean_treatment + 1) / (mean_control + 1)),
    p_value = t.test(abundance ~ group)$p.value,
    .groups = "drop"
  ) %>%
  mutate(
    adjusted_p_value = p.adjust(p_value, method = "BH")
  )

print(differential_summary)

# Save results
dir.create("results", showWarnings = FALSE)
dir.create("figures", showWarnings = FALSE)

write_csv(differential_summary, "results/differential_abundance_example.csv")

# Volcano-style plot
volcano_plot <- ggplot(
  differential_summary,
  aes(x = log2_fold_change, y = -log10(adjusted_p_value))
) +
  geom_point(size = 2) +
  theme_bw() +
  labs(
    x = "Log2 fold change",
    y = "-log10 adjusted p-value",
    title = "Example differential abundance analysis"
  )

print(volcano_plot)

ggsave(
  filename = "figures/differential_abundance_volcano_example.png",
  plot = volcano_plot,
  width = 6,
  height = 4,
  dpi = 300
)
