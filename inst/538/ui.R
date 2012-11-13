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
                min=0,max=3000,value=20)
  ),
  
  # GGPLOT
  
  mainPanel(
    plotOutput("voteplot")
  )
  
  
  
))