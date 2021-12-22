#This script works in tandem with ratingsmodify.py
#Used to fix non-uniform names across files.
import os


files =["2007odibattingrating.csv","2007odibowlingrating.csv","2007testbattingrating.csv",
"2007testbowlingrating.csv","2008odibattingrating.csv","2008odibowlingrating.csv",
"2008testbattingrating.csv","2008testbowlingrating.csv","2009odibattingrating.csv",
"2009odibowlingrating.csv","2009testbattingrating.csv","2009testbowlingrating.csv",
"2010odibattingrating.csv","2010odibowlingrating.csv","2010testbattingrating.csv",
"2010testbowlingrating.csv","2011odibattingrating.csv","2011odibowlingrating.csv",
"2011testbattingrating.csv","2011testbowlingrating.csv",
"2012odibattingrating.csv","2012odibowlingrating.csv","2012testbattingrating.csv",
"2012testbowlingrating.csv","2013odibattingrating.csv","2013odibowlingrating.csv",
"2013testbattingrating.csv","2013testbowlingrating.csv","2014odibattingrating.csv",
"2014odibowlingrating.csv","2014testbattingrating.csv","2014testbowlingrating.csv",
"2015odibattingrating.csv","2015odibowlingrating.csv","2015testbattingrating.csv",
"2015testbowlingrating.csv","2016odibattingrating.csv","2016odibowlingrating.csv",
"2016testbattingrating.csv","2016testbowlingrating.csv","adaptance_batsmen_mod.csv",
"adaptance_bowlers_mod.csv","domestict20careerbowlingrating_mod.csv","domestict20careerbattingrating_mod.csv",
"great_domestictwenty20_training_batsmen_mod.csv","great_odi_training_batsmen_mod.csv","great_test_training_batsmen_mod.csv",
"oditrainingbowlers_mod.csv","t20trainingbowlers_mod.csv","testtrainingbowlers_mod.csv"
]


for i in files:
	os.system("python3 ratingsmodify.py " + i)
	
	

