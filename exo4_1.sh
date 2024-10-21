#!/bin/bash

# Verifier si des arguments sont fournis
if [ "$#" -eq 0 ]; then
    echo "Veuillez fournirr des nombres en arguments."
    exit 1
fi

# Stocker les arguments dans un tableau
tableau=("$@")

# Trier le tableau en ordre decroissent
tableau_trie=($(for i in "${tableau[@]}"; do echo "$i"; done | sort -nr))

# Afficher le tableau trie
echo "tableau trie en ordre decroissant: ${tableau_trie[@]}"