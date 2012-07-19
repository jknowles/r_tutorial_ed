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
df <- read.csv("data/smalldata.csv")
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
- R has an `aggregate` function that can be used
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




# Exercises
1. Sort `df` on `measerr` and `mathss`. What are the highest 5 values of each. 

