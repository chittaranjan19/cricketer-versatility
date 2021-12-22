#This script generates the four clusters for the bowlers


library(cluster)
library(ggplot2)

# This function takes a filename as argument. The file contains the player statistics.
# The data-frame returned from the function has an added column for the cluster number.

make_clus <- function(fname){
  pf <- read.csv(fname)
  pf$Best_Bowling <- NULL
  pf$X5_Wicket_Hauls <- NULL
  pf$X10_Wicket_Hauls <- NULL
  pf <- na.omit(pf)
  names <- pf[1]
  pf$Name <- NULL
  pf <- data.frame(lapply(pf, as.numeric))
  
  clusters <- kmeans(pf,4)
  
  clusters$cluster <- as.factor(clusters$cluster)
  out <- cbind(pf,clusterNum = clusters$cluster)
  final <- cbind(names,out)

  return(final)
}
testclus <- make_clus("internationaltwenty20careerbowling.csv")


#Extract each cluster of players from the dataframe returned from make_clus
tcluster_1 <- subset(testclus,testclus$clusterNum==1)
tcluster_2 <- subset(testclus,testclus$clusterNum==2)
tcluster_3 <- subset(testclus,testclus$clusterNum==3)
tcluster_4 <- subset(testclus,testclus$clusterNum==4)


ggplot(testclus, aes(testclus$clusterNum, testclus$Balls, color = testclus$cluster)) + geom_point()

#Write the various clusters onto a file.

write.csv(tcluster_2,"it20averagebowlers.csv")
write.csv(tcluster_3,"it20goodbowlers.csv")

x = rbind(tcluster_4,tcluster_1)
write.csv(x,"it20bestbowlers.csv")
