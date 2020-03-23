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

#Checks if any two cell values are equal to computer character

function any2CompChars() {
	cell1=$1
	cell2=$2
	cell3=$3

	if [[ "$cell1" = "$compChar" && "$cell2" = "$compChar" ]]
	then
		canCompWin=$TRUE
	elif [[ "$cell2" = "$compChar" && "$cell3" = "$compChar" ]]
	then
		canCompWin=$TRUE
	elif [[ "$cell1" = "$compChar" && "$cell3" = "$compChar" ]]
	then
		canCompWin=$TRUE
	fi
}

#Checks for computer winning possibility
function checkingCompWinning() {
	canCompWin=$FALSE
	for (( i=0; i<3; i++ ))
	do
		any2CompChars ${matrix[$i,0]} ${matrix[$i,1]} ${matrix[$i,2]}
		any2CompChars ${matrix[0,$i]} ${matrix[1,$i]} ${matrix[2,$i]}
	done
	any2CompChars ${matrix[0,0]} ${matrix[1,1]} ${matrix[2,2]}
	any2CompChars ${matrix[0,2]} ${matrix[1,1]} ${matrix[2,0]}
}

#Checks if any two cell values equal to user character
function any2UserChars() {
	cell1=$1
	cell2=$2
	cell3=$3

	if [[ "$cell1" = "$userChar" && "$cell2" = "$userChar" ]]
	then
		canUserWin=$TRUE
	elif [[ "$cell2" = "$userChar" && "$cell3" = "$userChar" ]]
	then
		canUserWin=$TRUE
	elif [[ "$cell1" = "$userChar" && "$cell3" = "$userChar" ]]
	then
		canUserWin=$TRUE
	fi
}

#Checks for user winning possibility
function checkingUserWinning() {
	canUserWin=$FALSE
	for (( i=0; i<3; i++ ))
	do
		any2UserChars ${matrix[$i,0]} ${matrix[$i,1]} ${matrix[$i,2]}
		any2UserChars ${matrix[0,$i]} ${matrix[1,$i]} ${matrix[2,$i]}
	done
	any2UserChars ${matrix[0,0]} ${matrix[1,1]} ${matrix[2,2]}
	any2UserChars ${matrix[0,2]} ${matrix[1,1]} ${matrix[2,0]}
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

checkingUserWinning

if [ $canUserWin -eq $TRUE ]
then
   echo "User can win now"
else
   echo "User can't win now"
fi

