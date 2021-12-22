This project implements a better rating system for cricket players, based on their ability to adapt.

Pre-requisites to use this project:
- python3
- R/RStudio
- bs4 module (python)
- urllib module (python)
- ggplot2 library (R)



The directory structure :

+ DataSets
	+ ODI Matches
		- ODI-Runs.csv : Contains scraped match data of all matches played by India since 2007
		- odiRunsAway.csv : Only Away match data
		- odiRunsHome.csv : Only Home match data
	+ Player Ratings
		- Contains all ICC Ratings for Batting and Bowling (all three formats) from 2007 to 2016.
	+ Player Statistics
		- Contains every player's statistics for batting and bowling for all formats.
+ Code
	+ R
		- adapt.R : Computes adaptation factor for all players.
		- BattingClustering.R : Clusters the batsmen into different categories and classify each player based on clusters.
		- BowlingClustering.R : Clusters the bowlers into categories.
		- correlate.R : Computes average team rating and correlates that with the performance of the team.
		- ObservationBowling.R : Analyzes the bowling clusters and classifies bowlers.
	+ Python
		+ Web Scraping
			- ratingscrape.py : Scrapes ICC ODI Ratings for all years.
			- scrapeAway.py : Scrape Away matches of India since 2007.
			- scrapeHome.py : Scrape Home matches of India since 2007.
			- scrapePlayers.py : Scrape player statistics of all IPL Players.
			- writeheading.py : Creates files to be written into by scrapePlayers.py; Run before scrapePlayers.py
		+ Data Cleaning
			- clean.py : Minor modifications to data, not important.
			- filelist.py : Calls ratingsmodify.py on all rating files.
			- ratingsmodify.py : Changes names into a uniform format (with respect to initials)
+ Generated Data
	+ Adaptation
		- adaptance_batsmen_mod.csv : Adaptation values of all batsmen.
		- adaptance_bowlers_mod.csv : Adaptation values of all bowlers.
	+ Classifications
		- Contains list of 'good' batsmen and bowlers for each format.

- Project Report: Detailed write up of findings and results
