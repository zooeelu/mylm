##
my_model <- my_lm(formula = Petal.Width ~ Sepal.Length, data = iris)
R_model <- lm(formula = Petal.Width ~ Sepal.Length, data = iris)
R_model_summary <- summary(R_model)

test_that("my_lm coeffs works", {
  R_model_coeffs <- data.frame(R_model_summary$coefficient)
  my_model_coeffs <-  data.frame(my_model$Coefficients)
  expect_equal(my_model_coeffs, R_model_coeffs)
})

test_that("my_lm rsquared works", {
  expect_equal(my_model$r.squared, R_model_summary$r.squared)
})

test_that("my_lm adj rsquared works", {
  expect_equal(my_model$adj.r.squared, R_model_summary$adj.r.squared)
})

test_that("my_lm F stat works", {
  expect_equal(my_model$fstatistic, R_model_summary$fstatistic[[1]])
})

test_that("my_lm F stat pvalue works", {
  lm_f_p_value <- R_model_summary$fstatistic[[1]]  # F-statistic value
  lm_f_p_value <- pf(lm_f_p_value, df1 = R_model_summary$fstatistic[[2]],
                     df2 = R_model_summary$fstatistic[[3]], lower.tail = FALSE)
  expect_equal(my_model$F_statistic_P_Value, lm_f_p_value)
})

test_that("my_lm fitted works", {
  R_fitted <- as.vector(R_model$fitted.values)
  my_fitted <- as.vector(my_model$Fitted_Values)
  expect_equal(my_fitted, R_fitted)
})

test_that("my_lm residuals works", {
  R_res<- as.vector(R_model_summary$residuals)
  my_res <- as.vector(my_model$Residuals)
  expect_equal(my_res, R_res)
})





