library(shiny)
library(ggplot2)
library(eeptools)
shinyUI(pageWithSidebar(
  
  # Title
  headerPanel("When is a Fair Coin Fair?"),
  
  sidebarPanel(
    helpText('Imagine a friend asks you to bet on the outcome of some coin flips. 
             You can bet on a series of coin flips at once. Each time the coin is heads,
             you receive the payout. Each time the coin is tails, your friend receives
             the value of your bet. Explore how the bias of the coin and the value of your
             bet and your friend\'s payout explain probability.'),
    sliderInput("reps","Number of simulations:",
                min=5,max=200,value=100,animate=TRUE),
    sliderInput("obs","Number of trials:",
                min=1,max=200,value=1),
    sliderInput("coin","Fairness of the coin:",
                min=-.3,max=.3,value=0,step=0.05),
    sliderInput("value","Payout for You",
                min=5,max=50,value=5),
    sliderInput("bet","Payout for Friend",
                min=5,max=50,value=5)
  ),
  
  # GGPLOT
  
  mainPanel(
    h4("Payoffs for You and Your Friend"),
    plotOutput("payoffplot"),
    h4("Your Net Wins"),
    plotOutput("netplot")
  )
  
  
))