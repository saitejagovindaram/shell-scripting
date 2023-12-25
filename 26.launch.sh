#!/bin/bash

SERVICE=("web" "catalogue" "mongoDB" "shipping")

while read -r svc
do
    echo $svc
done <<< $SERVICE