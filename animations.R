# Animations
# Need to generate animations seperately to embed into R
#########################
# 
# http://animation.yihui.name/start
#########################


# Set up package

library(animation)
ani.options(ani.width=600,ani.height=350,outdir=paste(getwd(),"/figure",sep=""),
            imgdir=paste(getwd(),"/figure/tmp",sep=""),ani.dev="png")

# A field of random numbers, uniform 

saveGIF({
  for(i in seq(10,1000,by=50)){
  a<-runif(i,-5,5)
  b<-runif(i,-5,5)
  print(qplot(a,b)+coord_cartesian(xlim=c(-5,5),ylim=c(-5,5)))
  
}
}, convert="gm convert",img.name="runif",movie.name="runif.gif")

# Random normal

saveGIF({
for(i in c(5,20,40,60,80,100,150,200,350,500,1000)){
  a<-rnorm(i,mean=2,sd=2)
  print(qplot(a,geom='density')+coord_cartesian(xlim=c(-2,6),ylim=c(0,0.35))+
    geom_vline(xintercept=mean(a),color=I('blue'))+
    geom_vline(xintercept=2,color=I('purple'),size=I(1.2))+
    geom_text(aes(x=3.5,y=0.18,label=i)))
}
}, convert="gm convert",img.name="rnorm",movie.name="rnorm.gif")

# Scatterplot mean

saveGIF({
for(i in seq(4,50)){
  a<-c(rnorm(i,mean=2,sd=2),8,7,9,12,14,20)
  b<-c(rnorm(i,mean=2,sd=2),2,3,2,4,6,-1)
  print(qplot(a,b)+coord_cartesian(xlim=c(-2,20),ylim=c(-2,6))+
    geom_vline(xintercept=2,color=I("blue"),size=I(1.1))+
  geom_vline(xintercept=mean(a),color=I("orange"),size=I(1.1))+
  geom_vline(xintercept=median(a),color=I("dark green"),size=I(1.1))+
  geom_text(x=15,y=5,label=i))
}
}, convert="gm convert",img.name="scatterplot",movie.name="scatterplot_mean.gif")




