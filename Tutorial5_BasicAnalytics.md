% Tutorial 5: Analytics
% R Bootcamp HTML Slides
% Jared Knowles

# Overview
In this lesson we hope to learn:
- How to use summary statistics to look at data
- How to run basic statistical tests on a dataset
- How to use formulas to build a statistical model
- Analyze subsets of data





# Datasets
In this tutorial we will use a number of datasets of different types:
- `stulong`: student-level assessment and demographics data (simulated and research ready)
- `midwest_schools.csv`: aggregate school level test score averages from a large Midwest state

# Reading Data In
- We start with the aggregate school level data

```r
load("data/midwest_schools.rda")
head(midsch[, 1:12])
```

```
##   district_id school_id subject grade n1   ss1 n2   ss2 predicted
## 1          14       130    math     4 44 433.1 40 463.0     468.7
## 2          70        20    math     4 18 443.0 20 477.2     476.5
## 3         112        80    math     4 86 445.4 94 472.6     478.4
## 4         119        50    math     4 95 427.1 94 460.7     464.1
## 5         147        60    math     4 27 424.2 27 458.7     461.8
## 6         147       125    math     4 17 423.5 26 463.1     461.2
##   residuals  resid_z  resid_t
## 1   -5.7446 -0.59190 -0.59171
## 2    0.7235  0.07456  0.07452
## 3   -5.7509 -0.59267 -0.59248
## 4   -3.3586 -0.34606 -0.34591
## 5   -3.0937 -0.31877 -0.31863
## 6    1.8530  0.19094  0.19085
```


#  What do we have then?
- We have unique identifiers for districts and schools
- For each school/district combination we have a row of test scores in year 1 and year 2 by test_year (of year 1); grade; and subject
- How can we use R to ask this?

```r
table(midsch$test_year, midsch$grade)
```

```
##       
##           4    5    6    7    8
##   2007 1150 1094  472  638  734
##   2008 1204 1146  462  588  692
##   2009 1173 1092  434  592  668
##   2010 1120 1090  428  610  686
##   2011 1126 1060  420  618  688
```

```r
length(unique(midsch$district_id))
```

```
## [1] 357
```

```r
length(unique(midsch$school_id))
```

```
## [1] 247
```

- What's wrong with this?
  * More districts than schools? The IDs must be goofed
  * We need to create a unique school ID
  

# Explore Data Structure (II)

```r
table(midsch$subject, midsch$grade)
```

```
##       
##           4    5    6    7    8
##   math 2886 2741 1108 1523 1734
##   read 2887 2741 1108 1523 1734
```

- Why don't we want to do `table(midsch$district_id,midsch$grade)`
- What else do we want to know?

# Diagnostic Plots Perhaps

```r
library(ggplot2)
qplot(ss1, ss2, data = midsch, alpha = I(0.07)) + theme_dpi() + geom_smooth() + 
    geom_smooth(method = "lm", se = FALSE, color = "purple")
```

![plot of chunk diag1](figure/slides5-diag1.png) 


# Frequencies, Crosstabs, and t-tests

# What questions do we have?
- Let's imagine that a journalist has used this dataset to detect testing "irregularities" using publicly available aggregate test data
- The journalist's methodology is to regress test scores for a school/grade/subject in one year on a school/grade/subject aggregate test score in the next year
- For example, 2005-06, 3rd grade, reading scores are regressed on 2006-07, 4th grade, reading scores
- Where the observed gains are higher or lower than predicted by this statistical model, "irregularities" are suspected

# Regression 101
- What is wrong with this approach? 
- What are the five assumptions of simple linear regression?
  1. Dependent variable has a linear relationship to a combination of independent variables + a disturbance term (no variables omitted)
  2. The expected value of the disturbance term is zero.
  3. Disturbance terms have the same variance and are not correlated with one another.
  4. The observations of the independent variables are considered fixed in repeated samples.
  5. The number of observations exceeds the number of independent variables and no fixed linear combination exists among the independent variables (perfect collinearity)
- What are other concerns?
  1. Sensitivity of the model to outliers
  2. Confidence interval around predictions
  3. Validity of the model on key subsets


# How to approach this?
- This is a perfect case for exploring the power of R for doing analysis on data and for checking accuracy of results
- Two approaches
  1. Work on one test,grade,school_year combination and validate that
  2. Test model assumptions across all combinations
  3. Build one mega model from full data and control for year, grade, and subject


# First Step
- How many unique combinations are there of `test_year`, `grade`, and `subject`?


```r
nrow(unique(midsch[, c(3, 4, 14)]))
```

```
## [1] 50
```


# Let's look at one subset to start
5th grade, 2011, math scores

```r
midsch_sub <- subset(midsch, midsch$grade == 5 & midsch$test_year == 2011 & 
    midsch$subject == "math")
```

- How many observations in `midsch_sub`?

# How to specify a regression in R
`my_mod<-lm(ss2~ss1,data=midsch_sub)`
- OLS regression is done by the trusty `lm` function
- The `~` character divides the dependent variable `ss2` from the independent variable `ss1`
- We want to store the results of our function so we can capture it by `my_mod<-`
- `data` means we don't have to write: `lm(midsch_sub$ss2~midsch_sub$ss1)`
- Hooray

# Run the regression
- To implement the regression described above is simple in this framework

```r
ss_mod <- lm(ss2 ~ ss1, data = midsch_sub)
summary(ss_mod)
```

```
## 
## Call:
## lm(formula = ss2 ~ ss1, data = midsch_sub)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -46.36  -7.60  -0.42   6.49  58.36 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  -5.1687    11.3446   -0.46     0.65    
## ss1           1.0644     0.0242   44.00   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 11.2 on 528 degrees of freedom
## Multiple R-squared: 0.786,	Adjusted R-squared: 0.785 
## F-statistic: 1.94e+03 on 1 and 528 DF,  p-value: <2e-16 
## 
```


# Explore the Model Output

```r
objects(ss_mod)
```

```
##  [1] "assign"        "call"          "coefficients"  "df.residual"  
##  [5] "effects"       "fitted.values" "model"         "qr"           
##  [9] "rank"          "residuals"     "terms"         "xlevels"      
```

- Most of these we can ignore
- A few are interesting such as `coefficients` `fitted.values` and `call`
- Any idea how to access these objects?

# Omitted Variable
- What other data elements do we have available that might be omitted from our model specification?
  * What about the class size?
- Class size is attractive since class size probably correlates with the variability in the change of scores from year 1 to year 2--big classes swing less than small classes

# Plot of class size

```r
qplot(n2, ss2 - ss1, data = midsch, alpha = I(0.1)) + theme_dpi() + geom_smooth()
```

![plot of chunk diagn](figure/slides5-diagn.png) 

- Group size might matter
- Another type of omitted variable are non-linear terms (polynomials) of the independent variable


# How to check formally

```r
ssN1_mod <- lm(ss2 ~ ss1 + n1, data = midsch_sub)
summary(ssN1_mod)
```

```
## 
## Call:
## lm(formula = ss2 ~ ss1 + n1, data = midsch_sub)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -45.39  -7.73  -0.52   6.42  59.67 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   1.6849    11.7688    0.14    0.886    
## ss1           1.0450     0.0258   40.49   <2e-16 ***
## n1            0.0406     0.0193    2.10    0.036 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 11.2 on 527 degrees of freedom
## Multiple R-squared: 0.787,	Adjusted R-squared: 0.787 
## F-statistic:  976 on 2 and 527 DF,  p-value: <2e-16 
## 
```

```r
ssN2_mod <- lm(ss2 ~ ss1 + n2, data = midsch_sub)
summary(ssN2_mod)
```

```
## 
## Call:
## lm(formula = ss2 ~ ss1 + n2, data = midsch_sub)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -45.60  -7.62  -0.53   6.52  59.64 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   1.7971    11.8544    0.15     0.88    
## ss1           1.0450     0.0260   40.12   <2e-16 ***
## n2            0.0377     0.0192    1.97     0.05 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 11.2 on 527 degrees of freedom
## Multiple R-squared: 0.787,	Adjusted R-squared: 0.786 
## F-statistic:  975 on 2 and 527 DF,  p-value: <2e-16 
## 
```

- Both n1 and n2 seem to matter, or potentially to matter
- How can we test this formally?

# F Test

```r
anova(ss_mod, ssN1_mod, ssN2_mod)
```

```
## Analysis of Variance Table
## 
## Model 1: ss2 ~ ss1
## Model 2: ss2 ~ ss1 + n1
## Model 3: ss2 ~ ss1 + n2
##   Res.Df   RSS Df Sum of Sq    F Pr(>F)  
## 1    528 66239                           
## 2    527 65688  1       551 4.42  0.036 *
## 3    527 65755  0       -67              
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
```

```r
AIC(ssN2_mod)
```

```
## [1] 4067
```

```r
AIC(ssN1_mod)
```

```
## [1] 4067
```

- No difference between `n1` and `n2` but either improves model fit over the model without it

# Diagnostic Check for Linearity

```r
library(lmtest)
resettest(ss_mod, power = 2:4)
```

```
## 
## 	RESET test
## 
## data:  ss_mod 
## RESET = 2.642, df1 = 3, df2 = 525, p-value = 0.04866
## 
```

- Statistically significant

```r
raintest(ss2 ~ ss1, fraction = 0.5, order.by = ~ss1, data = midsch_sub)
```

```
## 
## 	Rainbow test
## 
## data:  ss2 ~ ss1 
## Rain = 1.402, df1 = 265, df2 = 263, p-value = 0.003105
## 
```

- Statistically significant

```r
harvtest(ss2 ~ ss1, order.by = ~ss1, data = midsch_sub)
```

```
## 
## 	Harvey-Collier test
## 
## data:  ss2 ~ ss1 
## HC = 2.734, df = 527, p-value = 0.006462
## 
```

- Statistically significant
- This is not a good sign for our model.

# Adjust for linearity
- No need to despair, we can quickly test a couple easy adjustments for non-linearity
- First, let's just include polynomial terms of our predictor

```r
ss_poly <- lm(ss2 ~ ss1 + I(ss1^2) + I(ss1^3) + I(ss1^4), data = midsch_sub)
summary(ss_poly)
```

```
## 
## Call:
## lm(formula = ss2 ~ ss1 + I(ss1^2) + I(ss1^3) + I(ss1^4), data = midsch_sub)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -44.89  -6.92  -0.20   6.76  59.66 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)
## (Intercept)  2.61e+03   3.61e+04    0.07     0.94
## ss1         -8.72e+00   3.18e+02   -0.03     0.98
## I(ss1^2)    -9.51e-03   1.05e+00   -0.01     0.99
## I(ss1^3)     7.21e-05   1.54e-03    0.05     0.96
## I(ss1^4)    -6.98e-08   8.42e-07   -0.08     0.93
## 
## Residual standard error: 11.1 on 525 degrees of freedom
## Multiple R-squared: 0.789,	Adjusted R-squared: 0.787 
## F-statistic:  490 on 4 and 525 DF,  p-value: <2e-16 
## 
```

- Ok, now what?

```r
anova(ss_mod, ss_poly)
```

```
## Analysis of Variance Table
## 
## Model 1: ss2 ~ ss1
## Model 2: ss2 ~ ss1 + I(ss1^2) + I(ss1^3) + I(ss1^4)
##   Res.Df   RSS Df Sum of Sq    F Pr(>F)  
## 1    528 66239                           
## 2    525 65253  3       985 2.64  0.049 *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
```


# Is this polynomial model still nonlinear?

```r
resettest(ss_poly, power = 2:4)
```

```
## 
## 	RESET test
## 
## data:  ss_poly 
## RESET = 1.562, df1 = 3, df2 = 522, p-value = 0.1976
## 
```

```r
raintest(ss2 ~ ss1 + I(ss1^2) + I(ss1^3) + I(ss1^4), fraction = 0.5, order.by = ~ss1, 
    data = midsch_sub)
```

```
## 
## 	Rainbow test
## 
## data:  ss2 ~ ss1 + I(ss1^2) + I(ss1^3) + I(ss1^4) 
## Rain = 1.392, df1 = 265, df2 = 260, p-value = 0.003804
## 
```

```r
harvtest(ss2 ~ ss1 + I(ss1^2) + I(ss1^3) + I(ss1^4), order.by = ~ss1, data = midsch_sub)
```

```
## 
## 	Harvey-Collier test
## 
## data:  ss2 ~ ss1 + I(ss1^2) + I(ss1^3) + I(ss1^4) 
## HC = NA, df = 524, p-value = NA
## 
```

- We don't eliminate all the problems

# What if we include our omitted variable?

```r
ss_polyn <- lm(ss2 ~ ss1 + I(ss1^2) + I(ss1^3) + I(ss1^4) + n2, data = midsch_sub)
anova(ss_mod, ssN2_mod, ss_poly, ss_polyn)
```

```
## Analysis of Variance Table
## 
## Model 1: ss2 ~ ss1
## Model 2: ss2 ~ ss1 + n2
## Model 3: ss2 ~ ss1 + I(ss1^2) + I(ss1^3) + I(ss1^4)
## Model 4: ss2 ~ ss1 + I(ss1^2) + I(ss1^3) + I(ss1^4) + n2
##   Res.Df   RSS Df Sum of Sq    F Pr(>F)  
## 1    528 66239                           
## 2    527 65755  1       483 3.91  0.049 *
## 3    525 65253  2       502 2.03  0.133  
## 4    524 64842  1       411 3.32  0.069 .
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
```

- Promising

# Non-linearity tests

```r
resettest(ss_polyn, power = 2:4)
```

```
## 
## 	RESET test
## 
## data:  ss_polyn 
## RESET = 2.485, df1 = 3, df2 = 521, p-value = 0.05991
## 
```

```r
raintest(ss2 ~ ss1 + I(ss1^2) + I(ss1^3) + I(ss1^4) + n2, fraction = 0.5, order.by = ~ss1, 
    data = midsch_sub)
```

```
## 
## 	Rainbow test
## 
## data:  ss2 ~ ss1 + I(ss1^2) + I(ss1^3) + I(ss1^4) + n2 
## Rain = 1.381, df1 = 265, df2 = 259, p-value = 0.004606
## 
```

```r
harvtest(ss2 ~ ss1 + I(ss1^2) + I(ss1^3) + I(ss1^4) + n2, order.by = ~ss1, data = midsch_sub)
```

```
## 
## 	Harvey-Collier test
## 
## data:  ss2 ~ ss1 + I(ss1^2) + I(ss1^3) + I(ss1^4) + n2 
## HC = NA, df = 523, p-value = NA
## 
```

- Yipes, nope, this isn't going to fix it.

# Another way to explore non-linearity
- Why might student test scores have a non-linear relationship?
- Tests are goofy at the low and high end of the scale, partly due to design, partly due to regression toward the mean
- How can we check if this is occurring in our data? 
- We can use quantile regression, to fit different models to different subsets of the data and see if they are different

# Diagnostic Check for Quantile Regression

```r
library(quantreg)
ss_quant <- rq(ss2 ~ ss1, tau = c(seq(0.1, 0.9, 0.1)), data = midsch_sub)
plot(summary(ss_quant, se = "boot", method = "wild"))
```

![plot of chunk quantileregression](figure/slides5-quantileregression.png) 


# Results
- `ss_quant` shows that in the lower quantiles the coefficients for the intercept and `ss1` fall outside the confidence interval around the base coefficient
- This suggests the relationship may vary in a statistically significant fashion at the high and low end of the scales, evidence of systematic non-linearity

# Robustness

```r
ss_quant2 <- rq(ss2 ~ ss1 + I(ss1^2) + I(ss1^3) + I(ss1^4) + n2, tau = c(seq(0.1, 
    0.9, 0.1)), data = midsch_sub)
plot(summary(ss_quant2, se = "boot", method = "wild"))
```

![plot of chunk quantileregression2](figure/slides5-quantileregression2.png) 

- The polynomials seem to address some of our concern about non-linearity in this manner, but remember, don't eliminate other symptoms of non-linearity

# Showing Off

```r
ss_quant3 <- rq(ss2 ~ ss1, tau = -1, data = midsch_sub)
qplot(ss_quant3$sol[1, ], ss_quant3$sol[5, ], geom = "line", main = "Continuous Quantiles") + 
    theme_dpi() + xlab("Quantile") + ylab(expression(beta)) + geom_hline(yintercept = coef(summary(ss_mod))[2, 
    1]) + geom_hline(yintercept = coef(summary(ss_mod))[2, 1] + (2 * coef(summary(ss_mod))[2, 
    2]), linetype = 3) + geom_hline(yintercept = coef(summary(ss_mod))[2, 1] - 
    (2 * coef(summary(ss_mod))[2, 2]), linetype = 3)
```

![plot of chunk betterquantileplot](figure/slides5-betterquantileplot.png) 


# Showing Off 2

```r
ss_quant4 <- rq(ss2 ~ ss1 + I(ss1^2) + I(ss1^3) + I(ss1^4) + n2, tau = -1, data = midsch_sub)
qplot(ss_quant4$sol[1, ], ss_quant4$sol[5, ], geom = "line", main = "Continuous Quantiles") + 
    theme_dpi() + xlab("Quantile") + ylab(expression(beta)) + geom_hline(yintercept = coef(summary(ss_mod))[2, 
    1]) + geom_hline(yintercept = coef(summary(ss_mod))[2, 1] + (2 * coef(summary(ss_mod))[2, 
    2]), linetype = 3) + geom_hline(yintercept = coef(summary(ss_mod))[2, 1] - 
    (2 * coef(summary(ss_mod))[2, 2]), linetype = 3)
```

![plot of chunk betterquantileplot2](figure/slides5-betterquantileplot2.png) 



# Test all 50 models
- This is just one of the fifty models we identified at the start
- How do we test them all?
- With a function and `dlply`

```r
library(plyr)
midsch$id <- interaction(midsch$test_year, midsch$grade, midsch$subject)
mods <- dlply(midsch, .(id), lm, formula = ss2 ~ ss1)
objects(mods)[1:10]
```

```
##  [1] "2007.4.math" "2007.4.read" "2007.5.math" "2007.5.read" "2007.6.math"
##  [6] "2007.6.read" "2007.7.math" "2007.7.read" "2007.8.math" "2007.8.read"
```


# Now we have fifty models in an object
- We need to test each one of them
- Sound tedious?
- R can easily do this as well

```r
mytest <- llply(mods, function(x) resettest(x, power = 2:4))
mytest[[1]]
```

```
## 
## 	RESET test
## 
## data:  x 
## RESET = 2.499, df1 = 3, df2 = 570, p-value = 0.05876
## 
```

```r
mytest[[2]]
```

```
## 
## 	RESET test
## 
## data:  x 
## RESET = 0.8864, df1 = 3, df2 = 597, p-value = 0.4478
## 
```

- OK, not that easy!

# Test Residuals

```r
a1 <- qplot(id, residmean, data = ddply(midsch, .(id), summarize, residmean = mean(residuals)), 
    geom = "bar", main = "Provided Residuals") + theme_dpi() + opts(axis.text.x = theme_blank(), 
    axis.ticks = theme_blank()) + ylab("Mean of Residuals") + xlab("Model") + 
    geom_text(aes(x = 12, y = 0.3), label = "SD of Residuals = 9")

a2 <- qplot(id, V1, data = ldply(mods, function(x) mean(x$residuals)), geom = "bar", 
    main = "Replication Models") + theme_dpi() + opts(axis.text.x = theme_blank(), 
    axis.ticks = theme_blank()) + ylab("Mean of Residuals") + xlab("Model") + 
    geom_text(aes(x = 7, y = 0.3), label = paste("SD =", round(mean(ldply(mods, 
        function(x) sd(x$residuals))$V1), 2)))
grid.arrange(a1, a2, main = "Comparing Replication and Provided Residual Means by Model")
```

![plot of chunk residplot1](figure/slides5-residplot1.png) 


# Test Expected Value of Residuals
- A key thing is that the residuals sum to 0

```r
qplot(residuals, data = midsch, geom = "density") + stat_function(fun = dnorm, 
    aes(colour = "Normal")) + geom_histogram(aes(y = ..density..), alpha = I(0.4)) + 
    geom_line(aes(y = ..density.., colour = "Empirical"), stat = "density") + 
    scale_colour_manual(name = "Density", values = c("red", "blue")) + opts(legend.position = c(0.85, 
    0.85)) + theme_dpi()
```

![plot of chunk residplot](figure/slides5-residplot.png) 


# Residuals Have Uniform Variance

```r
b <- 2 * rnorm(5000)
c <- b + runif(5000)
dem <- lm(c ~ b)

a1 <- qplot(midsch$ss1, abs(midsch$residuals), main = "Residual Plot of Replication Data", 
    geom = "point", alpha = I(0.1)) + geom_smooth(method = "lm", se = TRUE) + 
    xlab("SS1") + ylab("Residuals") + geom_smooth(se = FALSE) + ylim(c(0, 50)) + 
    theme_dpi()

a2 <- qplot(b, abs(lm(c ~ b)$residuals), main = "Well Specified OLS", alpha = I(0.3)) + 
    theme_dpi() + geom_smooth()

grid.arrange(a1, a2, ncol = 2)
```

![plot of chunk perfectmodel](figure/slides5-perfectmodel.png) 


# Empirical Tests
- We can do two tests, Breusch-Pagan and the Goldfeld-Quandt test to test for non-standard error variance
- Again, in R these are simple to use

```r
bptest(ss_mod)
```

```
## 
## 	studentized Breusch-Pagan test
## 
## data:  ss_mod 
## BP = 7.499, df = 1, p-value = 0.006172
## 
```

```r
gqtest(ss_mod)
```

```
## 
## 	Goldfeld-Quandt test
## 
## data:  ss_mod 
## GQ = 0.8302, df1 = 263, df2 = 263, p-value = 0.9341
## 
```


# Correcting for Heteroskedacticity
- After all it only messes up the standard errors, not the estimates themselves

# Accuracy of Predictions
- Even if the regression models fit the assumptions above, a somewhat heroic assumption, they still might not be accurate!
- What are some good ways to address accuracy and outlier sensitivity?
- R model diagnostics can be easily run on any `lm` object

# Convenience Functions
- Using `ggplot2` we can run something called `fortify` on our linear model to get a data frame that tells us a lot of diagnostics about each observation
- Example:


```r
damodel <- fortify(ss_mod)
summary(damodel)
```

```
##       ss2           ss1           .hat             .sigma    
##  Min.   :416   Min.   :392   Min.   :0.00189   Min.   :10.9  
##  1st Qu.:478   1st Qu.:457   1st Qu.:0.00207   1st Qu.:11.2  
##  Median :495   Median :471   Median :0.00275   Median :11.2  
##  Mean   :494   Mean   :468   Mean   :0.00377   Mean   :11.2  
##  3rd Qu.:510   3rd Qu.:483   3rd Qu.:0.00416   3rd Qu.:11.2  
##  Max.   :560   Max.   :511   Max.   :0.02920   Max.   :11.2  
##     .cooksd           .fitted        .resid         .stdresid     
##  Min.   :0.00000   Min.   :412   Min.   :-46.36   Min.   :-4.148  
##  1st Qu.:0.00015   1st Qu.:481   1st Qu.: -7.60   1st Qu.:-0.680  
##  Median :0.00062   Median :496   Median : -0.42   Median :-0.038  
##  Mean   :0.00225   Mean   :494   Mean   :  0.00   Mean   : 0.000  
##  3rd Qu.:0.00179   3rd Qu.:509   3rd Qu.:  6.49   3rd Qu.: 0.581  
##  Max.   :0.06596   Max.   :539   Max.   : 58.36   Max.   : 5.218  
```


# What do we get?
- `dv` `iv` `.hat` `.sigma` `.cooksd` `.fitted` `.resid` and `.stdresid`
- Some are obvious: `.fitted` is the prediction from our model
- `.resid` = `dv` - `.fitted`
- `.stdresid` = normalized `.resid`
- `.sigma` = estimate of residual standard deviation when observation is dropped from the model
- `.hat` is more obscure, but is a measure of the influence an individual observation has on overall model fit

# So, how do we use this?
- Visual inspection is the best in this case
- It's easy to implement, easy to interpret, and easy to explain to others
- Watch: let's look at an ideal linear regression model


```r
a <- rnorm(500)
b <- runif(500)
c <- a + b
goodsim <- lm(c ~ a)
goodsim_a <- fortify(goodsim)
qplot(c, .hat, data = goodsim_a) + theme_dpi() + geom_smooth(se = FALSE)
```

![plot of chunk simulatedgoodmodel](figure/slides5-simulatedgoodmodel.png) 


# Let's look at our model


```r
qplot(ss2, .hat, data = damodel) + theme_dpi() + geom_smooth(se = FALSE)
```

![plot of chunk nonsim](figure/slides5-nonsim.png) 


- The deviation here is quite stark

# Compare and contrast

```r
a <- qplot(c, .hat, data = goodsim_a) + theme_dpi() + geom_smooth(se = FALSE)
b <- qplot(ss2, .hat, data = damodel) + theme_dpi() + geom_smooth(se = FALSE)
grid.arrange(a, b, ncol = 2)
```

<img src="figure/slides5-comparisonplot.png" width="800px" height="570px"  alt="plot of chunk comparisonplot" title="plot of chunk comparisonplot" /> 

- These are different, but what do they tell us?
- Points with a high `hat` value are what we call "high leverage" observations, and on their own are not bad--in fact our good model has lots of them
- They help keep the model robust to outliers
- What do you notice about our replication model's outliers?

# One step further
- A rule of thumb is that observations greater than hat of 3x the mean hat value are troubling


```r
qplot(ss2, .hat, data = damodel) + theme_dpi() + geom_smooth(se = FALSE) + geom_hline(yintercept = 3 * 
    mean(damodel$.hat), color = I("red"), size = I(1.1))
```

![plot of chunk diagnosticplot](figure/slides5-diagnosticplot.png) 

- Yikes!

# Checking this systematically
- First, a nasty chunk of R code


```r
infobs <- which(apply(influence.measures(ss_mod)$is.inf, 1, any))
ssdata <- cbind(fortify(ss_mod), midsch_sub)
ssdata$id3 <- paste(ssdata$district_id, ssdata$school_id, sep = ".")
noinf <- lm(ss2 ~ ss1, data = midsch_sub[-infobs, ])
noinff <- fortify(noinf)
```


# Then a plot


```r

qplot(ss1, ss2, data = ssdata, alpha = I(0.5)) + geom_line(aes(ss1, .fitted, 
    group = 1), data = ssdata, size = I(1.02)) + geom_line(aes(x = ss1, y = .fitted, 
    group = 1), data = noinff, linetype = 6, size = 1.1, color = "blue") + theme_dpi() + 
    xlab("SS1") + ylab("Y")
```

![plot of chunk infobsplot](figure/slides5-infobsplot.png) 


# What have we learned?
- Regression in R is easy
- Regression is easy to get wrong


# What might we do different to address these concerns?
- Well, there is nesting in our data that is being ignored
- Also, by fitting fifty separate models we are not efficiently using our data
- Let's look at some quick easy strategies to address that concern
- Let's start with the megamodel

# Megamodel I

```r
my_megamod <- lm(ss2 ~ ss1 + grade + test_year + subject, data = midsch)
summary(my_megamod)
```

```
## 
## Call:
## lm(formula = ss2 ~ ss1 + grade + test_year + subject, data = midsch)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -83.58  -6.38   0.69   6.93  62.80 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 415.92105  108.01823    3.85  0.00012 ***
## ss1           0.89548    0.00321  278.85  < 2e-16 ***
## grade        -0.72909    0.08014   -9.10  < 2e-16 ***
## test_year    -0.16754    0.05380   -3.11  0.00185 ** 
## subjectread -11.53144    0.15245  -75.64  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 10.7 on 19980 degrees of freedom
## Multiple R-squared:  0.9,	Adjusted R-squared:  0.9 
## F-statistic: 4.5e+04 on 4 and 19980 DF,  p-value: <2e-16 
## 
```

- What's wrong with this?

# Megamodel II

```r
my_megamod2 <- lm(ss2 ~ ss1 + as.factor(grade) + as.factor(test_year) + subject, 
    data = midsch)
summary(my_megamod2)
```

```
## 
## Call:
## lm(formula = ss2 ~ ss1 + as.factor(grade) + as.factor(test_year) + 
##     subject, data = midsch)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -77.43  -5.78   0.36   6.18  60.16 
## 
## Coefficients:
##                           Estimate Std. Error t value Pr(>|t|)    
## (Intercept)               72.93813    1.35590   53.79  < 2e-16 ***
## ss1                        0.91197    0.00306  298.17  < 2e-16 ***
## as.factor(grade)5         -8.39756    0.20701  -40.57  < 2e-16 ***
## as.factor(grade)6         -0.69535    0.27917   -2.49    0.013 *  
## as.factor(grade)7         -2.92812    0.29120  -10.06  < 2e-16 ***
## as.factor(grade)8         -7.64546    0.32318  -23.66  < 2e-16 ***
## as.factor(test_year)2008  -3.08623    0.22493  -13.72  < 2e-16 ***
## as.factor(test_year)2009  -0.46178    0.22667   -2.04    0.042 *  
## as.factor(test_year)2010  -1.86967    0.22716   -8.23  < 2e-16 ***
## as.factor(test_year)2011  -1.49652    0.22769   -6.57  5.1e-11 ***
## subjectread              -11.59171    0.14416  -80.41  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 10.2 on 19974 degrees of freedom
## Multiple R-squared: 0.911,	Adjusted R-squared: 0.911 
## F-statistic: 2.04e+04 on 10 and 19974 DF,  p-value: <2e-16 
## 
```


# Comparison
- How do we test between these two?

# Answer

```r
anova(my_megamod, my_megamod2)
```

```
## Analysis of Variance Table
## 
## Model 1: ss2 ~ ss1 + grade + test_year + subject
## Model 2: ss2 ~ ss1 + as.factor(grade) + as.factor(test_year) + subject
##   Res.Df     RSS Df Sum of Sq   F Pr(>F)    
## 1  19980 2306425                            
## 2  19974 2061668  6    244757 395 <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
```


# What about nesting the data?
- Why can't we include a variable for each school in our replication model from earlier?
- What happens if we try?

```r
badidea <- lm(ss2 ~ ss1 + factor(school_id), data = midsch_sub)
head(summary(blah))
```



# Exercises
1. 
2. 
3. 

# Other References
- [Video Tutorials](http://www.twotorials.com/)


# Session Info

It is good to include the session info, e.g. this document is produced with **knitr** version `0.7`. Here is my session info:


```r
print(sessionInfo(), locale = FALSE)
```

```
## R version 2.15.1 (2012-06-22)
## Platform: i386-pc-mingw32/i386 (32-bit)
## 
## attached base packages:
## [1] grid      stats     graphics  grDevices utils     datasets  methods  
## [8] base     
## 
## other attached packages:
##  [1] quantreg_4.81  SparseM_0.96   lmtest_0.9-30  zoo_1.7-7     
##  [5] gridExtra_0.9  ggplot2_0.9.1  hexbin_1.26.0  lattice_0.20-6
##  [9] mgcv_1.7-19    Cairo_1.5-1    knitr_0.7      plyr_1.7.1    
## 
## loaded via a namespace (and not attached):
##  [1] colorspace_1.1-1   dichromat_1.2-4    digest_0.5.2      
##  [4] evaluate_0.4.2     formatR_0.6        labeling_0.1      
##  [7] MASS_7.3-19        Matrix_1.0-6       memoise_0.1       
## [10] munsell_0.3        nlme_3.1-104       proto_0.3-9.2     
## [13] RColorBrewer_1.0-5 reshape2_1.2.1     scales_0.2.1      
## [16] stringr_0.6.1      tools_2.15.1      
```


# Attribution and License
<p xmlns:dct="http://purl.org/dc/terms/">
<a rel="license" href="http://creativecommons.org/publicdomain/mark/1.0/">
<img src="http://i.creativecommons.org/p/mark/1.0/88x31.png"
     style="border-style: none;" alt="Public Domain Mark" />
</a>
<br />
This work (<span property="dct:title">R Tutorial for Education</span>, by <a href="www.jaredknowles.com" rel="dct:creator"><span property="dct:title">Jared E. Knowles</span></a>), in service of the <a href="http://www.dpi.wi.gov" rel="dct:publisher"><span property="dct:title">Wisconsin Department of Public Instruction</span></a>, is free of known copyright restrictions.
</p>

