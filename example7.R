# File name:    example7.R
# Author:       Felix Thoemmes             
# Date:         11/1/2024


# Load packages ----------------------------------------------------------------

library(tidyverse)
library(boot)
library(emmeans)
library(lme4)
library(readr)
library(mediation)
library(CMAverse)


#data generation
set.seed(123)

# Sample size
n <- 500

# Simulate variables
X <- rbinom(n, 1, 0.5) # Randomized binary treatment
C <- round(rnorm(n, mean = 50, sd = 15)) # Parental income (continuous)

# Mediator: Educational aspirations
M <- round(12 + 3 * X + 0.2 * C + 0.5 * X * C + rnorm(n, sd = 1.5)) # Continuous mediator

# Outcome: Future income
Y <- round(20 + 5 * X + 1.5 * M + 0.3 * C + 2 * X * M + rnorm(n, sd = 5)) # Continuous outcome

# Create a data frame
df1 <- data.frame(X, M, Y, C)



#mediation analysis
# Load CMAverse package
library(CMAverse)

#CMAverse plot
cmdag(outcome = "Y", exposure = "A", mediator = "M",
      basec = c("C1"), postc = NULL, node = TRUE, text_col = "white")

# Fit the mediation model using CMAverse
results <- cmest(
  data = df1,
  model = "rb",            # Regression-based approach
  outcome = "Y",           # Outcome variable
  exposure = "X",          # Treatment variable
  mediator = "M",          # Mediator variable
  basec = "C",             # Confounder C
  EMint = TRUE,            # Include X-M interaction
  mreg = list("linear"),   # Mediator regression type
  yreg = "linear",         # Outcome regression type
  astar = 0,               # Control value of treatment
  a = 1,                   # Treated value of treatment
  mval = list(mean(df1$M)) # Mediator vauee for CDE
)

# Summarize the results
summary(results)