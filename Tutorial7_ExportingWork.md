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

# Beginning
- Open a new script file in RStudio--"R Markdown"
- This opens a template file for an HTML report, the easiest type to create
- In R there are a number of packages designed to help create reports and place them on a scale like so:

![plot of chunk tradeoff](figure/slides3-tradeoff.svg) 


# Get the tools
- `install.packages('knitr')`; `sweave` is part of R base already
- We need a LaTeX distribution for Tex documents
- What is LaTeX?

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
## Platform: i386-pc-mingw32/i386 (32-bit)
## 
## attached base packages:
## [1] grid      stats     graphics  grDevices utils     datasets  methods  
## [8] base     
## 
## other attached packages:
##  [1] stringr_0.6.1  quantreg_4.81  SparseM_0.96   lmtest_0.9-30 
##  [5] zoo_1.7-7      gridExtra_0.9  ggplot2_0.9.1  hexbin_1.26.0 
##  [9] lattice_0.20-6 mgcv_1.7-19    Cairo_1.5-1    knitr_0.7     
## [13] plyr_1.7.1    
## 
## loaded via a namespace (and not attached):
##  [1] colorspace_1.1-1   dichromat_1.2-4    digest_0.5.2      
##  [4] evaluate_0.4.2     formatR_0.6        labeling_0.1      
##  [7] MASS_7.3-19        Matrix_1.0-6       memoise_0.1       
## [10] munsell_0.3        nlme_3.1-104       proto_0.3-9.2     
## [13] RColorBrewer_1.0-5 reshape2_1.2.1     scales_0.2.1      
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
