# 03_alpha_diversity_example.R
# Purpose: Demonstrate alpha diversity analysis using simulated rumen microbiome data

# Load required packages
library(tidyverse)

# Import metadata
metadata <- read_csv("data/example_metadata.csv")

# Simulated alpha diversity values
set.seed(123)

alpha_diversity <- metadata %>%
  mutate(
    observed_features = round(rnorm(n(), mean = 250, sd = 40)),
    shannon_index = round(rnorm(n(), mean = 4.2, sd = 0.4), 2)
  )

print(alpha_diversity)

# Compare Shannon diversity by group
shannon_model <- lm(shannon_index ~ group, data = alpha_diversity)

summary(shannon_model)

# Save results
dir.create("results", showWarnings = FALSE)
dir.create("figures", showWarnings = FALSE)

write_csv(alpha_diversity, "results/alpha_diversity_example.csv")

# Create simple plot
alpha_plot <- ggplot(alpha_diversity, aes(x = group, y = shannon_index)) +
  geom_boxplot() +
  geom_jitter(width = 0.1, alpha = 0.8) +
  theme_bw() +
  labs(
    x = "Group",
    y = "Shannon diversity index",
    title = "Example alpha diversity analysis"
  )

print(alpha_plot)

ggsave(
  filename = "figures/alpha_diversity_example.png",
  plot = alpha_plot,
  width = 6,
  height = 4,
  dpi = 300
)
