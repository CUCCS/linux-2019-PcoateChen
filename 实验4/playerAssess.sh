#!/bin/bash
#analyse the players info. in worldcupplayerinfo.tsv
#pcoateChen


#help
showHelp(){
	echo "analyse the players info. in worldcupplayerinfo.tsv"
	echo "Usage: bash playerAssess [option]"
	echo "-a :count number and radio of players in different range of age"
	echo "-p :count number adn radio of players in different position"
	echo "-n :find the player who has the longest name or shortest name"
	echo "-o :find the oldest and youngest player"
	echo "-h :help information" 
}
#count number and radio of players in different range of age
countAgeRangeNumAndRadio(){
	line_age = $(awk -F "\t" '{ print $6 }' worldcupplayerinfo.tsv)
	numAll = 0
	num_lower20 = 0
	num_between20_30 = 0
	num_higher30 = 0
	for i in $line_age
	do
		if [ "$i" != "Age" ]; then
			numAll = `expr $numAll +1`
			if [ $i -lt 20 ]; then
 				num_lower20 = `expr $num_lower20 +1`
			elif [ $i -gt 30 ]; then
				num_higher30 = `expr $num_higher30 +1`
			elif [ $i -ge 20 ] && [ $i -le 30 ]; then
				num_between20_30 = `expr $num_between20_30 +1`
			fi
		fi
	done
	percent_lower20 = `awk 'BEGIN{printf "%.3f\n",('${num_lower20}'/'$numAll')*100}'`
	percent_between20_30 = `awk 'BEGIN{printf "%.3f\n",('${num_between20_30}'/'$numAll')*100}'`
	percent_higher30 = `awk 'BEGIN{printf "%.3f\n",('${num_higher30}'/'$numAll')*100}'`
	
	echo "the total number of players is $numAll"
	echo "the number of lower 20 is $num_lower20,the percent is $percent_lower20"
	echo "the number of between 20 and 30 is $num_between20_30,the percent is $percent_between20_30"
	echo "the number of lower 20 is $num_higher30,the percent is $percent_higher30"
}

#count number adn radio of players in different position
countPositionNumAndRadio(){
	position = $(awk -F '\t' '{print %5}' worldcupplayerinfo.tsv)
	Goalie = 0
	Defender = 0
	Midfielder = 0
	Forward = 0
	numAll = 0

	for i in $position
	do
		if [ "$i" != "Position" ]; then
			numAll = `expr $numAll + 1`
			if [ "$i" == "Goalie" ]; then
				Goalie = `expr $Goalie + 1`
			elif [ "$i" == "Defender" ]; then
				Defender = `expr $Defender + 1`
			elif [ "$i" == "Midfielder" ]; then
				Defender = `expr $Midfielder + 1`
			elif [ "$i" == "Forward" ]; then
				Defender = `expr $Forward + 1`	
			fi
		fi
	done

	percent_G = `awk 'BEGIN{printf "%.3f\n",('${Goalie}'/'$numAll')*100}'`
	percent_D = `awk 'BEGIN{printf "%.3f\n",('${Defender}'/'$numAll')*100}'`
	percent_M = `awk 'BEGIN{printf "%.3f\n",('${Midfielder}'/'$numAll')*100}'`
	percent_F = `awk 'BEGIN{printf "%.3f\n",('${Forward}'/'$numAll')*100}'`
	echo "Goalies are $Goalie the percent is $percent_G"
	echo "Defenders are $Defender the percent is $percent_D"
	echo "Midfielders are $Midfielder the percent is $percent_M"
	echo "Forwards are $Forward the percent is $percent_F"
}

#find the player who has the longest name or shortest name
nameLength(){
	name = $(awk -F "\t" '{ print length($9) }' worldcupplayerinfo.tsv)
	longest = 0
	shortest = 100
	for i in $name
	do
		if [ $longest -lt $i ]; then
			longest = $i
		fi
		if [ $shortest -gt $i ]; then
			shortest = $i
		fi
	done

	longest_name = $(awk -F '\t' '{if (length($9)=='$longest'){print $9}}' worldcupplayerinfo.tsv)
	echo "$longest_name has the longest name and the length is $longest"
	shortest_name = $(awk -F '\t' '{if (length($9)=='$shortest'){print $9}}' worldcupplayerinfo.tsv)
	echo "$shortest_name has the shortest name and the length is $shortest"

}
#find the oldest and youngest player
playersAge(){
	age = $(awk -F "\t" '{ print $6 }' worldcupplayerinfo.tsv)
	oldest = 0
	youngest = 100
	count = 0
	for i in $age
	do
		if [ "$i" != "Age" ]; then
			count = `expr $count+1`
			if [ $i -lt $youngest ]; then
				youngest = $i
			fi
			if [ $i -gt $oldest ]; then
				oldest = $i
			fi
		fi
	done

	youngest_name = $(awk -F '\t' '{if($6=='$youngest') {print $9}}' worldcupplayerinfo.tsv)
	for j in $youngest_name
	do
		echo "the youngest player is $j, he is $youngest years old"
	done
	oldest_name = $(awk -F '\t' '{if($6=='$oldest') {print $9}}' worldcupplayerinfo.tsv)
	for k in $oldest_name
	do
		echo "the oldest player is $j, he is $oldest years old"
	done

}


if [ "$1" == "" ]; then
	echo "'-h' to show help"
elif [ "$1" == "-h" ]; then
	showHelp
elif [ "$1" == "-a" ]; then
	countAgeRangeNumAndRadio
elif [ "$1" == "-p" ]; then
	countPositionNumAndRadio
elif [ "$1" == "-n" ]; then
	nameLength
elif [ "$1" == "-o"]; then
	playersAge
fi
