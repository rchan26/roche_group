library(mice)
library(dplyr)

ammended <- read.csv('amended_data.csv')
dim(ammended)

# ----- try out multiple imputation using MICE
imputed_data <- mice(ammended, m = 5, method = 'pmm', seed = 2021)
summary(imputed_data)

#- problem: doesn't impute the discrete categories
#- e.g. looking at which variables still have missing values in the first imputed dataset:
complete(imputed_data, 1)[,which(proportion_of_complete_cases(complete(imputed_data, 1))!=1)]

