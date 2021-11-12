#!/bin/bash

REGEX_CHOIX="^(1|0){1}$"
REGEX_TEL="^$(0|\+33)[0-9]{9}"
encore=1
while [ $encore = 1 ]
do
    if [ -z $1 ]
        then
            echo "Usage : newContact.sh fichierContacts"
        else
            echo "Veuillez rentrez respectivement le prénom, le nom et l'adresse mail et le numéro de tel' :"
            echo "Prenom ?"
            read firstname
            echo "Nom ?"
            read name

            if [ -z $firstname ] && [ -z $name ]
            then
                echo "Il faut au moins un nom ou un prenom pour faire un contact"
                exit
            elif [ -f $1 ] && [ `grep -i -c "N:$name;$firstname;;;" $1` -ge 1 ] 
            then
                echo "Le contact avec le nom $name et prenom $firstname existe déjà."
                exit
            fi
            echo "E-mail ?"
            read mail
            echo "Numéro de téléphone ?"
            read tel
            match= `echo "$tel" | grep -E "$REGEX_TEL"`
            if [ -z $match ]
            then
                echo "Numéro de téléphone incorrecte. Valeur négligée"
            fi
            vcard="BEGIN:VCARD\nVERSION:4.0\nN:$name;$firstname;;;\nFN:$firstname $name\nEMAIL:$mail\nTEL:$match\nEND:VCARD"

            echo "-------------------------------"
            if [ -f $1 ]
            then
                echo -e $vcard >> $1
                echo "Le nouveau contact a été ajouté à la fin du fichier $1"
            else
                echo -e $vcard >> $1
                echo "Le fichier $1 a été créé avec le nouveau contact"
            fi
    fi
    echo "Voulez vous ajouter un autre contact ? si oui entrer 1, sinon entrer 0"
    read encore

    while [[ !($encore =~ $REGEX_CHOIX) ]]
    do
        echo "si oui entrer 1, sinon entrer 0"
        read encore
    done

done