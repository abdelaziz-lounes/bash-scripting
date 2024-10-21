#!/bin/bash

read -p "Entrerz un caractere: " char

if [[ "$char" =~ [a-z] ]]; then
    echo "C'est une lettre minuscule."
elif [[ "$char" =~ [A-Z] ]]; then
    echo "C'est une lettre majuscule."
elif [[ "$char" =~ [0-9] ]]; then
    echo "c'st un chifre."
else
    echo "CE N'EST NI UNUE LETTRE NI UN CHIFFRE"
fi