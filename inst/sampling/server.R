library(shiny)
library(ggplot2)
library(eeptools)
library(plyr)
# Sampling examples
probs<-c(.05,.15,.4,.4)
samprobs<-c(.4,.4,.15,.05)

###############
# Convenience functions
################
syssamp = function(data, nSubsets, nSkip){
  lapply(1:nSubsets, function(n) data[seq(n, NROW(data), by = nSkip),])
} 

sampleOne <- function(id, fraction=0.1){
  sort(sample(id, round(length(id)*fraction)))
}

# http://adammcelhinney.com/2012/04/10/r-function-for-stratified-sampling/
stratified_sampling<-function(df,id, size) {
  #df is the data to sample from
  #id is the column to use for the groups to sample
  #size is the count you want to sample from each group
df<-df[order(df[,id],decreasing = FALSE),]

# Get unique groups
groups<-unique(df[,id])
group.counts<-c(0,table(df[,id]))
#group.counts<-table(df[,id])

rows<-mat.or.vec(nr=size, nc=length(groups))

# Generate Matrix of Sample Rows for Each Group
for (i in 1:(length(group.counts)-1)) {
  start.row<-sum(group.counts[1:i])+1
  samp<-sample(group.counts[i+1]-1,size,replace=FALSE)
  
  rows[,i]<-start.row+samp
}
sample.rows<-as.vector(rows)
df[sample.rows,]
}

###############
# Shiny

shinyServer(function(input,output){
  
  POPinput <- reactive(function() {
    mypop<-data.frame(x=rnorm(input$obs),y=runif(input$obs),
                      z=sample(c("A","B","C","D"),input$obs,replace=TRUE,prob=probs))
    return(mypop)
  })
  

  SAMPinput <- reactive(function() {
    switch(input$sampling,
           "srs" = POPinput()[sample(row.names(POPinput()),nrow(POPinput()) %/% 5),],
           "cluster" = POPinput()[POPinput()$z %in% sample(unique(POPinput()$z),2),],
           "sys" = as.data.frame(syssamp(POPinput(), 1, 5)),
           "strat"=stratified_sampling(POPinput(),"z",size=min(table(POPinput()[,"z"]))%/%2))
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
#  mypop<-data.frame(x=rnorm(500),y=runif(500),
#                    z=sample(c("A","B","C","D"),500,replace=TRUE,prob=probs))
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