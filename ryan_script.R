data <- read.csv('Interns data.csv')
variables <- read.csv('Variables.csv')

# ----- remove cases that are missing from the INVET variable
data <- data[complete.cases(data[,"INVET"]),]
nrow(data)

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
ncol(data)


