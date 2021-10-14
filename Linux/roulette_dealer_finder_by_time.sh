#!/bin/bash
echo You are looking for the Dealer on a specific time and date.
echo
echo What time are you looking for?
read time
echo What date are you looking for?
read date

echo | awk "/$time/"'{print $1, $2, $5, $6}' "$date"_Dealer_schedule
