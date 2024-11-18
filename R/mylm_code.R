#' Run a basic linear regression model
#'
#' The my_lm function is a function under the mylm package which was created to mimic the usage of the lm() function in R to run a basic linear regression model as a means of practicing writing packages in R. It can be used to study the association between a chose response variable and multiple predictor variables including interactions (if desired) to help users make statistical inferences on their data.
#'
#' my_lm() can run basic linear regression models such as a model with just main effects, a model with interaction effects, a model with polynomial effects, and a model using a combination or all three types of effects.
#'
#' @param formula a formula with the selected response and predicted variables to run the desired linear regression model (e.g. formula = response ~ var1 + var2 + var3)
#' @param data specified data set from which the model will be ran on
#'
#' @return 1. A table of numeric coefficient estimates: estimates, standard errors, t-values, p-values
#' @return 2. A Numeric value for R-squared and adjusted R squared
#' @return 3. A Numeric value for F value and corresponding p-values
#' @return 4. A vector of fitted values and a vector of residuals
#'
#' @examples
#' # Example 1 with main effects only
#' my_model1 <- my_lm(formula = Petal.Width ~ Sepal.Length + Sepal.Width + Petal.Length, data = iris)
#'
#' # to view information on the linear regression model otutput
#' my_model1$Coefficients
#' my_model1$r.squared
#' my_model1$adj.r.squared
#' my_model1$fstatistic
#' my_model1$F_statistic_P_Value
#' head(my_model1$Fitted_Values)
#' head(my_model1$Residuals)
#'
#' # Example 2 with interaction effects
#' my_model2 <- my_lm(formula = mpg ~ cyl + disp + hp + drat + wt + wt*cyl, data = mtcars)
#'
#' # to view information on the linear regression model otutput
#' my_model2$Coefficients
#' my_model2$r.squared
#' my_model2$adj.r.squared
#' my_model2$fstatistic
#' my_model2$F_statistic_P_Value
#' head(my_model2$Fitted_Values)
#' head(my_model2$Residuals)
#'
#' # Example 3 with main effects and interaction effects
#' my_model3 <- my_lm(formula = mpg ~ cyl + disp + hp + drat + wt + wt*cyl, data = mtcars)
#'
#' # to view information on the linear regression model otutput
#' my_model3$Coefficients
#' my_model3$r.squared
#' my_model3$adj.r.squared
#' my_model3$fstatistic
#' my_model3$F_statistic_P_Value
#' head(my_model3$Fitted_Values)
#' head(my_model3$Residuals)
#'
#'@importFrom stats model.frame model.matrix model.response pf pt
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
