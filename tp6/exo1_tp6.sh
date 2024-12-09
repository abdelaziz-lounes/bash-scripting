#!/bin/bash

# Seuils pour le CPU et la mémoire (en pourcentage)
CPU_THRESHOLD=1  # Seuil d'utilisation CPU (%)
MEM_THRESHOLD=1  # Seuil d'utilisation mémoire (%)

# Fichier temporaire contenant les informations des processus
ps -eo pid,pcpu,pmem,comm | tail -n +2 > tmp

# Parcourir chaque ligne du fichier contenant les informations des processus
echo "Processus depassant les seuils ($CPU_THRESHOLD% CPU ou $MEM_THRESHOLD% memoire) :"
    printf "%-5s | %-9s | %-15s | %s\n" "PID" "CPU (%)" "Memoire (%)" "commande(%)"

# Lire chaque ligne du fichier temporaire
while read -r pid cpu mem comm; do
    # Vérifier si le processus dépasse les seuils définis
    if [[ $(echo "$cpu > $CPU_THRESHOLD" | bc -l) -eq 1 || $(echo "$mem > $MEM_THRESHOLD" | bc -l) -eq 1 ]]; then
        # Afficher les détails du processus
        printf "%-5s | %-9s | %-15s | %s\n" "$pid" "$cpu" "$mem" "$comm"
    fi
done < tmp

# Supprimer le fichier temporaire
rm -f tmp
