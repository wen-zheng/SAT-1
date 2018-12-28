#!/bin/bash

# rm -rf ./src-dir/emoji-java/
# rm -rf ./dst-dir/emoji-java/

# cp -r ./emoji-java ./src-dir
# cp -r ./emoji-java ./dst-dir

rm -rf commitid
rm -rf taglist
rm -rf branchhistory
rm -rf bugfix
rm -rf commitlog

git log >> commitlog
git tag | tac >> taglist
git log --graph --decorate >> branchhistory

cat commitlog | grep '^commit' | awk '{print $2}' | tac >> commitid

git log --graph --decorate | grep -B 1 'Merge' | grep 'commit' | grep "[a-z0-9]" | awk '{print $2 " " $3}' > branchid

java -jar filterbugfixid-1.0-SNAPSHOT-jar-with-dependencies.jar branchid branchhistory | tac >>  bugfix

bash ./commitvariance.sh
bash ./versionvariance.sh
bash ./bugfixvariance.sh