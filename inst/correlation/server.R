# Script to demonstrate distributions
library(eeptools)
library(shiny)
library(ggplot2)


rnormcor <- function(x,rho) rnorm(1,rho*x,sqrt(1-rho^2))

shinyServer(function(input,output){
  output$distPlot<-reactivePlot(function(){
    a<-rnorm(input$obs)
    b<-sapply(a,rnormcor,rho=input$rho)
    p<-qplot(a,b,alpha=0.85)+geom_smooth(method="lm",se=FALSE,size=1.1)+theme_dpi()
    p<-p+labs(x="",y="",title="Demonstrating Correlations")
    p<-p+geom_text(aes(x=-2.5,y=3,label=paste("Corr. =",input$rho,sep=" ")),size=8)
    print(p)
    
  })
})





# 
# rnormcor <- function(x,rho) rnorm(1,rho*x,sqrt(1-rho^2))
# a <- rnorm(1000,0,1)
# b <- sapply(a, rnormcor, rho = 0.8)
# 
# cor(a,b)