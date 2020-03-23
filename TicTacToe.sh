#!/bin/bash -x

#Problem Statement:- Play tic tac toe between user and computer
#Auhtor:- Balaji Ijjapwar
#Date:- 22 March 2020

echo "-------Tic Tac Toe-------"
declare -A matrix
userChar="x"
compChar="0"

USER=0
COMP=1
TRUE=1
FALSE=0

function resetBoard() {
	echo -e "\nNew game starts"
	filledCells=0
	for (( i=0; i<3; i++ ))
	do
		for (( j=0; j<3; j++ ))
		do
			matrix[$i,$j]=" "
		done
	done
}

function displayBoard() {
	for (( i=0; i<3; i++ ))
	do
		for (( j=0; j<3; j++ ))
		do
			printf "${matrix[$i,$j]} "
			if [ $j -ne 2 ]
			then
				printf "|"
			fi
		done
		if [ $i -ne 2 ]
		then
			printf "\n--------\n"
		fi
	done
}

#Checks equality of three cell values
function areThreeEqual() {
   cell1=$1
   cell2=$2
   cell3=$3
   if [ "$cell1" != "" ]
   then
      if [[ $cell1 = $cell2 && $cell2 = $cell3 ]]
      then
         isWon=$TRUE
         if [ "$cell1" = "$userChar" ]
         then
            winner=$userChar
         else
            winner=$compChar
         fi
      fi
   fi
}

#Finds if anyone won by checking if any row, column or diagonal have same values
function checkIfGameWon() {
   isWon=$FALSE
   for (( i=0; i<3; i++ ))
   do
      areThreeEqual ${matrix[$i,0]} ${matrix[$i,1]} ${matrix[$i,2]}
      areThreeEqual ${matrix[0,$i]} ${matrix[1,$i]} ${matrix[2,$i]}
   done
   areThreeEqual ${matrix[0,0]} ${matrix[1,1]} ${matrix[2,2]}
   areThreeEqual ${matrix[0,2]} ${matrix[1,1]} ${matrix[2,0]}
   if [ $isWon -eq $TRUE ]
   then
      if [ "$winner" = $userChar ]
      then
         echo "You Won"
      elif [ "$winner" = $compChar ]
      then
         echo "Computer Won"
      fi
   else
      if [ $filledCells -eq 9 ]
      then
         echo "Game Tie"
      else
         turn=$((1-turn))
      fi
   fi
}

#Checks if any two cell values are equal
function anyTwoEqual() {
	cell1=$1
	cell2=$2
	cell3=$3
	if [[ "$cell1" = "0" && "$cell2" = "0" ]]
	then
		canCompWin=$TRUE
	elif [[ "$cell2" = "0" && "$cell3" = "0" ]]
	then
		canCompWin=$TRUE
	elif [[ "$cell1" = "0" && "$cell3" = "0" ]]
	then
		canCompWin=$TRUE
	fi
}

#Checks for winnnig computer winning possibilities
function checkingCompWinning() {
	canCompWin=$FALSE
	for (( i=0; i<3; i++ ))
	do
		anyTwoEqual ${matrix[$i,0]} ${matrix[$i,1]} ${matrix[$i,2]}
		anyTwoEqual ${matrix[0,$i]} ${matrix[1,$i]} ${matrix[2,$i]}
	done
	anyTwoEqual ${matrix[0,0]} ${matrix[1,1]} ${matrix[2,2]}
	anyTwoEqual ${matrix[0,2]} ${matrix[1,1]} ${matrix[2,0]}
}


resetBoard

echo "You are assigned '$userChar'"

toss=$((RANDOM % 2))
case $toss in
	$USER)
		echo "Your turn first";;
	$COMP)
		echo "Computer's turn first";;
esac

displayBoard
checkIfGameWon

echo -e "\nThis is smart computer"

checkingCompWinning

if [ $canCompWin -eq $TRUE ]
then
   echo "Computer can win now"
else
	echo "Computer can't win now"
fi
