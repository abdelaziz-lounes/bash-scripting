#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Veuillez fournir exactement 2 arguments."
    exit 1
fi

a=$1  # 1er nombre
b=$2  # 2eme nombre

# algorithm Euclidean de calculer pgcd
while [ $b -ne 0 ];do
    temp=$b # Stocke le reste
    b=$((a%b)) # Met à jour b pour etre le reste de la division
    a=$temp
done

echo "Le PGCD est $a" # Affiche le PGCD