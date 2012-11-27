# GIST sharing

options(repos=c(RStudio='http://rstudio.org/_packages', getOption('repos')))
install.packages('shiny')

library(shiny)

# Standard Example
runGist('3239667')

# Jared's Example
# https://gist.github.com/4155326
runGist('4155326')
