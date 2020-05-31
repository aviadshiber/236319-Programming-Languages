#!/bin/bash

avgTime=0
sd=0
errors=0


for ((i=0; i < 30; i++)); do						#measuring 30 times
	start=$(date +%s%2N)							#save time before running command
	eval $* > /dev/null 2>errorOut					#run command, delete output and save errors output
	end=$(date +%s%2N)								#save end time
	let arr[i]=end-start							#save running time for instanse i
	let avgTime+=end-start							#increase total time (avgTime is total time at first)
	if [[ -n "$errorOut" ]]; then let errors++; fi	#if there were errors, then increase the number of Failures
done

let avgTime=avgTime/30								#average time is total time divided by all runs

### calculate sd ###

for ((i=0; i < 30; i++)); do	#for every run
    let x=arr[i]-avgTime		#subtruct avgTime from run time
	let x*=x					#square the quotient
	let sd+=x					#add to total sum
done

let sd=sd/30					#devide by number of instanses
sd=`echo "scale = 0; sqrt($sd)" | bc`	#take the square root of sum

####################

echo Command: $*
echo Times: 30
echo Failures: $errors

#print Average time#

if ((avgTime>=100)); then
	let printTime1=avgTime/100
	let printTime2=avgTime%100
	echo Average avgTime: $printTime1.$printTime2 sec
else if ((avgTime>=10)); then
		echo Average time: 0.$avgTime sec
	else
		echo Average time: 0.0$avgTime sec
	fi
fi

#####################
#print SD time#

if ((sd>=100)); then
	let printSD1=sd/100
	let printSD2=sd%100
	echo SD time: $printSD1.$printSD2 sec
else if ((sd>=10)); then
		echo SD time: 0.$sd sec
	else
		echo SD time: 0.0$sd sec
	fi
fi
##############