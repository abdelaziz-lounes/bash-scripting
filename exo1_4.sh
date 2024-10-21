#!/bin/bash

dossier="/usr/include"
nb_fichiers=$(find "$dossier" -type f -name "*.h" | wc -l) #(wc -l) count number of lines of .h files

# Check if there are any .h files
if [ $nb_fichiers -gt 0 ]; then
    echo "Il y a $nb_fichiers fichiers en-tete (.h) dans $dossier."
else
    echo "Aucun fichier en-tete (.h) trouve dans $dossier."
fi