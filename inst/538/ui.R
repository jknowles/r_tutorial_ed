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
                min=1,max=300,step=25,value=50),
    sliderInput("error","Adjust the error:",
                min=-2,max=6,step=0.5,value=0),
    sliderInput("bias","Adjust the bias:",
                min=-3,max=3,step=0.25,value=0)
  ),
  
  
  mainPanel(
    plotOutput("voteplot")
  )
  
  
  
))