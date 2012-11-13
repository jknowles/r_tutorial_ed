library(shiny)
library(ggplot2)
library(eeptools)
shinyUI(pageWithSidebar(
  
  # Title
  headerPanel("Normality"),
  
  sidebarPanel(
    sliderInput("obs","Number of observations:",
                min=0,max=1000,value=100)
    ),
  
  # GGPLOT
  
  mainPanel(
    plotOutput("distPlot")
    )
  
  
  
  ))