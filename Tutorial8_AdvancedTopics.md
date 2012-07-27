% Tutorial 8: Advanced Topics
% R Bootcamp HTML Slides
% Jared Knowles

# Overview
In this lesson we hope to learn:
- Coding Style
- Git, GitHub, and add-on packages
- Write a `for' loop
- Write a basic function
- Optimize R with parallelization
- Mixed effect models
- Data mining with R

# Basic Principles
- Good professional data analysis is computer programming
- An analysis project is computer code
- Computer code has bugs and to fight bugs the code has to be readable
- 

# Coding Style
- An important part of making work reproducible is making your code readable and understandable
- Much of this involves looking into where to break lines and how to simplify expressions without making them obscure
- You can also take some cues about how to make your code consistent and clean

# For Looping
- Don't do it

# Write a simple function
- Functions are easy
- To view any function in R just type `print(myfunction)`
- For speed, some functions are not viewable


```r
print(mean)  #bytecode, we can't see it
```

```
## function (x, ...) 
## UseMethod("mean")
## <bytecode: 0x0755d1c4>
## <environment: namespace:base>
```

```r
print(order)
```

```
## function (..., na.last = TRUE, decreasing = FALSE) 
## {
##     z <- list(...)
##     if (any(unlist(lapply(z, is.object)))) {
##         z <- lapply(z, function(x) if (is.object(x)) 
##             xtfrm(x)
##         else x)
##         if (!is.na(na.last)) 
##             return(do.call("order", c(z, na.last = na.last, decreasing = decreasing)))
##     }
##     else if (!is.na(na.last)) 
##         return(.Internal(order(na.last, decreasing, ...)))
##     if (any(diff(l.z <- vapply(z, length, 1L)) != 0L)) 
##         stop("argument lengths differ")
##     ans <- vapply(z, is.na, rep.int(NA, l.z[1L]))
##     ok <- if (is.matrix(ans)) 
##         !apply(ans, 1, any)
##     else !any(ans)
##     if (all(!ok)) 
##         return(integer())
##     z[[1L]][!ok] <- NA
##     ans <- do.call("order", c(z, decreasing = decreasing))
##     keep <- seq_along(ok)[ok]
##     ans[ans %in% keep]
## }
## <bytecode: 0x047b9dfc>
## <environment: namespace:base>
```



# Git and GitHub
- Working alone or in a group, `git` and GitHub can help
- [Learn Git and GitHub](http://try.github.com/)

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
