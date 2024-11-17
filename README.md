# mylm package

## Overview
The "mylm" package is a package that contains the my_lm() function which was created to mimic the useage of the lm() function to run a basic linear regression model as a means of practicing writing packages in R. It can be used to study the association between multiple variables including interactions to help users make statistical inferences on their data. This function can return the corresponding linear model results such as a table of the coefficient estimates, standard errors, t-statistic values, and its corresponding p-values. It can also estimate how well the model fits the data using measurements such as the F statistic value and its p-value, R-squared, and adjusted R-squared values. Lastly, if interested, users may obtain the models fitted values and residual values.
- `my_lm()`: runs a basic linear regression model using a user inputted formula and specified dataset to study the relationship between a response variable and select predictor variables.

## Installation
```{r, eval = FALSE}
devtools::install_github("zooeelu/mylm")
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
