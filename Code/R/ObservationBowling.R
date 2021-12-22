#This is a framework for analysis of the clusters. Intersection of various categories across different formats is done by means of this script
library(cluster)
library(ggplot2)
#Function takes filename as arg and passes dataset through kmeans, K=4
make_clus <- function(fname){
  pf <- read.csv(fname)
  pf$Best_Bowling <- NULL  #Removing unnecessary fields
  pf$X5_Wicket_Hauls <- NULL
  pf$X10_Wicket_Hauls <- NULL
  pf <- na.omit(pf)
  names <- pf[1]  #Storing names separately
  pf$Name <- NULL
  pf <- data.frame(lapply(pf, as.numeric))
  
  clusters <- kmeans(pf,4)
  
  clusters$cluster <- as.factor(clusters$cluster)
  out <- cbind(pf,clusterNum = clusters$cluster)
  final <- cbind(names,out) #Put names and clusterNumbers back in and return dataframe.
  
  return(final)
}

testclus <- make_clus("testcareerbowling.csv")

twentyclus <- make_clus("twenty20careerbowling.csv")

odiclus <- make_clus("odicareerbowling.csv")

# test : 4,1
# T20 : 2,1
# ODI : 2,3
ggplot(testclus, aes(testclus$clusterNum, testclus$Balls, color = testclus$cluster)) + geom_point()
ggplot(twentyclus,aes(twentyclus$clusterNum,twentyclus$Balls, color = twentyclus$cluster)) + geom_point()
ggplot(odiclus,aes(odiclus$clusterNum,odiclus$Balls, color = odiclus$cluster)) + geom_point()


#Getting the top two clusters of each format
tbest <- subset(testclus,testclus$clusterNum==4)
tgood <- subset(testclus,testclus$clusterNum==1)

t20best <- subset(twentyclus,twentyclus$clusterNum==2)
t20good <- subset(twentyclus,twentyclus$clusterNum==1)

obest <- subset(odiclus,odiclus$clusterNum==2)
ogood <- subset(odiclus,odiclus$clusterNum==3)

#Merging the top two clusters
testcore <- rbind(tbest,tgood)
testcore$clusterNum = NULL

t20core <- rbind(t20best,t20good)
t20core$clusterNum = NULL

odicore <- rbind(obest,ogood)
odicore$clusterNum = NULL

testandodicore <- rbind(testcore,odicore)
testandt20core <- rbind(testcore,t20core)
odiandt20core <- rbind(odicore,t20core)

setwd("/home/admin-pc/KANOE/Final_Scrape/Bowling/Clusters/T20/")

x = intersect(t20Best$Name,testBest$Name)

write.csv(x,"T20andTest.csv")
