#This script clusters batsmen and then analyses those clusters for intersection of different categories across formats.

make_clusters <- function(the_file_name){
  
  # Reading the filename which has statistics of IPL batsmen in a particular format
  
  batting_stats <- read.csv(the_file_name)
  
  # The machine learning is applied purely on batting skills and hence eliminating the stumpings
  
  batting_stats$Stumpings <- NULL
  
  # Removing all records with NA values
  
  batting_stats <- na.omit(batting_stats)
  
  # The K means accepts only a numerical data frame hence storing names seperately for binding post clustering
  
  Name <- batting_stats$Name
  
  # Slicing out names and catches taken
  
  batting_stats_cleaned <- batting_stats[2:10]
  
  # Converting the entire data frame to numeric type before clustering
  
  batting_stats_cleaned <- data.frame(lapply(batting_stats_cleaned, as.numeric))
  
  # Passing the data frame for k means clustering
  
  clusters <- kmeans(batting_stats_cleaned,5)
  
  # Storing the cluster object in a meaningful variable
  
  batting_clusters <- clusters
  
  library(cluster)
  library(ggplot2)
  
  # Plots clusters based on the 2 most influential cluster. ( Not necessary )
  
  clusplot(batting_stats_cleaned, batting_clusters$cluster, color=TRUE, shade=TRUE,
           labels=2, lines=0)
  
  # Storing all the cluster numbers as factors
  
  batting_clusters$cluster <- as.factor(batting_clusters$cluster)
  
  # A plot to analyse influence on innings and runs with respect to each cluster
  
  ggplot(batting_stats_cleaned, aes(Innings, Runs, color = batting_clusters$cluster)) + geom_point()
  
  # Binding the cluster numbers to the numerical data frame passed
  
  binded_cluster <- cbind(batting_stats_cleaned,clusterNum = batting_clusters$cluster)
  
  # Binding the names(Stored previously) to the data frame

  final_clusters <- cbind(Name,binded_cluster)
  
  # A plot denoting the influence of runs on each cluster

  ggplot(final_clusters, aes(final_clusters$clusterNum, final_clusters$Runs, color = batting_clusters$cluster)) + geom_point()
  
  # Saving the plot for analysis necessary for determining the training set
  
  ggsave(paste(the_file_name,".jpg"))
  
  # Some plots denoting influence of some batting variable on the cluster
  

  #ggplot(final_clusters, aes(final_clusters$clusterNum, final_clusters$Average, color = international_odi_batting_clusters$cluster)) + geom_point()
  #ggplot(final_clusters, aes(final_clusters$clusterNum, final_clusters$High_Score, color = international_odi_batting_clusters$cluster)) + geom_point()
  #ggplot(final_clusters, aes(final_clusters$clusterNum, final_clusters$Matches, color = international_odi_batting_clusters$cluster)) + geom_point()
  #ggplot(final_clusters, aes(final_clusters$clusterNum, final_clusters$No_Of_50, color = international_odi_batting_clusters$cluster)) + geom_point()
  #ggplot(final_clusters, aes(final_clusters$clusterNum, final_clusters$Strike_Rate, color = international_odi_batting_clusters$cluster)) + geom_point()
  
  return(final_clusters)
  
}

#---------------------------------------------------------------Test analysis-------------------------------------------

test_clusters <- make_clusters("testcareerbattingandfielding.csv")

test_cluster_1 <- subset(test_clusters,test_clusters$clusterNum==1)
test_cluster_2 <- subset(test_clusters,test_clusters$clusterNum==2)
test_cluster_3 <- subset(test_clusters,test_clusters$clusterNum==3)
test_cluster_4 <- subset(test_clusters,test_clusters$clusterNum==4)
test_cluster_5 <- subset(test_clusters,test_clusters$clusterNum==5)

ggplot(test_clusters, aes(test_clusters$clusterNum, test_clusters$Runs, color = test_clusters$cluster)) + geom_point()

write.csv(test_cluster_1,file = "test_batsmen_legends.csv")

write.csv(test_cluster_2,file = "test_batsmen_semi_legends.csv")

write.csv(test_cluster_4,file = "test_batsmen_excellent.csv")

write.csv(test_cluster_5,file = "test_batsmen_good.csv")

write.csv(test_cluster_3,file = "test_batsmen_average.csv")

great_test_training_batsmen <- rbind(test_cluster_1,test_cluster_2)

write.csv(great_test_training_batsmen,file = "great_test_training_batsmen.csv")

good_test_training_batsmen <- rbind(test_cluster_4,test_cluster_5)

write.csv(good_test_training_batsmen,file = "good_test_training_batsmen.csv")

write.csv(test_cluster_3,file = "average_test_training_batsmen.csv")


View(good_test_training_batsmen)
View(great_test_training_batsmen)
View(test_cluster_3)

View(test_cluster_1)
View(test_cluster_2)
View(test_cluster_3)
View(test_cluster_4)
View(test_cluster_5)

#-----------------------------------------ODI analysis------------------------------------------


odi_clusters <- make_clusters("odicareerbattingandfielding.csv")


odi_cluster_1 <- subset(odi_clusters,odi_clusters$clusterNum==1)
odi_cluster_2 <- subset(odi_clusters,odi_clusters$clusterNum==2)
odi_cluster_3 <- subset(odi_clusters,odi_clusters$clusterNum==3)
odi_cluster_4 <- subset(odi_clusters,odi_clusters$clusterNum==4)
odi_cluster_5 <- subset(odi_clusters,odi_clusters$clusterNum==5)

ggplot(odi_clusters, aes(odi_clusters$clusterNum, odi_clusters$Runs, color = odi_clusters$cluster)) + geom_point()

View(odi_cluster_5)

write.csv(odi_cluster_1,file = "odi_batsmen_legends.csv")

write.csv(odi_cluster_4,file = "odi_batsmen_semi_legends.csv")

write.csv(odi_cluster_3,file = "odi_batsmen_excellent.csv")

write.csv(odi_cluster_5,file = "odi_batsmen_good.csv")

write.csv(odi_cluster_2,file = "odi_batsmen_average.csv")

great_odi_training_batsmen <- rbind(odi_cluster_1,odi_cluster_4)

write.csv(great_odi_training_batsmen,file = "great_odi_training_batsmen.csv")

good_odi_training_batsmen <- rbind(odi_cluster_3,odi_cluster_5)

write.csv(good_odi_training_batsmen,file = "good_odi_training_batsmen.csv")


write.csv(odi_cluster_2,file = "average_odi_training_batsmen.csv")

View(odi_cluster_1)
View(odi_cluster_2)
View(odi_cluster_3)
View(odi_cluster_4)
View(odi_cluster_5)
#?str()
#?merge()

#test_and_odi <- merge(test_cluster_1, odi_cluster_5,by=c("Name"))

#legend <- merge(test_and_odi,it20_cluster_4,by = c("Name"))

#get_name <- legend[1:1]

#View(get_name)

#View(test_and_odi)

#list.files()

#-------------------------------------------International twenty 20 analysis--------------

internationaltwenty_clusters <- make_clusters("internationaltwenty20careerbattingandfielding.csv")

it20_cluster_1 <- subset(internationaltwenty_clusters,internationaltwenty_clusters$clusterNum==1)
it20_cluster_2 <- subset(internationaltwenty_clusters,internationaltwenty_clusters$clusterNum==2)
it20_cluster_3 <- subset(internationaltwenty_clusters,internationaltwenty_clusters$clusterNum==3)
it20_cluster_4 <- subset(internationaltwenty_clusters,internationaltwenty_clusters$clusterNum==4)
it20_cluster_5 <- subset(internationaltwenty_clusters,internationaltwenty_clusters$clusterNum==5)

View(it20_cluster_5)
View(it20_cluster_4)
View(it20_cluster_3)
View(it20_cluster_2)
View(it20_cluster_1)

ggplot(internationaltwenty_clusters, aes(internationaltwenty_clusters$clusterNum, internationaltwenty_clusters$Runs, color = internationaltwenty_clusters$cluster)) + geom_point()

write.csv(it20_cluster_1,file = "internationaltwenty20_batsmen_legends.csv")

write.csv(it20_cluster_5,file = "internationaltwenty20_batsmen_semi_legends.csv")

write.csv(it20_cluster_4,file = "internationaltwenty20_batsmen_excellent.csv")

write.csv(it20_cluster_3,file = "internationaltwenty20_batsmen_good.csv")

write.csv(it20_cluster_2,file = "internationaltwenty20_batsmen_average.csv")

great_it20_training_batsmen <- rbind(it20_cluster_1,it20_cluster_5)

write.csv(great_it20_training_batsmen,file = "great_internationaltwenty20_training_batsmen.csv")

good_it20_training_batsmen <- rbind(it20_cluster_2,it20_cluster_3)

write.csv(good_it20_training_batsmen,file = "good_internationaltwenty20_training_batsmen.csv")

write.csv(it20_cluster_4,file = "average_internationaltwenty20_training_batsmen.csv")

#------------------------Domestic twenty20 analysis--------------------------------------------

twenty_clusters <- make_clusters("twenty20careerbattingandfielding.csv")

t20_cluster_1 <- subset(twenty_clusters,twenty_clusters$clusterNum==1)
t20_cluster_2 <- subset(twenty_clusters,twenty_clusters$clusterNum==2)
t20_cluster_3 <- subset(twenty_clusters,twenty_clusters$clusterNum==3)
t20_cluster_4 <- subset(twenty_clusters,twenty_clusters$clusterNum==4)
t20_cluster_5 <- subset(twenty_clusters,twenty_clusters$clusterNum==5)

ggplot(twenty_clusters, aes(twenty_clusters$clusterNum, twenty_clusters$Runs, color = twenty_clusters$cluster)) + geom_point()

write.csv(t20_cluster_3,file = "twenty20_batsmen_legends.csv")

write.csv(t20_cluster_4,file = "twenty20_batsmen_semi_legends.csv")

write.csv(t20_cluster_5,file = "twenty20_batsmen_excellent.csv")

write.csv(t20_cluster_2,file = "twenty20_batsmen_good.csv")

write.csv(t20_cluster_1,file = "twenty20_batsmen_average.csv")

great_dt20_training_batsmen <- rbind(t20_cluster_3,t20_cluster_4)

write.csv(great_dt20_training_batsmen,file = "great_domestictwenty20_training_batsmen.csv")

good_dt20_training_batsmen <- rbind(t20_cluster_2,t20_cluster_5)

write.csv(good_dt20_training_batsmen,file = "good_domestictwenty20_training_batsmen.csv")

write.csv(t20_cluster_1,file = "average_domestictwenty20_training_batsmen.csv")

View(t20_cluster_2)

#-----------------------------------------------------------------------------------------------------------

#----------------CLASSIFICATIONS------------------------------------------------

#-------------Legends----------------

#-----Test Based----

test_and_odi_legends <- merge(test_cluster_1, odi_cluster_1,by=c("Name"))

View(test_and_odi_legends)

write.csv(test_and_odi_legends,file = "test_and_odi_legends.csv")

test_and_it20_legends <- merge(test_cluster_1, it20_cluster_1,by=c("Name"))

View(test_and_it20_legends)

write.csv(test_and_it20_legends,file = "test_and_it20_legends.csv")

test_and_dt20_legends <- merge(test_cluster_1, t20_cluster_3,by=c("Name"))

View(test_and_dt20_legends)

write.csv(test_and_dt20_legends,file = "test_and_dt20_legends.csv")

#------ ODI based----

odi_and_it20_legends <- merge(odi_cluster_1, it20_cluster_1,by=c("Name"))

View(odi_and_it20_legends)

write.csv(odi_and_it20_legends,file = "odi_and_it20_legends.csv")

odi_and_dt20_legends <- merge(t20_cluster_3, odi_cluster_1,by=c("Name"))

View(odi_and_dt20_legends)

write.csv(odi_and_dt20_legends,file = "odi_and_dt20_legends.csv")

#---- Twenty20 based---

it20_and_dt20_legends <- merge(t20_cluster_3, it20_cluster_1,by=c("Name"))

View(it20_and_dt20_legends)

write.csv(it20_and_dt20_legends,file = "it20_and_dt20_legends.csv")

#----------------------------------------------------------------------------------

# 3 format kings -------------------------------

# Shorter format kings

limited_over_legends <- merge(it20_and_dt20_legends, odi_cluster_1,by=c("Name"))

View(limited_over_legends)

write.csv(limited_over_legends,file = "odi_and_it20_and_dt20_legends.csv")

# Test and twenty20s

test_and_twenty20 <- merge(it20_and_dt20_legends, test_cluster_1,by=c("Name"))

View(test_and_twenty20)

write.csv(test_and_twenty20,file = "test_and_it20_and_dt20_legends.csv")

# International kings

test_odi_and_it20 <- merge(test_and_odi_legends,it20_cluster_1,by = c("Name"))

write.csv(test_odi_and_it20,file = "test_odi_it20_legends.csv")

# Test odi and domestic twenty20

test_odi_and_dt20 <- merge(test_and_odi_legends,t20_cluster_3,by = c("Name"))

write.csv(test_odi_and_dt20,file = "test_odi_dt20_legends.csv")

# Ultimate Legend

ultimate_legend <- merge(test_odi_and_dt20,it20_cluster_1,by = c("Name"))

write.csv(ultimate_legend,file = "ultimate_legend.csv")

#-----------------------------------------------------------------------------------

#--------------------------------------------------------------------------

#--------------- Exceptional Players---------------------------------------------------

# ------------- Two Formats---------

# Test and ODI---

exceptional_test_and_odi <- merge(great_test_training_batsmen,great_odi_training_batsmen,by = c("Name"))
View(exceptional_test_and_odi)
write.csv(exceptional_test_and_odi,file = "exceptional_test_and_odi.csv")

# Test and international twenty20------------------------

exceptional_test_and_it20 <- merge(great_test_training_batsmen,great_it20_training_batsmen,by = c("Name"))
View(exceptional_test_and_it20)
write.csv(exceptional_test_and_it20,file = "exceptional_test_and_internationaltwenty20.csv")

# Test and domestic twenty20------------------------

exceptional_test_and_dt20 <- merge(great_test_training_batsmen,great_dt20_training_batsmen,by = c("Name"))
View(exceptional_test_and_dt20)
write.csv(exceptional_test_and_dt20,file = "exceptional_test_and_domestictwenty20.csv")

# ODI and international twenty20 -----------

exceptional_odi_and_it20 <- merge(great_odi_training_batsmen,great_it20_training_batsmen,by = c("Name"))
View(exceptional_odi_and_it20)
write.csv(exceptional_odi_and_it20,file = "exceptional_odi_and_internationaltwenty20.csv")

# ODI and Domestic twenty20 -----------

exceptional_odi_and_dt20 <- merge(great_odi_training_batsmen,great_dt20_training_batsmen,by = c("Name"))
View(exceptional_odi_and_dt20)
write.csv(exceptional_odi_and_dt20,file = "exceptional_odi_and_domestictwenty20.csv")

# International twenty20 and Domestic twenty20 -----------

exceptional_it20_and_dt20 <- merge(great_it20_training_batsmen,great_dt20_training_batsmen,by = c("Name"))
View(exceptional_it20_and_dt20)
write.csv(exceptional_it20_and_dt20,file = "exceptional_internationaltwenty20_and_domestictwenty20.csv")

#---------------- Three Format ------------------------------------------------------------------------------

# Odi and the twenty20s

exceptional_odi_and_it20_and_dt20 <- merge(exceptional_it20_and_dt20,great_odi_training_batsmen,by = c("Name"))
View(exceptional_odi_and_it20_and_dt20)
write.csv(exceptional_odi_and_it20_and_dt20,file = "exceptional_odi_internationaltwenty20_and_domestictwenty20.csv")

# Test and the twenty20s

exceptional_test_and_it20_and_dt20 <- merge(exceptional_it20_and_dt20,great_test_training_batsmen,by = c("Name"))
View(exceptional_test_and_it20_and_dt20)
write.csv(exceptional_test_and_it20_and_dt20,file = "exceptional_test_internationaltwenty20_and_domestictwenty20.csv")

# Test,Odi and International Twenty20

exceptional_test_and_odi_and_it20 <- merge(exceptional_test_and_odi,great_it20_training_batsmen,by = c("Name"))
View(exceptional_test_and_odi_and_it20)
write.csv(exceptional_test_and_odi_and_it20,file = "exceptional_test_and_odi_internationaltwenty20.csv")

# Test,Odi and Domestic Twenty20

exceptional_test_and_odi_and_dt20 <- merge(exceptional_test_and_odi,great_dt20_training_batsmen,by = c("Name"))
View(exceptional_test_and_odi_and_dt20)
write.csv(exceptional_test_and_odi_and_dt20,file = "exceptional_test_and_odi_domestictwenty20.csv")

#----------- Ultimate Legend----------------------------------

exceptional_boss <- merge(exceptional_test_and_odi_and_it20,great_dt20_training_batsmen,by = c("Name"))
View(exceptional_boss)
write.csv(exceptional_boss,file = "exceptional_test_and_odi_domestictwenty20_and_internationaltwenty20.csv")

#---------------------------- Single Format Kings------------------------------------------

?setdiff()
#---- Test and not odi ---

test_and_not_odi <- setdiff(great_test_training_batsmen$Name,great_odi_training_batsmen$Name)
write.csv(test_and_not_odi,"test_not_odi.csv")

#---- Odi and not tests ----

odi_and_not_test <- setdiff(great_odi_training_batsmen$Name,great_test_training_batsmen$Name)
write.csv(odi_and_not_test,"odi_not_test.csv")

# --- Test and not international twenty 20 -----

test_not_internationaltwenty20 <- setdiff(great_test_training_batsmen$Name,great_it20_training_batsmen$Name)
write.csv(test_not_internationaltwenty20,"test_not_internationaltwenty20.csv")

#---- International twenty 20 and not test---

internationaltwenty20_not_test <- setdiff(great_it20_training_batsmen$Name,great_test_training_batsmen$Name)

write.csv(internationaltwenty20_not_test,"internationaltwenty20_not_test.csv")

# --- Test and not domestic twenty 20 -----

test_not_domestictwenty20 <- setdiff(great_test_training_batsmen$Name,great_dt20_training_batsmen$Name)
View(test_not_domestictwenty20)
write.csv(test_not_domestictwenty20,"test_not_domestictwenty20.csv")

#---- Domestic twenty 20 and not test---

domestictwenty20_not_test <- setdiff(great_dt20_training_batsmen$Name,great_test_training_batsmen$Name)

domestictwenty20_not_test

write.csv(domestictwenty20_not_test,"domestictwenty20_not_test.csv")

#---- Odi and not internationaltwenty20 ----

odi_and_not_it20 <- setdiff(great_odi_training_batsmen$Name,great_it20_training_batsmen$Name)
View(odi_and_not_it20)
write.csv(odi_and_not_it20,"odi_not_internationaltwenty20.csv")

#--- International twenty 20 and not odi ---

it20_not_odi <- setdiff(great_it20_training_batsmen$Name,great_odi_training_batsmen$Name)
it20_not_odi
View(it20_not_odi)

write.csv(it20_not_odi,"internationaltwenty20_not_odi.csv")

#---- Odi and not domestictwenty20 ----

odi_and_not_dt20 <- setdiff(great_odi_training_batsmen$Name,great_dt20_training_batsmen$Name)
View(odi_and_not_dt20)
write.csv(odi_and_not_dt20,"odi_not_domestictwenty20.csv")

#--- Domestic twenty 20 and not odi ---

dt20_not_odi <- setdiff(great_dt20_training_batsmen$Name,great_odi_training_batsmen$Name)
dt20_not_odi

write.csv(dt20_not_odi,"domestictwenty20_not_odi.csv")

#--- Domestic twenty 20 and not internationaltwenty20 ---

dt20_not_it20 <- setdiff(great_dt20_training_batsmen$Name,great_it20_training_batsmen$Name)
dt20_not_it20
View(great_it20_training_batsmen)
write.csv(dt20_not_it20,"domestictwenty20_not_internationaltwenty20.csv")

#--- International twenty 20 and not domestic twenty20 ---

it20_not_dt20 <- setdiff(great_it20_training_batsmen$Name,great_dt20_training_batsmen$Name)
it20_not_dt20
write.csv(it20_not_dt20,"internationaltwenty20_not_domestictwenty20.csv")


# --------------------------- Three Format ----------------------------------

# Test and odi based

# Test odi and not international twenty20

test_odi_not_it20 <- setdiff(exceptional_test_and_odi$Name,great_it20_training_batsmen$Name)
write.csv(test_odi_not_it20,"test_and_odi_not_internationaltwenty20.csv")

# Test odi and not domestic twenty20

test_odi_not_dt20 <- setdiff(exceptional_test_and_odi$Name,great_dt20_training_batsmen$Name)
View(test_odi_not_dt20)
write.csv(test_odi_not_dt20,"test_and_odi_not_domestictwenty20.csv")

# International twenty20 and (not test and odi)

it20_not_odi_not_test <- setdiff(great_it20_training_batsmen$Name,exceptional_test_and_odi$Name)
it20_not_odi_not_test
write.csv(it20_not_odi_not_test,"Internationaltwenty20_not_odi_not_test.csv")

# Domestic twenty20 and (not test and odi)

dt20_not_odi_not_test <- setdiff(great_dt20_training_batsmen$Name,exceptional_test_and_odi$Name)
dt20_not_odi_not_test
write.csv(it20_not_odi_not_test,"Domestictwenty20_not_odi_not_test.csv")

# Test and international twenty20 not odi

test_it20_not_odi <- setdiff(exceptional_test_and_it20$Name,great_odi_training_batsmen$Name)
write.csv(test_it20_not_odi,"Test_InternationalTwenty20_not_odi.csv")
test_it20_not_odi

# Test and domestic twenty20 not odi

test_dt20_not_odi <- setdiff(exceptional_test_and_dt20$Name,great_odi_training_batsmen$Name)
write.csv(test_dt20_not_odi,"Test_DomesticTwenty20_not_odi.csv")
test_it20_not_odi

# Odi not (test and domestic twenty20)

odi_not_test_not_d20 <- setdiff(great_odi_training_batsmen$Name,exceptional_test_and_dt20$Name)
odi_not_test_not_d20

# Pure odi Speacialist-------------------------------------

odi_not_internationalt20 <- read.csv("odi_not_internationaltwenty20.csv")
View(odi_not_internationalt20)
odi_not_domestict20 <- read.csv("odi_not_domestictwenty20.csv")
View(odi_not_domestict20)
odi_not_test <- read.csv("odi_not_test.csv")
View(odi_not_test)
odi_without_domestic <- merge(odi_not_internationalt20,odi_not_test,by = "x")
View(odi_without_domestic)
write.csv(odi_without_domestic,"odi_specialist_without_domestic.csv")
?setdiff()
odi_not_twenty20 <- merge(odi_not_internationalt20,odi_not_domestict20,by = "x")
View(odi_not_twenty20)
pure_odi <- merge(odi_not_twenty20,odi_not_test,by ="x")
View(pure_odi)
write.csv(pure_odi,"odi_specialists.csv")


# Pure test specalist ---------------------

test_not_internationalt20 <- read.csv("test_not_internationaltwenty20.csv")
test_not_domestict20 <- read.csv("test_not_domestictwenty20.csv")
test_not_odi <- read.csv("test_not_odi.csv")
View(test_not_internationalt20)
View(test_not_domestict20)
test_not_twenty20 <- merge(test_not_internationalt20,test_not_domestict20,by = "x")
test_without_domestic <- merge(test_not_internationalt20,test_not_odi, by = "x")
write.csv(test_without_domestic,"test_specialist_without_domestic.csv")

View(test_without_domestic)
pure_test <- merge(test_not_twenty20,test_not_odi,by = "x")
View(pure_test)
write.csv(pure_test,"test_specialists.csv")

# Pure international twenty20----------------

internationalt20_not_test <- read.csv("internationaltwenty20_not_test.csv")
internationalt20_not_odi <- read.csv("internationaltwenty20_not_odi.csv")
internationalt20_not_d20 <- read.csv("internationaltwenty20_not_domestictwenty20.csv")
View(internationalt20_not_test)
View(internationalt20_not_odi)
internationalt20_not_bigger_formats <- merge(internationalt20_not_test,internationalt20_not_odi,by = "Name")
View(internationalt20_not_bigger_formats)
write.csv(internationalt20_not_bigger_formats,"i20_specialists_without_domestic.csv")
pure_it20 <- merge(internationalt20_not_bigger_formats,internationalt20_not_d20,by = "Name")
write.csv(pure_it20,"internationalt20_specialists.csv")
View(pure_it20)

# Pure domestic twenty 20 ------------------------------------

domestictwenty20_not_test <- read.csv("domestictwenty20_not_test.csv")
domestictwenty20_not_odi <- read.csv("domestictwenty20_not_odi.csv")
domestict20_not_i20 <- read.csv("domestictwenty20_not_internationaltwenty20.csv")

domestic_not_bigger_formats <- merge(domestictwenty20_not_test,domestictwenty20_not_odi,by = "x")
View(domestic_not_bigger_formats)
pure_domestic <- merge(domestic_not_bigger_formats,domestict20_not_i20,by = "x")
View(pure_domestic)
write.csv(pure_domestic,"domestict20_specialists.csv")

?cor.test()
