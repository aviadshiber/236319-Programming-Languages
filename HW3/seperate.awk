#!/bin/awk -f
BEGIN {
# change the record separator from newline to %	
	RS="%";
# convert table
	convert="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
# question number
	question=1;
# answer set to A
	answer=1;
# last important line start character
	last="\\";
# mapping from EBCDIC to ASCII
	map["*"]="\\"
	map["+"]="N"
	map["-"]="`"
	}
{
	if ( substr($1,1,1) == map["*"]){
		if ( last == map["+"] || last == map["-"] ){
			answer=1;
			question++;
		}
		last=map["*"];
	}
	if ( substr($1,1,1) == map["-"]){
		answer++;
		last=map["-"];
	}
	if ( substr($1,1,1) == map["+"]){
		print question " " substr(convert,answer,1);
		last=map["+"];
	}
}