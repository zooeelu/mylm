test_that("my_lm works", {
  my_model <- my_lm(formula = Petal.Width ~ Sepal.Length, data = iris)
  R_model <- lm(formula = Petal.Width ~ Sepal.Length, data = iris)
  R_model_summary <- summary(R_model)
  R_model_coeffs <- data.frame(R_model_summary$coefficient)
  my_model_coeffs <-  data.frame(my_model$Coefficients)
  expect_equal(my_model_coeffs, R_model_coeffs)
})
