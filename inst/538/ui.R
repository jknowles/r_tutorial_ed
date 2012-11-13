library(shiny)
library(ggplot2)
library(eeptools)
library(plyr)
library(grid)
shinyUI(pageWithSidebar(
  
  # Title
  headerPanel("Five Thirty Eight"),
  
  sidebarPanel(
    sliderInput("sims","Number of simulations:",
                min=1,max=300,step=25,value=1),
    sliderInput("error","Adjust the error:",
                min=-2,max=10,step=1,value=0)
  ),
  
  # GGPLOT
  
  mainPanel(
    plotOutput("voteplot")
  )
  
  
  
))