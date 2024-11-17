#' Run a basic linear regression model using my version of the lm function as a package
#'
#'
#' @param formula a formula with the selected response and predicted variables to run the desired linear regression model
#' @param data specified datset from which the model will be ran on
#'
#' @return various information on the linear regression model such as coefficient estimates, p-values, and R-squared
#'
#' @examples
#' my_model <- my_lm(Petal.Width ~ Sepal.Length + Sepal.Width + Petal.Length, iris)

#' # to view information on the linear regression model otutput
#' my_model$Coefficients
#' my_model$r.squared
#' my_model$adj.r.squared
#' my_model$fstatistic
#' my_model$F_statistic_P_Value
#' head(my_model$Fitted_Values)
#' head(my_model$Residuals)
#' @export

my_lm <- function(formula, data) {
  # Extract the columns and response variable of our model
  model_dataset <- model.frame(formula, data)

  # Response variable (Y)
  Y <- model.response(model_dataset)

  # Design matrix (X)
  X <- model.matrix(formula, data)

  # Computing the design matrix
  coeffs <- solve(t(X) %*% X) %*% t(X) %*% Y

  # Calculating the fitted values and residuals
  fitted_values <- X %*% coeffs
  residuals <- Y - fitted_values

  # Calculating R-Squared
  SSR <- sum((fitted_values - mean(Y))^2)
  SSY <- sum((Y - mean(Y))^2)
  R_squared <- SSR / SSY

  # Adjusted R-Squared
  n <- nrow(data)
  p <- length(coeffs)
  SSE <- sum(residuals^2)
  adjusted_R_squared <- 1 - ((SSE / (n - p)) / (SSY / (n - 1)))

  # Calculating Standard Error
  MSE <- SSE / (n-p)
  var_cov_matrix <- MSE * solve(t(X) %*% X)
  standard_erorrs <- sqrt(diag(var_cov_matrix))

  # Calculating coefficient t-statistics and corresponding p-values
  t_values <- coeffs / standard_erorrs
  t_pvalues <- 2 * pt(-abs(t_values), df = n-p)

  # Calculating F-statistics and corresponding p-values
  F_numerator <- SSR / (p-1)
  F_denominator <- SSE / (n-p)

  F_statistic <- F_numerator / F_denominator
  F_pvalue <- pf(F_statistic, p-1, n-p, lower.tail = FALSE)

  # Create a table for the coefficient, standard error, T statistic, and P-value
  coeff_names <- colnames(X)
  summary <- data.frame(
    Estimate = coeffs,
    Std_Error = standard_erorrs,
    t_value = t_values,
    p = t_pvalues
  )

  colnames(summary) <- c("Estimate", "Std. Error", "t value", "Pr(>|t|)")

  # Return a list with the coefficient table, R-squared, and model p-value
  list_of_results <- list(
    Coefficients = summary,
    Standard_errors = standard_erorrs,
    T_Values = t_values,
    T_statistic_P_values = t_pvalues,
    r.squared = R_squared,
    adj.r.squared = adjusted_R_squared,
    fstatistic = F_statistic,
    F_statistic_P_Value = F_pvalue,
    Fitted_Values = fitted_values,
    Residuals = residuals
  )

  return(list_of_results)
}
