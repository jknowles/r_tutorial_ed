#
library(ggplot2)

names(cohorts)


mod1<-lm(ss2~ss1+as.factor(test_year)+as.factor(grade)+as.factor(subject),data=cohorts)

cohorts$mps<-0
cohorts$mps[cohorts$district_id==3619]<-1

mod2<-lm(ss2~ss1+as.factor(test_year)+as.factor(grade)+as.factor(subject)+
  mps,data=cohorts)

mod3<-lm(ss2~ss1+as.factor(test_year)+as.factor(grade)+as.factor(subject)+
  as.factor(district_id),data=cohorts)

cohorts$resids.j<-resid(mod1)
cohorts$fitted.j<-fitted(mod1)
cohorts$dist<-cohorts$predicted-cohorts$fitted.j

qplot(dist,data=cohorts)
qplot(fitted.j,dist,data=cohorts)


summary(cohorts$mps)


anova(mod1,mod2,mod3)

summary(mod1)
summary(mod2)
summary(mod3)


rep<-subset(cohorts,test_year==2008 & subject=='math' & grade==4)

mod2<-lm(ss2~1+ss1,data=rep)

rep$pred.j<-fitted(mod2)

qplot(fitted(mod2),rep$predicted,data=rep)

rep2<-within(rep,rep$dist<-fitted(mod2)-rep$predicted)

####################################################
#####################################################
<<echo=F,results=hide>>=
  library(sandwich)

summary(ss)
coeftest(ss,vcov=vcovHC)

#Let's show variation under robustness assumptions to correct 
# for heteroskedacticity above

rob<-t(sapply(c('const','HC0','HC1','HC2','HC3','HC4'),function (x)
  sqrt(diag(vcovHC(ss,type=x)))))

a<-c(NA,(rob[2,1]-rob[1,1])/rob[1,1],(rob[3,1]-rob[1,1])/rob[1,1],
     (rob[4,1]-rob[1,1])/rob[1,1],(rob[5,1]-rob[1,1])/rob[1,1],
     (rob[6,1]-rob[1,1])/rob[1,1])

rob<-cbind(rob,round(a*100,2))
rob

a<-c(NA,(rob[2,2]-rob[1,2])/rob[1,2],(rob[3,2]-rob[1,2])/rob[1,2],
     (rob[4,2]-rob[1,2])/rob[1,2],(rob[5,2]-rob[1,2])/rob[1,2],
     (rob[6,2]-rob[1,2])/rob[1,2])

rob<-cbind(rob,round(a*100,2))

print(rob)
# 37-42% inflation in standard errors and thus uncertainty

polytest<-function(f1,f2){
  flat<-lm(f1)
  poly<-lm(f2)
  anova(flat,poly)
}

f1<-formula(ss2~ss1)
f2<-formula(ss2~ss1+I(ss1^2))

anovamods<-dlply(cohorts,.(id),polytest,f1,f2)

sspoly<-lm(ss2~ss1+I(ss1^2),data=rep)

anova(ss,sspoly)

waldtest(ss,sspoly,vcov=vcovHC(sspoly,type='HC4'))
#Still significant, the polynomial is improperly omitted,
# even under strenuous adjustments for robustness to heteroskedacticity
@

<<echo=F,results=hide>>=
  ## Leave one out regression
  
library(MASS)

ss_lts<-lqs(ss2~ss1+n2,data=rep,psamp=100,nsamp='best')
print(ss_lts)

smallresid<-which(abs(residuals(ss_lts)/ss_lts$scale[2])<=2.5)

#Only works with multiple regressors
X<-model.matrix(ss_n)[,-1]
Xcv<-cov.rob(X,nsamp='best')
nohighlev<-which(sqrt(mahalanobis(X,Xcv$center,Xcv$cov))<=2.5)


X%*%Xcv$center%*%Xcv$co

summary(Xcv$center)
length(Xcv$center)

?mahalanobis
@
<<echo=F,results=hide>>=
  #Quantile Regression
  library(quantreg)
ss_f<-ss2~ss1
ss_quant<-rq(ss_f,tau=c(seq(0.1,.9,.1)),data=rep)
#fm1<-nls(ss2~SSasymp(ss1,as.numeric(quantile(rep$ss1,.8)),350,.8),data=rep)
#summary(fm1)

a<-summary(ss_quant2,se='boot',R=400,bsmethod='wild',covariance=TRUE)
summary(rq(ss2~ss1,tau=-1,data=rep),se='boot',covariance=TRUE)

ss_quant2<-rq(ss_f,tau=-1,data=rep)
a<-lapply(ss_quant2,summary,se='boot',covariance=TRUE)

a[1]$cov
names(a[[1]])

qrdf<-a[1]
qrdf<-as.data.frame(qrdf)


tdim <- dim(x$sol)
p <- tdim[1] - 3
m <- tdim[2]
oldpar <- par(no.readonly = TRUE)
par(mfrow = c(nrow, ncol))
ylab <- dimnames(x$sol)[[1]]
for (i in 1:p) {
  plot(x$sol[1, ], x$sol[3 + i, ], xlab = "tau", ylab = ylab[3 + 
    i], type = "l")
}
par(oldpar)


function (x, parm = NULL, ols = TRUE, mfrow = NULL, mar = NULL, 
          ylim = NULL, main = NULL, col = 1:2, lty = 1:2, cex = 0.5, 
          pch = 20, type = "b", xlab = "", ylab = "", ...) 
{
  taus <- x$tau
  cf <- coef(x)
  if (is.null(parm)) 
    parm <- rownames(cf)
  if (is.numeric(parm)) 
    parm <- rownames(cf)[parm]
  cf <- cf[parm, , drop = FALSE]
  if (ols) {
    obj <- x
    mt <- terms(x)
    mf <- model.frame(x)
    y <- model.response(mf)
    X <- model.matrix(mt, mf, contrasts = x$contrasts)
    olscf <- lm.fit(X, y)$coefficients[parm]
  }
  mfrow_orig <- par("mfrow")
  mar_orig <- par("mar")
  if (is.null(mfrow)) 
    mfrow <- n2mfrow(length(parm))
  if (is.null(mar)) 
    mar <- c(3.1, 3.1, 3.1, 1.6)
  par(mfrow = mfrow, mar = mar)
  col <- rep(col, length.out = 2)
  lty <- rep(lty, length.out = 2)
  if (is.null(main)) 
    main <- parm
  main <- rep(main, length.out = length(parm))
  xlab <- rep(xlab, length.out = length(parm))
  ylab <- rep(ylab, length.out = length(parm))
  ylim0 <- ylim
  for (i in seq(along = parm)) {
    if (is.null(ylim)) {
      if (ols) 
        ylim <- range(c(cf[i, ], olscf[i]))
      else ylim <- range(cf[i, ])
    }
    plot(taus, cf[i, ], cex = cex, pch = pch, type = type, 
         col = col[1], ylim = ylim, xlab = xlab[i], ylab = ylab[i], 
         main = main[i], ...)
    if (ols) 
      abline(h = olscf[i], col = col[2], lty = 2)
    abline(h = 0, col = gray(0.3))
    ylim <- ylim0
  }
  par(mfrow = mfrow_orig, mar = mar_orig)
  if (ols) 
    invisible(cbind(cf, ols = olscf))
  else invisible(cf)
}


ss_quant_2<-rq(ss_f,tau=.2,data=rep)
ss_quant_4<-rq(ss_f,tau=.4,data=rep)
ss_quant_6<-rq(ss_f,tau=.6,data=rep)
ss_quant_8<-rq(ss_f,tau=.8,data=rep)

anova(ss_quant_2,ss_quant_4,ss_quant_6,ss_quant_8)
anova(ss_quant_2,ss_quant_4)
anova(ss_quant_2,ss_quant_6)
anova(ss_quant_2,ss_quant_8)
anova(ss_quant_2,ss_quant_4,ss_quant_6,ss_quant_8,joint=FALSE)

plot(summary(ss_quant))

plot(ss2~ss1,data=rep)
abline(ss)
abline(ss_quant,lty=3)
@

<<echo=F,results=hide>>=
  #Correlations
  
  cor(rep$ss2,rep$ss1,method='pearson')
cor(rep$ss2,rep$ss1,method='spearman')
cor(rep$ss2,rep$ss1,method='kendall')

cor.test(rep$ss2,rep$ss1,alternative='two.sided',method='kendall')

@


<<echo=F,results=hide>>=
  #Bar graph of beta's by TAU
  #Not run
  #coef(ss_quant)
  #qplot(colnames(coef(ss_quant)),coef(ss_quant)[2,],geom='bar')+
  #  geom_hline(yintercept=coef(ss)[2])+theme_dpi()
  @


