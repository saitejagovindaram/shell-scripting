#!/bin/bash

ls -ltr > temp.log # by defalut stores only success output to temp.log

# 1 --> for success output
# 2 --> for failure output
# & --> both success and failure

ls -ltr 1> temp1.log
lssdfd -ltr 2> temp2.log
ls -ltr &> temp3.log

#appending
ls -ltr 1>> temp1.log
lssdfd -ltr 2>> temp2.log
ls -ltr &>> temp3.log