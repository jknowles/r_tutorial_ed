% Tutorial 6: Visualizations
% R Bootcamp HTML Slides
% Jared Knowles




# Overview
In this lesson we hope to learn:
- How to draw diagnostic plots in base graphics
- Colors
- `ggplot2' 
- Basic geoms
- Layering and faceting plots
- Putting it together




# Graphics Matter
- Graphics are a huge part of R and R encourages its users to use visualization to aid and present analysis
- Graphics are hard to get right, but tools can help make it easier
- Lots of great resources to help available for this online

# Base graphics
- R has base graphics which are useful for quickly doing some plots


```r
hist(df$readSS)
```

<img src="figure/slides6-basehist.svg" width="600px" height="350px"  alt="plot of chunk basehist" title="plot of chunk basehist" /> 


# Base graphics are simple
- You can use them to understand your data and do quick diagnostics
- The commands are pretty easy to remember
- You can do complex things with them if you like, but the syntax can be confusing

# Base graphics has some limitations
- What if we try to do a scatterplot of lots of data?

```r
plot(df$readSS, df$mathSS)
```

<img src="figure/slides6-basescatter.svg" width="600px" height="350px"  alt="plot of chunk basescatter" title="plot of chunk basescatter" /> 


# Basic Plot
- Don't use R base graphics
- `ggplot2` is pretty much the new standard in R
- Create beautiful, clear plots with a nice consistent set of language conventions


```r
library(ggplot2)
qplot(readSS, mathSS, data = df)
```

<img src="figure/slides6-plot1.svg" width="600px" height="350px"  alt="plot of chunk plot1" title="plot of chunk plot1" /> 

- Consider this basic scatterplot

# Variations

```r
qplot(readSS, mathSS, data = df) + geom_smooth()
```

<img src="figure/slides6-plot21.svg" width="400px" height="300px"  alt="plot of chunk plot2" title="plot of chunk plot2" /> 

```r
qplot(readSS, mathSS, data = df, alpha = I(0.3))
```

<img src="figure/slides6-plot22.svg" width="400px" height="300px"  alt="plot of chunk plot2" title="plot of chunk plot2" /> 

```r
qplot(readSS, mathSS, data = df) + xlab("Reading Score") + ylab("Math Score")
```

<img src="figure/slides6-plot23.svg" width="400px" height="300px"  alt="plot of chunk plot2" title="plot of chunk plot2" /> 

```r
qplot(readSS, mathSS, data = df, color = race) + scale_color_brewer(type = "qual", 
    palette = 2)
```

<img src="figure/slides6-plot24.svg" width="400px" height="300px"  alt="plot of chunk plot2" title="plot of chunk plot2" /> 


# Visualization Philosophy
- Visualization is about thinking about what objects in our dataset map with what visual cues for the viewer
  - liberal use of `names(object)` helps
- What is the best way to show discrete variables, continuous variables, and connected variables
- We also need to be unafraid about trying transformations of variables, recoding variables, and reshaping variables to tell the story we are looking for

# Our data for this exercise
- As we now know, student data is quite fascinating
- We have many discrete attribute variables
  - Race, gender, economics, etc.
- We have some continuous variables
  - Test scores, attendance
- We have some grouping variables
  - Schools, districts, students, teachers
- Rich ground to make a number of visualizations that are useful


# A few pro tips
- Don't be afraid to manipulate the data
  - Aggregate, combine, rescale variables to make the story easier to understand
- Don't use too much color
  - People print your work, color blindness is more prevalent than you think
  - Color is fickle. Monitors and projectors reproduce it differently.
- Don't overwhelm the user
  - Make your visual depictions as easy as possible to immediately understand that data
- Don't plot everything all at once


# Draw a Colorwheel to show this problem

```r
colwheel <- "https://dl.dropbox.com/u/1811289/colorwheel.R"
dropbox_source(colwheel)
col.wheel("magenta", nearby = 2)
```

<img src="figure/slides6-colorwheel1.svg" width="600px" height="350px"  alt="plot of chunk colorwheel" title="plot of chunk colorwheel" /> 

```
##  [1] "plum"        "violet"      "darkmagenta" "magenta4"    "magenta3"   
##  [6] "magenta2"    "magenta"     "magenta1"    "orchid4"     "orchid"     
```

```r
col.wheel("orange", nearby = 2)
```

<img src="figure/slides6-colorwheel2.svg" width="600px" height="350px"  alt="plot of chunk colorwheel" title="plot of chunk colorwheel" /> 

```
##  [1] "salmon1"       "darksalmon"    "orangered4"    "orangered3"   
##  [5] "coral"         "orangered2"    "orangered"     "orangered1"   
##  [9] "lightsalmon2"  "lightsalmon"   "peru"          "tan3"         
## [13] "darkorange2"   "darkorange4"   "darkorange3"   "darkorange1"  
## [17] "linen"         "bisque3"       "bisque1"       "bisque2"      
## [21] "darkorange"    "antiquewhite3" "antiquewhite1" "papayawhip"   
## [25] "moccasin"      "orange2"       "orange"        "orange1"      
## [29] "orange4"       "wheat4"        "orange3"       "wheat"        
## [33] "oldlace"      
```

```r
col.wheel("brown", nearby = 2)
```

<img src="figure/slides6-colorwheel3.svg" width="600px" height="350px"  alt="plot of chunk colorwheel" title="plot of chunk colorwheel" /> 

```
##  [1] "snow1"       "snow2"       "rosybrown"   "rosybrown1"  "rosybrown2" 
##  [6] "rosybrown3"  "rosybrown4"  "lightcoral"  "indianred"   "indianred1" 
## [11] "indianred3"  "brown"       "brown4"      "brown1"      "brown3"     
## [16] "brown2"      "firebrick"   "firebrick1"  "chocolate"   "chocolate4" 
## [21] "saddlebrown" "seashell3"   "seashell2"   "seashell4"   "sandybrown" 
## [26] "peachpuff2"  "peachpuff3" 
```


# Start with a great example
<img src="figure/slides6-premier.svg" width="800px" height="650px"  alt="plot of chunk premier" title="plot of chunk premier" /> 



# Scary R Code

```r
library(grid)
p1 <- qplot(readSS, ..density.., data = df, fill = race, position = "fill", 
    geom = "density") + scale_fill_brewer(type = "qual", palette = 2)

p2 <- qplot(readSS, ..fill.., data = df, fill = race, position = "fill", geom = "density") + 
    scale_fill_brewer(type = "qual", palette = 2) + ylim(c(0, 1)) + theme_bw() + 
    opts(legend.position = "none", axis.text.x = theme_blank(), axis.text.y = theme_blank(), 
        axis.ticks = theme_blank(), panel.margin = unit(0, "lines")) + ylab("") + 
    xlab("")

vp <- viewport(x = unit(0.65, "npc"), y = unit(0.73, "npc"), width = unit(0.2, 
    "npc"), height = unit(0.2, "npc"))
print(p1)
print(p2, vp = vp)
```


# Now, how?
- `ggplot2` can be understood as combining a few concepts
  - aesthetics, geoms, layers, and scales
- Making high quality graphics is just a matter of applying the right data to the right aesthetics in an appropriate geom, adding layer for detail, and ensuring the scale is appropriate
- Let's talk about how to do that next

# Aesthetics
- aesthetics are the axes, colors, glyphs, and sizes of the data mapped to visual cues
- `ggplot2` has an extended syntax that makes this obvious

```r
ggplot(df, aes(x = readSS, y = mathSS)) + geom_point()
```

<img src="figure/slides6-extended.svg" width="600px" height="350px"  alt="plot of chunk extended" title="plot of chunk extended" /> 

- We've seen this guy before
- This makes `ggplot2` like a sublanguage under R
- `aes` says we are specifying aesthetics, here we specified x and y to make a two dimensional graphic

# Layers
- Exactly what they sound like, each plot is a simple series of layers
- Show examples

# Geoms
- Geoms are the way data is represented, you can think of it like a chart type in another programming language
- 

# Scales
- Scales are the way the numeric/categorical data is mapped to a visual representation
- They transform the geoms and aesthetics
- Scales preserve the mapping, but allow us to explore reshaping the data

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
