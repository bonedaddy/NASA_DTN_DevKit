#rcgen.sh
#Generates an .ionrc file for the given node in the s6 simulation
#Usage:
#rcgen.sh this_node_number

#wait for the start condition
val=0
while [ $val == 0 ]
do
	if [ -f /tmp/ionrcdate ]
	then
		val=1
	fi
done

#get the time
curtime=`cat /tmp/ionrcdate`

#set other vars
looptime="120"
numloops="15"
bps="500000"
premades="prc"
n2start="0"
n2stop="25"
n3start="19"
n3stop="50"
n4start="47"
n4stop="73"
n5start="70"
n5stop="97"
n6start="93"
n6stop="120"
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
	echo "a range   +$(($n2start + $base)) +$(($n2stop + $base)) 2 8 1" >> $outfile
	echo "a range   +$(($n2start + $base)) +$(($n2stop + $base)) 8 2 1" >> $outfile
	echo "a contact +$(($n2start + $base)) +$(($n2stop + $base)) 2 8 $bps" >> $outfile
	echo "a contact +$(($n2start + $base)) +$(($n2stop + $base)) 8 2 $bps" >> $outfile
	echo "" >> $outfile

	#echo "a range   +$(($n3start + $base)) +$(($n3stop + $base)) 3 8 1" >> $outfile
	echo "a range   +$(($n3start + $base)) +$(($n3stop + $base)) 8 3 1" >> $outfile
	#echo "a contact +$(($n3start + $base)) +$(($n3stop + $base)) 3 8 $bps" >> $outfile
	echo "a contact +$(($n3start + $base)) +$(($n3stop + $base)) 8 3 $bps" >> $outfile
	echo "" >> $outfile

	#echo "a range   +$(($n4start + $base)) +$(($n4stop + $base)) 4 8 1" >> $outfile
	echo "a range   +$(($n4start + $base)) +$(($n4stop + $base)) 8 4 1" >> $outfile
	#echo "a contact +$(($n4start + $base)) +$(($n4stop + $base)) 4 8 $bps" >> $outfile
	echo "a contact +$(($n4start + $base)) +$(($n4stop + $base)) 8 4 $bps" >> $outfile
	echo "" >> $outfile

	echo "a range   +$(($n5start + $base)) +$(($n5stop + $base)) 5 8 1" >> $outfile
	echo "a range   +$(($n5start + $base)) +$(($n5stop + $base)) 8 5 1" >> $outfile
	echo "a contact +$(($n5start + $base)) +$(($n5stop + $base)) 5 8 $bps" >> $outfile
	echo "a contact +$(($n5start + $base)) +$(($n5stop + $base)) 8 5 $bps" >> $outfile
	echo "" >> $outfile

	#echo "a range   +$(($n6start + $base)) +$(($n6stop + $base)) 6 8 1" >> $outfile
	echo "a range   +$(($n6start + $base)) +$(($n6stop + $base)) 8 6 1" >> $outfile
	#echo "a contact +$(($n6start + $base)) +$(($n6stop + $base)) 6 8 $bps" >> $outfile
	echo "a contact +$(($n6start + $base)) +$(($n6stop + $base)) 8 6 $bps" >> $outfile
	echo "" >> $outfile
done




