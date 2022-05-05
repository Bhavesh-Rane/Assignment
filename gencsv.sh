#!/bin/bash
file=./InputFile
if test -f "$file"; then
	rm $file
fi
if [ -z "$1" ]
then 
	range=9	
else
	range=$(expr $1 - 1)
fi
for (( i=0; i<=$range; i++ ))
do
	rand_num=$(shuf -i 1-100 -n 1)
	echo "$i, $rand_num" >> InputFile
done
echo $1