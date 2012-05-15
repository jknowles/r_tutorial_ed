system("pandoc -s -S -i -t dzslides tutorialHTML.md -o test.html --self-contained")

system("pandoc -s -S -i -t slidy tutorialHTML.md -o RBootcampIntro.html --self-contained")



system("pandoc -s -S -i -t beamer tutorialHTML.md -o beamer.pdf")

