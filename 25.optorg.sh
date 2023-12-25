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
            Name="$OPTARG";;
        w) 
            wishes="$OPTARG";;
        h)
            usage; exit;;
        :) 
            usage; exit;;
        \?) 
            # echo "invalid options: -"$OPTARG"" >&2; 
            # usage; 
            exit;;
        
    esac

done

if [ $OPTIND -eq 1 ] && [ -z $Name ]; then
    usage
fi

if [ -z $Name ]; then
    echo "Name is empty"
    exit 1
fi