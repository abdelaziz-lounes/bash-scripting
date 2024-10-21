#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Veuillez fournir un seul argument."
    exit 1  # Exit if not exactly one argument
fi

input="$1"

if [[ "$input" =~ ^[0-9]+$ ]]; then
    echo "La chaine est entierement numerique"
else
    echo "La chaine n'est pas entierement numerique"
fi