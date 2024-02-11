a <- read.delim("hydrophobicity_plot2.tsv.txt")
View(a)
# plot(x = a$M, y = a$X1.9, type = "l")
library("gglpot")
install.packages("ggplot2")
library("ggplot2")
# ggplot(a, aes(x = a$M, y = a$X1.9, group = M,
#               color = a$m)) +
#   geom_line() +
#   labs(title = "Hydropathy Graph", 
#        x= "Amino Acid",
#        y= "Hydrpathy",
#        color = "Amino Acid") + 
#   theme_minimal()
# ggplot(a, aes(x= M, y= X1.9, group = 1)) +
#   geom_line() + 
#   labs(title = "graoph", 
#        x = "AA", 
#        y="Hydropathy")

# ggplot(a, aes(x = seq_along(M), y = X1.9, group = M)) +
#   geom_path() +
#   labs(title = "Hydropathy Graph", x = "Position", y = "Hydropathy") +
#   scale_x_continuous(breaks = seq_along(a$M), labels = a$M)

# ggplot(a, aes(x = seq_along(M), y = X1.9, group = M)) +
#   geom_smooth(method = "loess", se = FALSE, color = "blue") +
#   labs(title = "Hydropathy Graph", x = "Position", y = "Hydropathy") +
#   scale_x_continuous(breaks = seq_along(a$M), labels = a$M)

# ggplot(a, aes(x = as.numeric(M), y = X1.9, group = M)) +
#   geom_line() +
#   labs(title = "Hydropathy Graph", x = "Position", 
#        y = "Hydropathy")

# ggplot(a, aes(x = as.numeric(row.names(a)), 
#               y = X1.9, group = M)) +
#   geom_path() +
#   labs(title = "Hydropathy Graph", x = "Position", 
#        y = "Hydropathy")
# ggplot(a, aes(x = as.numeric(row.names(a)), y = X1.9)) +
#   geom_line(color= "blue") +
#   labs(title = "Hydropathy Graph", x = "Position", y = "Hydropathy")


# Assuming your data frame is named 'a'
library(dplyr)  # Load the dplyr package for data manipulation

a %>%
  filter(X1.9 > 0) %>%
  ggplot(aes(x = as.numeric(row.names(.)), y = X1.9)) +
  geom_line() +
  labs(title = "Hydropathy Graph (Positive Values Only)",
       x = "Position", y = "Hydropathy")


library(dplyr)
library(ggplot2)


a %>%
  mutate(X1.9 = ifelse(X1.9 < 0, 0, X1.9)) %>%
  ggplot(aes(x = as.numeric(row.names(.)), y = X1.9)) +
  geom_line() +
  labs(title = "Hydropathy Graph (Negative Values Nullified)",
       x = "Position", y = "Hydropathy")
