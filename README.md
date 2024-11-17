# mylm package

## Overview
The "mylm" package is a package that contains the my_lm() function which was created to mimic the useage of the lm() function to run a basic linear regression model as a means of practicing writing packages in R. It can be used to study the association between multiple variables including interactions to help users make statistical inferences on their data. This function can return the corresponding linear model results such as a table of the coefficient estimates, standard errors, t-statistic values, and its corresponding p-values. It can also estimate how well the model fits the data using measurements such as the F statistic value and its p-value, R-squared, and adjusted R-squared values. Lastly, if interested, users may obtain the models fitted values and residual values.
- `my_lm()`: runs a basic linear regression model using a user inputted formula and specified dataset to study the relationship between a response variable and select predictor variables.

## Installation
```{r, eval = FALSE}
devtools::install_github("zooeelu/my_lm_package")
```

## Usage
Examples ran below utilize some of R's built in datasets in order to run the my_lm() function. 

```r
library(mylm)

my_model <- my_lm(Depression ~ Age + Sex + R_E + Fatalism + Fatalism*Age, data1)

my_model$Coefficients
#>                Estimate Std. Error    t value    Pr(>|t|)
#> (Intercept)  -1.705600644 4.09957214 -0.4160436 0.677525414
#> Age           0.036798726 0.06106627  0.6026032 0.546998127
#> Sex           0.550000457 0.40963674  1.3426541 0.179886705
#> R_E           0.233057017 0.42742296  0.5452609 0.585774730
#> Fatalism      0.719410655 0.22058243  3.2614141 0.001170801
#> Age:Fatalism -0.007013593 0.00327765 -2.1398234 0.032767757

my_model$r.squared
#> [1] 0.1131733
my_model$adj.r.squared
#> [1] 0.1058563

my_model$fstatistic
#> [1] 15.46707

my_model$F_statistic_P_Value
#> [1] 2.475408e-14

head(my_model$Fitted_Values)
#>       [,1]
#> 1 3.321588
#> 2 3.321588
#> 3 5.281537
#> 4 6.223658
#> 5 6.223658
#> 6 3.350877

head(my_model$Residuals)
#>         [,1]
#> 1  7.6784122
#> 2  7.6784122
#> 3 -0.2815369
#> 4 18.7763418
#> 5 18.7763418
#> 6  2.6491225
```
