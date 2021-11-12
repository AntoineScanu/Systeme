#!/bin/bash
exec=0

if [[ !(-z $1) ]]
then
    target=`grep -o $1 makefile | head -n 1`
    if [ $1 == $target ]
    then
        dependances=`grep ^$target makefile | cut -d":" -f2`
        for dep in $dependances
        do
            ./make.sh $dep
            if [ $dep -nt $target ]
            then
                exec=1
            fi
        done
        if [ $exec -eq 1 ]
        then
            num=`grep -n $target makefile | head -n 1 | cut -d":" -f1`
            ((num++))
            command=`sed -n "$num"p makefile`
            $command
        fi
    else
        echo "Ce fichier n'est pas dans le makefile"
        exit
    fi
else
    echo "Veuillez rentrer un fichier"
    exit
fi