#Write caesar cipher script accepting three parameters -s <shift> -i <input file> -o <output file>

#!/bin/bash



read -p "Enter the text: " text
read -p "Enter the shift number: " shift
result=""




for (( i=0; i<${#text}; i++ )); do
	char="${text:$i:1}"
	ascii=$(printf "%d" "'$char")
	shifted=$(( (ascii + shift) % 256 ))
	result+=$(printf "\\$(printf '%03o' $shifted)")
done


echo "Result: $result"
