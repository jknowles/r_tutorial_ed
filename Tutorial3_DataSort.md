% Tutorial 3: Manipulating Data in R
% R Bootcamp HTML Slides
% Jared Knowles

# Overview
In this lesson we hope to learn:
- Aggregating data
- Organizing our data
- Manipulating vectors
- Dealing with missing data






# Again, read in our dataset

```r
# Set working directory to the tutorial directory In RStudio can do this
# in 'Tools' tab
setwd("~/GitHub/r_tutorial_ed")
# Load some data
load("data/smalldata.rda")
df <- mydat
rm(mydat)
# Note if we don't assign data to 'df' R just prints contents of table
```


# Aggregation
- Sometimes we need to do some basic checking for the number of observations or types of observations in our dataset
- To do this quickly and easily--the `table` function is our friend
- Let's look at our observations by year and grade

```r
table(df$grade, df$year)
```

```
##    
##     2000 2001 2002
##   3  200  100  200
##   4  100  200  100
##   5  200  100  200
##   6  100  200  100
##   7  200  100  200
##   8  100  200  100
```

- The first command gives the rows, the second gives the columns

# Aggregation can be more complex
- Let's aggregate by race and year


```r
table(df$year, df$race)
```

```
##       
##          A   B   H   I   W
##   2000  16 370  93   7 414
##   2001  16 370  93   7 414
##   2002  16 370  93   7 414
```


- Race is consistent across years, interesting
- What if we want to only look at 3rd graders that year?

# More complicated still


```r
with(df[df$grade == 3, ], {
    table(year, race)
})
```

```
##       race
## year     A   B   H   I   W
##   2000   4  78  22   4  92
##   2001   1  44   8   2  45
##   2002   0  74  20   1 105
```

- `with` specifies a data object to work on, in this case all elements of `df` where `grade==3`
- `table` is the same command as above, but since we specified the data object in the `with` statement, we don't need the `df$` in front of the variables of interest

# Quick exercise
- Can you find the number of black students in each grade in each year?
- hint: `with(df[df$___=="B",]...)`
- How many in year 2002, grade 6?
  * 48
- How many in 2001, grade 7?
  * 39


# Answer

```r
with(df[df$race == "B", ], {
    table(year, grade)
})
```

```
##       grade
## year    3  4  5  6  7  8
##   2000 78 48 87 39 74 44
##   2001 44 78 48 87 39 74
##   2002 74 44 78 48 87 39
```


# Tables cont.
- This is really powerful for looking at the descriptive dimensions of the data, we can ask questions like:
- how many students are at each proficiency level each year?

```r
table(df$year, df$proflvl)
```

```
##       
##        advanced basic below basic proficient
##   2000       56   313         143        388
##   2001      229   183          64        424
##   2002      503    27           3        367
```

- how many students are at each proficiency level by race?

```r
table(df$race, df$proflvl)
```

```
##    
##     advanced basic below basic proficient
##   A       19     7           3         19
##   B      160   302         162        486
##   H       54    76          33        116
##   I        7     4           1          9
##   W      548   134          11        549
```


# Proportional Tables
- What if we aren't interested in counts? 
- R makes it really easy to calculate proportions

```r
prop.table(table(df$race, df$proflvl))
```

```
##    
##      advanced     basic below basic proficient
##   A 0.0070370 0.0025926   0.0011111  0.0070370
##   B 0.0592593 0.1118519   0.0600000  0.1800000
##   H 0.0200000 0.0281481   0.0122222  0.0429630
##   I 0.0025926 0.0014815   0.0003704  0.0033333
##   W 0.2029630 0.0496296   0.0040741  0.2033333
```

- Hmmm, this is goofy. This tells us the proportion of each cell out of the total. Also, the digits are distracting. How can we fix this?

# Try number 2

```r
round(prop.table(table(df$race, df$proflvl), 1), digits = 3)
```

```
##    
##     advanced basic below basic proficient
##   A    0.396 0.146       0.062      0.396
##   B    0.144 0.272       0.146      0.438
##   H    0.194 0.272       0.118      0.416
##   I    0.333 0.190       0.048      0.429
##   W    0.441 0.108       0.009      0.442
```

- The `1` tells R we want proportions rowise, a `2` goes columnwise
- A few more problems arise--this pools all observations, including students across years

# Aggregating Data
- One of the most common questions will be to compute aggregates of data
- R has an `aggregate` function that can be used and helps us avoid the clustering problems above
- This works great for simple aggregation like scale score by race, we just need a `formula` (think I want variable X **by** grouping factor Y) and the statistic we want to compute


```r
# Reading Scores by Race
aggregate(readSS ~ race, FUN = mean, data = df)
```

```
##   race readSS
## 1    A  508.7
## 2    B  460.2
## 3    H  473.2
## 4    I  485.2
## 5    W  533.2
```


# Aggregate (II)
- `aggregate` can take us a little further, we can use aggregate multiple variables at a time

```r
aggregate(cbind(readSS, mathSS) ~ race, data = df, mean)
```

```
##   race readSS mathSS
## 1    A  508.7  477.9
## 2    B  460.2  442.5
## 3    H  473.2  442.7
## 4    I  485.2  455.9
## 5    W  533.2  529.8
```

- We can add multiple grouping varialbes using the `formula` syntax

```r
head(aggregate(cbind(readSS, mathSS) ~ race + grade, data = df, mean), 8)
```

```
##   race grade readSS mathSS
## 1    A     3  397.8  454.8
## 2    B     3  409.8  371.6
## 3    H     3  417.7  364.2
## 4    I     3  407.6  449.3
## 5    W     3  481.1  450.7
## 6    A     4  456.0  438.2
## 7    B     4  426.9  408.1
## 8    H     4  418.8  404.6
```


# Crosstabs
- We can build a systematic cross-tab now

```r
ag <- aggregate(readSS ~ race + grade, data = df, mean)
xtabs(readSS ~ ., data = ag)
```

```
##     grade
## race     3     4     5     6     7     8
##    A 397.8 456.0 479.1 539.5 600.4 605.3
##    B 409.8 426.9 447.6 470.9 492.3 523.5
##    H 417.7 418.8 481.2 489.1 500.3 534.2
##    I 407.6 531.1 547.6   0.0 405.5 518.0
##    W 481.1 498.5 517.1 546.6 565.2 596.1
```

- And prettier output

```r
ftable(xtabs(readSS ~ ., data = ag))
```

```
##      grade     3     4     5     6     7     8
## race                                          
## A          397.8 456.0 479.1 539.5 600.4 605.3
## B          409.8 426.9 447.6 470.9 492.3 523.5
## H          417.7 418.8 481.2 489.1 500.3 534.2
## I          407.6 531.1 547.6   0.0 405.5 518.0
## W          481.1 498.5 517.1 546.6 565.2 596.1
```


# Check your work
- What is the mean reading score for 6th grade students with disabilities?
  * __481.83__
- How many points is this from non-disabled students?
  * __29.877__


# Answer II

```r
aggregate(cbind(readSS, mathSS) ~ disab + grade, data = df, mean)
```

```
##    disab grade readSS mathSS
## 1      0     3  449.9  418.3
## 2      1     3  421.1  376.3
## 3      0     4  464.0  454.2
## 4      1     4  438.2  425.1
## 5      0     5  484.9  470.2
## 6      1     5  475.1  431.0
## 7      0     6  511.7  507.9
## 8      1     6  481.8  476.9
## 9      0     7  532.0  532.0
## 10     1     7  516.1  474.3
## 11     0     8  567.6  567.7
## 12     1     8  518.8  534.1
```


# Aggregate Isn't Enough
- `aggregate` is cool, but it isn't very flexible
- We can only use aggregate output as a table, which we have to convert to a data frame
- There is a better way; the `plyr` package
- `plyr` is a set of routines/logical structure for transforming, summarizing, reshaping, and reorganizing data objects of one type in R into another type
- We will focus here on summarizing and aggregating a data frame, but later in the bootcamp we'll apply functions to lists and turn lists into data frames as well
- This is cool!

# School Means
- Consider the case we want to turn our student level data into school level data
- Who hasn't had to do this?!?
- In `aggregate` we do:

```r
z <- aggregate(readSS ~ dist, FUN = mean, data = df)
z
```

```
##   dist readSS
## 1    6  493.8
## 2   15  496.4
## 3   45  492.1
## 4   66  507.2
## 5   75  496.6
## 6  105  491.0
```

- But I want more! I want to aggregate multiple variables. I want to do it across multiple groups. I want the output to be a dataframe I can work on.
- Thank you `plyr`

# Using plyr
- `plyr` has a straightforward syntax
- All `plyr` functions are in the format **XX**ply. The two X's specify what the input file we are applying a function to is, and then what way we would like it outputted.
- In `plyr` d = dataframe, l= list, m=matrix, and a=array. By far the most common usage is `ddply`
- From a dataframe, to a dataframe.

# plyr in Action

```r
library(plyr)
myag <- ddply(df, .(dist, grade), summarize, mean_read = mean(readSS, na.rm = T), 
    mean_math = mean(mathSS, na.rm = T), sd_read = sd(readSS, na.rm = T), sd_math = sd(mathSS, 
        na.rm = T), count_read = length(readSS), count_math = length(mathSS))
head(myag)
```

```
##   dist grade mean_read mean_math sd_read sd_math count_read count_math
## 1    6     3     409.8     425.5   70.82   78.30         50         50
## 2    6     4     471.6     426.2   83.95   68.70        100        100
## 3    6     5     466.2     485.8   75.58   78.00         50         50
## 4    6     6     502.9     476.4   90.29   75.57        100        100
## 5    6     7     536.1     539.9   64.38   76.63         50         50
## 6    6     8     541.6     536.2   66.58   67.05        100        100
```


# More plyr
- This is great, we can quickly build a summary dataset from individual records
- A few advanced tricks. How do we build counts and percentages into our dataset?

```r
myag <- ddply(df, .(dist, grade), summarize, mean_read = mean(readSS, na.rm = T), 
    mean_math = mean(mathSS, na.rm = T), sd_read = sd(readSS, na.rm = T), sd_math = sd(mathSS, 
        na.rm = T), count_read = length(readSS), count_math = length(mathSS), 
    count_black = length(race[race == "B"]), per_black = length(race[race == 
        "B"])/length(readSS))
summary(myag[, 7:10])
```

```
##    count_read    count_math   count_black     per_black    
##  Min.   : 50   Min.   : 50   Min.   :15.0   Min.   :0.300  
##  1st Qu.: 50   1st Qu.: 50   1st Qu.:20.8   1st Qu.:0.378  
##  Median : 75   Median : 75   Median :30.0   Median :0.400  
##  Mean   : 75   Mean   : 75   Mean   :30.8   Mean   :0.411  
##  3rd Qu.:100   3rd Qu.:100   3rd Qu.:40.0   3rd Qu.:0.453  
##  Max.   :100   Max.   :100   Max.   :48.0   Max.   :0.480  
```


# Quick Check
- What if we want to compare how districts do on educating ELL students?
- What district ID has the highest mean score for 4th grade ELL students on reading? Math?
  * 66 in reading, 105 in math
- How many students are in these classes?
  * 12 and 7 respectively


# Answer III

```r
myag2 <- ddply(df, .(dist, grade, ell), summarize, mean_read = mean(readSS, 
    na.rm = T), mean_math = mean(mathSS, na.rm = T), sd_read = sd(readSS, na.rm = T), 
    sd_math = sd(mathSS, na.rm = T), count_read = length(readSS), count_math = length(mathSS), 
    count_black = length(race[race == "B"]), per_black = length(race[race == 
        "B"])/length(readSS))
subset(myag2, ell == 1 & grade == 4)
```

```
##    dist grade ell mean_read mean_math sd_read sd_math count_read
## 4     6     4   1     424.6     375.8   76.98   41.74         17
## 16   15     4   1     425.4     420.6   84.18   18.74          6
## 28   45     4   1     405.5     422.8   93.56   89.99          6
## 40   66     4   1     469.4     407.0   78.71   63.82         12
## 52   75     4   1     389.6     376.3   49.68   39.15         10
## 64  105     4   1     411.6     439.8   68.48   55.78          7
##    count_math count_black per_black
## 4          17           3    0.1765
## 16          6           0    0.0000
## 28          6           0    0.0000
## 40         12           3    0.2500
## 52         10           2    0.2000
## 64          7           1    0.1429
```


# Sorting
- A key way to explore data in tabular form is to sort data
- Sorting data in R can be dangerous as you can reorder the vectors of a dataframe
- We use the `order` function to sort data


```r
df.badsort <- order(df$readSS, df$mathSS)
head(df.badsort)
```

```
## [1]  106 1026    2   56  122  118
```

- Why is this wrong?
- What is R giving us?
- Rownames...

# Correct Example
- To fix it, we need to tell R to reorder the rownames in the order we want


```r
df.sort <- df[order(df$readSS, df$mathSS, df$attday), ]
head(df[, c(3, 23, 29, 30)])
```

```
##    stuid attday readSS mathSS
## 1 149995    180  357.3  387.3
## 2  13495    180  263.9  302.6
## 3 106495    160  369.7  365.5
## 4  45205    168  346.6  344.5
## 5 142705    156  373.1  441.2
## 6  14995    157  436.8  463.4
```

```r
head(df.sort[, c(3, 23, 29, 30)])
```

```
##       stuid attday readSS mathSS
## 106  106705    160  251.5  277.0
## 1026  80995    176  263.2  377.8
## 2     13495    180  263.9  302.6
## 56   122402    180  264.3  271.7
## 122   79705    168  266.4  318.7
## 118   40495    173  266.9  275.0
```


# Let's clean it up a bit more

```r
head(df[with(df, order(-readSS, -attday)), c(3, 23, 29, 30)])
```

```
##       stuid attday readSS mathSS
## 1631 145205    137  833.2  828.4
## 1462 107705    180  773.3  746.6
## 2252 122902    180  744.0  621.6
## 2341  44902    175  741.7  676.3
## 1482 134705    180  739.2  705.4
## 1630  14495    162  738.9  758.2
```

- Here we find the high performing students, note that the `-` denotes we want descending order, R's default is ascending order
- This is easy to correct

# About sorting
- Sorting works differently on some data types, matrices are slightly different

```r
M <- matrix(c(1, 2, 2, 2, 3, 6, 4, 5), 4, 2, byrow = FALSE, dimnames = list(NULL, 
    c("a", "b")))
M[order(M[, "a"], -M[, "b"]), ]
```

```
##      a b
## [1,] 1 3
## [2,] 2 6
## [3,] 2 5
## [4,] 2 4
```

- Tables are familiar

```r
mytab <- table(df$grade, df$year)
mytab[order(mytab[, 1]), ]
```

```
##    
##     2000 2001 2002
##   4  100  200  100
##   6  100  200  100
##   8  100  200  100
##   3  200  100  200
##   5  200  100  200
##   7  200  100  200
```

```r
mytab[order(mytab[, 2]), ]
```

```
##    
##     2000 2001 2002
##   3  200  100  200
##   5  200  100  200
##   7  200  100  200
##   4  100  200  100
##   6  100  200  100
##   8  100  200  100
```


# Filtering Data
- Filtering data is an incredibly powerful feature and we have already seen it used to do some interesting things
- Filtering data in R is loaded with trouble though, because the filtering arguments must be very carefully specified
- Filtering is like a mini-sort
- Always, always, always check your work
- And remember, this is the place the NAs do the most damage
- Let's look at some examples

# Basic Filtering a Column

```r
# Gives all rows that meet this requirement
df[df$readSS > 800, ]
```

```
##            X school  stuid grade schid dist white black hisp indian asian
## 1631 1281061    852 145205     8   205   15     1     0    0      0     0
##      econ female ell disab sch_fay dist_fay luck ability measerr teachq
## 1631    0      1   0     0       0        0    0   108.3   6.325  155.7
##      year attday schoolscore district schoolhigh schoolavg schoollow
## 1631 2001    137       227.7       19          0         1         0
##      readSS mathSS  proflvl race
## 1631  833.2  828.4 advanced    W
```

```r
df$grade[df$mathSS > 800]
```

```
## [1] 8
```

```r
# Gives all values of grade that meet this requirement
```

- This seems basic enough, let's filter on multiple dimensions
- Before the brackets we specify what we want returned, and within the brackets we present the logical expression to evaluate
- Behind the scenes R does a logical test and gets the row numbers that match the logical expression
- It then combines them back with the object in front of the brackets to return the values
- So great we don't have to do that!

# Multiple filters

```r
df$grade[df$black == 1 & df$readSS > 650]
```

```
##  [1] 8 7 8 6 6 7 8 7 8 8 8 4
```

- What happens if we type `df$black=1` or `black==1`? 
- Why won't this work?

# Using filters to assign values
- We can also use filters to assign values as well
- This is how you recode variables and create new ones
- Let's create a variable `spread` indicating whether a district has high or low spread among its student scores

```r
myag$spread <- NA  # create variable
myag$spread[myag$sd_read < 75] <- "low"
myag$spread[myag$sd_read > 75] <- "high"
myag$spread <- as.factor(myag$spread)
summary(myag$spread)
```

```
## high  low 
##   26   10 
```


# Check your work
- The previous block of code is a useful way to learn how to recode variables


```r
myag$spread <- NA  # create variable
myag$spread[myag$sd_read < 75] <- "low"
myag$spread[myag$sd_read > 75] <- "high"
myag$spread <- as.factor(myag$spread)
```


- Create a new variable in `myag` called `schoolperf` for `mean_math` scores with the following coding scheme:


Grade | Score Range | Code
----- | ----------- | ----
3     |   >425      | "Hi"
4     |   >450      | "Hi"
5     |   >475      | "Hi"
6     |   >500      | "Hi"
7     |   >525      | "Hi"
8     |   >575      | "Hi"

- All other values are coded as "lo"
- How many "hi" and "lo" observations do we have?
- By `dist`?

# Results

```r
myag$schoolperf <- "lo"
myag$schoolperf[myag$grade == 3 & myag$mean_math > 425] <- "hi"
myag$schoolperf[myag$grade == 4 & myag$mean_math > 450] <- "hi"
myag$schoolperf[myag$grade == 5 & myag$mean_math > 475] <- "hi"
myag$schoolperf[myag$grade == 6 & myag$mean_math > 500] <- "hi"
myag$schoolperf[myag$grade == 7 & myag$mean_math > 525] <- "hi"
myag$schoolperf[myag$grade == 8 & myag$mean_math > 575] <- "hi"
myag$schoolperf <- as.factor(myag$schoolperf)
summary(myag$schoolperf)
```

```
## hi lo 
## 18 18 
```

```r
table(myag$dist, myag$schoolperf)
```

```
##      
##       hi lo
##   6    3  3
##   15   3  3
##   45   3  3
##   66   3  3
##   75   3  3
##   105  3  3
```



# Let's replace data
- For district 6 let's negate the grade 3 scores by replacing them with missing data

```r
myag$mean_read[myag$dist == 6 & myag$grade == 3] <- NA
head(myag[, 1:4], 2)
```

```
##   dist grade mean_read mean_math
## 1    6     3        NA     425.5
## 2    6     4     471.6     426.2
```

- Let's replace one data element with another

```r
myag$mean_read[myag$dist == 6 & myag$grade == 3] <- myag$mean_read[myag$dist == 
    6 & myag$grade == 4]
head(myag[, 1:4], 2)
```

```
##   dist grade mean_read mean_math
## 1    6     3     471.6     425.5
## 2    6     4     471.6     426.2
```

- Voila

# Why do NAs matter so much?
- Let's consider the case above but insert some NA values for all 3rd grade tests

```r
myag$mean_read[myag$grade == 3] <- NA
head(myag[order(myag$grade), 1:4])
```

```
##    dist grade mean_read mean_math
## 1     6     3        NA     425.5
## 7    15     3        NA     403.8
## 13   45     3        NA     404.9
## 19   66     3        NA     438.3
## 25   75     3        NA     408.4
## 31  105     3        NA     406.1
```



# NAs II
- Now let's calculate a few statistics:

```r
mean(myag$mean_math)
```

```
## [1] 490.7
```

```r
mean(myag$mean_read)
```

```
## [1] NA
```

- Remember, NA values propogate, so R assumes an NA value could take literally any value, and as such it is impossible to know the `mean` of a vector with NA
- We can override this though:

```r
mean(myag$mean_math, na.rm = T)
```

```
## [1] 490.7
```

```r
mean(myag$mean_read, na.rm = T)
```

```
## [1] 507.5
```


# Beyond the Mean
- But for other problems it is tricky
- What if we want to know the number of rows that have a `mean_read` of less than 500?

```r
length(myag$dist[myag$mean_read < 500])
```

```
## [1] 20
```

```r
head(myag$mean_read[myag$mean_read < 500])
```

```
## [1]    NA 471.6 466.2    NA 436.1 490.9
```

- And what if we want to add the standard deviation to these vectors?

```r
badvar <- myag$mean_read + myag$sd_read
summary(badvar)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##     505     566     589     587     612     658       6 
```


# So we need to filter NAs explicitly
- Consider the case where two sets of variables have different missing elements

```r
myag$sd_read[myag$count_read < 100 & myag$mean_read < 550] <- NA
length(myag$mean_read[myag$mean_read < 550])
```

```
## [1] 30
```

```r
length(myag$mean_read[myag$mean_read < 550 & !is.na(myag$mean_read)])
```

```
## [1] 24
```

- What is `!is.na()` ?
  * `is.na()` is a helpful function to identify TRUE if a value is missing
  * `!` is the reverse operator
  * We are asking R if this value is not a missing value, and to only give us non-missing values back

# Merging Data
- It is unlikely all the data we will want resides in a single dataset and often we have to combine data from several sources
- R makes this easy, but that simplicity comes at a cost--it can be easy to make mistakes if you don't specify things carefully





# Reshaping Data
- Reshaping data is a slightly different issue than aggregating data
- Let's review the two data types: long and wide

```r
head(df[, 1:10], 3)
```

```
##     X school  stuid grade schid dist white black hisp indian
## 1  44      1 149995     3   495  105     0     1    0      0
## 2  53      1  13495     3   495   45     0     1    0      0
## 3 116      1 106495     3   495   45     0     1    0      0
```

- Now let's look at wide:

```r
head(widedf[, 28:40], 3)
```

```
##   readSS.2000 mathSS.2000 proflvl.2000 race.2000  X.2001 school.2001
## 1       357.3       387.3        basic         B  441000           1
## 2       263.9       302.6  below basic         B  531000           1
## 3       369.7       365.5        basic         B 1161000           1
##   grade.2001 schid.2001 dist.2001 white.2001 black.2001 hisp.2001
## 1          4        495       105          0          1         0
## 2          4        495        45          0          1         0
## 3          4        495        45          0          1         0
##   indian.2001
## 1           0
## 2           0
## 3           0
```

- How did we do this?

# Wide data v. Long Data 
- The great debate
- Most econometrics, panel, and time series datasets come wide and so these seem familiar
- R for most cases prefers long data, including for most graphing and analysis functions
- But, not all
- So we have to learn both

# The reshape Function
- `reshape` is the way to move from wide to long
- The data stays the same, but the shape of it changes
- The long data had dimensions: `2700, 32`
- The wide data has dimensions: `1200, 91`
- How do we get to these numbers?
  * The rows in the wide dataframe represent unique students

# Deconstructing reshape

```r
widedf <- reshape(df, timevar = "year", idvar = "stuid", direction = "wide")
```

- `idvar` represents the unit we want to represent a single row, in this case each unique student gets a single row
- In this simple case `timevar` is the variable that differenaties between two rows with the same student ID
- `direction` tells R we are going to move to wide data
- As written all data will move, but using the `varying` argument we can tell R explicitly which items we want to move wide

# What about Wide to Long?
- We often need to do this to plot data in R
- Luckily the `reshape` function works well in both directions

```r
longdf <- reshape(widedf, idvar = "stuid", timevar = "year", varying = names(widedf[, 
    2:91]), direction = "long", sep = ".")
```

- If our data is formatted nicely, R can do the guessing and identify the years for us by parsing the dataframe names


# Subsetting Data
- We have already seen a lot of subsetting examples above, which is what filtering is, but R provides some great shortcuts to this
- Let's look at the `subset` function to get only 4th grade scores

```r
g4 <- subset(df, grade == 4)
dim(g4)
```

```
## [1] 400  32
```

- This is equivalent to:

```r
g4_b <- df[df$grade == 4, ]
```

- These two elements are the same:

```r
identical(g4, g4_b)
```

```
## [1] TRUE
```


# That's it
- Now you can filter, subset, sort, recode, and aggregate data!
- Let's look at a few exercises to test these skills
- Once these skills are mastered, we can begin to understand how to automate R to clean data with known errors, and to recode data in R so it is ready to be used for analysis
- Then we can really take off!

# Exercises
1. Sort `df` on `measerr` and `mathss`. What are the highest 5 values of each. 



# Other References
- [An R Vocabulary for Starting Out](https://github.com/hadley/devtools/wiki/vocabulary)
- [Quick-R: Data Management](http://www.statmethods.net/management/index.html)
- [UCLA ATS: R FAQ on Data Management](http://www.ats.ucla.edu/stat/r/faq/default.htm)
- [Video Tutorials](http://www.twotorials.com/)

