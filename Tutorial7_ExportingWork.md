% Tutorial 7: Exporting Your Work
% R Bootcamp HTML Slides
% Jared Knowles




# Overview

In this lesson we hope to learn:

- Quick and basic export of results
- Writing a basic report
- Exporting graphics for use in other documents
- Reproducible research

# Why does Export Matter?

- Need to be able to share work with others and present it
- This can be tricky in R because R has so many choices for export
- R can talk to a number of outside formats including Excel, Word, PDF, PNG, HTML
- R can even be used as a web service: [https://public.opencpu.org/pages/](https://public.opencpu.org/pages/)
- We'll cover the basics, but there are a lot of outside resources for doing what you need in your own environment

# Generating a basic report

- There are a few key concepts that R allows that we should follow when preparing a report on data

  1. Include the data, source code, and output together in one package
  2. Have the source code available for raw data to finished product
  3. Present figures, tables, and code in a single document

- Why do we do this?

  * Transparency
  * Reproducibility
  * It isn't much harder than the basic analysis itself

# A few terms
- **Rmarkdown** extension **.Rmd** and used for R flavored markdown in RStudio
- **R script** extension **.R** used to store R code only
- **R HTML** extension **.RHtml** used to store R HTML
- **Text** extension **.txt** used to write plain text
- ** R Sweave** extension **.Rnw** used to write LaTeX reports with embedded R code

# Beginning

- Open a new script file in RStudio--"R Markdown"
- This opens a template file for an HTML report, the easiest type to create
- In R there are a number of packages designed to help create reports and place them on a scale like so:

![plot of chunk tradeoff](figure/slides3-tradeoff.svg) 


# Get the tools
- `install.packages('knitr','markdown')`; `sweave` is part of R base already
- We need a LaTeX distribution for Tex documents
- What is LaTeX?
- An open source typsetting framework that can be used to produce complex technical documents
- We won't mess with LaTeX today - instead we will focus on HTML and markdown

# A Simple Example
- Paste this in a new R script
- Save the script in your working directory as `myscript.R`


```r
#' This is some text
#'

# + myplot, dev='svg',out.width='500px',out.height='400px'

library(ggplot2)
data(diamonds)
qplot(carat, price, data = diamonds, alpha = I(0.3), color = clarity)

#' Diamond size is clearly related to price, but not in a linear fashion.
#'
```



# Converting the Script
- This happens in two steps to make an HTML file


```r
o <- spin("C:/Path/To/myscript.R", knit = FALSE)
knit2html(o, envir = new.env())
```



# Example Script II

```r
#' This is some text that I want to explain
#' For example, this plot is important, let's look below

# + myplot,
# dev='svg',out.width='500px',out.height='400px',warning=FALSE,message=FALSE

library(ggplot2)
load("PATH/TO/MY/DATA.rda")
qplot(readSS, mathSS, data = df, alpha = I(0.2)) + geom_smooth()

#' There is not a linear relationship, but it sure is close.
#' Let's do some regression
#'

test <- lm(mathSS ~ readSS + factor(grade), data = df)
summary(test)

#' It's all statistically significant
```


# Spin 2

# Stitch

```r
## title: My Super Report ## Author: Mr. Data ##

# A plot and some text
library(ggplot2)
load("PATH/TO/MY/DATA")
qplot(readSS, mathSS, data = df, alpha = I(0.2)) + geom_smooth()

# Now a linear model
test <- lm(mathSS ~ readSS + factor(grade), data = df)
summary(test)

# Ok!
```


# Stitch Spin
- A number of different outputs


```r
# Markdown
stitch("PATH/TO/MY/SCRIPT", system.file("misc", "knitr-template.Rmd", package = "knitr"))
knit2html("Path/To/My/Markdown.md")

# Direct 2 Html
stitch("PATH/TO/MY/SCRIPT", system.file("misc", "knitr-template.html", package = "knitr"))

# Direct to PDF Requires LaTeX
stitch("PATH/TO/MY/SCRIPT")
```



# Exercises 
1.
2.


# References


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
## [1] grid      stats     graphics  grDevices utils     datasets  methods  
## [8] base     
## 
## other attached packages:
## [1] ggplot2_0.9.1 gridExtra_0.9 knitr_0.7    
## 
## loaded via a namespace (and not attached):
##  [1] colorspace_1.1-1   dichromat_1.2-4    digest_0.5.2      
##  [4] evaluate_0.4.2     formatR_0.6        labeling_0.1      
##  [7] MASS_7.3-19        memoise_0.1        munsell_0.3       
## [10] plyr_1.7.1         proto_0.3-9.2      RColorBrewer_1.0-5
## [13] reshape2_1.2.1     scales_0.2.1       stringr_0.6.1     
## [16] tools_2.15.1      
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
