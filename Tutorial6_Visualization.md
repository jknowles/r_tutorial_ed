% Tutorial 6: Visualizations
% R Bootcamp HTML Slides
% Jared Knowles




# Overview
In this lesson we hope to learn:

- What is data visualization and why does it matter?
- How to draw diagnostic plots in base graphics
- Colors
- `ggplot2' 
- Basic geoms
- Layering and faceting plots
- Putting it together




# Graphics Matter
- Graphics are a huge part of R and R encourages its users to use visualization to aid and present analysis
- Graphics are hard to get right, but tools can help make it easier
- Lots of great resources to help available for this online and linked to at the end of this document

# Visualization Philosophy
- Visualization is about thinking about what objects in our dataset map with what visual cues for the viewer
  - liberal use of `names(object)` helps
- What is the best way to show discrete variables, continuous variables, and connected variables
- We also need to be unafraid about trying transformations of variables, recoding variables, and reshaping variables to tell the story we are looking for
- What is a plot?

# Our data for this exercise
- As we now know, student data is quite fascinating
- We have many discrete attribute variables
  - Race, gender, economics, etc.
- We have some continuous variables
  - Test scores, attendance
- We have some grouping variables
  - Schools, districts, students, teachers
- Rich ground to make a number of visualizations that are useful


# Base graphics
- R has base graphics which are useful for quickly doing some plots


```r
hist(df$readSS)
```

<img src="figure/slides6-basehist.png" width="600px" height="350px"  alt="plot of chunk basehist" title="plot of chunk basehist" /> 


# Base graphics are simple
- You can use them to understand your data and do quick diagnostics
- The commands are pretty easy to remember
- You can do complex things with them if you like, but the syntax can be confusing

# Base graphics has some limitations
- What if we try to do a scatterplot of lots of data?


```r
plot(df$readSS, df$mathSS)
```

<img src="figure/slides6-basescatter.png" width="300px" height="200px"  alt="plot of chunk basescatter" title="plot of chunk basescatter" /> 


- To add a line, we have to use another line of code 


```r
plot(df$readSS, df$mathSS)
lines(lowess(df$readSS ~ df$mathSS), col = "red")
```

<img src="figure/slides6-scatterbaseline.png" width="300px" height="200px"  alt="plot of chunk scatterbaseline" title="plot of chunk scatterbaseline" /> 



# Basic Plot
- Don't use R base graphics
- `ggplot2` is pretty much the new standard in R
- Create beautiful, clear plots with a nice consistent set of language conventions


```r
library(ggplot2)
qplot(readSS, mathSS, data = df)
```

<img src="figure/slides6-plot1.png" width="600px" height="325px"  alt="plot of chunk plot1" title="plot of chunk plot1" /> 



# Now, how?
- Apply best visualization principles, particularly the "Grammar of Graphics"
- `ggplot2` an R package does just this by breaking plots into a few basic components
  - aesthetics, geoms, layers, and scales
- Making high quality graphics is just a matter of applying the right data to the right aesthetics in an appropriate geom, adding layer for detail, and ensuring the scale is appropriate
- Let's talk about how to do that next

# What are the basic plot types?
<img src="figure/slides6-ggplot2plottypes.png" width="850px" height="520px"  alt="plot of chunk ggplot2plottypes" title="plot of chunk ggplot2plottypes" /> 



# What are some advanced plot types?
<img src="figure/slides6-ggplot2plottypesadv.png" width="850px" height="520px"  alt="plot of chunk ggplot2plottypesadv" title="plot of chunk ggplot2plottypesadv" /> 


# 
Your Turn: What are some examples of interesting visualizations we could use?
-------------------------------------------------------------------


# Understanding Grammar of Graphics through A Scatterplot

```r
qplot(readSS, mathSS, data = df, alpha = I(0.3)) + theme_dpi()
```

<img src="figure/slides6-smallscatter.png" width="300px" height="240px"  alt="plot of chunk smallscatter" title="plot of chunk smallscatter" /> 


- What is a scatterplot?
- A 2d representation of data as coordinates, in this case the `readSS` is the x coordinate and `mathSS` is the y coordinate for each observation in our data
- Each observation is a point (*geom*)
- Both axes scale in a linear fashion (*scales*)

# Grammar of Graphics
- In one way of thinking about this, each data visualization has four components
- **Geometries** that represent data (*points, bars, lines*)
- **Statistics** that represent information about the data (*identity, mean, median, deviance*)
- **Scales** that map the geometries and statistics to space (*linear, quadratic, logrithmic*)
- A **coordinate system** and canvas to put all on


# Geoms
- **Geoms** are the way data is represented, you can think of it like a chart type in another programming language
- We have seen a number of examples, and **geoms** can be combined in unique ways to convey more data
- Quiz: Represent `df$mathSS` using **3 separate geoms**

# Geom Quiz

```r
qplot(mathSS, readSS, data = df) + theme_dpi()
```

<img src="figure/slides6-geomquiz1.png" width="350px" height="260px"  alt="plot of chunk geomquiz" title="plot of chunk geomquiz" /> 

```r
qplot(mathSS, data = df) + theme_dpi()
```

<img src="figure/slides6-geomquiz2.png" width="350px" height="260px"  alt="plot of chunk geomquiz" title="plot of chunk geomquiz" /> 

```r
qplot(factor(grade), mathSS, data = df, geom = "line", group = stuid, alpha = I(0.2)) + 
    theme_dpi()
```

<img src="figure/slides6-geomquiz3.png" width="350px" height="260px"  alt="plot of chunk geomquiz" title="plot of chunk geomquiz" /> 


# Aesthetics
- **geoms** allow us to only display a couple of data elements at once, to do more we need to map to other visual representations
- This is what *aesthetics* are
- aesthetics are colors, glyphs (shapes), and sizes of graph objects mapped to visual cues
- `ggplot2` has an extended syntax that makes this obvious


```r
ggplot(df, aes(x = readSS, y = mathSS)) + geom_point()
```

<img src="figure/slides6-extended.png" width="600px" height="240px"  alt="plot of chunk extended" title="plot of chunk extended" /> 

```r
# Identical to: qplot(readSS,mathSS,data=df)
```


- `aes` says we are specifying aesthetics, here we specified x and y to make a two dimensional graphic

# Examples of Aesthetics



```r
data(mpg)
qplot(displ, cty, data = mpg) + theme_dpi()
```

<img src="figure/slides6-plot21.png" width="400px" height="300px"  alt="plot of chunk plot2" title="plot of chunk plot2" /> 

```r
qplot(displ, cty, data = mpg, size = cyl) + theme_dpi()
```

<img src="figure/slides6-plot22.png" width="400px" height="300px"  alt="plot of chunk plot2" title="plot of chunk plot2" /> 

```r
qplot(displ, cty, data = mpg, shape = drv, size = I(3)) + theme_dpi()
```

<img src="figure/slides6-plot23.png" width="400px" height="300px"  alt="plot of chunk plot2" title="plot of chunk plot2" /> 

```r
qplot(displ, cty, data = mpg, color = class) + theme_dpi()
```

<img src="figure/slides6-plot24.png" width="400px" height="300px"  alt="plot of chunk plot2" title="plot of chunk plot2" /> 


# Experiment with Aesthetics
### Draw some plots with different aesthetics using our student level dataset

# Some Considerations with Aesthetics

- **aesthetics** are very sensitive to whether a variable is continuous or discrete or ordered
- **R** isn't always so worried about this!
- Why does it matter? Let's see a few examples

# Aesthetics Considerations (ordered)


```r
qplot(mathSS, readSS, data = df[1:100, ], size = race, alpha = I(0.8)) + theme_dpi()
```

<img src="figure/slides6-racesizemapping.png" width="600px" height="350px"  alt="plot of chunk racesizemapping" title="plot of chunk racesizemapping" /> 

- Does this make sense?

# Another Aesthetics Concern (ordered)


```r
df$proflvl2 <- factor(df$proflvl, levels = c("advanced", "basic", "proficient", 
    "below basic"))
df$proflvl2 <- ordered(df$proflvl2)
qplot(mathSS, readSS, data = df[1:100, ], color = proflvl2, size = I(3)) + scale_color_brewer(type = "seq") + 
    theme_dpi()
```

<img src="figure/slides6-proflvlcolor.png" width="600px" height="350px"  alt="plot of chunk proflvlcolor" title="plot of chunk proflvlcolor" /> 


# Aesthetics Concern 2 (discrete and continuous)
- What aesthetics can we map continuous variables like `mathSS` to, and waht can we map discrete characteristics like `race` to?


```r
qplot(factor(grade), readSS, data = df[1:100, ], color = mathSS, geom = "jitter", 
    size = I(3.2)) + theme_dpi()
```

<img src="figure/slides6-badcontinuousmapping.png" width="600px" height="350px"  alt="plot of chunk badcontinuousmapping" title="plot of chunk badcontinuousmapping" /> 

- What's wrong?

# Aesthetics Concern 2


```r
qplot(factor(grade), readSS, data = df[1:100, ], color = dist, geom = "jitter", 
    size = I(3.2)) + theme_dpi()
```

<img src="figure/slides6-baddiscretemap.png" width="600px" height="350px"  alt="plot of chunk baddiscretemap" title="plot of chunk baddiscretemap" /> 

- What's wrong?

# Thinking about Aesthetics

- One concern is discrete v. continuous variables

Aesthetic | Discrete | Continuous
----------| -------- | ----------
Color     | Disparate colors | Sequential or divergent colors
Size      | Unique size for each value | linear or logrithmic mapping to radius of value
Shape     | A shape for each value | **does not make sense**

# Another is ordered v. unordered


Aesthetic | Ordered | Unordered
----------| -------- | ----------
Color     | Sequential or divergent colors | Rainbow
Size      | Increasing or decreasing radius | **does not make sense**
Shape     | **does not make sense** | A shape for each value



# Scales
- Scales are the way the numeric/categorical data is mapped to a visual representation
- They transform the geoms and aesthetics
- Scales preserve the mapping, but allow us to explore reshaping the data

<img src="figure/slides6-scaleexample.png" width="600px" height="350px"  alt="plot of chunk scaleexample" title="plot of chunk scaleexample" /> 


# Scales Caveats
- Despite not changing the  mapping of data to space, scales can dramatically influence the interpretation of our data
- Rescaling data should be done thoughtfully and with care
- Picking a good scale can be really difficult, and sometimes, a good scale just won't exist without reshaping or subsetting the data!

# Scales also apply to color and fill
- 

# Layers
- Exactly what they sound like, each plot is a simple series of layers
- One way to do layers is to break plots up into small multiples (see Tufte)


```r
qplot(readSS, mathSS, data = df) + facet_wrap(~grade) + theme_dpi(base_size = 12) + 
    geom_smooth(method = "lm", se = FALSE, size = I(1.2))
```

<img src="figure/slides6-smallfacets.png" width="600px" height="350px"  alt="plot of chunk smallfacets" title="plot of chunk smallfacets" /> 


# We can also facet across more attributes


```r
qplot(readSS, mathSS, data = df) + facet_grid(ell ~ grade) + theme_dpi(base_size = 12) + 
    geom_smooth(method = "lm", se = FALSE, size = I(1.2))
```

<img src="figure/slides6-smallfacets2.png" width="600px" height="350px"  alt="plot of chunk smallfacets2" title="plot of chunk smallfacets2" /> 




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

<img src="figure/slides6-colorwheel1.png" width="300px" height="240px"  alt="plot of chunk colorwheel" title="plot of chunk colorwheel" /> 

```
##  [1] "plum"        "violet"      "darkmagenta" "magenta4"    "magenta3"   
##  [6] "magenta2"    "magenta"     "magenta1"    "orchid4"     "orchid"     
```

```r
col.wheel("orange", nearby = 2)
```

<img src="figure/slides6-colorwheel2.png" width="300px" height="240px"  alt="plot of chunk colorwheel" title="plot of chunk colorwheel" /> 

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

<img src="figure/slides6-colorwheel3.png" width="300px" height="240px"  alt="plot of chunk colorwheel" title="plot of chunk colorwheel" /> 

```
##  [1] "snow1"       "snow2"       "rosybrown"   "rosybrown1"  "rosybrown2" 
##  [6] "rosybrown3"  "rosybrown4"  "lightcoral"  "indianred"   "indianred1" 
## [11] "indianred3"  "brown"       "brown4"      "brown1"      "brown3"     
## [16] "brown2"      "firebrick"   "firebrick1"  "chocolate"   "chocolate4" 
## [21] "saddlebrown" "seashell3"   "seashell2"   "seashell4"   "sandybrown" 
## [26] "peachpuff2"  "peachpuff3" 
```



# Above and Beyond
<img src="figure/slides6-premier.png" width="800px" height="520px"  alt="plot of chunk premier" title="plot of chunk premier" /> 



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



# Exercises 

1.

2.

# References
1. [Hadley Wickham's JSM 2012 Presentation](http://www.stat.yale.edu/~jay/JSM2012/PDFs/ggplot2.pdf)
2. [Hadley Wickam's GGPLOT2 Intro Presentation](http://had.co.nz/ggplot2/resources/2007-vanderbilt.pdf)
3. [The GGPLOT2 Homepage](http://had.co.nz/ggplot2/)
4. [GGPLOT2 Documentation](http://had.co.nz/ggplot2/docs)


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
## [1] splines   grid      stats     graphics  grDevices utils     datasets 
## [8] methods   base     
## 
## other attached packages:
## [1] stringr_0.6.1    Hmisc_3.9-3      survival_2.36-14 quantreg_4.81   
## [5] SparseM_0.96     plyr_1.7.1       ggplot2_0.9.1    gridExtra_0.9   
## [9] knitr_0.7       
## 
## loaded via a namespace (and not attached):
##  [1] cluster_1.14.2     colorspace_1.1-1   dichromat_1.2-4   
##  [4] digest_0.5.2       evaluate_0.4.2     formatR_0.6       
##  [7] labeling_0.1       lattice_0.20-6     MASS_7.3-19       
## [10] memoise_0.1        munsell_0.3        proto_0.3-9.2     
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
