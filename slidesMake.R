# Load knitr library
# Knit all the Rmd files into Md files in plain markdown
# From markdown we can make the files what we want

library(knitr)
knit("rsetup.Rmd",envir=new.env())
knit("Tutorial0_Overview.Rmd",envir=new.env())
knit("Tutorial1_Intro.Rmd",envir=new.env())
knit("Tutorial2_DataImport.Rmd",envir=new.env())
knit("Tutorial3_DataSort.Rmd",envir=new.env())
knit("Tutorial4_CleaningData.Rmd",envir=new.env())
knit("Tutorial5_BasicAnalytics.Rmd",envir=new.env())
knit("Tutorial6_Visualization.Rmd",envir=new.env())
knit("Tutorial7_ExportingWork.Rmd",envir=new.env())
knit("Tutorial8_AdvancedTopics.Rmd",envir=new.env())
knit("TutorialX_StatisticsRefresher.Rmd",envir=new.env())
knit("TutorialXX_IntroToProgramming.Rmd",envir=new.env())

# We need pandoc installed
# This part allows pandoc to do the work of taking the md files
# and converting them into nice looking HTML5 slides

# Consider removing -S to avoid character problems

system("pandoc -s -t slidy rsetup.md -o RsetupforBootcamp.html --self-contained")
system("pandoc -s -t slidy Tutorial0_Overview.md -o Tutorial0_Overview.html --self-contained")
system("pandoc -s -t slidy Tutorial1_Intro.md -o Tutorial1_Intro.html --self-contained")
system("pandoc -s -t slidy Tutorial2_DataImport.md -o Tutorial2_DataImport.html --self-contained")
system("pandoc -s -i -t slidy Tutorial3_DataSort.md -o Tutorial3_DataSort.html --self-contained")
system("pandoc -s -i -t slidy Tutorial4_CleaningData.md -o Tutorial4_CleaningData.html --self-contained")
system("pandoc -s -i -t slidy Tutorial5_BasicAnalytics.md -o Tutorial5_BasicAnalytics.html --self-contained")
system("pandoc -s -i -t slidy Tutorial6_Visualization.md -o Tutorial6_Visualization.html --self-contained")
system("pandoc -s -i -t slidy Tutorial7_ExportingWork.md -o Tutorial7_ExportingWork.html --self-contained")
system("pandoc -s -i -t slidy Tutorial8_AdvancedTopics.md -o Tutorial8_AdvancedTopics.html --self-contained")
system("pandoc -s -i -S -t slidy TutorialX_StatisticsRefresher.md -o TutorialX_StatisticsRefresher.html --self-contained")
system("pandoc -s -S -t slidy TutorialXX_IntroToProgramming.md -o TutorialXX_IntroToProgramming.html --self-contained")



# Make a notes sheet by knitting to HTML, but not converting it to slides
# Store this in the "handouts" subdirectory

dir.create("handouts")
opts_knit$set(self.contained=TRUE)
knit2html("Tutorial0_Overview.Rmd",output="handouts/Tutorial0_handout.html",envir=new.env())
knit2html("Tutorial1_Intro.Rmd",output="handouts/Tutorial1_handout.html",envir=new.env())
knit2html("Tutorial2_DataImport.Rmd",output="handouts/Tutorial2_handout.html")
knit2html("Tutorial3_DataSort.Rmd",output="handouts/Tutorial3_handout.html")
knit2html("Tutorial4_CleaningData.Rmd",output="handouts/Tutorial4_handout.html")
knit2html("Tutorial5_BasicAnalytics.Rmd",output="handouts/Tutorial5_handout.html")
knit2html("Tutorial6_Visualization.Rmd",output="handouts/Tutorial6_handout.html")
knit2html("Tutorial7_ExportingWork.Rmd",output="handouts/Tutorial7_handout.html")
knit2html("Tutorial8_AdvancedTopics.Rmd",output="handouts/Tutorial8_handout.html")
knit2html("rsetup.Rmd",output="handouts/settingupR_handout.html",envir=new.env())
knit2html("TutorialX_StatisticsRefresher.Rmd",output="handouts/TutorialX_handout.html")

# PURL the Rmd files to extract the R code

dir.create("handouts/scripts")
purl("Tutorial0_Overview.Rmd",output="handouts/scripts/Tutorial0.R")
purl('Tutorial1_Intro.Rmd',output="handouts/scripts/Tutorial1.R")
purl("Tutorial2_DataImport.Rmd",output="handouts/scripts/Tutorial2.R")
purl("Tutorial3_DataSort.Rmd",output="handouts/scripts/Tutorial3.R")
purl("Tutorial4_CleaningData.Rmd",output="handouts/scripts/Tutorial4.R")
purl("Tutorial5_BasicAnalytics.Rmd",output="handouts/scripts/Tutorial5.R")
purl("Tutorial6_Visualization.Rmd",output="handouts/scripts/Tutorial6.R")
purl("Tutorial7_ExportingWork.Rmd",output="handouts/scripts/Tutorial7.R")
purl("Tutorial8_AdvancedTopics.Rmd",output="handouts/scripts/Tutorial8.R")
purl("rsetup.Rmd",output="handouts/scripts/settingupR.R")
purl("TutorialX_StatisticsRefresher.Rmd",output="handouts/scripts/TutorialX.R")


