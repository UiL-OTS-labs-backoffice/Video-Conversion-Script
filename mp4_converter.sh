#!/bin/bash

FILE=`zenity --file-selection --title="Select input file(s)" --multiple`

case $? in 
	0) src="$FILE";;
	1) exit;;
	-1) echo "Unexpected error. now exiting" && exit;;
esac

vcodec="h264" 
bitrate="0"
scale="0"
ext=".mp4" 
mux="mp4" 
vlc="vlc"  

IFS='|' read -a array <<< "$src"

for a in "${array[@]}"; do
destination_name=$a$ext
$vlc -I dummy -vvv "$a" --sout "#transcode{vcodec=$vcodec,vb=$bitrate,scale=$scale}:standard{mux=$mux,dst=\"$destination_name\",access=file}" vlc://quit
done 
echo "done"
