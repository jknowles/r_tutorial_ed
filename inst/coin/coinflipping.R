library(shiny)
library(ggplot2)
library(eeptools)
shinyUI(pageWithSidebar(
  
  # Title
  headerPanel("Normality"),
  
  sidebarPanel(
    sliderInput("obs","Number of simulations:",
                min=1,max=1000,value=100),
    sliderInput("coin","Fairness of the coin:",
                min=-.3,max=.3,value=0,step=0.05),
    sliderInput("value","Payout",
                min=5,max=50,value=5),
    sliderInput("bet","Payout",
                min=5,max=50,value=5)
  ),
  
  # GGPLOT
  
  mainPanel(
    plotOutput("distPlot")
  )
  
  
  
))