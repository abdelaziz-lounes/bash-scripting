#!/bin/bash

# fonction pour calculer la serie
calc_serie(){
    local n=$1 # Le nombre N initial
    local termes=$2 # le nombre de termes a calculer

    echo "Serie claculer pour N=$n :"

    for (( i=0; i<termes; i++ )); do
        echo -n "$n "  # affiche chaque terme sans retour a la ligne
        if (( n % 2 == 0 )); then
            n=$((n / 2)) 
        else
            n=$((3 * n + 1))
        fi
    done
    echo "" # Nouvelle ligne apres avoir affiches tous les termes

}

# Demande à l'utilisateur d'entrer N
read -p "Enterz un nombre N (u0): " N

# verifie que N est un entier valide
if ! [[ "$N" =~ ^[0-9]+$ ]]; then
    echo "Veuillez entrer un nombre entier valide."
    exit 1
fi

# Demande a l'utilisateur d'entrer le nombre de termes
read -p "Entrez le nombre de termes a calculer : " nb_termes

# Verifie que le nombre de termes est un entier valide
if ! [[ "$nb_termes" =~ ^[0-9]+$ ]]; then
    echo "Veuillez entrer un nombre de termes valide."
    exit 1
fi

# appel de la fonction pour calculer la serie
calc_serie $N $nb_termes