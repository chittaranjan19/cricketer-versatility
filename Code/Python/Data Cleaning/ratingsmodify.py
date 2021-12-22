#List of names that are non-uniform. This script modifies those names.
import sys

replacements = {

	#"." : " "

	#"  " : " "

	"D P M D Jayawardene" : "D P M Jayawardene",

	"D P M d s Jayawardene" : "D P M Jayawardene",

	"D P M d S Jayawardene" : "D P M Jayawardene",
	
	"Younus Khan" : "Younis Khan",

	"L R P L Taylor" : "L R Taylor",

	"D J Bravo" : "D J J Bravo",

	"K D Karthik" : "K K D Karthik",

	"W P U J C Vaas" : "W P U Vaas",

	"M Muralidaran" : "M Muralitharan",

	"H M R K B Herath" : "H M R Herath",

	"K M D N Kulasekara" : "K M D Kulasekara",

	"Misbah-ul-Haq" : "Misbah ul Haq",

	"J-P Duminy" : "J P Duminy",

	"Inzamam-ul-haq" : "Inzamam ul haq",

	"Naved-ul-Hasan" : "Naved ul Hasan",

	"U W M B C Welegedara" : "U W M Welegedara",

	"S M Warnapura" : "B S M Warnapura",

	"K T G D Prasad" : "K T G Prasad",

	"H D R L Thirimanne" : "H D R Thirimanne",

	"N L T C Perera" : "N L T Perera",

	"S M S K Afridi" : "Shahid Afridi",

	"H Singh" : "Harbhajan Singh",

	"U Gul" : "Umar Gul",

	"M I Tahir" : "Imran Tahir",

	"M Hafeez" : "Mohammad Hafeez",

	"R V Kumar" : "R Vinay Kumar",

	"R E v d Merwe" : "R E van der Merwe",

	"P S Singh" : "P Kumar",

	"Z Khan" : "Zaheer Khan",

	"S Malik" : "Shoaib Malik",

	"B K Singh" : "B Kumar",

	"S M S M Senanayake" : "S M S Senanayake",

	"N M Coulter-Nile" : "N M Coulter Nile",

	"Y Singh" : "Yuvraj Singh",

	"J Duminy" : "J P Duminy",

	"M Shami" : "Mohammed Shami",

	"F d Plessis" : "F du Plessis",

	"S Akhtar" : "Shoaib Akhtar",

	"B Sran" : "B B Sran",

	"Virat Kohli" : "V Kohli",

	"S Butt" : "Salman Butt",

	"S L M Swarnajith" : "S L Malinga",

	"A B d Villiers" : "A B de Villiers"

}

lines = []


modify_file = sys.argv[1]

with open(modify_file) as infile:
	for line in infile:
		for src, target in replacements.items():
		    	line = line.replace(src, target)
		lines.append(line)

with open(modify_file, "w") as outfile:
	for line in lines:
		outfile.write(line)


