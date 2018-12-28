#!/bin/bash
my_array=();
a=0;
for line in $(cat taglist)
do
	my_array[$a]=$line
	let "a++"
done

rm -f versionvariance

b=1

while(($b < $a))
do
	cd ./src-dir/
	git checkout tags/${my_array[$b-1]} > /dev/null 2>&1
	cd ../

	cd ./dst-dir/
	git checkout tags/${my_array[$b]} > /dev/null 2>&1
	cd ../
	java -jar astcompare-0.1-jar-with-dependencies.jar ./src-dir ./dst-dir $b >> eachversionvariance

	
	let "b++"
done
