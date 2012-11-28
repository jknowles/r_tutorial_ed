# Script to demonstrate distributions
library(VGAM)
library(eeptools)
library(shiny)
library(ggplot2)
shinyUI(pageWithSidebar(
  
  # Title
  headerPanel("Simulating Data with Correlation"),
  
  sidebarPanel(
    sliderInput("obs","Number of tries:",
                min=200,max=5000,value=500,step=250),
    sliderInput("rho","Correlation Coefficient",
                min=-1,max=1,value=0,step=0.1)    
  ),
  
  # GGPLOT
  
  mainPanel(
    plotOutput("distPlot")
  )
  
  
  
))