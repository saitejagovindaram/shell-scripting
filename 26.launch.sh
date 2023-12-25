#!/bin/bash

SERVICE=("web" "catalogue" "mongoDB" "shipping")

while IFS=' ' read -r svc
do
    echo $svc
done <<< "$SERVICE"