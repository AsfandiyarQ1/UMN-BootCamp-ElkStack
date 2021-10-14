#!/bin/bash
echo You are looking for the Dealer on a specific time and date.
echo
echo What time are you looking for?
read time
echo What date are you looking for?
read date

awk "/$time/"'{print $1, $2, $5, $6}' "$date"_Dealer_schedule 

echo Would you like to know the game?
read game
awk "/game/" 'NR==3 {print $3, $4}' 0310_Dealer_schedule
