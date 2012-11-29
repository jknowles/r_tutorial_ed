library(shiny)
library(ggplot2)
library(eeptools)
library(plyr)
# Sampling examples
probs<-c(.05,.15,.4,.4)
samprobs<-c(.4,.4,.15,.05)

syssamp = function(data, nSubsets, nSkip){
  lapply(1:nSubsets, function(n) data[seq(n, NROW(data), by = nSkip),])
} 

sampleOne <- function(id, fraction=0.1){
  sort(sample(id, round(length(id)*fraction)))
}

shinyServer(function(input,output){
  POPinput <- reactive(function() {
    mypop<-data.frame(x=rnorm(input$obs),y=runif(input$obs),
                      z=sample(c("A","B","C","D"),input$obs,replace=TRUE,prob=probs))
    return(mypop)
  })
  
  STRATinput<-function(){
    df<-ddply(POPinput(), .(z), summarize, sampleID=sampleOne(rownames(POPinput()), fraction=0.05))
    STRAT<-POPinput()[rownames(POPinput()) %in% df$sampleID,]
    return(STRAT)
  }
  
  SAMPinput <- reactive(function() {
    switch(input$sampling,
           "srs" = POPinput()[sample(row.names(POPinput()),nrow(POPinput()) %/% 5),],
           "cluster" = POPinput()[POPinput()$z %in% sample(unique(POPinput()$z),2),],
           "sys" = as.data.frame(syssamp(POPinput(), 1, 5)),
           "strat"=STRATinput())
  })
  
  output$distPlot<-reactivePlot(function(){
    p<-ggplot()+geom_point(aes(x=x,y=y),data=POPinput())+
      geom_point(aes(x=x,y=y),data=SAMPinput(),color=I('blue'),shape=0,size=I(4))+
      theme_dpi()+facet_wrap(~z)
    print(p)
  })
})


# 
# # Generate some data
# 
# mypop<-data.frame(x=rnorm(500),y=runif(500),
#                   z=sample(c("A","B","C","D"),500,replace=TRUE,prob=probs))
# qplot(x,y,data=mypop)
# 
# SRS<-mypop[sample(row.names(mypop),100),]
# CLUSTER<-mypop[mypop$z %in% sample(unique(mypop$z),2),]
# 

# 

# 
# syssamp = function(data, nSubsets, nSkip){
#   lapply(1:nSubsets, function(n) data[seq(n, NROW(data), by = nSkip),])
# } 
# 
# SYSTEMIC<-as.data.frame(syssamp(mypop, 1, 5))
# 
# #################
# # Outputs
# ##################
# 
# 
# 
# 
# 
# 
# ggplot()+geom_point(aes(x=x,y=y),data=mypop)+
#   geom_point(aes(x=x,y=y),data=SRS,color=I('blue'),shape=0,size=I(4))+
#   theme_dpi()+facet_wrap(~z)
# 
# 
# ggplot()+geom_point(aes(x=x,y=y),data=mypop)+
#   geom_point(aes(x=x,y=y),data=CLUSTER,color=I('blue'),shape=0,size=I(4))+
#   theme_dpi()+facet_wrap(~z)
# 
# ggplot()+geom_point(aes(x=x,y=y),data=mypop)+
#   geom_point(aes(x=x,y=y),data=STRAT,color=I('blue'),shape=0,size=I(4))+
#   theme_dpi()+facet_wrap(~z)
# 
# ggplot()+geom_point(aes(x=x,y=y),data=mypop)+
#   geom_point(aes(x=x,y=y),data=SYSTEMIC,color=I('blue'),shape=0,size=I(4))+
#   theme_dpi()+facet_wrap(~z)