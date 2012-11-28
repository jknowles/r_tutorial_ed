# Script to demonstrate distributions
library(VGAM)
library(eeptools)
library(shiny)
library(ggplot2)
shinyUI(pageWithSidebar(
  
  # Title
  headerPanel("Exploring Propoerties of Distributions"),
  
  sidebarPanel(
    sliderInput("obs","Number of tries:",
                min=200,max=5000,value=500,step=250),
    sliderInput("mean","Mean of the Distribution",
                min=-10,max=10,value=0,step=1),
    sliderInput("mode","Mode of the Distribution",
                min=-10,max=10,value=0,step=1),
    sliderInput("variance","Variance of the Distribution",
                min=1,max=5,value=1,step=1),
    sliderInput("skew","skew of the Distribution",
                min=-5,max=5,value=0,step=1)
    
  ),
  
  # GGPLOT
  
  mainPanel(
    plotOutput("distPlot")
  )
  
  
  
))