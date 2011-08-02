#! /bin/sh

# THIS VERSION TAKES A WEBCAM PIC AND BLENDS IT WITH SCREENSHOT
# ***************************************
# ******OMPD - One Minute Per Day - Voluntary Anthropology
# ******public timelapse wall
# need to install ffmpeg and imagemagick for this to work
# maybe wacaw too 
# **************
# **************

# whatever you want to be your directory of files
cd ~/Pictures/OMPD
# make a subdirectory with today's date, then go to it.
mkdir `date +%Y-%m`
cd `date +%Y-%m`

screencapture -m -x -t jpg last.jpg

DDDATE=`date +%Y%m`
DATETIME=`date +%Y%m%d%H%M%S`

RAMP=9
counter=10000
# at 15 seconds per shot, 4/min, 240/hr, 10 hours = 2400 shots
# while [ $counter -ne 3400 ] # run a fixed number of shots.
#while [ `date +%H` -lt 23 ] # if it's less that 11pm
while [ 1 ] # run all the time
do
DATETIME=`date +%Y%m%d%H%M%S`

NOWDATE=`date +%Y%m`
	if [ $NOWDATE -gt $DDDATE ]
	then
		echo "month change"
		counter=100000
		for f in screen*.jpg; do
		let "counter+=1"
		mv $f renum${counter:1}.jpg 
		done
		# convert *.jpg ~/Movies/AUTOUPLOAD/OMPD-$DDDATE-$DATETIME.mp4
# 		for f in *.jpg; do let "counter+=1"; mv $f screen${counter:1}.jpg ; done 
		#done
# -g sets keyframes. useful if you ever edit the file later
		ffmpeg -r 20 -b 5000 -g 1 -i renum%05d.jpg -sameq -s 720x450 ~/Movies/AUTOUPLOAD/OMPD-$DDDATE.mp4
		#ffmpeg -r 10 -sameq -i webcam%04d.jpg ~/Movies/AUTOUPLOAD/camTL-$DDDATE.mp4
		#ffmpeg -r 15 -b 5000 -i webcam%04d.jpg ~/Movies/AUTOUPLOAD/`
		# -b 5000 to limit movie size.	
		cd ~/Pictures/OMPD
		mkdir `date +%Y-%m-%d`
		cd `date +%Y-%m-%d`
		sleep 1
		screencapture -m -x -t jpg last.jpg
		screencapture -m -x -t jpg new.jpg
		screencapture -m -x -t jpg middle.jpg
		counter=10000
		DDDATE=`date +%Y%m`
	fi

#let "counter+=1"
echo $DATETIME
#echo $counter # if you want to see the progression on the terminal window
# capture a JPG screenshot

let "RAMP%=6"
let "RAMP+=1"
echo $RAMP
#screencapture -m -x -t jpg screen${counter:1}.jpg
screencapture -m -x -t jpg new.jpg
#composite /Users/danielpaluska/Pictures/OMPD/wave_gradient6.png new.jpg -displace 3x3 middle.jpg #screen$DATETIME.jpg
composite -blend 35 new.jpg last.jpg -matte middle.jpg

wacaw --jpeg -n 4 webcam

composite -blend 50 webcam.jpeg middle.jpg last.jpg
#composite -blend 50 -gravity center /Users/danielpaluska/OneMinutePerDay/label.gif middle.jpg middle.jpg
#cp middle.jpg last.jpg
#mv temp.jpg screen$DATETIME.jpg
convert last.jpg -resize %50 screen$DATETIME.jpg

#wacaw --jpeg -n 4 webcam${counter:1}.jpg
echo "captured images"
# resize images using imagemagick here?

#mogrify screen$DATETIME.jpg -resize 720x450

# add additional imagemagick filters that intentionally art-ify the images?
echo "made screen smaller"
# convert webcam${counter:1}.jpg.jpeg -resize 95% webcam${counter:1}.jpg
# mv webcam$DATETIME.jpg.jpeg webcam$DATETIME.jpg



#convert screen${counter:1}.jpg -resize 50% screen${counter:1}.jpg

# capture an image from the webcam using wacaw package. get from sourceforge
#
# download zip file. unzip. run these two things at command line
# sudo cp wacaw /usr/local/bin; sudo chmod +x /usr/local/bin/wacaw
echo yofool
# number of seconds between shots
sleep 20
# make a beep here? display a shot onscreen?
done
# one shot/15sec, played at 10 fps = 150x speedup. 150min(2.5hr) = 1 min vid. 10hrs = 4min
# about mac cron jobs on laptops and sleep times
# http://www.thexlab.com/faqs/maintscri...