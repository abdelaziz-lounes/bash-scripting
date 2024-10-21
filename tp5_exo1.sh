#!/bin/bash

# Verifier si un argument est fourni
# Si la chaine est vide, -z renvoie true. Sinon, elle renvoie false.

if [ -z "$1" ]; then
    echo "Veuillez fournir un texte à chiffrer ou déchiffrer."
    exit 1
fi

# Chiffrer/Dechiffrer le texte avec ROT13
texte="$1"
texte_crypte=$(echo "$texte" | tr 'A-Za-z' 'N-ZA-Mn-za-m')

# Afficher le resultat
echo "Texte d'origine : $texte"
echo "Texte chiffre/dechiffré : $texte_crypte"
