#!/bin/bash

#Finds the free IP address in the network within the range of given addresses
#e.g. ./FreeIpInNetwork 20 30 -------------> It finds the free IP address in the range of 192.168.1.20 to 192.168.1.30


prefix="192.168.1"

# if number of arguments are not equal to 2 then exit
if [ ! $# == 2 ]
	then
	echo "Give Inputs"
	exit
	fi

#check if given input is correct or not
declare -i suffix1=$1
if [ $? -eq 0 ]
then
	echo
else
	echo "invalid input"
	exit
fi

declare -i suffix2=$2
if [ $? -eq 0 ]
then
	echo
else
	echo "invalid input"
	exit
fi


#check if a number contains all digits 
if [[ $1 =~ ^[0-9]+ ]]
	then
	echo "Contains digit"
    	if [ $suffix1 -lt 0 ]
    	then
    		echo "Give input in range"
    		exit
    	fi
    	
	if [ $suffix1 -gt 255 ]
		then
			echo "Give input in range "
			exit
	fi
else 
	echo "Not contains digit" 
	exit
fi


#check if a number contains all digits 
if [[ $2 =~ ^[0-9]+ ]]
	then
	echo "Contains digit"
    	if [ $suffix2 -lt 0 ]
    	then
    		echo "Give input in range"
    		exit
    	fi
    	
	if [ $suffix2 -gt 255 ]
		then
			echo "Give input in range "
			exit
	fi
else 
	echo "Not contains digit" 
	exit
fi
	
#if arguments are equal

if [ $1 == $2 ]
then
	ping -c 2 $prefix$1
	
	if [ $? -eq 0 ]
		then 
		echo "Not free"
		exit
	else
		echo "Free"
		exit
	fi
fi


#Check which argument is greater
if [ $suffix1 -gt $suffix2 ]
	then 
	suffix_min=$suffix2
	suffix_max=$suffix1
else
	suffix_min=$suffix1
	suffix_max=$suffix2
fi

#declaring array
declare -a ips
i=0

while [ $suffix_min -lt $suffix_max ]
do
	ping -c 2 $prefix$suffix_min
	
	if [ $? -eq 0 ]
		then 
		echo "Not free "
	else
		echo "Free"
		ips[i]=$prefix$suffix_min
	fi
	
	suffix_min=$((suffix_min+1))
	i=$((i+1))
	echo "Incrementing $suffix_min"
	
done

echo "Free IPs"
echo "${ips[*]}" 

	

