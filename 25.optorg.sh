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
    esac

done