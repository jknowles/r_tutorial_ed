library(knitr)
knit("Tutorial0_Overview.Rmd")
knit("Tutorial1_Intro.Rmd")

system("pandoc -s -S -i -t slidy Tutorial0_Overview.md -o Tutorial0_Overview.html --self-contained")
system("pandoc -s -S -i -t slidy Tutorial1_Intro.md -o Tutorial1_Intro.html --self-contained")





