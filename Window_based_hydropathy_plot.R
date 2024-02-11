# Assuming you have a vector 'hydropathy_values' containing the hydropathy values for each amino acid
# Assuming the length of the protein sequence is 470

a <- read.delim("hydrophobicity_plot2.tsv.txt")
b <- a$X1.9
# Calculate the moving average of hydropathy values for each window of 10 amino acids
window_size <- 10
moving_avg <- sapply(seq_along(b), function(i) {
  if (i <= length(b) - window_size + 1) {
    mean(b[i:(i + window_size - 1)])
  } else {
    NA # Return NA for positions where the window exceeds the length of the sequence
  }
})

# Plot the moving average values against the protein length
plot(
  x = 1:length(moving_avg), y = moving_avg, type = "l",
  xlab = "Position in Protein", ylab = "Moving Average Hydropathy",
  main = "Moving Average Hydropathy Plot"
)
