#!/bin/bash

SERVICES=("web" "catalogue" "mongoDB" "shipping")

for svc in ${SERVICES[@]}
do
    echo $svc
done