#! /bin/sh

# boranj!
#
# ***************************************
# ******OMPD - One Minute Per Day - Voluntary Anthropology
# ******public timelapse wall
# need to install ffmpeg and imagemagick for this to work
# maybe wacaw too if you want webcam on mac.
# for linux you need to install scrot as well.
# **************
# **************

# whatever you want to be your directory of files
cd ~/Pictures/OMPD
# make a subdirectory with today's date, then go to it.
mkdir `date +%Y-%m-%d`
cd `date +%Y-%m-%d`

DDDATE=`date +%Y%m%d`
DATETIME=`date +%Y%m%d%H%M%S`

counter=10000
# at 15 seconds per shot, 4/min, 240/hr, 10 hours = 2400 shots
# while [ $counter -ne 3400 ] # run a fixed number of shots.
#while [ `date +%H` -lt 23 ] # if it's less that 11pm
while [ 1 ] # run all the time
do
DATETIME=`date +%Y%m%d%H%M%S`

NOWDATE=`date +%Y%m%d`
    if [ $NOWDATE -gt $DDDATE ]
    then
        echo "day change"
        counter=10000
        # rename files sequentially for FFMPEG to work properly
        for f in *.jpg; do
        let "counter+=1"
        mv $f screen${counter:1}.jpg
        done


# convert *.jpg ~/Movies/AUTOUPLOAD/OMPD-$DDDATE-$DATETIME.mp4
# this is a one liner you can run if you need to manually do a day that got missed.
#         for f in *.jpg; do let "counter+=1"; mv $f screen${counter:1}.jpg ; done
#done

        ffmpeg -r 20 -b 5000 -i screen%04d.jpg ~/Movies/AUTOUPLOAD/OMPD-$DDDATE-$NOWDATE.mp4
        #ffmpeg -r 10 -sameq -i webcam%04d.jpg ~/Movies/AUTOUPLOAD/camTL-$DDDATE.mp4
        #ffmpeg -r 15 -b 5000 -i webcam%04d.jpg ~/Movies/AUTOUPLOAD/`
        # -b 5000 to limit movie size.    
        cd ~/Pictures/OMPD
        mkdir `date +%Y-%m-%d`
        cd `date +%Y-%m-%d`
        counter=10000
        DDDATE=`date +%Y%m%d`
    fi

#let "counter+=1"
echo $DATETIME
#echo $counter # if you want to see the progression on the terminal window
# capture a JPG screenshot

#screencapture -m -x -t jpg screen${counter:1}.jpg
screencapture -m -x -t jpg screen$DATETIME.jpg

## linux commands
#scrot screen$DATETIME.jpg
#streamer -c /dev/video0 -o cam$DATETIME.jpeg



#wacaw --jpeg -n 4 webcam${counter:1}.jpg
echo "captured images"
# resize images using imagemagick here?
convert screen$DATETIME.jpg -resize 60% screen$DATETIME.jpg
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
