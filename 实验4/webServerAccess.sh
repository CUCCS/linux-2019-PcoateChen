#!/bin/bash
#analyse webserver access data in web_log.tsv
#pcoateChen


#help
showHelp(){
	echo "analyse webserver access data in web_log.tsv"
	echo "Usage: bash webServerAccess [option]"
	echo "-o :top 100 host and count"
	echo "-i :top 100 ip and count"
	echo "-u :top 100 url"
	echo "-r :response state code count and radio"
	echo "-s :4xx state code and top 10 url count"
	echo "-a :identified url top 100 host"
	echo "-h :help information" 
}
#top 100 host and count
top100_host(){
	awk '{a[$1]++;} END {for i in a}{print a[i],i;}' ./web_log.tsv | sort -t " " -k 1 -n -r | head -n 100
}

#top 100 ip and count
top100_ip(){
	awk -F '\t' '{a[$1]++} END {for(i in a) {print a[i],i;}}' ./web_log.tsv | egrep "[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}" | sort -nr -k1 | head -n 100
}

#top 100 url
top100_url(){
	awk -F '\t' '{a[$5]++} END {for(i in a) {print a[i],i;}}' ./web_log.tsv | sort -nr -k1 |head -n 100
}

#response state code count and radio
ResStateCodeCountAndRadio(){
	sed -e '1d' ./web_log.tsv | awk -F '\t' '{a[$6]++;b++} END {for(i in a) {print i,a[i],a[i]/b*100 "%"}}' | column -t
}

#4xx state code and top 10 url count
StateCodeAndTop10_Url(){
	sed -n '2, $ p' ./web_log.tsv | awk -F '\t' '{if($6~/^4+[0-9]*[0-9]$/) {a[$5]++}} END{for (i in a) {print i,a[i]}}' | sort -nr -k2 | head -n 10
}

#identified url top 100 host
top100_host_Url(){
	awk -F '\t' '{if($5=="'$1'") {a[$1]++}} END {for(c in a) {print a[c],c;}}' ./web_log.tsv |sort -nr -k1 |head -n 10
}

if [ "$1" == "" ]; then
	echo "'-h' to show help"
elif [ "$1" == "-h" ]; then
	showHelp
elif [ "$1" == "-o" ]; then
	top100_host
elif [ "$1" == "-i" ]; then
	top100_ip
elif [ "$1" == "-u" ]; then
	top100_url
elif [ "$1" == "-r" ]; then
	ResStateCodeCountAndRadio
elif [ "$1" == "-s" ]; then
	StateCodeAndTop10_Url
elif [ "$1" == "-a" ]; then
	top100_host_Url
fi
