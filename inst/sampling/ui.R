# Script to demonstrate distributions
library(eeptools)
library(shiny)
library(ggplot2)
shinyUI(pageWithSidebar(
  
  # Title
  headerPanel("Sampling Regimes in R"),
  
  sidebarPanel(
    sliderInput("obs","Number of tries:",
                min=50,max=1000,value=100,step=50),
    selectInput("sampling", "Choose a sample type:", 
                choices = c("srs", "cluster", "sys","strat"))
  ),
  
  # GGPLOT
  
  mainPanel(
    plotOutput("distPlot")
  )
  
  
  
))