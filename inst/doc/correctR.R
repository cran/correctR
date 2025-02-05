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
rss <- resampled_ttest(x = x, y = y, n = 30, n1 = 80, n2 = 20)
kcv <- kfold_ttest(x = x, y = y, n = 100, k = 30)
rkcv <- repkfold_ttest(data = tmp, n1 = 80, n2 = 20, k = 2, r = 2)

## ---- message = FALSE, warning = FALSE----------------------------------------
print(rss)

## ---- message = FALSE, warning = FALSE----------------------------------------
resampled_ttest(x = x, y = y, n = 30, n1 = 80, n2 = 20, 
                tailed = "one", greater = "x")

## ---- message = FALSE, warning = FALSE----------------------------------------
kfold_ttest(x = x, y = y, n = 100, k = 30, 
            tailed = "one", greater = "x")

## ---- message = FALSE, warning = FALSE----------------------------------------
repkfold_ttest(data = tmp, n1 = 80, n2 = 20, k = 2, r = 2, 
               tailed = "one", greater = 1)

