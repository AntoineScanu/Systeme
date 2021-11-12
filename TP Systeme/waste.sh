#!/bin/bash
if [[ !(-d "$HOME/waste") ]]
then mkdir $HOME/waste
    echo "Le dossier a été creer"
fi

case $1 in

    --help)
       echo "Usage : ./waste.sh [OPTION] [FICHIERS]"
       echo "Les options ci-dessous sont permises : "
       echo "--help                     : cette aide"
       echo "--liste                    : liste des fichiers contenus dans la corbeille"
       echo "--suppress FICHIERS        : déplacement des fichiers vers la corbeille"
       echo "--restore FICHIER CHEMIN   : déplacement du fichier vers le chemin"
       echo "--empty                    : vide la corbeille et affiche le nombre de "
       echo "fichiers supprimés, ainsi que le nombre d’octets libérés"
       echo
        ;;

    --liste)
    echo "Voici les fichier contenu dans la corbeille : "
    ls $HOME/waste
    ;;

    --suppress)
    shift
    for i in $*
    do
    if [ -f $1 ]
    then
        echo "Fichier $1 déplacé dans la corbeille"
        mv $1 $HOME/waste/
        shift
    else
        echo "Usage : ./waste.sh --suppress [FICHIERS]"
        echo "le fichier $1 n'est pas valide"
        exit
    fi
    done 

    

    ;;

    --restore)
    if [ -z $2 ] || [ -z $3 ]
    then
        echo "Usage : ./waste.sh --restore [FICHIER] [CHEMIN]"
        exit
    fi
    mv $2 $3
    echo "Fichier restauré a l'adresse $3"
    ;;

    --empty)
    ls -Al $HOME/waste 
    # echo "La corbeille a été vidé"
    ;;

esac
