library(shiny)
library(ggplot2)
library(eeptools)
library(reshape)

shinyServer(function(input,output){
  
  output$distPlot<-reactivePlot(function(){
    Coin <- c()
    Die1 <- c()
    Die2 <- c()
    DieTot <- c()
    for (i in 1:input$obs) {
      Coin[i] <- sample(c("Heads", "Tails"), 1)
      Die1[i] <- sample(c(1,2,3,4,5,6), 1)
      Die2[i] <- sample(c(1,2,3,4,5,6), 1)
      DieTot[i] <- Die1[i]+Die2[i]
    }
    a<-prop.table(table(Coin,Die1))
    #b<-matrix(rep(1/12,12),nrow=2)
    c<-as.data.frame(a)
    p<-qplot(factor(Die1),factor(Coin),
          fill=Freq,data=c,geom='tile',label=round(Freq*100,digits=2))+geom_text()+
      theme_dpi()+coord_cartesian()
    print(p)
  })
  
  output$distPlot2<-reactivePlot(function(){
    b2<-matrix(rep(1/12,12),nrow=2)
    p2<-as.table(b2)
    p2<-melt(p2)
    m<-qplot(X2,X1,fill=value,data=p2,geom='tile',label=round(value*100,digits=2))+
      theme_dpi()+geom_text()+coord_cartesian()
    print(m)
  })
  
  
  
})



# 
# Coin <- c()
# Die1 <- c()
# Die2 <- c()
# DieTot <- c()
# 
# for (i in 20:input$obs) {
#   Coin[i] <- sample(c("Heads", "Tails"), 1)
#   Die1[i] <- sample(c(1,2,3,4,5,6), 1)
#   Die2[i] <- sample(c(1,2,3,4,5,6), 1)
#   DieTot[i] <- Die1[i]+Die2[i]
# }
# 
# a<-prop.table(table(Coin,Die1))
# b<-matrix(rep(1/12,12),nrow=2)
# 
# 
# 
# round(prop.table(table(Coin, DieTot))*100,digits=2)
