library(shiny)

shinyUI(pageWithSidebar(

  headerPanel('Ordinary Least Squares'),

  sidebarPanel(
    tags$head(
      tags$script(src = 'https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML', type = 'text/javascript')
    ),
    helpText('This module shows the least squares fit for the linear regression model
             $$Y_i=\\beta_0+\\beta_1x_i+\\epsilon_i$$ where \\(\\epsilon \\sim
             N(0, I_{n \\times n})\\). You can guess estimates of
             \\(\\beta_0\\) (intercept) and \\(\\beta_1\\) (slope) below.'),
    numericInput('b0', '\\(\\beta_0\\) Intercept', min = -5, max = 5,
                 value = round(runif(1, -2, 2), 1), step = .1),
    numericInput('b1', '\\(\\beta_1\\) Slope', min = -5, max = 5,
                 value = round(runif(1, -2, 2), 1), step = .1),
    checkboxInput('showFit', 'Show OLS fit'),
    checkboxInput('showResid', 'Show residuals'),
    helpText('The red bar on the right indicates the Error Sum of Squares (SSE),
             which is the goal to minimize.'),
    checkboxInput('showSSE', 'Show SSE of the OLS fit')
  ),

  mainPanel(
    plotOutput('olsPlot')
  )
))