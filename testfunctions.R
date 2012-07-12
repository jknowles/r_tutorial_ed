# Functions for testing linear models

delist.test<-function(test,...){
  vector<-c(test$method,test$p.value,paste(test$parameter,collapse=" "),
            test$statistic,test$data.name)
  return(vector)
}

lm_reset_test<-function(lm){
  require(lmtest)
  a<-resettest(lm,power=2:4)
  a<-delist.test(a)
  return(a)
}

# 
# a<-bptest(ss)
# testresults<-delist.test(a)
# a<-bptest(ss,~ss1+I(ss1^4),data=rep)
# testresults<-rbind(testresults,delist.test(a))
# a<-resettest(ss,power=2:4)
# testresults<-rbind(testresults,delist.test(a))
# a<-gqtest(ss,order.by=~ss1,point=0.5,data=rep)
# testresults<-rbind(testresults,delist.test(a))
# a<-raintest(ss,order.by=~ ss1,data=rep)
# testresults<-rbind(testresults,delist.test(a))
# a<-harvtest(ss,order.by=~ss1,data=rep)
# testresults<-rbind(testresults,delist.test(a))
# 
# 


lm_mega_test<-function(lm){
  require(lmtest)
  #df<<- eval(parse(text=lm$call$data))
  order<-eval(parse(text=paste(substr(lm$call[2],5,9))))
  a<-bptest(lm)
  #Heteroskedacticity
  testresults<-delist.test(a)
  #Heteroskdacticity test2, look at 20% v. 80%
  a<-gqtest(lm,order.by=order,point=0.2)
  testresults<-rbind(testresults,delist.test(a))
  #RESET test finds functional form misspecified by looking at polynomials
  a<-resettest(lm,power=2:4)
  testresults<-rbind(testresults,delist.test(a))
  #Rainbow test for linearity, compares fit in middle to tails of data
  a<-raintest(lm,order.by=order)
  testresults<-rbind(testresults,delist.test(a))
  #Harvey collier test for linearity
  a<-harvtest(lm,order.by=order)
  testresults<-rbind(testresults,delist.test(a))
  colnames(testresults)<-c('method','p','parameter','test statistic','data.name')
  return(testresults)
}



lm_mega_test_count<-function(lm){
  require(lmtest)
  #df<<- eval(parse(text=lm$call$data))
  order<-eval(parse(text=paste(substr(lm$call[2],5,9))))
  a<-bptest(lm)
  #Heteroskedacticity
  testresults<-delist.test(a)
  #Heteroskdacticity test2, look at 20% v. 80%
  a<-gqtest(lm,order.by=order,point=0.2)
  testresults<-rbind(testresults,delist.test(a))
  #RESET test finds functional form misspecified by looking at polynomials
  a<-resettest(lm,power=2:4)
  testresults<-rbind(testresults,delist.test(a))
  #Rainbow test for linearity, compares fit in middle to tails of data
  a<-raintest(lm,order.by=order)
  testresults<-rbind(testresults,delist.test(a))
  #Harvey collier test for linearity
  a<-harvtest(lm,order.by=order)
  testresults<-rbind(testresults,delist.test(a))
  colnames(testresults)<-c('method','p','parameter','test statistic','data.name')
  return(length(which(as.numeric(testresults[,2])<.025)))
}

lm_het_test_count<-function(lm){
  require(lmtest)
  #df<<- eval(parse(text=lm$call$data))
  order<-eval(parse(text=paste(substr(lm$call[2],5,9))))
  white.form<-parse(text=paste("~",order[2],"+","I(",substr(order,1,4)[2],
                                 "^2)"))
  a<-bptest(lm)
  #Heteroskedacticity
  testresults<-delist.test(a)
  #White test
  #a<-bptest(lm,eval(white.form))
  #testresults<-rbind(testresults,delist.test(a))
  #Heteroskdacticity test2, look at 20% v. 80%
  a<-gqtest(lm,order.by=order,point=0.2)
  testresults<-rbind(testresults,delist.test(a))
  colnames(testresults)<-c('method','p','parameter','test statistic','data.name')
  return(length(which(as.numeric(testresults[,2])<.01)))
}

lm_het_test_count_w<-function(lm){
  require(lmtest)
  #df<<- eval(parse(text=lm$call$data))
  order<-eval(parse(text=paste(substr(lm$call[2],5,9))))
  white.form<-parse(text=paste("~",order[2],"+",
                               "I(",substr(order,1,4)[2],"^2)"))
  df<-lm$model
  a<-bptest(lm)
  #Heteroskedacticity
  testresults<-delist.test(a)
  #White test
  #a<-bptest(lm,eval(white.form))
  #testresults<-rbind(testresults,delist.test(a))
  #Heteroskdacticity test2, look at 20% v. 80%
  a<-gqtest(lm,order.by=order,point=0.3,data=df)
  testresults<-rbind(testresults,delist.test(a))
  colnames(testresults)<-c('method','p','parameter','test statistic','data.name')
  return(length(which(as.numeric(testresults[,2])<.025)))
}




lm_linear_test_count<-function(lm){
  require(lmtest)
  order<-eval(parse(text=paste(substr(lm$call[2],5,9))))
  #RESET test finds functional form misspecified by looking at polynomials
  a<-resettest(lm,power=2:4)
  testresults<-delist.test(a)
  #Rainbow test for linearity, compares fit in middle to tails of data
  a<-raintest(lm,order.by=order)
  testresults<-rbind(testresults,delist.test(a))
  #Harvey collier test for linearity
  a<-harvtest(lm,order.by=order)
  testresults<-rbind(testresults,delist.test(a))
  colnames(testresults)<-c('method','p','parameter','test statistic','data.name')
  return(length(which(as.numeric(testresults[,2])<.025)))
}

lm_linear_test_count_w<-function(lm){
  require(lmtest)
  order<-eval(parse(text=paste(substr(lm$call[2],5,9))))
  df<-lm$model
  #RESET test finds functional form misspecified by looking at polynomials
  a<-resettest(lm,power=2:4)
  testresults<-delist.test(a)
  #Rainbow test for linearity, compares fit in middle to tails of data
  a<-raintest(lm,order.by=order,data=df)
  testresults<-rbind(testresults,delist.test(a))
  #Harvey collier test for linearity
  a<-harvtest(lm,order.by=order,data=df)
  testresults<-rbind(testresults,delist.test(a))
  colnames(testresults)<-c('method','p','parameter','test statistic','data.name')
  return(length(which(as.numeric(testresults[,2])<.025)))
}


gls.correct<-function(lm){
  require('sandwich')
  rob<-t(sapply(c('const','HC0','HC1','HC2','HC3','HC4','HC5'),function (x)
    sqrt(diag(vcovHC(lm,type=x)))))
  a<-c(NA,(rob[2,1]-rob[1,1])/rob[1,1],(rob[3,1]-rob[1,1])/rob[1,1],
       (rob[4,1]-rob[1,1])/rob[1,1],(rob[5,1]-rob[1,1])/rob[1,1],
       (rob[6,1]-rob[1,1])/rob[1,1],(rob[7,1]-rob[1,1])/rob[1,1])
  rob<-cbind(rob,round(a*100,2))
  a<-c(NA,(rob[2,2]-rob[1,2])/rob[1,2],(rob[3,2]-rob[1,2])/rob[1,2],
       (rob[4,2]-rob[1,2])/rob[1,2],(rob[5,2]-rob[1,2])/rob[1,2],
       (rob[6,2]-rob[1,2])/rob[1,2],(rob[7,2]-rob[1,2])/rob[1,2])
  rob<-cbind(rob,round(a*100,2))
  rob<-as.data.frame(rob)
  names(rob)<-c('alpha','beta','alpha.pchange','beta.pchange')
  rob$id2<-rownames(rob)
  rob
}

lm_mega_test_count_w<-function(lm){
  require(lmtest)
  #df<<- eval(parse(text=lm$call$data))
  order<-eval(parse(text=paste(substr(lm$call[2],5,9))))
  df<-lm$model
  a<-bptest(lm)
  #Heteroskedacticity
  testresults<-delist.test(a)
  #Heteroskdacticity test2, look at 20% v. 80%
  a<-gqtest(lm,order.by=order,point=0.2,data=df)
  testresults<-rbind(testresults,delist.test(a))
  #RESET test finds functional form misspecified by looking at polynomials
  a<-resettest(lm,power=2:4)
  testresults<-rbind(testresults,delist.test(a))
  #Rainbow test for linearity, compares fit in middle to tails of data
  a<-raintest(lm,order.by=order,data=df)
  testresults<-rbind(testresults,delist.test(a))
  #Harvey collier test for linearity
  a<-harvtest(lm,order.by=order,data=df)
  testresults<-rbind(testresults,delist.test(a))
  colnames(testresults)<-c('method','p','parameter','test statistic','data.name')
  return(length(which(as.numeric(testresults[,2])<.025)))
}
