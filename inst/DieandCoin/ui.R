library(shiny)
library(ggplot2)
library(eeptools)
library(reshape)
shinyUI(pageWithSidebar(
  
  # Title
  headerPanel("Dice and Coins"),
  
  sidebarPanel(
    sliderInput("obs","Number of tries:",
                min=20,max=300,value=20,step=20)
  ),
  
  # GGPLOT
  
  mainPanel(
    plotOutput("distPlot"),
    tableOutput("view")
  )
  
  
  
))