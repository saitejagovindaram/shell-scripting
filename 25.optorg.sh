#!/bin/bash

Name=""
wishes="Good Morning"

usage(){
    echo "-n is mandatory"
    echo "-w, default value is Good Morning"
}

while getopts "n:w:h" flag
do
    case $flag in
        n) 
            Name="$OPTORGS";;
        w) 
            wishes="$OPTORGS";;
        h)
            usage; exit;;
        :) usage; exit;;
        \?) echo "invalid options: -"$OPTARGS"" >&2; usage; exit;;
        
    esac

done

if [ $OPTIND -eq 1 ]; then
    usage
    exit 1
fi