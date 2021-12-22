#This script correlates the ratings difference between India and an opposition with the win/loss margin.
#It uses the developed formula to evaluate a player and then computes the average rating for a team.


great_odi <- read.csv("TrainingODIBatsmen.csv")
great_odi_bowling <- read.csv("TrainingODIBowlers.csv")

odi_runs_matches <- read.csv("ODI-Runs.csv")



i <- sapply(odi_runs_matches, is.factor)
odi_runs_matches[i] <- lapply(odi_runs_matches[i], as.character)
j <- sapply(odi_runs_matches, is.integer)
odi_runs_matches[j] <- lapply(odi_runs_matches[j], as.numeric)

#Keeping the margin within a 100 runs
odi_runs_matches <- subset(odi_runs_matches,odi_runs_matches$Runs > -100)
odi_runs_matches <- subset(odi_runs_matches,odi_runs_matches$Runs < 100)


#Excluding Bangladesh and Pakistan from the evaluation
odi_runs_matches <- subset(odi_runs_matches,odi_runs_matches$Against != "PAK")
odi_runs_matches <- subset(odi_runs_matches,odi_runs_matches$Against != "BAN")
#------------------------------------------/////------------------------------------------------#


getTestRatingBatting <- function(player,year)
{
  player = toString(player)
  battingRating <- read.csv(paste(year,"testbattingrating.csv",sep=''))
  r = battingRating[battingRating$Name==player,]
  if(nrow(r) == 0 )
  {
    year = as.character(as.numeric(year) + 1)
    if(year=="2017")
    {
      return(0.0)
    }
    return(getTestRatingBatting(player,year))
  }
  else
  {
    return (as.numeric(r$Rating))
  }
}


getTestRatingBowling <- function(player,year)
{
  player = toString(player)
  bowlingRating <- read.csv(paste(year,"testbowlingrating.csv",sep=''))
  r = bowlingRating[bowlingRating$Name==player,]
  if(nrow(r) == 0 )
  {
    year = as.character(as.numeric(year) + 1)
    if(year=="2017")
    {
      return(0.0)
    }
    
    return(getTestRatingBowling(player,year))
  }
  else
  {
    return (as.numeric(r$Rating))
  }
  
}


getOdiRatingBatting <- function(player,year)
{

  player = toString(player)
  battingRating <- read.csv(paste(year,"odibattingrating.csv",sep=''))
  r = battingRating[battingRating$Name == player,]
  if(nrow(r) == 0 )
  {
    year = as.character(as.numeric(year) + 1)
    if(year=="2017")
    {
      return(0.0)
    }
    
    return(getOdiRatingBatting(player,year))
  }
  else
  {
    return (as.numeric(r$Rating))
  }
  
  
}

getOdiRatingBowling <- function(player,year)
{
  

  player = toString(player)
  bowlingRating <- read.csv(paste(year,"odibowlingrating.csv",sep=''))
  r = bowlingRating[bowlingRating$Name == player,]
  if(nrow(r) == 0 )
  {
    year = as.character(as.numeric(year) + 1)
    if(year=="2017")
    {
      return(0.0)
    }
    
    return(getOdiRatingBowling(player,year))
  }
  else
  {
    return (as.numeric(r$Rating))
  }
  
    
}

getT20RatingBatting <- function(player,year)
{
  

  player = toString(player)
  battingRating <- read.csv(paste(year,"twenty20battingrating.csv",sep=''))
  r = battingRating[battingRating$Name==player,]
  
  if(nrow(r) == 0 )
  {
    year = as.character(as.numeric(year) + 1)
    if(year=="2017")
    {
      return(0.0)
    }
    
    return(getT20RatingBatting(player,year))
  }
  else
  {
    
    return(as.numeric(as.character(r$Rating)))
  }
  
}

getT20RatingBowling <- function(player,year)
{
  bowlingRating <- read.csv(paste(year,"twenty20bowlingrating.csv",sep=''))

  player = toString(player)
  
  r = bowlingRating[bowlingRating$Name==player,]
  
  #print(r)
  
  if(nrow(r) == 0 )
  {
    year = as.character(as.numeric(year) + 1)
    if(year=="2017")
    {
      return(0.0)
    }
    
    return(getT20RatingBowling(player,year))
  }
  else
  {
    
    return(as.numeric(as.character(r$Rating)))
  }
  
}


getAdaptance <- function(player,cricketFormat)
{
  #use argument to fetch appropriate value
  
  #Hard coding to ODI for now
  
  player = toString(player)
  adaptance_batsmen <- read.csv("adaptance_batsmen_mod.csv")
  adaptance_bowlers <- read.csv("adaptance_bowlers_mod.csv")
  
  r1 = adaptance_batsmen[adaptance_batsmen$Name==player,]
  r2 = adaptance_bowlers[adaptance_bowlers$Name==player,]
  print(r1)
  print(nrow(r1))
  if(nrow(r1)==0 && nrow(r2)==0)
  {
    return(as.numeric(0.0))
  }
  else if(nrow(r1) == 0)
  {
    return(as.numeric(r2$AdaptODI))
  }
  else if(nrow(r2) == 0)
  {
    return(as.numeric(r1$AdaptODI))
  }
  else
  {
    if(as.numeric(r1$AdaptODI) > as.numeric(r2$AdaptODI))
    {
      return(as.numeric(r1$AdaptODI))
    }
    else
    {
      return(as.numeric(r2$AdaptODI))
    }
  }
}

#This function computes the rating for the whole team, the team is passed as '-' separated string.
cumulativeRating <- function(players,year)
{

  #players <- tournament$Name
  players <- strsplit(as.character(players),split = "-")
  players <- players[[1]]
  
  
  total = 0.0
  
  for(p in players)
  {  
    
    tBatRating = getTestRatingBatting(p,year)
    tBowlRating = getTestRatingBowling(p,year)
    
    oBatRating = getOdiRatingBatting(p,year)
    oBowlRating = getOdiRatingBowling(p,year)
    
    t20BatRating = getT20RatingBatting(p,year)
    t20BowlRating = getT20RatingBowling(p,year)
    
    adaptance = getAdaptance(p,"ODI")
    
    oRating = max(oBatRating,oBowlRating)
    

    t20Rating = max(t20BatRating,t20BowlRating)
    tRating = max(tBatRating,tBowlRating)
    
    finalRating = 0.55*(oRating) + 0.4*(adaptance)*(t20Rating) +0.05*(adaptance)*(tRating)   
    total = total + finalRating
  }
  
  return(total/11.0)
}



#Loop through all matches and make appropriate function calls, and write the details into another dataframe called final
final <- data.frame()

for(i in 1:nrow(odi_runs_matches)){
  
  players <-odi_runs_matches[i,"Players"]
  opponents <- odi_runs_matches[i,"Opponents"]
  year <-odi_runs_matches[i,"Year"]
  runs <- odi_runs_matches[i,"Runs"]
  year <- as.character(year)
  
  avg_team_ratings <- as.numeric(cumulativeRating(players,year))
  opponent_avg_team_ratings <- as.numeric(cumulativeRating(opponents,year))
  
  better_rating = 0
  if(avg_team_ratings > opponent_avg_team_ratings)
  {
    better_rating = 1
  }
  
  diff = avg_team_ratings - opponent_avg_team_ratings

  temp = data.frame(avg_team_ratings,opponent_avg_team_ratings,diff,runs,better_rating)
  final = rbind(final,temp)
   
}
#Removal of these 4 outlier points results in a large boost in the correlation :
#final = final[final$runs!=-72,]
#final = final[final$runs!=-41,]
#final = final[final$runs!=-3,]
#final = final[-c(4),]

library(ggplot2)
ggplot(data=final,aes(x=final$runs,y=final$diff)) + geom_point() + geom_abline()
cor.test(final$runs,final$diff)
#View(final)
