library(shiny)
library(ggplot2)
library(eeptools)
library(reshape)
shinyUI(pageWithSidebar(
  
  # Title
  headerPanel("Normality"),
  
  sidebarPanel(
    sliderInput("obs","Number of observations:",
                min=20,max=1000,value=20)
  ),
  
  # GGPLOT
  
  mainPanel(
    plotOutput("distPlot"),
    plotOutput("distPlot2")
  )
  
  
  
))