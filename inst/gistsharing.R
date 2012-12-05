# GIST sharing

options(repos=c(RStudio='http://rstudio.org/_packages', getOption('repos')))
install.packages('shiny')

library(shiny)

#####################
# 

runApp("inst/ols")
runApp("inst/coin")
runApp("inst/correlation")
runApp("inst/538")
runApp("inst/DieandCoin")
runApp("inst/sports")
runApp("inst/sampling")
runApp("inst/Power t")
runApp("inst/normality")
runApp("distribution")
runApp("schexplorer")

# Standard Example
runGist('3239667')

# Jared's Example
# https://gist.github.com/4155326
runGist('4155326')
