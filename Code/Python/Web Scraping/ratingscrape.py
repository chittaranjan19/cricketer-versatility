#This script scrapes the ICC Ratings for all formats for each year's July month. (From 2007 to 2016)
from urllib.request import urlopen
from bs4 import BeautifulSoup

def scrap_contents(url,file_name):

	ratings = urlopen(url)

	soup = BeautifulSoup(ratings)

	all_ratings = soup.find_all("td",{"class" : "top100rating"})

	all_names = soup.find_all("td",{"class" : "top100name"})

	#all_ranking = soup.find_all("td",{"class" : "top100id"})

	f = open(file_name,'w')

	f.write("Name,")
	f.write("Rating")
	f.write("\n")

	for i in range(0,100):

		#ranking = all_ranking[i].get_text()
		rating = all_ratings[i].get_text()
		name = all_names[i].get_text()
		#ranking = ranking + ","
		rating = rating + "\n"
		name = name + ","
		
		f.write(name)
		f.write(rating)

	
	f.close()

#starting_year = 2007

# test batsmen



for year in range(2007,2017):

	the_url = "http://www.relianceiccrankings.com/datespecific/test/?stattype=batting&day=01&month=07&year=" + str(year)
	the_file = str(year) + "testbattingrating.csv"
	scrap_contents(the_url,the_file)



# test bowlers



for year in range(2007,2017):

	the_url = "http://www.relianceiccrankings.com/datespecific/test/?stattype=bowling&day=01&month=07&year=" + str(year)
	the_file = str(year) + "testbowlingrating.csv"
	scrap_contents(the_url,the_file)



# odi batsmen



for year in range(2007,2017):

	the_url = "http://www.relianceiccrankings.com/datespecific/odi/?stattype=batting&day=01&month=07&year=" + str(year)
	the_file = str(year) + "odibattingrating.csv"
	scrap_contents(the_url,the_file)



# odi bowlers




for year in range(2007,2017):

	the_url = "http://www.relianceiccrankings.com/datespecific/odi/?stattype=bowling&day=01&month=07&year=" + str(year)
	the_file = str(year) + "odibowlingrating.csv"
	scrap_contents(the_url,the_file)



# twenty20 batsmen

'''

for year in range(2007,2017):

	the_url = "http://www.relianceiccrankings.com/datespecific/t20/?stattype=batting&day=01&month=07&year=" + str(year)
	the_file = str(year) + "twenty20battingrating.csv"
	scrap_contents(the_url,the_file)



# twenty20 bowlers



for year in range(2007,2017):

	the_url = "http://www.relianceiccrankings.com/datespecific/t20/?stattype=bowling&day=01&month=07&year=" + str(year)
	the_file = str(year) + "twenty20bowlingrating.csv"
	scrap_contents(the_url,the_file)

'''


