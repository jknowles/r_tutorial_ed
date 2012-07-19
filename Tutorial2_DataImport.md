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

```r
# NA can hold a place in a vector, NULL cannot
```

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
- This is because R is incredibly flexible and can handle data in almost any form
- So we have to carefully specify the data types to R so it can understand what form the data needs to take
- Compared to C this is great!

# CSV is Our Friend
- The easiest data type is .csv though Excel files can be read as well

```r
# Set working directory to the tutorial director In RStudio can do this in
# 'Tools' tab
setwd("~/GitHub/r_tutorial_ed")
```

```
## Error: cannot change working directory
```

```r
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
  - ```{r dim}
  dim(df)
  ```
  - ```{r summary}
  summary(df[,1:5])
    ```
  - ```{r names}
  names(df)
  ```
  -```{r attributes}
  names(attributes(df))
  class(df)
```
  

# Some Slide on RODBC
- Do you have data in a warehouse? 
  - RODBC can help
- You can query the data directly and bring it into R, saving time and hassle
- Makes your work reproducible, always start with a clean slate of data
- At DPI this can allow us to pull data directly from LDS or other databases

# Now we have the data
- What next?

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
## [1] knitr_0.7
## 
## loaded via a namespace (and not attached):
## [1] digest_0.5.2   evaluate_0.4.2 formatR_0.6    plyr_1.7.1    
## [5] stringr_0.6    tools_2.15.1  
```

