% Tutorial 1: Getting Started
% R Bootcamp HTML Slides
% Jared Knowles




# R
- R is an Open Source (and freely available) environment for statistical computing and graphics
- Available for Windows, Mac OS X, and Linux
- R is being actively developed with two major releases per year and dozens of releases of add on packages
- R can be extended with 'packages' that contain data, code, and documentation to add new functionality

# What Does it Look Like?
The R workspace in RStudio

<p align="center"><img src="img/workspacescreen.png" height="500" width="700"></p>

# A Bit of Histo**R**y
- R is a flavor of the **S** computer language
- S was developed by John Chambers at Bell Labs in the late 1970s
- In 1988 it was rewritten from a Fortran base to a C base
- Version 4 of S, the latest version, was finished in 1998, and won several awards

# The Philosophy
John Chambers, in describing the logic behind the S language said:

> [W]e wanted users to be able to begin in an interactive
> environment, where they did not consciously think of
> themselves as programming. Then as their needs became
> clearer and their sophistication increased, they should be
> able to slide gradually into programming, when the
> language and system aspects would become more
> important.


# R is Born
- 1991 in New Zealand Ross Ihaka and Robert Gentleman create R
- Named for their first initials
- R is made public in 1993, and in 1995 Martin Maechler convinces the creators to make it open source with the GNU General Public License
- 1997 R Core Group is formed--the maintainers and main developers of R (about 14 members today)
- 2000 version 1.0.0 ships
- 2012 version 2.15.1 is available


# Why Use R
- R is a common tool among data experts at major universities
- No need to go through procurement, R can be installed in any environment on any machine and used with no licensing or agreements needed
- R source code is very readable to increase transparency of processes
- R code is easily borrowed from and shared with others
- R is incredibly flexible and can be adapted to specific local needs
- R is under incredibly active development, improving greatly, and supported wildly by both professional and academic developers

# Thoughts on Free
- R is free in many senses
  1. R can be run and used for any purpose, commercial or non-commercial, profit or not-for-profit
  2. R's source code is freely available so you can study how it works and adapt it to your needs.
  3. R is free to redistribute so you can share it with your ~~enemies~~  friends
  4. R is free to modify and those modifications are free to redistribute and may be adopted by the rest of the community!


# R Advantages Continued
- R is platform agnostic--Linux, Mac, PC, server, desktop, etc.
- R can output results in a variety of formats
- R can build routines straight out of a database for common and universal reporting

R Can Compliment Other Tools
------------------------------------
- R plays nicely with data from Stata, SPSS, SAS and others
- R can check work, produce output, visualize results from other programs
- R can do bleeding edge analysis that aren't available in proprietary packages yet
- R is becoming more prevalent in undergraduate statistics courses

# R's Drawbacks
- R is based on S, which is close to 40 years old
- R only has features that the community contributes
- Not the ideal solution to all problems
- R is a programming language and not a software package--steeper learning curve

# Google Scholar Hits
R has recently passed Stata on Google Scholar hits and it is catching up to the two major players SPSS and SAS

<p align="center"><img src="img/googlescholar.png" height="500" width="700"></p>

# R Has an Active Web Presence
R is linked to from more and more sites 

<p align="center"><img src="img/sitelinks.png" height="500" width="700"></p>

# R Extensions
These links come from the explosion of add-on packages to R

<p align="center"><img src="img/addons.png" height="500" width="700"></p>

# R Has an Active Community 
Usage of the R listserv for help has really exploded recently

<p align="center"><img src="img/rlistserv.png" height="500" width="700"></p>

# R Vocabulary
- **packages** are add on features to R that include data, new functions and methods, and extended capabilities. Think of them as ``apps'' on your phone.
- **terminal** this is the main window of R where you enter commands
- **scripts** these are where you store commands to be run in the terminal later, like syntax in SPSS or .do files in Stata
- **functions** commands that do something to an object in R
- **dataframe** the main element for statistical purposes, an object with rows and columns that includes numbers, factors, and other data types
- **workspace** the working memory of R where all objects in the current session are stored
- **vector** the basic unit of data in R
- **symbols** anything not starting with a digit, can be used to name and store objects or to designate operations/functions
- **attributes** determine how functions act on objects

# Components of an R Setup
- **R** - obviously we need R. R works in the command line of any OS, but also comes with a basic GUI to operate on its own in Windows and Mac [download](http://cran.r-project.org/)
- **RStudio** - a much better way to work in R that allows editing of scripts, operation of R, viewing of the workspace, and R help all on one screen [download](http://rstudio.org/download/)
- **LaTeX** - for producing documents using R this is less necessary, but still useful. download [WIN](http://miktex.org/2.9/setup) [MAC](http://www.tug.org/mactex/2011/)

**ADVANCED**

- **Dev Tools for R** - on Windows this is Rtools, on Linux and Mac it is installing the development mode of R download [WIN](http://www.stats.ox.ac.uk/pub/Rtools/R215x.html) [MAC](http://cran.r-project.org/bin/macosx/tools/)
- **Git** - for version control, sharing code, and collaboration this is essential. It integrates well with RStudio. [download](http://git-scm.com/download)
- **pandoc** - for converting output into other formats for sharing with non-user**R**s! [download](http://johnmacfarlane.net/pandoc/installing.html)
- **ImageMagick** - for creating more flexible graphics in R, including animations! [download](http://www.imagemagick.org/script/index.php) [alternate](http://www.graphicsmagick.org/)

# Open Source Toolchain
- This really represents a completely open source toolchain to going from a data analysis idea, to a full fledged professional report
- These tools are free, updated regularly, and available on **any** platform **today**

# Some Notes about Maintaining R
- Adding packages onto R means you also have to update them with the `update.packages()` command
- Upgrading R, which is on a 6 month release cycle, is not straightforward
- We will walk through this a bit later, but remember that the flexibility in R means that users probably need to be self-supported

# Self-help
- In the spirit of open-source R is very much a self-guided tool
- Let's see, type: `?summary`
- Now type: `??regression`
- For tricky questions, funky error messages (there are many), and other issues, use Google (include "in R" to the end of your query)


# R As A Calculator


```r
2 + 2  # add numbers
```

```
## [1] 4
```

```r
2 * pi  #multiply by a constant
```

```
## [1] 6.283
```

```r
7 + runif(1, min = 0, max = 1)  #add a random variable
```

```
## [1] 7.378
```

```r
4^4  # powers
```

```
## [1] 256
```

```r
sqrt(4^4)  # functions
```

```
## [1] 16
```


# Arithmetic Operators
- In addition to the obvious `+` `-` `=` `/` `*` and exponential `^`, there is also integer division `%/%` and remainder in integer division (known as modulo arithmetic) `%%`

```r
2 + 2
```

```
## [1] 4
```

```r
2/2
```

```
## [1] 1
```

```r
2 * 2
```

```
## [1] 4
```

```r
2^2
```

```
## [1] 4
```

```r
2 = 2
```

```
## Error: invalid (do_set) left-hand side to assignment
```

```r
23%/%2
```

```
## [1] 11
```

```r
23%%2
```

```
## [1] 1
```


# Other Key Symbols
- `<-` is the assignment operator, it declares something is something else

```r
foo <- 3
foo
```

```
## [1] 3
```

- `:` is the sequence operator

```r
1:10
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```

```r
# it increments by one
a <- 100:120
a
```

```
##  [1] 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116
## [18] 117 118 119 120
```

- **This is handy**

# R Advanced Math
- R also supports advanced mathematical features and expressions
- R can take integrals and derivatives and express complex functions
- Easiest of all, R can generate distributions of data very easily
- This comes in handy when writing examples and building analyses


# Using the Workspace
- To do more we need to learn how to manipulate the 'workspace'.
- This includes all the vectors, datasets, and functions stored in memory.
- All R objects are stored in the memory of the computer, limiting the available space for calculation to the size of the RAM on your machine.
- R makes organizing the workspace easy.

# Using the Workspace (2)

```r
x <- 5  #store a variable with <-
x  #print the variable
```

```
## [1] 5
```

```r
z <- 3
ls()  #list all variables
```

```
## [1] "x" "z"
```

```r
ls.str()  #list and describe variables
```

```
## x :  num 5
## z :  num 3
```

```r
rm(x)  # delete a variable
ls()
```

```
## [1] "z"
```


# R as a Language
- R is more than statistical software, it is a computer language
- Like any language it has rules (some poorly enforced), and conventions
- You will learn more as you go, but we'll go over a few to start

1. Case sensitivity matters

```r
a <- 3
A <- 4
print(c(a, A))
```

```
## [1] 3 4
```

  * <font color="red">**a** &#8800; **A**</font> 
2. What happens if I type **print(a,A)**?

# `c` is our friend
- So what does **c** do?

```r
A <- c(3, 4)
print(A)
```

```
## [1] 3 4
```

- `c` stands for concatenate and allows vectors to have multiple elements

# Language
- In language there are a number of ways to say the same thing
  *  <font color="green">The dog chased the cat.</font> 
  *  <font color ="blue">The cat was chased by the dog.</font>
  *  <font color ="red">By the dog, the cat was chased.</font>
- Some ways are more elegant than others, all convey the same message. 

```r
a <- runif(100)  # Generate 100 random numbers
b <- runif(100)  # 100 more
c <- NULL  # Setup for loop (declare variables)
for (i in 1:100) {
    # Loop just like in Java or C
    c[i] <- a[i] * b[i]
}
d <- a * b
identical(c, d)  # Test equality
```

```
## [1] TRUE
```

- Which is nicer?

# More Language ~~Bugs~~ Features
- R is maddeningly inconsistent
  * Some functions are `camelCase`; others `are.dot.separated`; others `use_underscores`
  * Function results are stored in a variety of ways across function implementations
  * R has multiple graphics packages that different functions use for default plot construction (`base`, `grid`, `lattice`, and `ggplot2`)

# Reading Data In
- To read data in we have to tell R where it currently is on the filesystem by setting a working directory
- Then we have to tell it where to look for the dataset and what format that dataset is in
- CSV files are **simplest** for beginning use cases, but R is flexible

```r
# Set working directory to the tutorial director In RStudio can do this in
# 'Tools' tab
setwd("~/r_tutorial_ed")
```

```
## Error: cannot change working directory
```

```r
# Load some data
df <- read.csv("data/smalldata.csv")
# Note if we don't assign data to 'df' R just prints contents of table
```


# Objects
- Everything in R is an object--even functions
- Objects can be manipulated many ways
- A common example is applying the `summary' function to a variety of object types and seeing how it adapts

```r
summary(df[, 28:31])  #summary look at df object
```

```
##    schoollow         readSS        mathSS           proflvl    
##  Min.   :0.000   Min.   :252   Min.   :210   advanced   : 788  
##  1st Qu.:0.000   1st Qu.:430   1st Qu.:418   basic      : 523  
##  Median :0.000   Median :495   Median :480   below basic: 210  
##  Mean   :0.242   Mean   :496   Mean   :483   proficient :1179  
##  3rd Qu.:0.000   3rd Qu.:562   3rd Qu.:543                     
##  Max.   :1.000   Max.   :833   Max.   :828                     
```

```r
summary(df$readSS)  #summary of a single column
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     252     430     495     496     562     833 
```

-The `$` says to look for object **readSS** in object **df**

# Graphics too


```r
library(ggplot2)  # Load graphics Package
qplot(readSS, mathSS, data = df, geom = "point", alpha = I(0.3)) + theme_bw() + 
    opts(title = "Test Score Relationship") + geom_smooth()
```

![Student Test Scores](figure/slides-graphics1.svg) 


# Handling Data in R
- R handles data differently than many other statistical packages
- In R, all elements are objects

```r
length(unique(df$school))
```

```
## [1] 173
```

```r
length(unique(df$stuid))
```

```
## [1] 1200
```

```r
uniqstu <- length(unique(df$stuid))
uniqstu
```

```
## [1] 1200
```

- Results of function calls can be stored


# Special Operators
- The comparison operators `<`, `>`, `<=`, `>=`, `==`, and `!=` are used to compare values across vectors

```r
big <- c(9, 12, 15, 25)
small <- c(9, 3, 4, 2)
big > small
```

```
## [1] FALSE  TRUE  TRUE  TRUE
```

```r
# Gives us a nice vector of logical values
big = small
# Oops--don't do this, reassigns big to small
print(big)
```

```
## [1] 9 3 4 2
```

```r
print(small)
```

```
## [1] 9 3 4 2
```


# Special Operators II
- The best way to evaluate these objects is to use brackets `[]`


```r
big <- c(9, 12, 15, 25)
big[big == small]
```

```
## [1] 9
```

```r
# Returns values where the logical vector is true
big[big > small]
```

```
## [1] 12 15 25
```

```r
big[big < small]  # Returns an empty set
```

```
## numeric(0)
```


# Special operators (III)
- The `%in%` operator determines whether each value in the left operand can be matched with one of the values in the right operand.

```r
big <- c(9, 12, 15, 25)
small <- c(9, 12, 15, 25, 9, 1, 3)
big[small %in% big]
```

```
## [1]  9 12 15 25 NA
```



# Special operators (IV)
- The logical operators `||` (or) and `&&` (and) can be used to combine two logical values and produce another logical value as the result. The operator `!` (not) negates a logical value. These operators allow complex conditions to be constructed.

```r
foo <- c("a", NA, 4, 9, 8.7)
!is.na(foo)  # Returns TRUE for non-NA
```

```
## [1]  TRUE FALSE  TRUE  TRUE  TRUE
```

```r
class(foo)
```

```
## [1] "character"
```

```r
a <- foo[!is.na(foo)]
class(a)
```

```
## [1] "character"
```


# Simple Data Cleaning Function
- What if we want to extract the numeric elements out of `foo`?


```r
extractN <- function(x) {
    x <- x[!is.na(x)]
    x <- suppressWarnings(as.numeric(x))
    # ignore warnings because we don't care
    x <- x[!is.na(x)]
    x
}
extractN(foo)
```

```
## [1] 4.0 9.0 8.7
```

```r
A <- extractN(foo)
```



# Special operators (V)
- The operators `|` and `&` are similar, but they combine two logical vectors. The comparison is performed element by element, so the result is also a logical vector.

# Regular Expressions
- R also supports a full suite of regular expressions
- This could be material for a full tutorial and another time


# Data Modes in R
- R allows users to implement a number of different types of data
- The three basic data types are numeric data, character data, and logical data
-**numeric** includes valid numbers

```r
is.numeric(A)
```

```
## [1] TRUE
```

```r
class(A)
```

```
## [1] "numeric"
```

```r
print(A)
```

```
## [1] 4.0 9.0 8.7
```

-**character** is known as strings in other software, any characters that have no numeric meaning

```r
b <- c("one", "two", "three")
print(b)
```

```
## [1] "one"   "two"   "three"
```

```r
is.numeric(b)
```

```
## [1] FALSE
```

-**logical** is TRUE or FALSE values, useful for logical testing and programming

```r
c <- c(TRUE, TRUE, TRUE, FALSE, FALSE, TRUE)
is.numeric(c)
```

```
## [1] FALSE
```

```r
is.character(c)
```

```
## [1] FALSE
```

```r
is.logical(c)  # Results in a logical value
```

```
## [1] TRUE
```


# Easier way
- Just ask R using the `class` function


```r
class(A)
```

```
## [1] "numeric"
```

```r
class(b)
```

```
## [1] "character"
```

```r
class(c)
```

```
## [1] "logical"
```


# Factor
- A factor is a very special and sometimes frustrating data type in R


```r
myfac <- factor(c("basic", "proficient", "advanced", "minimal"))
class(myfac)
```

```
## [1] "factor"
```

```r
myfac  # What order are the factors in?
```

```
## [1] basic      proficient advanced   minimal   
## Levels: advanced basic minimal proficient
```

```r
myfac <- ordered(myfac, levels = c("minimal", "basic", "proficient", "advanced"))
myfac
```

```
## [1] basic      proficient advanced   minimal   
## Levels: minimal < basic < proficient < advanced
```

```r
summary(myfac)
```

```
##    minimal      basic proficient   advanced 
##          1          1          1          1 
```


# Ordering and More
- Factors can be ordered. This is useful when doing ordered logistic regression, or organizing output. 
- Turning factors into other data types can be tricky. All factor levels have an underlying numeric structure.


```r
class(myfac)
```

```
## [1] "ordered" "factor" 
```

```r
unclass(myfac)
```

```
## [1] 2 3 4 1
## attr(,"levels")
## [1] "minimal"    "basic"      "proficient" "advanced"  
```

```r
defac <- unclass(myfac)
defac
```

```
## [1] 2 3 4 1
## attr(,"levels")
## [1] "minimal"    "basic"      "proficient" "advanced"  
```


- Be careful! The best way to unpack a factor is to convert it to a character first.

# Defactor

```r
destring <- function(x) {
    x <- as.character(x)
    x
}
destring(myfac)
```

```
## [1] "basic"      "proficient" "advanced"   "minimal"   
```


# Dates
- R has built-in ways to handle dates
- See `lubridate` package for more advanced functionality


```r
mydate <- as.Date("7/20/2012", format = "%m/%d/%Y")
# Input is a character string and a parser
class(mydate)  # this is date
```

```
## [1] "Date"
```

```r
weekdays(mydate)  # what day of the week is it?
```

```
## [1] "Friday"
```

```r
mydate + 30  # Operate on dates
```

```
## [1] "2012-08-19"
```

```r
# We can parse other formats of dates
mydate2 <- as.Date("8-5-1988", format = "%d-%m-%Y")
mydate2
```

```
## [1] "1988-05-08"
```

```r
mydate - mydate2
```

```
## Time difference of 8839 days
```


# A few notes on dates
- R converts all dates to numeric values, like Excel and other languages
- The origin date in R is January 1, 1970


```r
as.numeric(mydate)  # days since 1-1-1970
```

```
## [1] 15541
```

```r
as.Date(56, origin = "2013-4-29")  # we can set our own origin
```

```
## [1] "2013-06-24"
```


# Other Classes
- R classes can be specified for any special purpose

# Why care so much about classes?
- Classes determine what you can and can't do with objects
- Classes have different computational times associated with them, for optimization
- Classes allow you to keep projects/data organized and following business rules
- **Because R makes you care**

# Data Structures in R
- R has a number of basic data classes as well as arbitrary specialized object types for various purposes
- **vectors** are the basic data class in R and can be thought of as a single column of data (even a column of length 1)
- **matrices and arrays** are rows and columns of all the same mode data
- **dataframes** are rows and columns where the columns can represent different data types
- **lists** are arbitrary combinations of disparate object types in R

# Vectors 
- Everything is a vector in R, even single numbers
- Single objects are "atomic" vectors


```r
print(1)
```

```
## [1] 1
```

```r
# The 1 in braces means this element is a vector of length 1
print("This tutorial is awesome")
```

```
## [1] "This tutorial is awesome"
```

```r
# This is a vector of length 1 consisting of a single 'string of
# characters'
print(LETTERS)
```

```
##  [1] "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q"
## [18] "R" "S" "T" "U" "V" "W" "X" "Y" "Z"
```

```r
# This vector has 26 character elements
print(LETTERS[6])
```

```
## [1] "F"
```

```r
# The sixth element of this vector has length 1
length(LETTERS[6])
```

```
## [1] 1
```

```r
# The length of that element is a number with length 1
```


# Matrices
- Matrices are combinations of vectors of the same length and data type
- We can have numeric matrices, character matrices, or logical matrices
- Can't mix types


```r
mymat <- matrix(1:36, nrow = 6, ncol = 6)
rownames(mymat) <- LETTERS[1:6]
colnames(mymat) <- LETTERS[7:12]
class(mymat)
```

```
## [1] "matrix"
```

```r
rownames(mymat)
```

```
## [1] "A" "B" "C" "D" "E" "F"
```

```r
colnames(mymat)
```

```
## [1] "G" "H" "I" "J" "K" "L"
```

```r
mymat
```

```
##   G  H  I  J  K  L
## A 1  7 13 19 25 31
## B 2  8 14 20 26 32
## C 3  9 15 21 27 33
## D 4 10 16 22 28 34
## E 5 11 17 23 29 35
## F 6 12 18 24 30 36
```



# More Matrices
- We can add to matrices


```r
dim(mymat)  # We have 6 rows and 6 columns
```

```
## [1] 6 6
```

```r
myvec <- c(5, 3, 5, 6, 1, 2)
length(myvec)  # What happens when you do dim(myvec)?
```

```
## [1] 6
```

```r
newmat <- cbind(mymat, myvec)
newmat
```

```
##   G  H  I  J  K  L myvec
## A 1  7 13 19 25 31     5
## B 2  8 14 20 26 32     3
## C 3  9 15 21 27 33     5
## D 4 10 16 22 28 34     6
## E 5 11 17 23 29 35     1
## F 6 12 18 24 30 36     2
```

- Dataframes works similar

# Unsure


```r
foo.mat <- matrix(c(rnorm(100), runif(100), runif(100), rpois(100, 2)), ncol = 4)
head(foo.mat)
```

```
##          [,1]   [,2]    [,3] [,4]
## [1,] -0.96662 0.6482 0.70849    3
## [2,] -0.03917 0.1237 0.07748    3
## [3,]  1.00540 0.7265 0.63849    1
## [4,]  0.37477 0.3728 0.33395    1
## [5,] -0.11520 0.5562 0.71539    3
## [6,]  1.18498 0.9190 0.98694    3
```

```r
cor(foo.mat)
```

```
##          [,1]    [,2]    [,3]     [,4]
## [1,]  1.00000 0.03762 0.01870 -0.01632
## [2,]  0.03762 1.00000 0.03326  0.03788
## [3,]  0.01870 0.03326 1.00000  0.15642
## [4,] -0.01632 0.03788 0.15642  1.00000
```


# Arrays
- Arrays are a set of matrices of the same `dim` and `class`
- Arrays allow dimensions to be named


```r
myarray <- array(1:42, dim = c(7, 3, 2), dimnames = list(c("tiny", "small", 
    "medium", "medium-ish", "large", "big", "huge"), c("slow", "moderate", "fast"), 
    c("boring", "fun")))
class(myarray)
```

```
## [1] "array"
```

```r
dim(myarray)
```

```
## [1] 7 3 2
```

```r
dimnames(myarray)
```

```
## [[1]]
## [1] "tiny"       "small"      "medium"     "medium-ish" "large"     
## [6] "big"        "huge"      
## 
## [[2]]
## [1] "slow"     "moderate" "fast"    
## 
## [[3]]
## [1] "boring" "fun"   
## 
```

```r
myarray
```

```
## , , boring
## 
##            slow moderate fast
## tiny          1        8   15
## small         2        9   16
## medium        3       10   17
## medium-ish    4       11   18
## large         5       12   19
## big           6       13   20
## huge          7       14   21
## 
## , , fun
## 
##            slow moderate fast
## tiny         22       29   36
## small        23       30   37
## medium       24       31   38
## medium-ish   25       32   39
## large        26       33   40
## big          27       34   41
## huge         28       35   42
## 
```



# Lists
- Lists are arbitrary collections of objects. 
- The objects do not have to be of the same type or same element or same dimensions


```r
mylist <- list(vec = myvec, mat = mymat, arr = myarray, date = mydate)
class(mylist)
```

```
## [1] "list"
```

```r
length(mylist)
```

```
## [1] 4
```

```r
names(mylist)
```

```
## [1] "vec"  "mat"  "arr"  "date"
```

```r
str(mylist)
```

```
## List of 4
##  $ vec : num [1:6] 5 3 5 6 1 2
##  $ mat : int [1:6, 1:6] 1 2 3 4 5 6 7 8 9 10 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : chr [1:6] "A" "B" "C" "D" ...
##   .. ..$ : chr [1:6] "G" "H" "I" "J" ...
##  $ arr : int [1:7, 1:3, 1:2] 1 2 3 4 5 6 7 8 9 10 ...
##   ..- attr(*, "dimnames")=List of 3
##   .. ..$ : chr [1:7] "tiny" "small" "medium" "medium-ish" ...
##   .. ..$ : chr [1:3] "slow" "moderate" "fast"
##   .. ..$ : chr [1:2] "boring" "fun"
##  $ date: Date[1:1], format: "2012-07-20"
```


# Lists (II)
- R has two object classification schemes S3 and S4
  - For S3 use `$` or `[[]]` to extract elements
  - For S4 use `@` to extract elements


```r
mylist$vec
```

```
## [1] 5 3 5 6 1 2
```

```r
mylist[[2]][1, 3]
```

```
## [1] 13
```


# So what?
- Matrices, lists, and arrays are useful for storing analyses results, generating reports, and doing analysis on many objects types
- We'll see examples of list and array manipulation later
- A useful tip is to use the `attributes` function to learn about the object


```r
attributes(mylist)
```

```
## $names
## [1] "vec"  "mat"  "arr"  "date"
## 
```

```r
attributes(myarray)
```

```
## $dim
## [1] 7 3 2
## 
## $dimnames
## $dimnames[[1]]
## [1] "tiny"       "small"      "medium"     "medium-ish" "large"     
## [6] "big"        "huge"      
## 
## $dimnames[[2]]
## [1] "slow"     "moderate" "fast"    
## 
## $dimnames[[3]]
## [1] "boring" "fun"   
## 
## 
```


- They also provide simplified ways to get used to operating on dataframes by reducing complexity


# Dataframes
- Dataframes are combinations of vectors of the same length, but can be of different types

```r
str(df[, 25:32])
```

```
## 'data.frame':	2700 obs. of  8 variables:
##  $ district  : int  3 3 3 3 3 3 3 3 3 3 ...
##  $ schoolhigh: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ schoolavg : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ schoollow : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ readSS    : num  357 264 370 347 373 ...
##  $ mathSS    : num  387 303 365 344 441 ...
##  $ proflvl   : Factor w/ 4 levels "advanced","basic",..: 2 3 2 2 2 4 4 4 3 2 ...
##  $ race      : Factor w/ 5 levels "A","B","H","I",..: 2 2 2 2 2 2 2 2 2 2 ...
```

- Data frames must have consistent dimensions
- Dataframes are what we use most commonly as a "dataset" for analysis
- Dataframes are what sets R apart from other programming languages like C, C++, Python, and Perl. 
- The dataframe structure is much more complex and much easier to use than any datastructure in these languages--though Python is catching up!

# Summing it Up
- Vectors are used to store bits of data
- Matrices are combinations of vectors of the same length and type
- Matrices are most commonly used in statistical models (in the background), and for computation
- Arrays are stacks of matrices and are used in building multiple models or for storing complex data structures
- Lists are groups of R objects commonly used to combine function output in useful ways (like store model results and model data together)


# Exercises
1. Create a matrix of 5x6 dimensions. Add a vector to it (as either a row or column). Identify element 2,3. 

2. Read in the sample datafile. Find the `readSS` (reading scale score) for student 205 in grade 4. 

3. 

# Other References
- [An R Vocabulary for Starting Out](https://github.com/hadley/devtools/wiki/vocabulary)
- [UCLA Academic Technology Services: R Starter Kit](http://www.ats.ucla.edu/stat/r/sk/)
- [Quick R: Getting Started](http://www.statmethods.net/)
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
## [1] mgcv_1.7-18   ggplot2_0.9.1 knitr_0.7    
## 
## loaded via a namespace (and not attached):
##  [1] colorspace_1.1-1   dichromat_1.2-4    digest_0.5.2      
##  [4] evaluate_0.4.2     formatR_0.6        grid_2.15.1       
##  [7] labeling_0.1       lattice_0.20-6     MASS_7.3-19       
## [10] Matrix_1.0-6       memoise_0.1        munsell_0.3       
## [13] nlme_3.1-104       plyr_1.7.1         proto_0.3-9.2     
## [16] RColorBrewer_1.0-5 reshape2_1.2.1     scales_0.2.1      
## [19] stringr_0.6        tools_2.15.1      
```

