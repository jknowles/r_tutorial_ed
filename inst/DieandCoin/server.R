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
    a<-table(Coin,Die1)
    #b<-matrix(rep(1/12,12),nrow=2)
    c<-as.data.frame(a)
    p<-qplot(factor(Die1),factor(Coin),
          data=c,geom='tile',label=Freq,fill=I("white"),
             color=I("black"))+geom_text()+
      theme_dpi()+coord_cartesian()
    print(p)
  })
  
  output$view<-reactiveTable(function(){
    b2<-matrix(rep((1/12)*input$obs,12),nrow=2)
    p2<-as.table(b2)
    p2

  })
  
  
  
})



# 
# Coin <- c()
# Die1 <- c()
# Die2 <- c()
# DieTot <- c()
# 
# for (i in 1:100) {
#   Coin[i] <- sample(c("Heads", "Tails"), 1)
#   Die1[i] <- sample(c(1,2,3,4,5,6), 1)
#   Die2[i] <- sample(c(1,2,3,4,5,6), 1)
#   DieTot[i] <- Die1[i]+Die2[i]
# }
# 
# a<-prop.table(table(Coin,Die1))
# a<-table(Coin,Die1)
# c<-as.data.frame(a)
# b<-matrix(rep(1/12,12),nrow=2)
# 
# 
# 
# round(prop.table(table(Coin, DieTot))*100,digits=2)
