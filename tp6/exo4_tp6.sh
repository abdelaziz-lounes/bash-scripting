#!/bin/bash

# Verification des privileges administrateur
# On utilise `id -u` pour obtenir l'UID de l'utilisateur en cours.
# Si cet UID n'est pas egal a 0, cela signifie que l'utilisateur n'est pas root.
if [ "$(id -u)" -ne 0 ]; then
    echo "Ce script necessite des privileges administrateur. Veuillez l'executer en tant que root."
    exit 1  # Quitte le script avec un code d'erreur.
fi

# Creation des groupes necessaires s'ils n'existent pas deja
# On parcourt les noms des groupes ('admin', 'user', 'guest') avec une boucle for.
for group in admin user guest; do
    # La commande `getent group` verifie si le groupe existe dans le systeme.
    # Si le groupe n'existe pas, on le cree avec `groupadd`.
    if ! getent group "$group" > /dev/null; then
        groupadd "$group"
        echo "Groupe '$group' cree."  # Confirmation de la creation du groupe.
    fi
done

# Fonction pour afficher les groupes et leurs utilisateurs associes
afficher_utilisateurs_groupes() {
    echo "Liste des groupes et des utilisateurs associes :"
    for group in admin user guest; do
        echo "Groupe : $group"
        # Recuperation des membres du groupe avec `grep` et `cut` :
        # - `grep "^$group:" /etc/group` : Recherche la ligne contenant le groupe.
        # - `cut -d ':' -f 4` : Extrait le champ contenant les utilisateurs (le 4e champ).
        membres=$(grep "^$group:" /etc/group | cut -d ':' -f 4)
        # Si des membres sont presents, on les affiche. Sinon, on indique qu'il n'y a pas de membres.
        if [ -n "$membres" ]; then
            echo "  Membres : $membres"
        else
            echo "  Membres : Aucun membre."
        fi
    done
}

# Fonction pour ajouter un nouvel utilisateur
ajouter_utilisateur() {
    read -p "Entrez le nom du nouvel utilisateur : " username
    # Verifie si l'utilisateur existe deja avec `id`.
    if id "$username" > /dev/null 2>&1; then
        echo "Erreur : L'utilisateur '$username' existe deja."
        return  # Retourne a l'appelant sans continuer.
    fi
    echo "Groupes disponibles : admin, user, guest"
    # Demande a l'utilisateur d'entrer un groupe pour le nouvel utilisateur.
    read -p "Choisissez un groupe pour l'utilisateur : " group
    # Verifie si le groupe specifie existe avec `getent group`.
    if ! getent group "$group" > /dev/null; then
        echo "Erreur : Le groupe '$group' n'existe pas."
        return
    fi
    # Creation de l'utilisateur avec `useradd` :
    # - `-m` : Cree un repertoire personnel pour l'utilisateur.
    # - `-G` : Ajoute l'utilisateur au groupe specifie.
    useradd -m -G "$group" "$username"
    echo "Utilisateur '$username' ajoute au groupe '$group'."
}

# Fonction pour changer le groupe d'un utilisateur
changer_groupe() {
    read -p "Entrez le nom de l'utilisateur : " username
    # Verifie si l'utilisateur existe avec `id`.
    if ! id "$username" > /dev/null 2>&1; then
        echo "Erreur : L'utilisateur '$username' n'existe pas."
        return
    fi
    echo "Groupes disponibles : admin, user, guest"
    # Demande a l'utilisateur d'entrer un nouveau groupe.
    read -p "Choisissez un nouveau groupe pour l'utilisateur : " new_group
    # Verifie si le groupe existe.
    if ! getent group "$new_group" > /dev/null; then
        echo "Erreur : Le groupe '$new_group' n'existe pas."
        return
    fi
    # Change le groupe principal de l'utilisateur avec `usermod`.
    usermod -G "$new_group" "$username"
    echo "Utilisateur '$username' deplace vers le groupe '$new_group'."
}

# Fonction pour supprimer un utilisateur
supprimer_utilisateur() {
    read -p "Entrez le nom de l'utilisateur a supprimer : " username
    # Verifie si l'utilisateur existe.
    if ! id "$username" > /dev/null 2>&1; then
        echo "Erreur : L'utilisateur '$username' n'existe pas."
        return
    fi
    # Supprime l'utilisateur et son repertoire personnel avec `userdel -r`.
    userdel -r "$username"
    echo "Utilisateur '$username' supprime."
}

# Fonction principale qui gere le menu interactif
menu_principal() {
    while true; do
        # Affiche les options disponibles pour l'utilisateur.
        echo "===== Menu Principal ====="
        echo "1. Afficher les groupes et utilisateurs"
        echo "2. Ajouter un nouvel utilisateur"
        echo "3. Changer de groupe pour un utilisateur"
        echo "4. Supprimer un utilisateur"
        echo "5. Quitter"
        # Demande a l'utilisateur de choisir une option.
        read -p "Choisissez une option : " choix

        # Execute l'action correspondante a l'option choisie avec un `case`.
        case $choix in
            1) afficher_utilisateurs_groupes ;;  # Affiche les groupes et utilisateurs.
            2) ajouter_utilisateur ;;           # Ajoute un nouvel utilisateur.
            3) changer_groupe ;;                # Change le groupe d'un utilisateur.
            4) supprimer_utilisateur ;;         # Supprime un utilisateur.
            5) echo "Au revoir !"; break ;;     # Quitte la boucle (et le script).
            *) echo "Option invalide, veuillez réessayer." ;;  # Message d'erreur en cas de choix invalide.
        esac
    done
}

# Appelle la fonction pour lancer le menu principal
menu_principal
