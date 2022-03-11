#!/bin/bash
#author: Florian Wagner
#date of creation: 10/03/22
#
#############################################
#Script to calc the size of a payload in HEX#
#License GNU General Public License v3.0    #
#############################################

if [[ -z "$1" ]]; then
   echo "Please provide a file like this: # ./tePayloadToHex.sh ./Path/To/Txt/With/Payload"
   exit
fi

#get the bytecount of the payload file in UNIX form
charsInFile=$(wc -c $1|cut -d " " -f1)

echo "Chars in file with UNIX CR count: $charsInFile"

#get the lines of the file to calc the CRLF
linesInFile=$(wc -l $1|cut -d " " -f1)

#original char count with substraction of UNIX CR count
charsInFile=$(($charsInFile-$linesInFile))
echo "Chars in file: $charsInFile"

#calc CRLF like it is mentioned in the HTTP RFC
httpCRLFCount=$((($linesInFile -1) * 2))

echo "HTTP CRCL count: $httpCRLFCount"
bytecount=$(($charsInFile+$httpCRLFCount))
printf "\nResult with CRLF counted like in RFC2616\n\n"
echo "byte count in DEC: "
echo $bytecount

echo "byte count in HEX:"
echo $(printf "%x" $bytecount)

