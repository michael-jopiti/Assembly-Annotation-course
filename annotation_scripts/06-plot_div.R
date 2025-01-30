library(reshape2)
library(hrbrthemes)
library(tidyverse)
library(data.table)

# Load data
data <- "assembly.fasta.mod.out.landscape.Div.Rname.tab"

# Read data
rep_table <- fread(data, header = FALSE, sep = "\t")
colnames(rep_table) <- c("Rname", "Rclass", "Rfam", 1:50)

# Remove rows where the family is unknown
rep_table <- rep_table %>% filter(Rfam != "unknown")

# Combine Rclass and Rfam into a new 'fam' column
rep_table$fam <- paste(rep_table$Rclass, rep_table$Rfam, sep = "/")

# Remove rows where all divergence values are zero
rep_table_non_zero <- rep_table[apply(rep_table[, 4:53], 1, function(x) any(x != 0)), ]

# Create a list of column names from 4 to 53
measure_vars <- colnames(rep_table_non_zero)[4:53]

# Melt the data table using the actual column names for measure.vars
rep_table.m <- melt(rep_table_non_zero, 
                    id.vars = c("Rname", "Rclass", "Rfam", "fam"), 
                    measure.vars = measure_vars)

rep_table.m <- rep_table.m[-c(which(rep_table.m$variable == 1)), ]  # Remove the peak at 1

# Reorder factor levels for visualization
rep_table.m$fam <- factor(rep_table.m$fam, levels = c(
  "LTR/Copia", "LTR/Gypsy", "DNA/DTA", "DNA/DTC", "DNA/DTH", "DNA/DTM", "DNA/DTT", "DNA/Helitron",
  "MITE/DTA", "MITE/DTC", "MITE/DTH", "MITE/DTM"
))

# Convert divergence to numeric distance (percent to proportion)
rep_table.m$distance <- as.numeric(rep_table.m$variable) / 100 

# Substitution rate for Brassicaceae
substitution_rate <- 8.22e-9  # substitutions per synonymous site per year

# Calculate the age of transposons using the formula T = K / 2r
rep_table.m$age <- (rep_table.m$distance / 100) / (2 * substitution_rate)

# Inspect the first few rows to verify the calculation
head(rep_table.m)

# Histogram to visualize the distribution of transposon ages by family
rep_table.m$log10_age <- log10(rep_table.m$age)

ggplot(rep_table.m, aes(x = log10_age, fill = fam)) +
  geom_histogram(position = "dodge", bins = 30) +
  labs(title = "Histogram of Log-transformed Age of Transposons", x = "Log(Age) (years)", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Filter the dataset for Copia and Gypsy families
filtered_data <- rep_table.m %>% filter(fam %in% c("LTR/Copia", "LTR/Gypsy"))

# Plot histogram for Copia and Gypsy
ggplot(filtered_data, aes(x = log10_age, fill = fam)) +
  geom_histogram(position = "dodge", bins = 30) +  # Adjust width for spacing
  labs(title = "Histogram of Log-transformed Age of Transposons (Proportional) for Copia and Gypsy", 
       x = "Log(Age) (years)", y = "Density") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))



# Remove Helitron family as they may not be annotated properly
rep_table.m <- rep_table.m %>% filter(fam != "DNA/Helitron")

# Plot the distribution of sequence distances (same as before)
ggplot(rep_table.m, aes(fill = fam, x = distance, weight = value / 1000000)) +
  geom_bar() +
  cowplot::theme_cowplot() +
  scale_fill_brewer(palette = "Paired") +
  xlab("Distance") +
  ylab("Sequence (Mbp)") +
  theme(axis.text.x = element_text(angle = 90, vjust = 1, size = 9, hjust = 1), plot.title = element_text(hjust = 0.5))

# Save the plot
ggsave(filename = "Div_plot.pdf", width = 10, height = 5, useDingbats = F)
