#!/bin/bash -x

#Problem Statement:- Play tic tac toe between user and computer
#Auhtor:- Balaji Ijjapwar
#Date:- 22 March 2020

echo "-------Tic Tac Toe-------"
declare -A matrix

function resetBoard() {
	echo "New game starts"
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
