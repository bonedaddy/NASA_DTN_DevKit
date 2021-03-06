#rcgen.sh
#Generates an .ionrc file for the given node in the s6 simulation
#Usage:
#rcgen.sh this_node_number

#wait for the start condition
echo "rcgen.sh waiting for time from mobility script." >> `hostname`.log
val=0
while [ $val == 0 ]
do
	if [ -f /tmp/ionrcdate ]
	then
		val=1
	fi
done
echo "rcgen.sh got time; continuing" >> `hostname`.log

#get the time
curtime=`cat /tmp/ionrcdate`

#set other vars
looptime="120"
numloops="15"
bps="500000"
premades="prc"
thisnode=$1
outfile=`hostname`.ionrc

#satellite passby times for orbiter
p1start="0"
p1stop="7"
p2start="31"
p2stop="45"
p3start="68"
p3stop="86"
p4start="111"
p4stop="120"

#satellite passby times for nodes 2-4
n2start="12"
n2stop="26"
n3start="49"
n3stop="65"
n4start="92"
n4stop="106"

#echo a header for the auto generated ranges
echo "### Generated by RCGEN.SH" > $outfile
#echo the initialization command
echo "1 $thisnode" `hostname`.ionconfig >> $outfile
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
	echo "a range   +$(($p1start + $base)) +$(($p1stop + $base)) 6 5 1" >> $outfile
	echo "a range   +$(($p1start + $base)) +$(($p1stop + $base)) 5 6 1" >> $outfile
	echo "a contact +$(($p1start + $base)) +$(($p1stop + $base)) 6 5 $bps" >> $outfile
	echo "a contact +$(($p1start + $base)) +$(($p1stop + $base)) 5 6 $bps" >> $outfile
	echo "" >> $outfile
	echo "a range   +$(($n2start + $base)) +$(($n2stop + $base)) 5 2 1" >> $outfile
	echo "a range   +$(($n2start + $base)) +$(($n2stop + $base)) 2 5 1" >> $outfile
	echo "a contact +$(($n2start + $base)) +$(($n2stop + $base)) 5 2 $bps" >> $outfile
	echo "a contact +$(($n2start + $base)) +$(($n2stop + $base)) 2 5 $bps" >> $outfile
	echo "" >> $outfile
	echo "a range   +$(($p2start + $base)) +$(($p2stop + $base)) 6 5 1" >> $outfile
	echo "a range   +$(($p2start + $base)) +$(($p2stop + $base)) 5 6 1" >> $outfile
	echo "a contact +$(($p2start + $base)) +$(($p2stop + $base)) 6 5 $bps" >> $outfile
	echo "a contact +$(($p2start + $base)) +$(($p2stop + $base)) 5 6 $bps" >> $outfile
	echo "" >> $outfile
	echo "a range   +$(($n3start + $base)) +$(($n3stop + $base)) 5 3 1" >> $outfile
	echo "a range   +$(($n3start + $base)) +$(($n3stop + $base)) 3 5 1" >> $outfile
	echo "a contact +$(($n3start + $base)) +$(($n3stop + $base)) 5 3 $bps" >> $outfile
	echo "a contact +$(($n3start + $base)) +$(($n3stop + $base)) 3 5 $bps" >> $outfile
	echo "" >> $outfile
	echo "a range   +$(($p3start + $base)) +$(($p3stop + $base)) 6 5 1" >> $outfile
	echo "a range   +$(($p3start + $base)) +$(($p3stop + $base)) 5 6 1" >> $outfile
	echo "a contact +$(($p3start + $base)) +$(($p3stop + $base)) 6 5 $bps" >> $outfile
	echo "a contact +$(($p3start + $base)) +$(($p3stop + $base)) 5 6 $bps" >> $outfile
	echo "" >> $outfile
	echo "a range   +$(($n4start + $base)) +$(($n4stop + $base)) 5 4 1" >> $outfile
	echo "a range   +$(($n4start + $base)) +$(($n4stop + $base)) 4 5 1" >> $outfile
	echo "a contact +$(($n4start + $base)) +$(($n4stop + $base)) 5 4 $bps" >> $outfile
	echo "a contact +$(($n4start + $base)) +$(($n4stop + $base)) 4 5 $bps" >> $outfile
	echo "" >> $outfile
	echo "a range   +$(($p4start + $base)) +$(($p4stop + $base)) 6 5 1" >> $outfile
	echo "a range   +$(($p4start + $base)) +$(($p4stop + $base)) 5 6 1" >> $outfile
	echo "a contact +$(($p4start + $base)) +$(($p4stop + $base)) 6 5 $bps" >> $outfile
	echo "a contact +$(($p4start + $base)) +$(($p4stop + $base)) 5 6 $bps" >> $outfile
	echo "" >> $outfile
done




