data <- read.csv('Interns data.csv')
variables <- read.csv('Variables.csv')

proportion_of_complete_cases <- rep(0, ncol(data))
for (j in 1:ncol(data)) {
  proportion_of_complete_cases[j] <- sum(complete.cases(data[,j])) / nrow(data)
}
plot(proportion_of_complete_cases)
