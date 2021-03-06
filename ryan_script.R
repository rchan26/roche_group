library(dplyr)

data <- read.csv('Interns data.csv')
variables <- read.csv('Variables.csv')

# ----- change characters to factors
data <- data %>% mutate_if(is.character, as.factor)

# ----- columns that have 2 unqiue values should be as a factor
indicies <- which(sapply(data, function(col) length(unique(col))) == 2)
data[,indicies] <- as.factor(data[,indicies])

# ----- remove cases that are missing from the INVET variable
data <- data[complete.cases(data[,"INVET"]),]
nrow(data)

# ----- remove variables which shouldn't be included in the analysis
remove_variables <- c("INVID", "AGEU", "BAGEU", "BWTU", "BHTU", "BAGE", 
                      "AGE40", "AGE55", "AGE60", "AGE65", "AGE70", "AGE75", "X")
data <- subset(data, select = -which(colnames(data) %in% remove_variables))

# ------ remove variables that only have one factor or one unique value
data <- subset(data, select = -which(sapply(data, function(col) length(unique(col)))==1))

# function to look at the proportion of missing data cases in the data
proportion_of_complete_cases <- function(df) {
  complete_cases <- rep(0, ncol(df))
  for (j in 1:ncol(df)) {
    complete_cases[j] <- sum(complete.cases(df[,j])) / nrow(df)
  }
  return(complete_cases)
}
plot(proportion_of_complete_cases(data))

# ----- remove variables where proportion of complete cases are less than 0.8
cut_off_point <- 0.8
data <- data[,(proportion_of_complete_cases(data) > cut_off_point)]
# now look at the data
plot(proportion_of_complete_cases(data))

write.csv(x = data, file = "amended_data.csv", row.names = FALSE)




