data <- read.csv("2024_data_results_table.xlsx - Sheet1.csv")
names(data)

###
# data splitted
###
accessions <- data$Accession
assembler <- data$Assembler.Used
size_assembly <- as.numeric(gsub("[^0-9]", "", iconv(data$Size.of.Assembly, to = "ASCII", sub = "")))
n_contigs <- as.numeric(gsub("[^0-9]", "", iconv(data$Number.of.Contigs, to = "ASCII", sub = "")))
n_50 <- as.numeric(gsub("[^0-9]", "", iconv(data$N50, to = "ASCII", sub = "")))
TE <- as.numeric(gsub("[^0-9]", "", iconv(data$Number.of.TEs, to = "ASCII", sub = "")))
TE_coverage_bp <- as.numeric(gsub("[^0-9]", "", iconv(data$Basepairs.covered.by.TEs, to = "ASCII", sub = "")))
blast_genes <- as.numeric(gsub("[^0-9]", "", iconv(data$Genes.with.Blast.hits, to = "ASCII", sub = "")))
no_blast_genes <- as.numeric(gsub("[^0-9]", "", iconv(data$Genes.without.Blast.hits, to = "ASCII", sub = "")))

###
# Assembler choice
###
summary(assembler)
assembler <- tolower(assembler)  # Convert to lowercase
assembler[assembler == "" | assembler == "annotation"] <- NA  # Replace empty strings with NA
assembler <- factor(na.omit(assembler))  # Remove NA and convert to factor
barplot(table(assembler), main = "Assembler choice", ylab = "count")

###
# Assemblies' size
###

# Format data and plot
summary(size_assembly)
plot(sort(size_assembly[!is.na(size_assembly)])/10^8, type = "o", pch = 16, col = "darkred", bty = "l", 
     ylab = "Assemblies' size [Mbp]", xlab = "", main = "Assembly size overview", xaxt = "n")


###
# Number of contigs
###
summary(n_contigs)
plot(sort(log10(n_contigs[!is.na(n_contigs)])), type = "o", pch = 16, col = "darkred", bty = "l", 
     ylab = "log10(Contigs)", xlab="", main = "Number of contigs per assembly (log10 scale)", xaxt = "n")

###
# Assemblies' N50
###
summary(n_50)
plot(sort(n_50[!is.na(n_50)])/10^8, type = "o", pch = 16, col = "darkred", bty = "l", 
     ylab = "N50 [Mbp]", xlab = "", main = "N50 overview", xaxt = "n")

###
# Number of TEs
###
summary(TE)
plot(sort(TE[!is.na(TE)]), type = "o", pch = 16, col = "darkred", bty = "l", 
     ylab = "TE", xlab = "", main = "Number of TEs per assembly", xaxt = "n")

###
# % TE coverage 
###
percentage <- (TE_coverage_bp / size_assembly)*100
summary(percentage)
plot(sort(percentage), main = "Coverage of TE bp over total Assembly size", 
     type = "o", pch = 16, col = "darkred", bty = "l",
     ylab = "Percentage", xlab = "", xaxt = "n")


###
# BLAST hit genes
###
summary(blast_genes)
plot(sort(blast_genes[!is.na(blast_genes)]), type = "o", pch = 16, col = "darkred", bty = "l", 
     ylab = "Genes", xlab = "", main = "Number of BLAST hit genes", xaxt = "n")


###
# BLAST no-hit genes
###
summary(no_blast_genes)
plot(sort(no_blast_genes[!is.na(no_blast_genes)]), type = "o", pch = 16, col = "darkred", bty = "l", 
     ylab = "Genes", xlab = "", main = "Number of BLAST without hit genes", xaxt = "n")



