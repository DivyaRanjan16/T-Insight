# Load required libraries
library(ggplot2)
library(readxl)

# Function to read hydropathy data from Excel file
read_hydropathy_data <- function(file_path, amino_acid_column, hydropathy_column) {
  amino_acid_data <- read_excel(file_path)
  names(amino_acid_data) <- c(amino_acid_column, hydropathy_column)
  return(amino_acid_data)
}

# Function to calculate average values
calculate_average_values <- function(amino_acid_data) {
  index_numbers <- seq(5, nrow(amino_acid_data), by=10)
  num_chunks <- ceiling(nrow(amino_acid_data) / 10)
  average_values <- numeric(num_chunks)
  for (i in seq_len(num_chunks)) {
    chunk_start <- (i - 1) * 10 + 1
    chunk_end <- min(i * 10, nrow(amino_acid_data))
    chunk_values <- amino_acid_data[[2]][chunk_start:chunk_end] # Assuming hydropathy values are in the second column
    average_values[i] <- mean(chunk_values)
  }
  return(list(index_numbers, average_values))
}

# Main function
main <- function() {
  file_path <- "F:/rohan_bhai/Book1.xlsx"  # Replace this with your file path
  amino_acid_column <- readline(prompt="Enter column name for amino acids: ")  # Prompt user for amino acid column name
  hydropathy_column <- readline(prompt="Enter column name for hydropathy values: ")  # Prompt user for hydropathy column name
  amino_acid_data <- read_hydropathy_data(file_path, amino_acid_column, hydropathy_column)
  results <- calculate_average_values(amino_acid_data)
  
  # Plotting the graph
  ggplot(data=data.frame(Index=results[[1]], Average_Hydropathy=results[[2]]), aes(x=Index, y=Average_Hydropathy)) +
    geom_line() +
    geom_point() +
    labs(x="Amino Acid Index", y="Average Hydropathy Value", title="Average Hydropathy Values") +
    theme_minimal() +
    theme(panel.grid = element_blank())
}

# Call the main function
main()
