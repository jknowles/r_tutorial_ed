% Setting Up R
% Jared Knowles

# Materials
- [Download R](http://cran.r-project.org/)
- [RStudio](http://www.rstudio.org/) 
- We'll also want to install a few basic packages. This can be done on the fly later, but a few include `ggplot2`;`knitr`;`plyr`

# Step 1: Install R
- Simply run the installer. If you have a 64-bit machine, choose 64 bit R, if you don't know, just choose the default
- The install should be less than 100mb
- There is a short video on the next slide for help installing on Windows machines


# Installing R on Windows
<p align='center'><iframe src="http://www.screenr.com/embed/kzT8" width="650" height="396" frameborder="0"></iframe></p>


# Step 2: RStudio
- Now run the RStudio installer
- RStudio will automatically find your R installation

# Step 3: Install packages
First, watch this tutorial<br>

<iframe src="http://www.screenr.com/embed/Fps8" width="650" height="396" frameborder="0"></iframe>

# Install Packages
- Are you running RStudio in administrator mode on Windows Vista or Windows 7?
- If not, you need to be. Right click on RStudio and then click "Run as Administrator"
- If you are on a Mac or Windows XP you can disregard this

# Install Packages (2)
- Now, copy and paste the code below into the bottom left window in RStudio (the R terminal):

```r
install_new <- function(mypkg) {
    if (mypkg %in% installed.packages()) 
        cat("Package already installed") else {
        cat("Package not found, so installing with dependencies... Press CTRL C to abort.")
        Sys.sleep(5)
        install.packages(mypkg, repos = "http://cran.wustl.edu/")
    }
}

install_new("plyr")
install_new("lmtest")
install_new("ggplot2")
install_new("gridExtra")
install_new("stringr")
install_new("knitr")
install_new("quantreg")
install_new("zoo")
install_new("devtools")
```


# Alternate Install
- If you want or if you have troubles with the above, you can overwrite any existing versions of those packages and do the install in one line, shown below:


```r
install.packages(c("plyr", "lmtest", "ggplot2", "gridExtra", "stringr", "knitr", 
    "quantreg", "zoo", "devtools"), repos = "http://cran.wustl.edu/")
```

```

# Run RStudio
- You should be able to run RStudio now and load any of the packages above.
- Run the code below in the RStudio terminal window (bottom left) to test this:

```r
library(lmtest)
example(gqtest)
```


# And you should see...

```
## Loading required package: zoo
```

```
## Attaching package: 'zoo'
```

```
## The following object(s) are masked from 'package:base':
## 
## as.Date, as.Date.numeric
```

```
## 
## gqtest> ## generate a regressor
## gqtest> x <- rep(c(-1,1), 50)
## 
## gqtest> ## generate heteroskedastic and homoskedastic disturbances
## gqtest> err1 <- c(rnorm(50, sd=1), rnorm(50, sd=2))
## 
## gqtest> err2 <- rnorm(100)
## 
## gqtest> ## generate a linear relationship
## gqtest> y1 <- 1 + x + err1
## 
## gqtest> y2 <- 1 + x + err2
## 
## gqtest> ## perform Goldfeld-Quandt test
## gqtest> gqtest(y1 ~ x)
## 
## 	Goldfeld-Quandt test
## 
## data:  y1 ~ x 
## GQ = 3.078, df1 = 48, df2 = 48, p-value = 7.871e-05
## 
## 
## gqtest> gqtest(y2 ~ x)
## 
## 	Goldfeld-Quandt test
## 
## data:  y2 ~ x 
## GQ = 0.8951, df1 = 48, df2 = 48, p-value = 0.6486
## 
```


# And test the graphics...
Type in in the terminal (or copy and paste)

```r
library(ggplot2)
y <- rt(200, df = 5)
qplot(sample = y, stat = "qq")
```


# Results

```r
library(ggplot2)
y <- rt(200, df = 5)
qplot(sample = y, stat = "qq")
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 


# That's all
- Did you see the output like the slides above?
- Did you see the plot in the lower right? 

# You are ready to go!
See you on August 2nd and 3rd to find out how to go from these basic steps to using R to learn from your data. Can't wait to see you in Madison!
