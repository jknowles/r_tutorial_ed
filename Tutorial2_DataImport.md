% Tutorial 2: Getting Data In
% R Bootcamp HTML Slides
% Jared Knowles

# Overview
- Loading Packages
- Data import is incredibly flexible and once you are used to it, it is easy
- Understand data types
- Load a CSV file
- Organize an analysis project
- Query a database

# A quick note on R `packages`
- `packages` are essentially free and open source add-ons for R
- There are over 3,000 packages available for R that add all sorts of functionality
- A few examples (from the mundane to the crazy)
  * Additional graphics capabilities from the `ggplot2` package
  * Advanced regression techniques from the `lme4` package for mixed effects models
  * 3d graphics from the `scatterplot3d` package (also `webGL`)
  * GIS analytics and mapping functionality with `sp`
  * Text mining analytics with `tm`
  * Predictive modeling frameworks with `caret`
  * Interfaces to other programming languages like Python, Java, and C and C++
  * A web server: `Rserve`
  * And Minesweeper from the `fun` package
  

# I can haz packages?

```r
# You can find and install packages within R
install.packages("foo")  # Name must be in quotes
install.packages(c("foo", "foo1", "foo2"))
# Packages get updated FREQUENTLY
update.packages()  # Gonna update them all
```

- Note, on Windows Vista and later R either needs to be run as an administrator to install packages, or you have to fiddle with where the packages are installed
- Packages are stored in something called the **library** which is just a collection of packages
  * Sometimes folks call packages **libraries**

# Finding Packages
- Official packages are found on CRAN (Comprehensive R A Network)
- Unofficial packages or **beta** versions of packages are found on RForge and GitHub mostly
- To find out what packages are out there that do a specific function, try:
  * Google "doing X in R package"
  * Look at CRAN taskviews
- CRAN taskviews are great to find a bunch of packages related to a problem you are trying to solve

# Some Must Have Packages
`plyr` `ggplot2` `lme4` `sp` `knitr`

# Data Management
- Data management in R used to be managed by the `ls()` command 
- Go ahead, type it. 
- Now you can look at the Workspace tab in RStudio and have a complete list of the data in R's memory that is accessible to you
- All data objects have names
- All object names are unique (not strictly so, but let's not violate this)
- To reference items within an object type we need to give it an address like in `mydata$thingIwant` or `mydata@thingIwant`
- The `$` and `@` distinction depends on whether this is an S3 or an S4 class

# Ground Rules
- Get used to plain text input files
  * R can handle other formats, but your error rate increases as does the tweaking necessary
- R has a limited set of special characters (symbols) you can use in your data input to be translated correctly 
- These symbols are reserved and will be interpreted in strange ways if you include them in your plain text data file
- Most of them are fairly obvious operators, see [Paul Murrell's excellent summary](http://www.stat.auckland.ac.nz/~paul/ItDT/HTML/node75.html)


# Missing Data Symbols
- Missing data has the symbols `NA` or `NaN` or `NULL` depending on the context.
- Consider:

```r
a <- c(1, 2, 3)  # a is a vector with three elements
# Ask R for element 4
print(a[4])
```

```
## [1] NA
```

- But what is the difference between `NA` and `NULL`?

```r
ls()  # get objects
```

```
## [1] "a"
```

```r
a <- c(a, NULL)  # Append NULL onto a
print(a)
```

```
## [1] 1 2 3
```

```r
# Notice no change
a <- c(a, NA)
print(a)
```

```
## [1]  1  2  3 NA
```

- `NA` can hold a place, `NULL` cannot
- `NaN` is even more special, and only holds things like imaginary numbers

```r
b <- 1
b <- sqrt(-b)
```

```
## Warning: NaNs produced
```

```r
print(b)
```

```
## [1] NaN
```

```r
pi/0
```

```
## [1] Inf
```

- Inf is a special case as well representing an infinite value; just for fun `sin(Inf)` = `NaN`

# Beginning Analysis
- Now let's set up our analysis project
- It is best to keep projects discrete in directories
- Create a few subdirectories
  - Data
  - Functions / R src
  - Figures / Plots
  - Cleaned Data
- See the ProjectTemplate package for a more detailed philosophy about organizing projects

# Organization of a project is key
- Separate data from scripts
- Separate automatic scripts from interactive scripts
- Put figures apart from both of these
- **Always keep your raw data**

# Read in Data
- Reading in data is one of the trickiest issues for R
- This is because R is incredibly flexible and can handle data in almost any form including `.csv` `.dta` `.sas` `.spss` `.dat` and even `.xls` and `.xlsx` with some care
- So we have to carefully specify the data types to R so it can understand what form the data needs to take
- Compared to C this is great!

# CSV is Our Friend
- The easiest data type is .csv though Excel files can be read as well `df`

```r
# Set working directory to the tutorial directory In RStudio can do this
# in 'Tools' tab
setwd("~/GitHub/r_tutorial_ed")
# Load some data
df <- read.csv("data/smalldata.csv")
# Note if we don't assign data to 'df' R just prints contents of table
```


# Let's Check What We Got

```
## 'data.frame':	2700 obs. of  6 variables:
##  $ schoolavg: int  1 1 1 1 1 1 1 1 1 1 ...
##  $ schoollow: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ readSS   : num  357 264 370 347 373 ...
##  $ mathSS   : num  387 303 365 344 441 ...
##  $ proflvl  : Factor w/ 4 levels "advanced","basic",..: 2 3 2 2 2 4 4 4 3 2 ...
##  $ race     : Factor w/ 5 levels "A","B","H","I",..: 2 2 2 2 2 2 2 2 2 2 ...
```


# Always Check Your Data
- A few great commands:

```r
dim(df)
```

```
## [1] 2700   32
```

-

```r
summary(df[, 1:5])
```

```
##        X               school         stuid            grade     
##  Min.   :     44   Min.   :   1   Min.   :   205   Min.   :3.00  
##  1st Qu.: 108677   1st Qu.: 195   1st Qu.: 44205   1st Qu.:4.00  
##  Median : 458596   Median : 436   Median : 88205   Median :5.00  
##  Mean   : 557918   Mean   : 460   Mean   : 99229   Mean   :5.44  
##  3rd Qu.: 972291   3rd Qu.: 717   3rd Qu.:132205   3rd Qu.:7.00  
##  Max.   :1499992   Max.   :1000   Max.   :324953   Max.   :8.00  
##      schid    
##  Min.   :205  
##  1st Qu.:205  
##  Median :402  
##  Mean   :367  
##  3rd Qu.:495  
##  Max.   :495  
```

-

```r
names(df)
```

```
##  [1] "X"           "school"      "stuid"       "grade"       "schid"      
##  [6] "dist"        "white"       "black"       "hisp"        "indian"     
## [11] "asian"       "econ"        "female"      "ell"         "disab"      
## [16] "sch_fay"     "dist_fay"    "luck"        "ability"     "measerr"    
## [21] "teachq"      "year"        "attday"      "schoolscore" "district"   
## [26] "schoolhigh"  "schoolavg"   "schoollow"   "readSS"      "mathSS"     
## [31] "proflvl"     "race"       
```

-

```r
names(attributes(df))
```

```
## [1] "names"     "class"     "row.names"
```

```r
class(df)
```

```
## [1] "data.frame"
```

  

# Data Warehouses, Oracle, SQL and RODBC
- Do you have data in a warehouse? 
  - RODBC can help
- You can query the data directly and bring it into R, saving time and hassle
- Makes your work reproducible, always start with a clean slate of data
- At DPI this can allow us to pull data directly from LDS or other databases using SQL queries

# An Example From DPI
- The basics of the RODBC package are easy to understand


```r
library(RODBC)  # interface driver for R
channel <- odbcConnect("Mydatabase.location", uid = "useR", pwd = "secret")  # establish connection
# we can do multiple connections in the same R session credentials stored
# in plain text unless you do some magic
table_list <- sqltables(channel, schema = "My_DB")  # Get a list of tables in the connection
colnames(sqlFetch(channel, "My_DB.TABLE_NAME", max = 1))  # get the column names of a table

datapull <- sqlQuery(channel, "SELECT DATA1, DATA2, DATA3 FROM My_DB.TABLE_NAME")  # execute some SQLquery, can paste any SQLquery as a string into this space
```


# Missing Data
- Let's add some missing data to our dataframe so we can see how missing data works


```r
random <- sample(unique(df$stuid), 100)
random2 <- sample(unique(df$stuid), 120)
messdf <- df
messdf$readSS[messdf$stuid %in% random] <- NA
messdf$mathSS[messdf$stuid %in% random2] <- NA
```


# Checking for Missing Data
- The `summary` function helps identify missing data

```r
summary(messdf[, c("stuid", "readSS", "mathSS")])
```

```
##      stuid            readSS        mathSS   
##  Min.   :   205   Min.   :252   Min.   :232  
##  1st Qu.: 44205   1st Qu.:431   1st Qu.:417  
##  Median : 88205   Median :496   Median :479  
##  Mean   : 99229   Mean   :497   Mean   :483  
##  3rd Qu.:132205   3rd Qu.:564   3rd Qu.:546  
##  Max.   :324953   Max.   :773   Max.   :828  
##                   NA's   :218   NA's   :257  
```

```r
nrow(messdf[!complete.cases(messdf), ])  # number of rows with missing data
```

```
## [1] 457
```

- To get rid of missing data, we can copy our data with all missing cases dropped using the `na.omit` function

```r
cleandf <- na.omit(messdf)
nrow(cleandf)
```

```
## [1] 2243
```


# Now we have the data
- What next?
- We need to do some basic diagnostics on our data to understand the look and feel of it before we proceed
- Here are a few examples of scripts we could run to understand our data object

```r
dim(messdf)
```

```
## [1] 2700   32
```

```r
str(messdf[, 18:26])
```

```
## 'data.frame':	2700 obs. of  9 variables:
##  $ luck       : int  0 1 0 1 0 0 1 0 0 0 ...
##  $ ability    : num  87.9 97.8 104.5 111.7 81.9 ...
##  $ measerr    : num  11.13 6.82 -7.86 -17.57 52.98 ...
##  $ teachq     : num  39.0902 0.0985 39.5389 24.1161 56.6806 ...
##  $ year       : int  2000 2000 2000 2000 2000 2000 2000 2000 2000 2000 ...
##  $ attday     : int  180 180 160 168 156 157 169 180 170 152 ...
##  $ schoolscore: num  29.2 56 56 56 56 ...
##  $ district   : int  3 3 3 3 3 3 3 3 3 3 ...
##  $ schoolhigh : int  0 0 0 0 0 0 0 0 0 0 ...
```

```r
names(messdf)
```

```
##  [1] "X"           "school"      "stuid"       "grade"       "schid"      
##  [6] "dist"        "white"       "black"       "hisp"        "indian"     
## [11] "asian"       "econ"        "female"      "ell"         "disab"      
## [16] "sch_fay"     "dist_fay"    "luck"        "ability"     "measerr"    
## [21] "teachq"      "year"        "attday"      "schoolscore" "district"   
## [26] "schoolhigh"  "schoolavg"   "schoollow"   "readSS"      "mathSS"     
## [31] "proflvl"     "race"       
```

- It looks like we have a number of `id` variables, this is useful and it is good to check if these variables have multiple rows per id or not and we do this using `length` and `unique`

```r
length(unique(messdf$stuid))
```

```
## [1] 1200
```

```r
length(unique(messdf$schid))
```

```
## [1] 3
```

```r
length(unique(messdf$dist))
```

```
## [1] 6
```


# Checking for Coding
- Data is coded using numeric or character representations of attributes--commonly things are coded using a 1 and 0 scheme or an A,B,C scheme
- With R we can check how our variables are coded very easily


```r
unique(messdf$grade)
```

```
## [1] 3 4 5 6 7 8
```

```r
unique(messdf$econ)
```

```
## [1] 0 1
```

```r
unique(messdf$race)
```

```
## [1] B H I W A
## Levels: A B H I W
```

```r
unique(messdf$disab)
```

```
## [1] 0 1
```


# Next Steps
- In the next section we will learn to aggregate, explore, reshape, and recode data
- Questions?

# Exercises
1.
2.
3. 

# Other References
- [UCLA Academic Technology Services: Reading in Raw Data](http://www.ats.ucla.edu/stat/r/pages/raw_data.htm)
- [An R Vocabulary for Starting Out](https://github.com/hadley/devtools/wiki/vocabulary)
- [Quick-R: Data Import](http://www.statmethods.net/input/importingdata.html)
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
## [1] knitr_0.7
## 
## loaded via a namespace (and not attached):
## [1] digest_0.5.2   evaluate_0.4.2 formatR_0.6    plyr_1.7.1    
## [5] stringr_0.6    tools_2.15.1  
```

