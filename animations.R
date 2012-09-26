# Animations
# Need to generate animations seperately to embed into R
#########################
# 
# http://animation.yihui.name/start
#########################


# Set up package

library(animation)
ani.options(ani.width=800,ani.height=600,outdir=paste(getwd(),"/figure",sep=""),
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
for(i in c(5,20,40,60,80,100,200,500)){
  a<-rnorm(i,mean=2,sd=2)
  print(qplot(a,geom='density')+coord_cartesian(xlim=c(-5,5))+
    geom_vline(xintercept=mean(a),color=I('blue'))+
    geom_vline(xintercept=2,color=I('purple'),size=I(1.2)))
}
}, convert="gm convert",img.name="rnorm",movie.name="rnorm.gif")




