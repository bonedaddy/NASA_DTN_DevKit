#rcgen.sh
#Generates an .ionrc file for the given node in the s6 simulation
#Usage:
#rcgen.sh this_node_number

#get the time
basetime=`date -u +"%Y/%m/%d-%H:"`
mintime=`date +'%M'`
mintime=${mintime#0}
printf -v curtime "%s%02d:00" $basetime $mintime

##wait for the start condition
#val=0
#while [ $val == 0 ]
#do
#	if [ -f /tmp/ionrcdate ]
#	then
#		val=1
#	fi
#done
#
##get the time
#curtime=`cat /tmp/ionrcdate`

#set other vars
looptime="60"
numloops="30"
bps="500000"
premades="prc"
start="0"
stop="30"
start2="30"
stop2="60"
thisnode=$1
outfile='node'$thisnode'.ionrc'

#echo a header for the auto generated ranges
echo "### Generated by RCGEN.SH" > $outfile
#echo the initialization command
echo "1 $thisnode" >> $outfile
echo "s" >> $outfile
#echo the correct time to set the reference
echo @ $curtime >> $outfile
echo "m horizon +0" >> $outfile
echo "" >> $outfile
echo "# RANGES AND CONTACTS:" >> $outfile
echo "" >> $outfile
#write in all of the premade routes and contacts
cat $premades >> $outfile

#actually generate times
echo "" >> $outfile
echo "#Generated loop ranges and contacts:" >> $outfile
echo "" >> $outfile

for (( i=0; i<$numloops; i+=1 ))
do
	((base=($looptime*$i)))
	echo "a range   +$(($start + $base)) +$(($stop + $base)) 2 4 12" >> $outfile
	echo "a range   +$(($start + $base)) +$(($stop + $base)) 4 2 12" >> $outfile
	echo "a contact +$(($start + $base)) +$(($stop + $base)) 2 4 $bps" >> $outfile
	echo "a contact +$(($start + $base)) +$(($stop + $base)) 4 2 $bps" >> $outfile
	echo "" >> $outfile
	echo "a range   +$(($start2 + $base)) +$(($stop2 + $base)) 3 4 12" >> $outfile
	echo "a range   +$(($start2 + $base)) +$(($stop2 + $base)) 4 3 12" >> $outfile
	echo "a contact +$(($start2 + $base)) +$(($stop2 + $base)) 3 4 $bps" >> $outfile
	echo "a contact +$(($start2 + $base)) +$(($stop2 + $base)) 4 3 $bps" >> $outfile
	echo "" >> $outfile
done




