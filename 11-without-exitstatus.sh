#!/bin/bash

set -e  #when kept at the top of script it will automatically check the exit status 
        #and move forward in the script, if exit status of line 4 is not 0 then script will stop its execution at line 4 only. 
        #it has DrawBack not suits for all scenarios.

ls -ltr

mkdir /app