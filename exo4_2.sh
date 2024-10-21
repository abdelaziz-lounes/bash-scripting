#!/bin/bash

# verifier si un fichier est fourni en argument
if [ "$#" -ne 1 ]; then
    echo "Veuillez fournir un fichier contenant des nombres entiers"
    exit1
fi

fichier="$1"
# Verifier si le fichier existe
if [ ! -f "$fichier" ]; then
    echo "Le fichier n'existe pas"
    exit 1
fi

# Lire les valeurs de fichier dans un tableau
tableau=($(cat "$fichier"))

# Trier le tableau en ordre croissant
tableau_trie=($(for i in "${tableau[@]}"; do echo "$i"; done | sort -n))

# Afficher le tableau trié
echo "Tableau trie en ordre croissant : ${tableau_trie[@]}"