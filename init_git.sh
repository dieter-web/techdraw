#!/usr/bin/sh

git init
echo "dist-newstyle/" >> .gitignore
echo "*.hi"           >> .gitignore
echo "*.o"            >> .gitignore
echo "*.swp"          >> .gitignore
echo "*.svg"          >> .gitignore # optional 
