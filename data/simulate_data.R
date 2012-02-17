#Simulating mixed effect data
# Jared Knowles
library(ggplot2)

  #########################################################################
  # Function: Create and define proficiency levels
  # Proficiency levels are set to be approximately 40 SS points below the
  # mean at each grade level. Basic levels are set 60 points below proficient.
  # Advanced levels are set 100 points above proficient.
  #########################################################################
proflvl <- function(student)
{

  proflvl3 <- 380
  proflvl4 <- 410
  proflvl5 <- 430
  proflvl6 <- 450
  proflvl7 <- 480
  proflvl8 <- 500

  basiclvl3 <- proflvl3 - 60
  basiclvl4 <- proflvl4 - 60
  basiclvl5 <- proflvl5 - 60
  basiclvl6 <- proflvl6 - 60
  basiclvl7 <- proflvl7 - 60
  basiclvl8 <- proflvl8 - 60

  advlvl3 <- proflvl3 + 100
  advlvl4 <- proflvl4 + 100
  advlvl5 <- proflvl5 + 100
  advlvl6 <- proflvl6 + 100
  advlvl7 <- proflvl7 + 100
  advlvl8 <- proflvl8 + 100

  student$proflvl <- NA

  student <- within(student,
    {
     
      proflvl[grade==3 & readSS >= basiclvl3] <- 'basic'
      proflvl[grade==3 & readSS >= proflvl3] <- 'proficient'
      proflvl[grade==3 & readSS >= advlvl3] <- 'advanced'
      proflvl[is.na(proflvl)] <- 'below basic'
      
      proflvl[grade==4 & readSS >= basiclvl4] <- 'basic'
      proflvl[grade==4 & readSS >= proflvl4] <- 'proficient'
      proflvl[grade==4 & readSS >= advlvl4] <- 'advanced'
      proflvl[is.na(proflvl)] <- 'below basic'
      
      proflvl[grade==5 & readSS >= basiclvl5] <- 'basic'
      proflvl[grade==5 & readSS >= proflvl5] <- 'proficient'
      proflvl[grade==5 & readSS >= advlvl5] <- 'advanced'
      proflvl[is.na(proflvl)] <- 'below basic'
      
      proflvl[grade==6 & readSS >= basiclvl6] <- 'basic'
      proflvl[grade==6 & readSS >= proflvl6] <- 'proficient'
      proflvl[grade==6 & readSS >= advlvl6] <- 'advanced'
      proflvl[is.na(proflvl)] <- 'below basic'
      
      proflvl[grade==7 & readSS >= basiclvl7] <- 'basic'
      proflvl[grade==7 & readSS >= proflvl7] <- 'proficient'
      proflvl[grade==7 & readSS >= advlvl7] <- 'advanced'
      proflvl[is.na(proflvl)] <- 'below basic'
      
      proflvl[grade==8 & readSS >= basiclvl8] <- 'basic'
      proflvl[grade==8 & readSS >= proflvl8] <- 'proficient'
      proflvl[grade==8 & readSS >= advlvl8] <- 'advanced'
      proflvl[is.na(proflvl)] <- 'below basic'
      
      proflvl <- as.factor(proflvl)
      
    })
  return(student)
}

  #########################################################################
  # Function: Create a simulated reading scale score
  #########################################################################
set.seed(6283)
simscoreread <- function(student)
{
  student<-within(student,
      {
        measerr <- rnorm(length(student$stuid),0,20)
        
        readSS<-((rnorm(1,mean=14,sd=20)+rweibull(1,shape=9,scale=6))*white)+
        ((rnorm(1,mean=-20,sd=20)+rweibull(1,shape=3,scale=7))*black)+
        ((rnorm(1,mean=-14,sd=20)+rweibull(1,shape=5,scale=9))*hisp)+
        ((rnorm(1,mean=-4,sd=20)+rweibull(1,shape=9,scale=6))*asian)+
        ((rnorm(1,mean=-14,sd=20)+rweibull(1,shape=2,scale=8))*indian)+
        ((rnorm(1,mean=8,sd=20)+rweibull(1,shape=6,scale=5))*female)+
        ((rnorm(1,mean=-24,sd=30)+rweibull(1,shape=2,scale=6))*disab)+
        ((rnorm(1,mean=-18,sd=20)+rweibull(1,shape=5,scale=6))*econ)+
        ((rnorm(1,mean=-16,sd=20)+rweibull(1,shape=3,scale=6))*ell)+
        ((rnorm(1,mean=20,sd=7)+rexp(1,rate=rnorm(1,mean=.5,sd=.2)))*grade)+
        ((rnorm(1,mean=8,sd=20)-rweibull(1,shape=1,scale=6))*sch_fay)+
        ((rnorm(1,mean=14,sd=20)-rweibull(1,shape=1,scale=6))*dist_fay)+
        rnorm(1,mean=rnorm(1,mean=0,sd=100),sd=60)+rweibull(1,shape=1,scale=100)+ability+
        ((rnorm(1,mean=30,sd=5)*luck))+((rnorm(1,mean=2,sd=.2)*teachq))-120
        
        readSS<-readSS+measerr
        
        ## Add in school effects
        readSS <- readSS + ((rnorm(1,mean=10,sd=20)+rweibull(1,shape=3,scale=6))*schoolhigh)
        readSS <- readSS + ((rnorm(1,mean=0,sd=20)+rweibull(1,shape=3,scale=6))*schoolavg)
        readSS <- readSS + ((rnorm(1,mean=-10,sd=20)+rweibull(1,shape=3,scale=6))*schoollow)
        
        readSS[readSS>900]<-900
        readSS[readSS<200]<-200
      })
}

  #########################################################################
  # Function: Create a simulated math scale score
  #########################################################################
simscoremath <- function(student)
{
  student<-within(student,
      {
        measerr <- rnorm(length(student$stuid),0,20)
        
        mathSS<-((rnorm(1,mean=16,sd=20)+rweibull(1,shape=9,scale=6))*white)+
        ((rnorm(1,mean=-14,sd=20)+rweibull(1,shape=3,scale=7))*black)+
        ((rnorm(1,mean=-12,sd=20)+rweibull(1,shape=5,scale=9))*hisp)+
        ((rnorm(1,mean=-4,sd=20)+rweibull(1,shape=9,scale=6))*asian)+
        ((rnorm(1,mean=-10,sd=20)+rweibull(1,shape=2,scale=8))*indian)+
        ((rnorm(1,mean=8,sd=20)+rweibull(1,shape=6,scale=5))*female)+
        ((rnorm(1,mean=-29,sd=30)+rweibull(1,shape=2,scale=6))*disab)+
        ((rnorm(1,mean=-20,sd=20)+rweibull(1,shape=5,scale=6))*econ)+
        ((rnorm(1,mean=-12,sd=20)+rweibull(1,shape=3,scale=6))*ell)+
        ((rnorm(1,mean=20,sd=7)+rexp(1,rate=rnorm(1,mean=.5,sd=.2)))*grade)+
        ((rnorm(1,mean=7,sd=20)-rweibull(1,shape=1,scale=6))*sch_fay)+
        ((rnorm(1,mean=2,sd=20)-rweibull(1,shape=1,scale=6))*dist_fay)+
        rnorm(1,mean=rnorm(1,mean=0,sd=100),sd=60)+rweibull(1,shape=1,scale=100)+ability+
        ((rnorm(1,mean=20,sd=5)*luck))+((rnorm(1,mean=2,sd=.2)*teachq))-120
        
        mathSS<-mathSS+measerr

        ## Add in school effects
        mathSS <- mathSS + ((rnorm(1,mean=10,sd=20)+rweibull(1,shape=3,scale=6))*schoolhigh)
        mathSS <- mathSS + ((rnorm(1,mean=0,sd=20)+rweibull(1,shape=3,scale=6))*schoolavg)
        mathSS <- mathSS + ((rnorm(1,mean=-10,sd=20)+rweibull(1,shape=3,scale=6))*schoollow)
         
        mathSS[mathSS>900]<-900
        mathSS[mathSS<200]<-200
      })  

return(student)
}
  
  #########################################################################
  # Function: Draw some plots of the simulated data set
  #########################################################################

simdiagread<-function(student)
{
  qplot(readSS,geom='density',data=student)+facet_wrap(~grade)
}
simdiagmath<-function(student)
{
  qplot(mathSS,geom='density',data=student)+facet_wrap(~grade)
}

#Create a data frame
  
  commonnames<-c('stuid','school','dist','cesa','year','female','grade','econ','disab','ell',
               'loc','age','readSS','readRS','mathSS','mathRS','dist_fay','sch_fay','Rprof',
               'Rproflvl','Mprof','Mproflvl')

stuid<-seq(1,150000,by=1)
grade<-rep(c(3,4,5,6,7,8),length.out=150000)
student<-cbind(stuid,grade)
student<-as.data.frame(student)
student$schid<-rep(c(seq(1,500)),length.out=150000)
student$dist<-rep(c(seq(3,120,by=3)),length.out=150000)
student$white<-rbinom(150000,1,.45)
student$black<-0
student$black[student$white==0]<-rbinom(100000,1,.75)
student$hisp<-0
student$hisp[student$white==0 & student$black==0]<-rbinom(100000,1,.8)
student$indian<-0
student$indian[student$white==0 & student$black==0 &student$hisp==0]<-rbinom(100000,1,.3)
student$asian<-0
student$asian[student$white==0 & student$black==0 & student$hisp==0]<-1
student$econ<-0
student$econ[student$white==1]<-rbinom(100000,1,.5)
student$econ[student$black==1]<-rbinom(100000,1,.9)
student$econ[student$hisp==1]<-rbinom(100000,1,.8)
student$econ[student$asian==1]<-rbinom(100000,1,.66)
student$econ[student$indian==1]<-rbinom(100000,1,.66)
student$female<-0
student$female<-rbinom(150000,1,.505)
student$ell<-0
student$ell[student$hisp==1]<-rbinom(100000,1,.88)
student$ell[student$white==1]<-rbinom(100000,1,.05)
student$ell[student$black==1]<-rbinom(100000,1,.05)
student$ell[student$asian==1]<-rbinom(100000,1,.73)
student$ell[student$indian==1]<-rbinom(100000,1,.02)
student$disab<-0
student$disab[student$white==1]<-rbinom(100000,1,.1)
student$disab[student$black==1]<-rbinom(1000000,1,.22)
student$disab[student$hisp==1]<-rbinom(1000000,1,.195)
student$disab[student$asian==1]<-rbinom(100000,1,.14)
student$disab[student$indian==1]<-rbinom(100000,1,.19)
student$sch_fay<-0
student$sch_fay[student$econ==1]<-rbinom(200000,1,.15)
student$sch_fay[student$econ==0]<-rbinom(200000,1,.05)
student$dist_fay<-0
student$dist_fay[student$sch_fay==1]<-rbinom(200000,1,.2)
student$luck<-rbinom(150000,1,.2)
student$ability<-rnorm(150000,mean=100,sd=10)
student$measerr<-rweibull(150000,shape=3,scale=100)
student$teachq[student$econ==1 & student$black==1]<-rnorm(200000,mean=40,sd=20)
student$teachq[student$econ==0 & student$black==1]<-rnorm(200000,mean=70,sd=20)
student$teachq[student$econ==1 & student$white==1]<-rnorm(200000,mean=60,sd=15)
student$teachq[student$econ==0 & student$white==1]<-rnorm(200000,mean=85,sd=20)
student$teachq[student$econ==1 & student$asian==1]<-rnorm(200000,mean=50,sd=20)
student$teachq[student$econ==0 & student$asian==1]<-rnorm(200000,mean=85,sd=20)
student$teachq[student$econ==1 & student$hisp==1]<-rnorm(200000,mean=55,sd=20)
student$teachq[student$econ==0 & student$hisp==1]<-rnorm(200000,mean=75,sd=20)
student$year <- '2000'
student$attday<-round(rpois(150000,170)-rnorm(150000,mean=0,sd=5))
student$attday[student$attday>180]<-180

#########################################################################
# Create schools and districts, and assign students to schools and districts.
#########################################################################

student$school <- NA 
student$schoolscore<-NA

student<-within(student,
    {
      schoolscore<-((rnorm(1,mean=14,sd=20)+rweibull(1,shape=9,scale=6))*white)+
      ((rnorm(1,mean=-20,sd=20)+rweibull(1,shape=3,scale=7))*black)+
      ((rnorm(1,mean=-14,sd=20)+rweibull(1,shape=5,scale=9))*hisp)+
      ((rnorm(1,mean=-4,sd=20)+rweibull(1,shape=9,scale=6))*asian)+
      ((rnorm(1,mean=-14,sd=20)+rweibull(1,shape=2,scale=8))*indian)+
      ((rnorm(1,mean=8,sd=20)+rweibull(1,shape=6,scale=5))*female)+
      ((rnorm(1,mean=-24,sd=30)+rweibull(1,shape=2,scale=6))*disab)+
      ((rnorm(1,mean=-18,sd=20)+rweibull(1,shape=5,scale=6))*econ)+
      ((rnorm(1,mean=-16,sd=20)+rweibull(1,shape=3,scale=6))*ell)+
      ((rnorm(1,mean=20,sd=7)+rexp(1,rate=rnorm(1,mean=.5,sd=.2)))*grade)+
      ((rnorm(1,mean=-8,sd=20)-rweibull(1,shape=1,scale=6))*sch_fay)+
      ((rnorm(1,mean=14,sd=20)-rweibull(1,shape=1,scale=6))*dist_fay)
                         
})

PROBS <- runif(1000, 0.01, 1.0)
PROBS <- c(PROBS,1)

quants <- quantile(student$schoolscore, probs = PROBS )
quants <- as.data.frame(quants)
quants$quant <- quants$quants
quants$quants <- NULL
quants <- quants[order(quants$quant) , ]
quants <- as.data.frame(quants)

## Assign to schools
  i <- 1
  while(i < length(quants$quants))
  {
    student$school[student$schoolscore <= quants$quants[i] &
                   is.na(student$school)] <- i
    i <- i+1
  }

student$school[is.na(student$school)] <- 1000

## Assign to districts, currently set to 25 districts total
schools <- unique(student$school)
schools <- as.data.frame(schools)
schools$school <- schools$schools
schools$schools <- NULL
schools$district<-rep(c(1:25),length.out=length(unique(schools$school)))

# Assign school quality values to schools
# 15% of schools will be high quality schools
schools$schoolhigh <- rbinom(length(schools$school),1,.15)
# 75% of the remaining schools will be average quality schools
schools$schoolavg[schools$schoolhigh == 1] <- 0
schools$schoolavg[schools$schoolhigh != 1] <- rbinom(length(schools$school),1,.75)
# all the rest will be low quality
schools$schoollow <- 0
schools$schoollow[schools$schoolavg == 0 & schools$schoolhigh == 0] <- 1

student <- merge(student,schools,by="school")

#########################################################################
# Create one year of simulated test scores.
#########################################################################

set.seed(55)
student <- simscoreread(student)
  simdiagread(student)

set.seed(1)
student <- simscoremath(student)
  simdiagmath(student)

## Assign proficiency levels
student <- proflvl(student)


#########################################################################
# Create more years of data.
# This can currently support up to 5 more years of data.
#########################################################################

number_of_years <- 2
student_new <- student
student_long <- student
i <- 1

while(i <= number_of_years)
{

    ## Copy original data frame
    student_temp <- student_new
    
    ## Move 9th graders back to 3rd grade
    student_temp <- within(student_temp, 
        {
            grade <- grade + 1
            grade[grade==9] <- 3
          
        })
    
    ## Assign the new 3rd graders new student ids
    newstud <- subset(student_temp,grade==3,)
    newstud$stuid <- (150000*i) + seq(1,length(newstud$stuid),by=1)
    
    ## Attach the 3rd graders with new ids back onto the main data frame
    student_temp <- subset(student_temp,grade!=3, )
    student_temp <- rbind(student_temp,newstud)
                                      
    student_temp <- within(student_temp, 
        {
            year <- 2000+i
        })

    if(i==1)
      set.seed(1)
    else if(i==2)
      set.seed(450)
    else if(i==3)
      set.seed(10027)
    else if(i==4)
      set.seed(6283)
    else if(i==5)
      set.seed(36)                 
    student_temp <- simscoreread(student_temp)

    if(i==1)
      set.seed(10027)
    else if(i==2)
      set.seed(6283)
    else if(i==3)
      set.seed(36)
    else if(i==4)
      set.seed(1)
    else if(i==5)
      set.seed(450)
    student_temp <- simscoremath(student_temp)
      
  ## Break off the students who weren't assigned a reading score
  ## and give them a reading score
  student_temp2 <- subset(student_temp,is.na(readSS), )
  student_temp <- subset(student_temp,!is.na(readSS), ) 
      if(i==1)
        set.seed(1)
      else if(i==2)
        set.seed(450)
      else if(i==3)
        set.seed(10027)
      else if(i==4)
        set.seed(6283)
      else if(i==5)
        set.seed(36)
      student_temp2 <- simscoreread(student_temp2)
 
  ## Put them back on to the main temporary data frame        
  student_temp <- rbind(student_temp,student_temp2)
                                
  ## Assign proficiency levels                              
  student_temp <- proflvl(student_temp)                                                        
    
  ## Merge the temporary data frame onto the main big data frame                              
  student_long <- rbind(student_long,student_temp)    
      
  student_new <- student_temp
  i <- i + 1   
}

student_long$race[student_long$white==1]<-'W'
student_long$race[student_long$asian==1]<-'A'
student_long$race[student_long$black==1]<-'B'
student_long$race[student_long$hisp==1]<-'H'
student_long$race[student_long$indian==1]<-'I'
student_long$race<-factor(student_long$race,levels=c('W','B','H','I','A'))


student_wide <- reshape(student_long,timevar="year",idvar="stuid",direction="wide")

rm(quants,newstud,student,student_new,student_temp,student_temp2)
