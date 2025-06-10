# campus_bites

A project for Tech Elevate to expose student on mobile development

## Git setup  
git config --global user.name "Your Name"
git config --global user.email "your@email.com"

## Git first repository
git init
git add .
git commit -m "First commit"
git remote add origin https://github.com/username/repo.git
git push -u origin main

## Useful Git Command 

Command	Description

git clone [repo-url]	Downloads a repo
git status	Shows changed files
git add [file]	Stages changes
git commit -m "message"	Saves changes with a message
git push	Uploads changes to GitHub
git pull	Downloads latest changes
git branch [name]	Creates a new branch
git checkout [branch]	Switches to a branch
git merge [branch]	Merges a branch into current


## collaboration workflow 
git clone https://github.com/your-username/repo.git

git checkout -b feature-branch

git add .
git commit -m "Added new feature"

git push origin feature-branch

open a PR (pull Request) on Github to propose changes

## handling conflicts 
 view this video to lead merge conflict 
 https://www.youtube.com/watch?v=lz5OuKzvadQ

git add .
git commit -m "Fixed merge conflict"
git push

# campus_bites

A project for Tech Elevate to expose student on mobile development

## Git setup  
git config --global user.name "Your Name"
git config --global user.email "your@email.com"

## Git first repository ( using master branch to teach merging branch)
git init
git add .
git commit -m "First commit"

++first time ++
git remote add origin https://github.com/username/repo.git
++if using above++
git push -u origin master

++ else the normal push to main (not a good practice) ++

git push -u main



now we have added new branched named master, in order to merge with main branch 
git pull origin main
---> If there are merge conflicts, resolve them, then commit:
    git add .
    git commit -m "Merge remote main branch"

git checkout -b main
git merge master
git push -u origin main

++Deleting master branch (optional if you dont want branching and only using main) ++
git branch -d master       # Delete locally
git push origin --delete master  # Delete on GitHub

## Useful Git Command 

Command	Description

git clone [repo-url]	Downloads a repo
git status	Shows changed files
git add [file]	Stages changes
git commit -m "message"	Saves changes with a message
git push	Uploads changes to GitHub
git pull	Downloads latest changes
git branch [name]	Creates a new branch
git checkout [branch]	Switches to a branch
git merge [branch]	Merges a branch into current


## collaboration workflow 
git clone https://github.com/your-username/repo.git

git checkout -b feature-branch

git add .
git commit -m "Added new feature"

git push origin feature-branch

open a PR (pull Request) on Github to propose changes

## handling conflicts 
 view this video to lead merge conflict 
 https://www.youtube.com/watch?v=lz5OuKzvadQ

git add .
git commit -m "Fixed merge conflict"
git push
