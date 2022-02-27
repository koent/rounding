#!/bin/bash
LC_NUMERIC=C LC_COLLATE=C

echo -n "You have: "
read have
echo -n "You want: "
read want

if check=$(units "$have" "$want")
then
	:
else
	echo "The values have different dimensions or another problem was detected."
	exit
fi

echo -n "$have"

progress=$(units -t "$want" "$have" )

while [ $progress \> 1 ]
do
	maxunit=""
	maxratio=1
	units=$(printf "$have\n?" | units -q | awk '{ print $1 }')
	for unit in $units
	do
		if val=$(units -t -d 15 "$have" $unit)
		then
			if [[ $val == *";"* ]] || [[ $val == *" "* ]] || [ $val = "0" ]
			then
				:
			else
				rounded=$(printf "%.0f" "$val")
				ratio=$(awk -v v=$val -v r=$rounded 'BEGIN { printf "%.15f", r / v }')
				if [ $ratio \> $maxratio ]
				then
					maxratio=$ratio
					maxunit=$unit
				fi
			fi
		fi
	done
	val=$(units -t "$have" $maxunit)
	rounded=$(printf "%.0f" "$val")
	echo -n " = $rounded $maxunit"
	if [ "$rounded$maxunit" = "$have" ]
	then
		echo ""
		echo "Loop detected, exiting"
		exit
	fi
	have="$rounded$maxunit"
	progress=$(units -t "$want" "$have")
done
echo " > $want (rounded)"
