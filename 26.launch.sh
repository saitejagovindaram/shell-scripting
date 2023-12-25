#!/bin/bash

SERVICE=("web" "catalogue" "mongoDB" "shipping")

while read svc
do
    echo $svc
done <<< "$SERVICE"