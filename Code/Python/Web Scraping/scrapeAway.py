from urllib.request import urlopen
from bs4 import BeautifulSoup
import os

#This script scrapes the ODI records of all matches India have played away from home.
#Minor changes to scrape home matches.

page = urlopen("http://howstat.com/cricket/Statistics/Series/SeriesListCountry_ODI.asp?A=IND&B=XXX&W=T#odis")
soup = BeautifulSoup(page)

odiWickets = open("odiWicketsAway.csv",'w') 	
odiRuns = open("odiRunsAway.csv",'w')

odiWickets.write("Year,Players,Wickets,Venue,Against,Opponents\n")
odiRuns.write("Year,Players,Runs,Venue,Against,Opponents\n")

def processResult(resultString):
	if "wicket" not in resultString and "run" not in resultString:
		return 0
			
	r = resultString.split()

	index = len(r)-2
	if "Duckworth" in resultString:
		index -= 1	
	if r[0] == "India":
		return int(r[3])
	else:
		return (-1*int(r[index]))
		




allLinks = soup.find_all("a",attrs={"class":"LinkNormal"})
tournamentLinks = {}

for a in allLinks:
	
	text = a.get_text().lstrip().rstrip()[:4]
	if int(text) in range(2007,2017):
		tournamentLinks["http://howstat.com/cricket/Statistics/Series/"+a['href']] = int(text)

matchLinks = {}
for tlink in tournamentLinks:
	tpage = urlopen(tlink)
	tsoup = BeautifulSoup(tpage)
	matches = tsoup.find_all("a",attrs={"class":"LinkNormal"})

	for l in matches:
		matchLinks["http://howstat.com/cricket/Statistics"+l['href'][2:]] = tournamentLinks[tlink]




for eachMatch in matchLinks:
	print(eachMatch)
	visited = []
	mpage = urlopen(eachMatch)
	msoup = BeautifulSoup(mpage)
	players = []
	opp = []
	temp = msoup.find_all("a",attrs={"class":"LinkOff"})
	for a in temp:
		if "PlayerID" in a['href']:
			playerLink = "http://howstat.com/cricket/Statistics" + a['href'][2:]
			if playerLink not in visited:
				visited.append(playerLink)
				ppage = urlopen(playerLink)
				psoup = BeautifulSoup(ppage)
				ptext = psoup.get_text()
				if "India" in ptext:		
					players.append(a.get_text().lstrip().rstrip())
				else:
					if "Australia" in ptext:
						oppTeam = "AUS"
					elif "Sri Lanka" in ptext:
						oppTeam = "SL"
					elif "South Africa" in ptext:
						oppTeam = "SA"
					elif "Pakistan" in ptext:
						oppTeam = "PAK"
					elif "West Indies" in ptext:
						oppTeam = "WI"
					elif "New Zealand" in ptext:
						oppTeam = "NZ"
					else :
						oppTeam = "NA"
					opp.append(a.get_text().lstrip().rstrip())	
	
	x = msoup.find_all("table")[6]
	x = x.find_all("td")
	for i in x:
		if "won by" in i.get_text():
			result = i.get_text().lstrip().rstrip()
			break
	val = processResult(result)
	players = "-".join(players)
	opp = "-".join(opp)
	year = matchLinks[eachMatch]
	place = "Away"
	if "wicket" in result:
		odiWickets.write(str(year)+","+players+","+str(val)+","+place+","+oppTeam+","+opp+"\n")
		
	elif "run" in result:
		odiRuns.write(str(year)+","+players+","+str(val)+","+place+","+oppTeam+","+opp+"\n")	

	print(year,players,val,place,oppTeam,opp)
	print("----------------\n")

odiRuns.close()
odiWickets.close()
