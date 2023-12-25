#!/bin/bash

Name=""
wishes="Good Morning"

usage(){
    echo "-n is mandatory"
    echo "-w, default value is Good Morning"
}

while getopts "n:w:h" flag; do
    case $flag in
        n) 
            Name="$OPTARG";;
        w) 
            wishes="$OPTARG";;
        h)
            usage; exit;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            usage; exit 1;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage; exit 1;;
    esac
done

if [ $OPTIND -eq 1 ] && [ -z $Name ]; then
    usage
fi

if [ -z $Name ]; then
    echo "Name is empty"
    exit 1
fi