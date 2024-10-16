#Write script with following functionality:
#If -v tag is passed, replaces lowercase characters with uppercase and vise versa
#If -s is passed, script substitutes <A_WORD> with <B_WORD> in text (case sensitive)
#If -r is passed, script reverses text lines
#If -l is passed, script converts all the text to lower case
#If -u is passed, script converts all the text to upper case
#Script should work with -i <input file> -o <output file> tags

#!/bin/bash


input_file=""
output_file=""
toggle_case=false
lower_case=false
upper_case=false
reverse_case=false
substitute_case=false
a_word=""
b_word=""


while getopts ":i:o:vlurs:" opt; do
  case $opt in
    i)
      input_file="$OPTARG"
      ;;
    o)
      output_file="$OPTARG"
      ;;
    v)
      toggle_case=true
      ;;
	l)
	  lower_case=true
	  ;;
	u)
	  upper_case=true
	  ;;
	r)
      reverse_case=true
	  ;;
	s)
	  substitute_case=true
	  IFS=":" read -r a_word b_word <<< "$OPTARG"
	  ;;
  esac
done


if $toggle_case; then
	tr '[:lower:][:upper:]' '[:upper:][:lower:]' < "$input_file" > "$output_file"
else
	cp "$input_file" "$output_file"
fi



if $lower_case; then
	tr '[:upper:]' '[:lower:]' < "$input_file" > "$output_file"
else
	cp "$input_file" "$output_file"
fi


if $upper_case; then
	tr '[:lower:]' '[:upper:]' < "$input_file" > "$output_file"
else
	cp "$input_file" "$output_file"
fi

if $reverse_case; then
	tac -s ' ' "$input_file" > "$output_file"
fi


if $substitute_case; then
	placeholder="__PLACEHOLDER__"
    sed -e "s/$a_word/$placeholder/g" -e "s/$b_word/$a_word/g" -e "s/$placeholder/$b_word/g" "$input_file" > "$output_file"
fi
