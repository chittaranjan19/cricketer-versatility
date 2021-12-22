#This script creates files on the directory so that the player scraping script may write into them.

formatsBatting = [
	"first-classcareerbattingandfielding.csv",
	"internationaltwenty20careerbattingandfielding.csv",
	"listacareerbattingandfielding.csv",
	"odicareerbattingandfielding.csv",
	"testcareerbattingandfielding.csv",
	"twenty20careerbattingandfielding.csv",
	"under-19testcareerbattingandfielding.csv",
	"under-19odicareerbattingandfielding.csv"
	]					# All the batting files

formatsBowling = [
	"first-classcareerbowling.csv",
	"listacareerbowling.csv",
	"internationaltwenty20careerbowling.csv",
	"odicareerbowling.csv",
	"testcareerbowling.csv",
	"twenty20careerbowling.csv",
	"under-19testcareerbowling.csv",
	"under-19odicareerbowling.csv"
]						# All the bowling files


# Make entries of the column headings.

for oneFormat in formatsBatting:		
	f_1 = open(oneFormat,"w")

	f_1.write('Name' + ',')
	f_1.write('Matches' + ',')
	f_1.write('Innings' + ',')
	f_1.write('Not_Outs' + ',')
	f_1.write('Runs' + ',')
	f_1.write('High_Score' + ',')
	f_1.write('Average' + ',')
	f_1.write('No_Of_100' + ',')
	f_1.write('No_Of_50' + ',')
	f_1.write('Strike_Rate' + ',')
	f_1.write('Catches_Taken' + ',')
	f_1.write("Stumpings" + "\n")

	f_1.close()


for oneFormat in formatsBowling:
	g_1 = open(oneFormat,"w")

	g_1.write('Name' + ',')
	g_1.write('Balls' + ',')
	g_1.write('Maidens' + ',')
	g_1.write('Runs' + ',')
	g_1.write('Wickets' + ',')
	g_1.write('Best_Bowling' + ',')
	g_1.write('Average' + ',')
	g_1.write('5_Wicket_Hauls' + ',')
	g_1.write('10_Wicket_Hauls' + ',')
	g_1.write('Strike_Rate' + ',')
	g_1.write('Economy' + '\n')


