#!/bin/bash
#image batch processing
#author:pcoateChen

#help
showHelp(){
	echo "image batch processing,version 0.1"
	echo "Usage: bash imgPro [option]"
	echo "-q [quality][folderPath] :compress imgs.jpeg quality"
	echo "-c [percent][folderPath] :imgs.jpeg/png/svg resolution compress with same aspect ratio"
	echo "-w [watermark_text][folderPath] :imgs add watermarks"
	echo "-r [pre|tail][newName][folderPath] :imgs rename"
	echo "-t [folderPath]:imgs.png/svg convert to imgs.jpg"
	echo "-h :help information" 
}

#compress imgs.jpeg quality
compressJpeg(){
	quality=$1
	folderPath=$2
	if [-d "$folderPath" ]; then
		for file in $(find "folderPath" \(-name "*.jpeg"\) -type f); do
			echo $file
			$(convert "$file" -quality "$quality" "$file")
		done
	else
		echo "$folderPath not exists"
}

#compress imgs.jpg|svg|png size
compressPx(){
	percent=$1
	folderPath=$2
	if [-d "$folderPath" ]; then
		for file in $(find "folderPath" \(-name "*.jpg" -or -name "*.svg" -or -name "*.png" \) -type f); do
			echo $file
			$(convert "$file" -resize "$percent" "$file")
		done
	else
		echo "$folderPath not exists"
}

#add watermark to imgs
add_watermark(){
	watermark_text=$1
	folderPath=$2
	if [-d "$folderPath" ]; then
		for file in $(find "folderPath" \(-name "*.jpg" -or -name "*.svg" -or -name "*.png" \) -type f); do
			echo $file
			$(composite -greavity southeast -dissolve 80 -pointsize 16 -draw "text 5,5 '$watermark_text'" "$file")
		done
	else
		echo "$folderPath not exists"
}

#rename pre or tail
rename(){
	preTail=$1
	newName=$2
	folderPath=$3
	if [-d "$folderPath" ]; then
		for file in $(findfind "folderPath" \(-name "*.jpg" -or -name "*.svg" -or -name "*.png" \) -type f); do
			if [ "$preTail" == "pre" ]; then
				x=$file
				direc=${x%/*}
				echo $direc
				file_name=${x%%.*}
				x=$file
				file_tail=${x#*.}
				echo $file_name
				x=$file_name
				single_name=${x##*/}
				echo $single_name
				mv $file $direc'/'$newName$single_name'.'$file_tail		
			elif [ "$preTail" == "tail" ]; then
				x=$file
				file_name = ${x%%/*}
				x=$file
				file_tail = ${x#*.}
				mv $file $file_name$newName'.'$file_tail
			else
				echo "please input 'pre' or 'tail'."
			if
		done
	else
                echo "$folderPath not exists"
}

#imgs.png|svg to .jpg
convert(){
	folderPath=$1
	if [-d "$folderPath" ]; then
		for file in $(findfind "folderPath" \( -name "*.svg" -or -name "*.png" \) -type f); do
			x=$file
			file_name=${x%%.*}
			x=$file
			file_tail=${x#*.}
			convert $file $file_name'_format.'$file_tail	
	else
                echo "$folderPath not exists"
}

if [ "$1" == "" ]; then
	echo "'-h' to show help"
elif [ "$1" == "-h" ]; then
	showHelp
elif [ "$1" == "-q" ]; then
	compressJpeg "$2" "$3"
elif [ "$1" == "-c" ]; then
	compressPx "$2" "$3"
elif [ "$1" == "-w" ]; then
	add_watermark "$2" "$3"
elif [ "$1" == "-r"]; then
	rename "$2" "$3" "$4"
elif [ "$1" == "-t"]; then
	convert "$2"
fi
