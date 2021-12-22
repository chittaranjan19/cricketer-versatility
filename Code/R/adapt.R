#This script calculates each player's adaptation factor by looking at the category he is in from previous results.

setwd("/home/admin-pc/KANOE/Final_Scrape/Bowling/Clusters/Test/")
list.files()
adapt = data.frame()
str(adapt)
adapt$Name = as.character(adapt$Name)
adapt$AdaptTest = as.numeric(adapt$AdaptTest)
adapt$AdaptODI = as.numeric(adapt$AdaptODI)
adapt$AdaptT20 = as.numeric(adapt$AdaptT20)
View(adapt)

tAve = read.csv("AverageTestBowlers.csv")
tGood = read.csv("GoodTestBowlers.csv")
tGreat = read.csv("BestTestBowlers.csv")

oAve = read.csv("AverageOdiBowlers.csv")
oGood = read.csv("GoodOdiBowlers.csv")
oGreat = read.csv("BestOdiBowlers.csv")

d20Ave = read.csv("AverageIT20Bowlers.csv")
d20Good = read.csv("GoodIT20Bowlers.csv")
d20Great = read.csv("BestIT20Bowlers.csv")

setwd("/home/admin-pc/KANOE/Final_Scrape/Bowling/")
list.files()
bowlers = read.csv("twenty20careerbowling.csv")
batters = read.csv("twenty20careerbattingandfielding.csv")
bowlName = bowlers[1]
batName = batters[1]

names2 = rbind(bowlName,batName)
names2 = unique(names2)


for (i in names2$Name)
{
  
  tcount = 0
  ocount = 0
  dcount = 0
  if(i %in% tGreat$Name)
  {
    tcount  = tcount + 3
  }
  else if(i %in% tGood$Name)
  {
    tcount = tcount + 2
  }
  else if(i %in% tAve$Name)
  {
    tcount  = tcount + 1
  }
  
  
  if(i %in% oGreat$Name)
  {
    ocount  = ocount + 3
  }
  else if(i %in% oGood$Name)
  {
    ocount = ocount + 2
  }
  else if(i %in% oAve$Name)
  {
    ocount  = ocount + 1
  }
  
  
  if(i %in% d20Great$Name)
  {
    dcount  = dcount + 3
  }
  else if(i %in% d20Good$Name)
  {
    dcount = dcount + 2
  }
  else if(i %in% d20Ave$Name)
  {
    dcount  = dcount + 1
  }
  
  testAdapt = (ocount+dcount)/6  
  odiAdapt = (tcount+dcount)/6
  t20Adapt =  (ocount+tcount)/6

  temp <- c(i,testAdapt,odiAdapt,t20Adapt)
  adapt[nrow(adapt)+1,] <- temp
}
write.csv(adapt,"adaptance_bowlers.csv")
