#!/bin/bash

# verifier si un repertoire est passe en argument
if [ -z "$1" ]; then
    echo "veuillez fournir un repertoire en argument."
    exit 1
fi

# verifie si l'argument est bien un repertoire
if [ ! -d "$1" ]; then
    echo "l'argument fourni n'est pas un repertoire valide"
    exit 1
fi

# 1) Calculer et afficher le nombre de fichiers reguliers et de dossiers

# compte les fichiers reguliers (lignes commençant pa '-')
nb_fichiers=$(ls -l "$1" | grep '^-' | wc -l)
#compte les dossier
nb_dossiers=$(ls -l "$1" | grep '^d' | wc -l)

# Afichage de nombre de fichiers et de dossiers
echo "Nombre de fichiers reguliers : $nb_fichiers"
echo "Nombre de dossiers : $nb_dossiers"

# ----------------------------------------
# 2) Trouver et afficher le nom et la taille du fichier ou dossier ayant la taille maximale

# Liste les fichiers tries par taille en ordre decroissant et selectionne le premier
max_size_info=$(ls -l "$1" | sort -nr | grep -v '^total' | head -n 1)
# Utilise `cut` pour extraire le nom du fichier (9eme colonne)
max_size_file=$(echo "$max_size_info" | tr -s ' ' | cut -d' ' -f9)
# Utilise `cut` pour extraire la taille (5eme colonne)
max_size=$(echo "$max_size_info" | tr -s ' ' | cut -d' ' -f5)

# Affiche le fichier/repertoire ayant la taille maximale
echo "Fichier/repertoire avec la taille maximale : $max_size_file, Taille : $max_size octets"

# 3) trouver et afficher le nombre maximum de liens physiques et le nom du fichiers correspondant

# Extrait les colonnes pour le nombre de liens et le nom de fichier, trie par ordre decroissant et selectionne le premier
max_links_info=$(ls -l "$1" | tail -n+2 | sort -nr | tr -s ' ' | cut -d ' ' -f 2,9 | head -n 1)
# Utilise `cut` pour extraire le nombre maximum de liens physiques (1re colonne)
max_links=$(echo "$max_links_info" | cut -d' ' -f1)
# Utilise `cut` pour extraire le nom du fichier (2me colonne)
max_links_file=$(echo "$max_links_info" | cut -d' ' -f2)

# Affiche le fichier ayant le plus grand nombre de liens physiques
echo "Fichier avec le nombre maximum de liens physiques : $max_links_file, avec : $max_links de liens"