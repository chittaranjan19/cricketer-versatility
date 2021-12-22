#Replaces * with a space.
import fileinput
filesToSearch = [
	"first-classcareerbattingandfielding.csv",
	"internationaltwenty20careerbattingandfielding.csv",
	"listacareerbattingandfielding.csv",
	"odicareerbattingandfielding.csv",
	"testcareerbattingandfielding.csv",
	"twenty20careerbattingandfielding.csv",
	"under-19testcareerbattingandfielding.csv",
	"under-19odicareerbattingandfielding.csv"
	]
for fileToSearch in filesToSeach:	
	with fileinput.FileInput(fileToSearch, inplace=True, backup='.bak') as file:
	    for line in file:
		print(line.replace('*', ''), end='')
