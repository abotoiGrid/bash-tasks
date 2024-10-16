#Write bash script accepting operation parameter (“-”, “+”, “*”, “%”), sequence of numbers and debug flag. For example:
# ./your_script.sh -o % -n 5 3 -d > Result: 2
#./your_script.sh -o + -n 3 5 7 -d > Result: 15
#If -d flag is passed, script must print additional information:

#User: <username of the user running the script>
#Script: <script name>        
#Operation: <operation>
#Numbers: <all space-separated numbers>

#!/bin/bash

debug=0
operation=""
numbers=()


while getopts "o:n:d" opt; do
  case $opt in
    o)
      operation=$OPTARG 
      ;;
    n)
      numbers=($OPTARG)
      ;;
    d)
      debug=1
      ;;
  esac
done

if [ "$debug" -eq 1 ]; then
    echo "User: $(whoami)"
    echo "Script: $0"
    echo "Operation: $operation"
    echo "Numbers: ${numbers[*]}"
fi

result=${numbers[0]}

for (( i=1; i<${#numbers[@]}; i++ )); do
    case $operation in
        +)
            result=$((result + numbers[i]))
            ;;
        -)
            result=$((result - numbers[i]))
            ;;
        "*")
            result=$((result * numbers[i]))
            ;;
        %)
            result=$((result % numbers[i]))
            ;;
    esac
done

echo "Result: $result"

