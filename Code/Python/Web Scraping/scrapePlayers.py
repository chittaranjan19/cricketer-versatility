'''
Problem Statement : "Performance Analysis Of IPL Players Across Multiple Cricketing Formats".

A python script that web scrapes a data set from www.cricketarchive.com based on the needs of the problem statement.

The data set consists of 16 .csv files with each file representing a different format of the game that a given player has possibly played. 

This program restricts the player pool to only those who have been a part of an IPL team at any point in their career and the data set has the statistics of these players across multiple formats they have played in.

The parameters include general cricket statistics respective of the format of the game like Runs, Wickets, Catches,Stumpings,100s, Strike Rate, Average etc (for both bowlers and batsmen). 

Note: Before a fresh scrape please run the writeheading.py script.



Before reading the program please make sure you have an understanding of the following:-

	1) An understanding of the format of the webpage generated by the urls present in the lists 'teams' and 'rcbkkr'. 
           The code is built after extensive understanding and pattern finding in the format of the webpages.

	2) An understanding of the python programming language.

	3) Basic understanding of the urllib.request and bs4 modules used.

'''

'''
Bug fixes to be done : 

	1. Deal with players who have played for multiple countries for a given format. Do not directly take the 2nd row of corresponding table, rather take the last row which is the overall record of both countries combined.

	2. A couple of anomalous cases of Under-19 T20 being played in South Africa. Since this format isn't very well known, only a handful of IPL players have taken part in it. Hence, we have chosen to discard this format assuming it won't provide any significant insight. The code must still deal with this (in the substring matching) where Under-19 T20 and T20 both match onto the same bucket resulting in duplicate entries.


Temporary fixes have been done by manually modifying the csv files for these anomalous cases.
'''
if __name__ == '__main__':
	from urllib.request import urlopen
	from bs4 import BeautifulSoup


	teams = [
	"http://cricketarchive.com/Archive/Teams/6/6927/Players.html",
	"http://cricketarchive.com/Archive/Teams/6/6934/Players.html",

	"http://cricketarchive.com/Archive/Teams/6/6933/Players.html",
	"http://cricketarchive.com/Archive/Teams/6/6931/Players.html",
	"http://cricketarchive.com/Archive/Teams/22/22793/Players.html",
	"http://cricketarchive.com/Archive/Teams/6/6928/Players.html",
	"http://cricketarchive.com/Archive/Teams/6/6931/Players.html",
	"http://cricketarchive.com/Archive/Teams/6/6929/Players.html",
	"http://cricketarchive.com/Archive/Teams/6/6932/Players.html",
	"http://cricketarchive.com/Archive/Teams/39/39398/Players.html",
	"http://cricketarchive.com/Archive/Teams/39/39397/Players.html",
	"http://cricketarchive.com/Archive/Teams/15/15056/Players.html",
	"http://cricketarchive.com/Archive/Teams/6/6930/Players.html",
	"http://cricketarchive.com/Archive/Teams/15/15055/Players.html"


	]		# List containing URL of IPL teams with their player pool information.



	rcbkkr = [
	"http://cricketarchive.com/Archive/Teams/6/6927/Players.html",
	"http://cricketarchive.com/Archive/Teams/6/6934/Players.html"
	]		# List containing URL of RCB and KKR with their player pool information. The two respective teams have a different player organisation pattern on the website and are hence in a seperate list.


	def checkPlayer(href):					#Required for filtering <a>s in a page
	
		if href.startswith("/Archive/Players"):
			return True
		return False


	def write_values(table,f):				# A function to write the appropriate data values onto the respective file considred.


		trs = table.find_all('tr')[2:]

		tds = trs[0].find_all('td')[1:]			# Slicing out the unwanted parameter.(Country(s)/Trophy/Overall)

		data = ""
		for td in tds: 

			if td.get_text() == "" :		# In case of a blank value, appending NA on the .csv file.
				data += "NA" + ','
			else:
				data += td.get_text()+','	# Getting the text/data value.

		f.write(data)					# Writing the scrapped out data value on the file.
		f.write('\n')

	def fill_table(table,filename,player_name):		# Filling the respective .csv file considered


		f = open(filename,'a')

		f.write(player_name + ',')			# Writing the player name onto the first .csv file which is the first parameter.


		write_values(table,f)				# A function to write the appropriate data values onto the respective file considred.


		f.close()


	scrapedPlayers = []					# A list keeping track of players whose data values in all the formats played are scraped.

	for teamlink in teams:


		if teamlink in rcbkkr:				# For RCB and KKR the page is further segmented into links sorted based on alphabets each representing the starting character of 
								# the player name. The following snippet takes care of this case.
			allPlayers = []
		
			for i in range(65,91):
				link = teamlink.replace(".html","") + "_" + chr(i) +".html"
				print(link)
				players = urlopen(link)
				soup = BeautifulSoup(players)
	
				allPlayers.extend(soup.find_all("a",attrs={"href":checkPlayer}))

		else:
			players = urlopen(teamlink)
			soup = BeautifulSoup(players)
		
			allPlayers = soup.find_all("a",attrs={"href":checkPlayer})  	# List of <a> which lead to each player's profile
	
	
		for playerTag in allPlayers:
			playerLink = "http://cricketarchive.com"+playerTag["href"]
	
			if playerLink in scrapedPlayers:				# Eliminate duplicate scraping in case a player has played for multiple franchises in his career.
				continue
			else :
				scrapedPlayers.append(playerLink)
		
			print(playerLink)
			playerProfile = urlopen(playerLink)
			playerSoup = BeautifulSoup(playerProfile)
			all_tables = playerSoup.find_all('table')

			if all_tables[0].find('table'):					# Slicing the unwanted tables based on web page format.If it has an image we discard 2 otherwise we discard 1.
				discard = 2
			else:
				discard = 1

		
			playerName = all_tables[discard-1].find_all('tr')[0].find_all('td')[1].get_text()	# Extracting player name. (Present in the first non discarded table present).
		
		
		
			for i in range(discard,len(all_tables)-1):			# Extracting format type based on table heading at consideration.
				eachFormat = all_tables[i]('b')[0]
				eachFormat = eachFormat.get_text().lower()
		
		
		
				if "batting" in eachFormat:				# The following snippet of code uses sub string matching on the extracted format type in order to select the appropriate .csv file.
			
					if eachFormat.startswith("first-class"):
						file_name = "first-classcareerbattingandfielding.csv"
					
					elif eachFormat.startswith("international twenty20") :
						file_name = "internationaltwenty20careerbattingandfielding.csv"
				
					elif eachFormat.startswith("list a"):
						file_name = "listacareerbattingandfielding.csv" 
				
					elif eachFormat.startswith("odi"):
						file_name = "odicareerbattingandfielding.csv"
				
					elif eachFormat.startswith("test"):
						file_name = "testcareerbattingandfielding.csv"
					
					elif eachFormat.startswith("twenty20"):
						file_name = "twenty20careerbattingandfielding.csv"
					
					elif eachFormat.startswith("under-19 test"):
						file_name = "under-19testcareerbattingandfielding.csv"
					
					elif eachFormat.startswith("under-19 odi"):
						file_name = "under-19odicareerbattingandfielding.csv"
			
			
				elif "bowling" in eachFormat:

					if eachFormat.startswith("first-class"):
						file_name = "first-classcareerbowling.csv"
					
					elif eachFormat.startswith("international twenty20") :
						file_name = "internationaltwenty20careerbowling.csv"
				
					elif eachFormat.startswith("list a"):
						file_name = "listacareerbowling.csv" 
				
					elif eachFormat.startswith("odi"):
						file_name = "odicareerbowling.csv"
				
					elif eachFormat.startswith("test"):
						file_name = "testcareerbowling.csv"
					
					elif eachFormat.startswith("twenty20"):
						file_name = "twenty20careerbowling.csv"
					
					elif eachFormat.startswith("under-19 test"):
						file_name = "under-19testcareerbowling.csv"
					
					elif eachFormat.startswith("under-19 odi"):
						file_name = "under-19odicareerbowling.csv"
			
				fill_table(all_tables[i],file_name,playerName)
			
			
