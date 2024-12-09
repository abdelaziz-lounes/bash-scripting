#!/bin/bash

#verifier si une repertoijre est fourni en argument
if [ -z "$1" ]; then
    echo "veuillez fournir un repertoire en argument"
    exit 1
fi

# verifier si l'argument est bein un repertoijre
if [ ! -d "$1" ]; then
    echo "l'argument fourni n'estpas un repertoire valide"
    exit 1
fi

# afficher le nombere de fichier reguliers et le nombre de dossiers
nb_fichiers=$(ls- l "$1" | grep '^-' | wc -l) # compter les fichiers reguliers
nb_dossiers= $(ls -l "$1" | grep '^d' | wc -l) # compter les dossiers

echo "Nombre de fichiers réguliers : $nb_fichiers"
echo "Nombre de dossiers : $nb_dossiers"