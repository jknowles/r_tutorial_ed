library(knitr)
knit("Tutorial0_Overview.Rmd")
knit("Tutorial1_Intro.Rmd")
knit("Tutorial2_DataImport.Rmd")
knit("Tutorial3_DataSort.Rmd")
knit("Tutorial4_CleaningData.Rmd")
knit("Tutorial5_BasicAnalytics.Rmd")
knit("Tutorial6_Visualization.Rmd")
knit("Tutorial7_ExportingWork.Rmd")
knit("Tutorial8_AdvancedTopics.Rmd")


system("pandoc -s -S -i -t slidy Tutorial0_Overview.md -o Tutorial0_Overview.html --self-contained")
system("pandoc -s -S -i -t slidy Tutorial1_Intro.md -o Tutorial1_Intro.html --self-contained")
system("pandoc -s -S -i -t slidy Tutorial2_DataImport.md -o Tutorial2_DataImport.html --self-contained")
system("pandoc -s -S -i -t slidy Tutorial3_DataSort.md -o Tutorial3_DataSort.html --self-contained")
system("pandoc -s -S -i -t slidy Tutorial4_CleaningData.md -o Tutorial4_CleaningData.html --self-contained")
system("pandoc -s -S -i -t slidy Tutorial5_BasicAnalytics.md -o Tutorial5_BasicAnalytics.html --self-contained")
system("pandoc -s -S -i -t slidy Tutorial6_Visualization.md -o Tutorial6_Visualization.html --self-contained")
system("pandoc -s -S -i -t slidy Tutorial7_ExportingWork.md -o Tutorial7_ExportingWork.html --self-contained")
system("pandoc -s -S -i -t slidy Tutorial8_AdvancedTopics.md -o Tutorial8_AdvancedTopics.html --self-contained")


system("pandoc -s -S -t slidy rsetup.md -o RsetupforBootcamp.html --self-contained")



