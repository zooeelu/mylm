# mylm package
<!-- badges: start -->
  [![R-CMD-check](https://github.com/zooeelu/mylm/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/zooeelu/mylm/actions/workflows/R-CMD-check.yaml)
  [![codecov](https://codecov.io/github/zooeelu/mylm/graph/badge.svg?token=8BY02BUD71)](https://codecov.io/github/zooeelu/mylm)
  <!-- badges: end -->

## Overview
The "mylm" package is a package that contains the my_lm() function which was created to mimic the useage of the lm() function to run a basic linear regression model as a means of practicing writing packages in R. It can be used to study the association between multiple variables including interactions to help users make statistical inferences on their data. This function can return the corresponding linear model results such as a table of the coefficient estimates, standard errors, t-statistic values, and its corresponding p-values. It can also estimate how well the model fits the data using measurements such as the F statistic value and its p-value, R-squared, and adjusted R-squared values. Lastly, if interested, users may obtain the models fitted values and residual values.
- `my_lm()`: runs a basic linear regression model using a user inputted formula and specified dataset to study the relationship between a response variable and select predictor variables.

## Installation
```{r, eval = FALSE}
devtools::install_github("zooeelu/mylm", build_vignettes = T)
```

## Usage
Examples ran below utilize some of R's built in datasets in order to run the my_lm() function. 

```r
library(mylm)

my_model <- my_lm(formula = Petal.Width ~ Sepal.Length, data = iris)

my_model$Coefficients
#>                Estimate Std. Error   t value     Pr(>|t|)
#> (Intercept)  -3.2002150 0.25688579 -12.45773 8.141394e-25
#> Sepal.Length  0.7529176 0.04353017  17.29645 2.325498e-37

my_model$fstatistic
#> [1] 299.1673

my_model$F_statistic_P_Value
#> [1] 2.325498e-37

my_model$r.squared
#> [1] 0.6690277

my_model$adj.r.squared
#> [1] 0.6667914

head(my_model$Fitted_Values, 5)
#>        [,1]
#> 1 0.6396646
#> 2 0.4890811
#> 3 0.3384976
#> 4 0.2632058
#> 5 0.5643728

head(my_model$Residuals, 5)
#>          [,1]
#> 1 -0.43966461
#> 2 -0.28908109
#> 3 -0.13849758
#> 4 -0.06320582
#> 5 -0.36437285
```

```
my_model <- my_lm(formula = mpg ~ cyl + hp + drat + wt + hp*wt + cyl*wt, data = mtcars)
my_model$Coefficients
#>                Estimate Std. Error     t value     Pr(>|t|)
#> (Intercept) 51.39899665 9.11570457  5.63851058 7.216081e-06
#> cyl         -0.10251425 2.61323413 -0.03922888 9.690195e-01
#> hp          -0.11841982 0.07424414 -1.59500565 1.232765e-01
#> drat        -0.45321259 1.42736049 -0.31751796 7.534874e-01
#> wt          -7.61786425 2.50345640 -3.04293866 5.445009e-03
#> hp:wt        0.02928176 0.02259772  1.29578391 2.068865e-01
#> cyl:wt      -0.10537841 0.81956657 -0.12857822 8.987202e-01

my_model$fstatistic
#> [1] 32.83019

my_model$F_statistic_P_Value
#> [1] 1.097358e-10

my_model$r.squared
#> [1] 0.8873778

my_model$adj.r.squared
#> [1] 0.8603485

head(my_model$Fitted_Values, 5)
#>                       [,1]
#> Mazda RX4         22.81385
#> Mazda RX4 Wag     21.53142
#> Datsun 710        25.89750
#> Hornet 4 Drive    20.19315
#> Hornet Sportabout 16.94995

head(my_model$Residuals, 5)
#>                         [,1]
#> Mazda RX4         -1.8138525
#> Mazda RX4 Wag     -0.5314215
#> Datsun 710        -3.0975040
#> Hornet 4 Drive     1.2068521
#> Hornet Sportabout  1.7500521
```







