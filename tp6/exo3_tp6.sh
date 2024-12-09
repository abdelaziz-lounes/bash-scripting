#!/bin/bash

# etape 1 : Definir le repertoire a verifier
# Vous pouvez modifier cette variable pour specifier un repertoire particulier
REPERTOIRE="/home/caro/Desktop"

# etape 2 : Definir le fichier de log
# Ce fichier enregistrera les resultats des verifications
FICHIER_LOG="/home/caro/Desktop/log_verification.txt"

# etape 3 : Verifier l'existence du repertoire
if [ -d "$REPERTOIRE" ]; then
    # Si le repertoire existe, verifier s'il contient des fichiers
    if [ "$(ls -A "$REPERTOIRE")" ]; then
        # Si le repertoire contient des fichiers, enregistrer les noms et la date/heure dans le fichier de log
        echo "[$(date)] Fichiers trouves dans $REPERTOIRE :" >> "$FICHIER_LOG"
        ls -A "$REPERTOIRE" >> "$FICHIER_LOG"
        echo "-----------------------------------" >> "$FICHIER_LOG"
    else
        # Si le repertoire est vide, enregistrer un message dans le fichier de log
        echo "[$(date)] Aucun fichier trouve dans $REPERTOIRE." >> "$FICHIER_LOG"
        echo "-----------------------------------" >> "$FICHIER_LOG"
    fi
else
    # Si le repertoire n'existe pas, enregistrer un message d'erreur dans le fichier de log
    echo "[$(date)] ERREUR : Le repertoire $REPERTOIRE n'existe pas." >> "$FICHIER_LOG"
    echo "-----------------------------------" >> "$FICHIER_LOG"
fi
