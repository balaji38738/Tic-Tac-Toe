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
	printf "\n\n"
}

#Checks equality of three cell values
function areThreeEqual() {
   cell1=$1
   cell2=$2
   cell3=$3
   if [ "$cell1" != "" ]
   then
      if [[ "$cell1" = "$cell2" && "$cell2" = "$cell3" ]]
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
		#Function call to check equality of rows
		areThreeEqual ${matrix[$i,0]} ${matrix[$i,1]} ${matrix[$i,2]}

		#Function call to check equality of columns
		areThreeEqual ${matrix[0,$i]} ${matrix[1,$i]} ${matrix[2,$i]}
	done

	#Function call to check equality of diagonals
	areThreeEqual ${matrix[0,0]} ${matrix[1,1]} ${matrix[2,2]}
	areThreeEqual ${matrix[0,2]} ${matrix[1,1]} ${matrix[2,0]}

	if [ $isWon -eq $TRUE ]
	then
		if [ "$winner" = "$userChar" ]
		then
			echo "You Won"
		elif [ "$winner" = "$compChar" ]
		then
			echo "Computer Won"
		fi
	elif [ $filledCells -eq 9 ]
	then
		echo "Game Tie"
	fi
}

#Checks If someone can win
function checkingWinPossibility() {
	char=$1
	putAtRow=""
	putAtColumn=""
	for (( i=0; i<3; i++ ))
	do
		if [[ "${matrix[$i,0]}" = "$char" && "${matrix[$i,1]}" = "$char" && "${matrix[$i,2]}" = " " ]]
		then
			putAtRow=$i
			putAtColumn=2
			break
		elif [[ "${matrix[$i,0]}" = "$char" && "${matrix[$i,2]}" = "$char" && "${matrix[$i,1]}" = " " ]]
		then
			putAtRow=$i
			putAtColumn=1
			break
		elif [[ "${matrix[$i,1]}" = "$char" && "${matrix[$i,2]}" = "$char" && "${matrix[$i,0]}" = " " ]]
		then
			putAtRow=$i
			putAtColumn=0
			break
		elif [[ "${matrix[0,$i]}" = "$char" && "${matrix[1,$i]}" = "$char" && "${matrix[2,$i]}" = " " ]]
		then
			putAtRow=2
			putAtColumn=$i
			break
		elif [[ "${matrix[0,$i]}" = "$char" && "${matrix[2,$i]}" = "$char" && "${matrix[1,$i]}" = " " ]]
		then
			putAtRow=1
			putAtColumn=$i
			break
		elif [[ "${matrix[1,$i]}" = "$char" && "${matrix[2,$i]}" = "$char" && "${matrix[0,$i]}" = " " ]]
		then
			putAtRow=0
			putAtColumn=$i
			break
		fi
	done

	if [[ "$putAtRow" = ""  && "$putAtColumn" = "" ]]
	then
		if [[ "${matrix[0,0]}" = "$char" && "${matrix[1,1]}" = "$char" && "${matrix[2,2]}" = " " ]]
		then
			putAtRow=2
			putAtColumn=2
		elif [[ "${matrix[0,0]}" = "$char" && "${matrix[2,2]}" = "$char" && "${matrix[1,1]}" = " " ]]
		then
			putAtRow=1
			putAtColumn=1
		elif [[ "${matrix[1,1]}" = "$char" && "${matrix[2,2]}" = "$char" && "${matrix[0,0]}" = " " ]]
		then
			putAtRow=0
			putAtColumn=0
		elif [[ "${matrix[0,2]}" = "$char" && "${matrix[1,1]}" = "$char" && "${matrix[2,0]}" = " " ]]
		then
			putAtRow=2
			putAtColumn=0
		elif [[ "${matrix[0,2]}" = "$char" && "${matrix[2,0]}" = "$char" && "${matrix[1,1]}" = " " ]]
		then
			putAtRow=1
			putAtColumn=1
		elif [[ "${matrix[1,1]}" = "$char" && "${matrix[2,0]}" = "$char" && "${matrix[0,2]}" = " " ]]
		then
			putAtRow=0
			putAtColumn=2
		fi
	fi
}

#Fills vacant corner for computer
function fillAtCorner() {
	isEmptyCorner=$TRUE
	if [ "${matrix[0,0]}" = " " ]
	then
		matrix[0,0]=$compChar
	elif [ "${matrix[0,2]}" = " " ]
	then
		matrix[0,2]=$compChar
	elif [ "${matrix[2,0]}" = " " ]
	then
		matrix[2,0]=$compChar
	elif [ "${matrix[2,2]}" = " "  ]
	then
		matrix[2,2]=$compChar
	else
		isEmptyCorner=$FALSE
	fi
}

function playGame() {
	echo "You are assigned '$userChar'"
	toss=$((RANDOM % 2))
	case $toss in
		$USER)
			echo "Your turn first"
			turn=$USER;;
		$COMP)
			echo "Computer's turn first"
			turn=$COMP;;
	esac
	echo -e "\nThis is smart computer"
	displayBoard
	checkIfGameWon
	if [[ $isWon -eq $FALSE && $filledCells -ne 9 ]]
	then
		if	[ $turn -eq $USER ]
		then
			while [ 1==1 ]
			do
				read -p "Enter row (0-2) and column(0-2): " row column
				if [ "${matrix[$row,$column]}" == " " ]
				then
					matrix[$row,$column]=$userChar
					((filledCells++))
					break
				fi
			done
		else
			printf "Computer's turn\n"
			checkingWinPossibility $compChar	#Checks if computer can win
			if [[ "$putAtRow" != "" && "$putAtColumn" != "" ]]
			then
				matrix[$putAtRow,$putAtColumn]=$compChar
			else
				checkingWinPossibility $userChar #Checks if user can win
				if [[ "$putAtRow" != "" && "$putAtColumn" != "" ]]
				then
					matrix[$putAtRow,$putAtColumn]=$compChar
				else
					fillAtCorner
					if [ $isEmptyCorner -eq $FALSE ]
					then
						if [ "${matrix[1,1]}" = " " ]
						then
							matrix[1,1]=$compChar
						fi
					fi
				fi
			fi
			((filledCells++))
			turn=$((1-turn))
		fi
	fi
}

resetBoard
playGame

