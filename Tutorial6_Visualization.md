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

# Basic Plot
- Don't use R base graphics
- `ggplot2` is pretty much the new standard in R
- Create beautiful, clear plots with a nice consistent set of language conventions


```r
library(ggplot2)
qplot(readSS, mathSS, data = df)
```

![plot of chunk plot1](figure/slides6-plot1.svg) 

- Consider this basic scatterplot

# Variations

```r
qplot(readSS, mathSS, data = df) + geom_smooth()
```

![plot of chunk plot2](figure/slides6-plot21.svg) 

```r
qplot(readSS, mathSS, data = df, alpha = I(0.3))
```

![plot of chunk plot2](figure/slides6-plot22.svg) 

```r
qplot(readSS, mathSS, data = df) + xlab("Reading Score") + ylab("Math Score")
```

![plot of chunk plot2](figure/slides6-plot23.svg) 

```r
qplot(readSS, mathSS, data = df, color = race) + scale_color_brewer(type = "qual", 
    palette = 2)
```

![plot of chunk plot2](figure/slides6-plot24.svg) 


# Visualization Philosophy
- Visualization is about thinking about what objects in our dataset map with what visual cues for the viewer
  - liberal use of `names(object)` helps
- What is the best way to show discrete variables, continuous variables, and connected variables

# Our data
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

![plot of chunk colorwheel](figure/slides6-colorwheel1.svg) 

```
##  [1] "plum"        "violet"      "darkmagenta" "magenta4"    "magenta3"   
##  [6] "magenta2"    "magenta"     "magenta1"    "orchid4"     "orchid"     
```

```r
col.wheel("orange", nearby = 2)
```

![plot of chunk colorwheel](figure/slides6-colorwheel2.svg) 

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

![plot of chunk colorwheel](figure/slides6-colorwheel3.svg) 

```
##  [1] "snow1"       "snow2"       "rosybrown"   "rosybrown1"  "rosybrown2" 
##  [6] "rosybrown3"  "rosybrown4"  "lightcoral"  "indianred"   "indianred1" 
## [11] "indianred3"  "brown"       "brown4"      "brown1"      "brown3"     
## [16] "brown2"      "firebrick"   "firebrick1"  "chocolate"   "chocolate4" 
## [21] "saddlebrown" "seashell3"   "seashell2"   "seashell4"   "sandybrown" 
## [26] "peachpuff2"  "peachpuff3" 
```


# Start with a great example

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

![plot of chunk premier](figure/slides6-premier.svg) 


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

![plot of chunk extended](figure/slides6-extended.svg) 

- We've seen this guy before
- This makes `ggplot2` like a sublanguage under R
- `aes` says we are specifying aesthetics, here we specified x and y to make a two dimensional graphic

