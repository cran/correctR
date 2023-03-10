#' Compute correlated t-statistic and p-value for k-fold cross-validated results
#' @importFrom stats var pt
#' @param x \code{numeric} vector of values for model A
#' @param y \code{numeric} vector of values for model B
#' @param n \code{integer} denoting total sample size
#' @param k \code{integer} denoting number of folds used in k-fold
#' @return object of class \code{data.frame}
#' @references Nadeau, C., and Bengio, Y. Inference for the Generalization Error. Machine Learning 52, (2003).
#' @references Corani, G., Benavoli, A., Demsar, J., Mangili, F., and Zaffalon, M. Statistical comparison of classifiers through Bayesian hierarchical modelling. Machine Learning, 106, (2017).
#' @author Trent Henderson
#' @export
#'

kfold_ttest <- function(x, y, n, k){

  # Arg checks

  if(length(x) != length(y)){
    stop("x and y are not the same length.")
  }

  if(!is.numeric(x) || !is.numeric(y)){
    stop("x and y should be numeric vectors of the same length.")
  }

  if(!is.numeric(n) || !is.numeric(k)){
    stop("n and k should be integer scalars.")
  }

  if(length(n) != 1 || length(k) != 1){
    stop("n and k should be integer scalars.")
  }

  # Calculations

  d <- x - y # Calculate differences
  statistic <- mean(d, na.rm = TRUE) / sqrt(stats::var(d, na.rm = TRUE) * ((1/n + (1/k)) / (1 - 1/k))) # Calculate t-statistic

  if(statistic < 0){
    p.value <- stats::pt(statistic, n - 1) # p-value for left tail
  } else{
    p.value <- stats::pt(statistic, n - 1, lower.tail = FALSE) # p-value for right tail
  }

  tmp <- data.frame(statistic = statistic, p.value = p.value)
  return(tmp)
}
