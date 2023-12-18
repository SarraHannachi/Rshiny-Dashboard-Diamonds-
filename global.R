# Rshiny Training Session
# Date: 09.11.2023




#Load Data

library(ggplot2)
data(diamonds)

#Transform/Clean Data

diamonds <- diamonds[,-c(8:10)]

diamonds$table <- as.integer(diamonds$table)
