#!/bin/bash

for fichier in /etc/*.conf
do
    if [ -f "$fichier" ]; then  # Check if the file exists
        echo "$fichier"         # Print the filename
    fi
done