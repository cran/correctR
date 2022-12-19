## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.height = 7,
  fig.width = 9
)

## ---- message = FALSE, warning = FALSE----------------------------------------
library(correctR)

## ---- message = FALSE, warning = FALSE----------------------------------------
set.seed(123) # For reproducibility

# Data for random subsampling and k-fold cross-validation corrections

x <- stats::rnorm(30, mean = 0.6, sd = 0.1)
y <- stats::rnorm(30, mean = 0.4, sd = 0.1)

# Data for repeated k-fold cross-validation correction

tmp <- data.frame(model = rep(c(1, 2), each = 60),
                  values = c(stats::rnorm(60, mean = 0.6, sd = 0.1), 
                             stats::rnorm(60, mean = 0.4, sd = 0.1)),
                  k = rep(c(1, 1, 2, 2), times = 15),
                  r = rep(c(1, 2), times = 30))

## ---- message = FALSE, warning = FALSE----------------------------------------
rss <- resampled_ttest(x = x, y = y, n = 30, n1 = 80, n2 = 20) # Random subsampling
kcv <- kfold_ttest(x = x, y = y, n = 100, k = 30) # k-fold cross-validation
rkcv <- repkfold_ttest(data = tmp, n1 = 80, n2 = 20, k = 2, r = 2) # Repeated k-fold cross-validation

## ---- message = FALSE, warning = FALSE----------------------------------------
print(rss)

