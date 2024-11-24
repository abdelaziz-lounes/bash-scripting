#!/bin/bash

# Fichier temporaire pour stocker les informations reseau
TEMP_FILE="network_info.txt"

# Recuperer les informations sur les interfaces reseau
ip addr > "$TEMP_FILE"

# Variables pour stocker les informations de l'interface en cours
interface=""
ipv6=""
mac=""

# Lire le fichier ligne par ligne
while read -r line; do
    # Verifier si c'est une nouvelle interface (ligne contenant "<interface>:")
    if [[ "$line" =~ ^[0-9]+:\ ([^:]+): ]]; then
        # Si une interface precedente etait dejà traitee, afficher ses informations
        if [[ -n "$interface" ]]; then
            echo "Nom de l'interface : $interface"
            [[ -n "$ipv6" ]] && echo "Adresse inet6 : $ipv6" || echo "Adresse inet6 : Non disponible"
            [[ -n "$mac" ]] && echo "Adresse MAC : $mac" || echo "Adresse MAC : Non disponible"
            echo "-----------------------------------------"
        fi

        # Initialiser les variables pour la nouvelle interface
        interface="${BASH_REMATCH[1]}"
        ipv6=""
        mac=""
    fi

    # Verifier si la ligne contient une adresse IPv6
    if [[ "$line" =~ inet6\ ([^ ]+) ]]; then
        ipv6="${BASH_REMATCH[1]}"
    fi

    # Verifier si la ligne contient une adresse MAC
    if [[ "$line" =~ link/ether\ ([^ ]+) ]]; then
        mac="${BASH_REMATCH[1]}"
    fi
done < "$TEMP_FILE"

# Afficher les informations de la derniere interface
if [[ -n "$interface" ]]; then
    echo "Nom de l'interface : $interface"
    [[ -n "$ipv6" ]] && echo "Adresse inet6 : $ipv6" || echo "Adresse inet6 : Non disponible"
    [[ -n "$mac" ]] && echo "Adresse MAC : $mac" || echo "Adresse MAC : Non disponible"
    echo "-----------------------------------------"
fi

# Supprimer le fichier temporaire
rm -f "$TEMP_FILE"
