# 04_beta_diversity_example.R
# Purpose: Demonstrate beta diversity analysis using simulated rumen microbiome data

# Load required packages
library(tidyverse)

# Import metadata
metadata <- read_csv("data/example_metadata.csv")

# Simulate a small feature table
set.seed(123)

feature_table <- matrix(
  sample(0:100, size = nrow(metadata) * 20, replace = TRUE),
  nrow = nrow(metadata),
  ncol = 20
)

rownames(feature_table) <- metadata$sample_id
colnames(feature_table) <- paste0("Feature_", 1:20)

# Convert to relative abundance
relative_abundance <- feature_table / rowSums(feature_table)

# Calculate simple Euclidean distance
distance_matrix <- dist(relative_abundance, method = "euclidean")

# Perform principal coordinate analysis
pcoa_result <- cmdscale(distance_matrix, eig = TRUE, k = 2)

pcoa_scores <- as_tibble(pcoa_result$points) %>%
  rename(PCoA1 = V1, PCoA2 = V2) %>%
  mutate(sample_id = rownames(pcoa_result$points)) %>%
  left_join(metadata, by = "sample_id")

print(pcoa_scores)

# Save results
dir.create("results", showWarnings = FALSE)
dir.create("figures", showWarnings = FALSE)

write_csv(pcoa_scores, "results/beta_diversity_pcoa_scores.csv")

# Plot PCoA
pcoa_plot <- ggplot(pcoa_scores, aes(x = PCoA1, y = PCoA2, colour = group)) +
  geom_point(size = 3) +
  theme_bw() +
  labs(
    x = "PCoA 1",
    y = "PCoA 2",
    colour = "Group",
    title = "Example beta diversity analysis"
  )

print(pcoa_plot)

ggsave(
  filename = "figures/beta_diversity_pcoa_example.png",
  plot = pcoa_plot,
  width = 6,
  height = 4,
  dpi = 300
)
