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

resetBoard

echo "You are assigned '$userChar'"

toss=$((RANDOM % 2))
case $toss in
	$USER)
		echo "Your turn first";;
	$COMP)
		echo "Computer's turn first";;
esac
