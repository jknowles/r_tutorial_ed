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
