#!/usr/bin/sh
echo "# techdraw" >> README.md
git init
echo "dist-newstyle/" >> .gitignore
echo "*.hi"           >> .gitignore
echo "*.o"            >> .gitignore
echo "*.swp"          >> .gitignore
echo "*.svg"          >> .gitignore # optional 

git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/dieter-web/techdraw.git
git push -u origin main



