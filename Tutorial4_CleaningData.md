% Tutorial 4: Cleaning and Merging Data
% R Bootcamp HTML Slides
% Jared Knowles

# Overview
In this lesson we hope to learn:
- The Strategic Data Project
- Checking data for errors
- Recoding data and changing data types
- Diagnostics and error checks




# Data Setup
- Let's read in a new dataset now that has some messiness to it


```r
load("data/Student_Attributes.rda")
head(stuatt[, 1:4], 7)
```

```
##   sid school_year male race_ethnicity
## 1   1        2004    1              B
## 2   1        2005    1              H
## 3   1        2006    1              H
## 4   1        2007    1              H
## 5   2        2006    0              W
## 6   2        2007    0              B
## 7   3        2006    1              H
```

- What's wrong with this?

# How can R help correct this?
- Identify problems
- Enforce business rules for messy data consistently
- Build data cleaning into all analyses tasks across the workflow
- Analyze inconsistencies and do reports

# Strategic Data Project
- The Strategic Data Project is 

<p align="center"><img src="img/sdp.gif" height="112" width="329"></p>

# Toolkit--Data Cleaning
- The SDP has come up with a great tutorial and guided analyses using a great synthetic data set to help walk through the process of cleaning data
- This was written in Stata, we have ported it to R, and are going to walk through just a single lesson of it here (Clean Data Building)

# SDP Task 1 Student Attributes Intro
- Drop the `first_9th_school_year_reported` variable


```r
stuatt$first_9th_year_reported <- NULL
```

- Later in the tutorial a new variable like this will be created

# SDP Task 1 - Step 1: Consistent Gender
- Is gender unique for each student?


```r
length(unique(stuatt$sid))
```

```
## [1] 21803
```

```r
length(unique(stuatt$sid, stuatt$male))
```

```
## [1] 21806
```

- Nah, we have 21,803 unique students in our dataset, but  unique combinations of 21,806 unique combinations of gender and student


```r
testuniqueness <- function(id, group) {
    length(unique(id)) == length(unique(id, group))
}  # Need better varname and some optimization to the speed of this code
testuniqueness(stuatt$sid, stuatt$male)
```

```
## [1] FALSE
```

```r
testuniqueness(stuatt$sid, stuatt$race_ethnicity)
```

```
## [1] FALSE
```

```r
testuniqueness(stuatt$sid, stuatt$birth_date)
```

```
## [1] FALSE
```


# Where is the data messy?


```r
stuatt[17:21, 1:3]
```

```
##    sid school_year male
## 17   7        2004    1
## 18   7        2005    1
## 19   7        2006    1
## 20   7        2007    0
## 21   7        2008    1
```

- How do we fix this?

# Unifying Consistent Gender Values
- First we create a variable with the number of unique values gender takes per student
- In R to do this we create a summary table of student attributes by collapsing the data set into one row per student
- Then we ask R to tell us how many rows have what values for the length of gender

```r
library(plyr)
sturow <- ddply(stuatt, .(sid), summarize, nvals_gender = length(unique(male)))
table(sturow$nvals_gender)
```

```
## 
##     1     2 
## 21799     4 
```

- So 4 students have more than one unique value for gender

# Fixing the pesky observations
- At this point there are a number of business rules we could adopt
- We could assign students the most recent value, the most frequent value, or even a random value!
- Let's see if replacing it with the most frequent value works


```r
# A function to find the most frequent value
statamode <- function(x) {
    z <- table(as.vector(x))
    m <- names(z)[z == max(z)]
    if (length(m) == 1) {
        return(m)
    }
    return(".")
}
sturow <- ddply(stuatt, .(sid), summarize, nvals_gender = length(unique(male)), 
    gender_mode = statamode(male), gender_recent = tail(male, 1))
head(sturow[7:10, ])
```

```
##    sid nvals_gender
## 7    7            2
## 8    8            1
## 9    9            1
## 10  10            1
```


# Fixing observations II
- Now we have two objects `stuatt` and `sturow` and we need to replace some values from `stuatt` with some values from `sturow`
- `merge` to the rescue!
- Let's `merge` our two data objects into a temporary data object called `tempdf`


```r
tempdf <- merge(stuatt, sturow)  # R finds the linking variable already
head(tempdf[17:21, c(1, 2, 3, 10, 11)])
subset(tempdf[, c(1, 2, 3, 10, 11)], sid == 12506)
```

- We fixed observation 7, but not observation 12506

# Fixing where the mode does not work

```r
subset(tempdf[, c(1, 2, 3, 10, 11, 12)], sid == 12506)
```

- Our next business rule is to assign the most recent value of gender from the `gender_recent` variable when there is not `gender_mode` that is valid
- This seems like a pretty simple job for `recoding` our variable!

# Recode Gender
- Two step process: first we assign `tempdf$male` to be the same as `tempdf$gender_mode`
- Then, where `tempdf$male` is now a "." indicating no modal category exists, we assign `tempdf$gender_recent` to be `tempdf$male`
- Go ahead and try this and use `testuniqueness(tempdf$id,tempdf$male)` to check if it worked

# Results

```r
tempdf$male <- tempdf$gender_mode
tempdf$male[tempdf$male == "."] <- tempdf$gender_recent[tempdf$male == "."]
# we have to put the filter on both sides of the assignment operator
testuniqueness(tempdf$id, tempdf$male)
```

```
## [1] TRUE
```

- Now let's clean up our workspace, we created a lot of temporary variables that we don't need

```r
rm(sturow)
stuatt <- tempdf
stuatt$nvals_gender <- NULL
stuatt$gender_mode <- NULL
stuatt$gender_recent <- NULL
# or just run stuatt<-tempdf[,1:9]
rm(tempdf)
```


# Create a consistent race and ethnicity indicator
- Let's practice the same procedure on race


```r
testuniqueness(stuatt$id, stuatt$race_ethnicity)
```

```
## [1] TRUE
```

```r
head(stuatt[, 1:4])
```

```
##   sid school_year race_ethnicity birth_date
## 1   1        2004              B      10869
## 2   1        2005              H      10869
## 3   1        2006              H      10869
## 4   1        2007              H      10869
## 5   2        2006              W      11948
## 6   2        2007              B      11948
```


# A Note About Variable Types
- In the SDP Toolkit you are advised to convert the `race_ethnicity` variable to numeric and add labels to it
- This is because Stata and other statistical packages don't have internal data structures that can handle the `factor` variable type like R can, and rely on numeric coding schemes
- Why don't we need to do this in R?
- In fact, in R, we should probably recode the `male` variable as a factor with values `M` and `F`
- One problem is that our datafile uses 'NA' for Native American and we do have to recode that... why?

# Recoding Race
- How do we do this?


```r
length(stuatt$race_ethnicity[is.na(stuatt$race_ethnicity)])
stuatt$race_ethnicity[is.na(stuatt$race_ethnicity)] <- "AI"
summary(stuatt$race_ethnicity)
```


# Correct conversion

```r
length(stuatt$race_ethnicity[is.na(stuatt$race_ethnicity)])
```

```
## [1] 1129
```

```r
stuatt$race_ethnicity <- as.character(stuatt$race_ethnicity)
stuatt$race_ethnicity[is.na(stuatt$race_ethnicity)] <- "AI"
stuatt$race_ethnicity <- factor(stuatt$race_ethnicity)
summary(stuatt$race_ethnicity)
```

```
##     A    AI     B     H   M/O     W 
##  7303  1129 25321 30444  2809 20528 
```

- Factors are pesky, even though they are useful and keep us from having to remember numeric representations of our data

# Inconsistency Within Years
- Let's consider student 3 in our dataset

```r
stuatt[7:9, c(1, 2, 4)]
```

```
##   sid school_year birth_date
## 7   3        2006      11724
## 8   3        2006      11724
## 9   3        2007      11724
```

- How is this different from our prior problem?

```r
length(unique(stuatt$sid, stuatt$school_year))
length(unique(stuatt[, c(1, 2, 4)]))
```



# How should we do the recoding of `stuatt$race_ethnicity`
-

# Answer

```r
tempdf <- ddply(stuatt, .(sid), summarize, var_temp = statamode(race_ethnicity), 
    nvals = length(unique(race_ethnicity)), most_recent_year = max(school_year), 
    most_recent_var = tail(race_ethnicity, 1))
tempdf$race2[tempdf$var_temp != "."] <- tempdf$var_temp[tempdf$var_temp != "."]
tempdf$race2[tempdf$var_temp == "."] <- paste(tempdf$most_recent_var[tempdf$var_temp == 
    "."])
tempdf <- merge(stuatt, tempdf)
head(tempdf[, c(1, 2, 4, 14)], 7)
```

- Why do we have to do a paste command?
- What other parts of this code are important to remember?
- Always filter on both sides
- Always use `summarize` in the `ddply` call in this situation

# A Faster Way
- The nice thing about R is we can role processes together once we understand them
- Let's build a script to do this more efficiently


```r
task1 <- function(df, id, year, var) {
    require(plyr)
    mdf <- eval(parse(text = paste("ddply(", df, ",.(", id, "),summarize,\nvar_temp=statamode(", 
        var, "),\nnvals=length(unique(", var, ")),most_recent_year=max(", year, 
        "),\nmost_recent_var=tail(", var, ",1))", sep = "")))
    mdf$var2[mdf$var_temp != "."] <- mdf$var_temp[mdf$var_temp != "."]
    mdf$var2[mdf$var_temp == "."] <- as.character(mdf$most_recent_var[mdf$var_temp == 
        "."])
    ndf <- eval(parse(text = paste("merge(", df, ",mdf)", sep = "")))
    rm(mdf)
    return(ndf)
}
# Note data must be sorted
tempdf <- task1(stuatt, stuatt$sid, stuatt$school_year, stuatt$race_ethnicity)
```



# Exercises
1. Sort `df` on `measerr` and `mathss`. What are the highest 5 values of each. 



# Other References
- [The Strategic Data Project Toolkit](http://www.gse.harvard.edu/~pfpie/index.php/sdp/tools)
- [UCLA ATS: R FAQ on Data Management](http://www.ats.ucla.edu/stat/r/faq/default.htm)
- [Video Tutorials](http://www.twotorials.com/)
