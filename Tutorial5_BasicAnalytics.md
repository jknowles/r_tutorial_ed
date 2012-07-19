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
midsch <- read.csv("data/midwest_schools.csv")
str(midsch)
```

```
## 'data.frame':	19985 obs. of  18 variables:
##  $ district_name: Factor w/ 480 levels "21ST CENTURY",..: 6 7 10 11 13 13 13 13 13 13 ...
##  $ district_id  : int  14 70 112 119 147 147 147 147 147 147 ...
##  $ school_name  : Factor w/ 1784 levels "21ST CENTURY",..: 14 25 1153 35 59 1749 359 593 619 629 ...
##  $ school_id    : int  130 20 80 50 60 125 130 180 190 195 ...
##  $ subject      : Factor w/ 2 levels "math","read": 1 1 1 1 1 1 1 1 1 1 ...
##  $ grade        : int  4 4 4 4 4 4 4 4 4 4 ...
##  $ n1           : int  44 18 86 95 27 17 73 66 46 75 ...
##  $ ss1          : num  433 443 445 427 424 ...
##  $ n2           : int  40 20 94 94 27 26 76 60 50 73 ...
##  $ ss2          : num  463 477 473 461 459 ...
##  $ predicted    : num  469 476 478 464 462 ...
##  $ residuals    : num  -5.745 0.724 -5.751 -3.359 -3.094 ...
##  $ resid_z      : num  -0.5919 0.0746 -0.5927 -0.3461 -0.3188 ...
##  $ resid_t      : num  -0.5917 0.0745 -0.5925 -0.3459 -0.3186 ...
##  $ cooks        : num  1.71e-04 3.51e-06 2.45e-04 5.99e-05 5.41e-05 ...
##  $ test_year    : int  2007 2007 2007 2007 2007 2007 2007 2007 2007 2007 ...
##  $ tprob        : num  0.279 0.471 0.277 0.365 0.376 ...
##  $ flagged_t95  : int  0 0 0 0 0 0 0 0 0 0 ...
```

```r
head(midsch[, 1:12])
```

```
##   district_name district_id     school_name school_id subject grade n1
## 1 ADAMS FRIENDS          14 ADAMS FRIEND EL       130    math     4 44
## 2        ALGOMA          70       ALGOMA EL        20    math     4 18
## 3       ALTOONA         112     PEDERSEN EL        80    math     4 86
## 4         AMERY         119       AMERY INT        50    math     4 95
## 5      APPLETON         147       BADGER EL        60    math     4 27
## 6      APPLETON         147 WIS CONNECTIONS       125    math     4 17
##     ss1 n2   ss2 predicted residuals
## 1 433.1 40 463.0     468.7   -5.7446
## 2 443.0 20 477.2     476.5    0.7235
## 3 445.4 94 472.6     478.4   -5.7509
## 4 427.1 94 460.7     464.1   -3.3586
## 5 424.2 27 458.7     461.8   -3.0937
## 6 423.5 26 463.1     461.2    1.8530
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
nrow(unique(midsch[, c(5, 6, 16)]))
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


# Omitted Variable
- What other data elements do we have available that might be omitted from our model specification?
  * What about the class size?
- Class size is attractive since class size probably correlates with the variability in the change of scores from year 1 to year 2--big classes swing less than small classes


```r
qplot(n2, ss2 - ss1, data = midsch, alpha = I(0.1)) + theme_dpi() + geom_smooth()
```

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


# Diagnostic Check for Polynomials

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



# Exercises
1. 
2. 
3. 

# Other References
- [An R Vocabulary for Starting Out](https://github.com/hadley/devtools/wiki/vocabulary)
- [R Features List](http://www.revolutionanalytics.com/what-is-open-source-r/r-language-features/)
- [Video Tutorials](http://www.twotorials.com/)


# Session Info

It is good to include the session info, e.g. this document is produced with **knitr** version `0.7`. Here is my session info:


```r
print(sessionInfo(), locale = FALSE)
```

```
## R version 2.15.1 (2012-06-22)
## Platform: x86_64-pc-mingw32/x64 (64-bit)
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] lmtest_0.9-30 zoo_1.7-7     ggplot2_0.9.1 knitr_0.7    
## 
## loaded via a namespace (and not attached):
##  [1] colorspace_1.1-1   dichromat_1.2-4    digest_0.5.2      
##  [4] evaluate_0.4.2     formatR_0.6        grid_2.15.1       
##  [7] labeling_0.1       lattice_0.20-6     MASS_7.3-19       
## [10] memoise_0.1        munsell_0.3        plyr_1.7.1        
## [13] proto_0.3-9.2      RColorBrewer_1.0-5 reshape2_1.2.1    
## [16] scales_0.2.1       stringr_0.6        tools_2.15.1      
```

