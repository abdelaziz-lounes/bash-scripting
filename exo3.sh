#!/bin/bash

# Creer ou ecraser le dossier 'redirections'
if [ -d "redirections" ]; then
    rm -rf redirections
fi
mkdir redirections

# Aller dans le dossier 'redirections'
cd redirections

# Lister les fichiers et repertoires de /etc de maniere récursive et détaillée,
# et rediriger les flux de sortie et d'erreur dans les fichiers list_etc et err_etc
ls -lR /etc > list_etc 2> err_etc

# Ouvrir le fichier 'list_etc' et compter les repertoires
# Utiliser un tube pour rendre l'operation plus rapide
# La commande 'grep' permet de rechercher les repertoires (indiqués par un 'd' en début de ligne)
grep '^d' list_etc | wc -l
