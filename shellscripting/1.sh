!#/bin/bash
###################Day 01################
for I in {1..10}; do
    echo $(date) | awk -F " " 'print $1,$2'
    sleep 1
done

aws s3 ls | cut -d " " -f 2,3,4
aws s3 ls | awk -F " " 'print $3,$2,$1'

aws s3 ls | cut -d ' ' -f 3 | grep -E www[.,-] ###expression what you want

set -x ##debugging tools script file

#################Day 02 #########################
##Passing params $0,$1,$2,$3
##exit code 0 success
##exit code 1 after error
##Undestanding of $?,$@,$*,$#
##Output redirection

aws ec2 describe-vpcs --region us-east-1 | jq ".Vpcs[].VpcId" -r ##another way to do

aws ec2 describe-vpcs --region us-east-1 | jq ".Vpcs[].VpcId" | tr -d '"'

##special type of file /dev/null everything discarded
###This part is used to suppress error messages. In Linux, 2 refers to the stderr (standard error stream), and > /dev/null redirects any errors (if there are any) to /dev/null, which is a special location that essentially discards the data (like a "black hole").

##$?
#!/bin/bash
awd --version
if [ $? -eq 0]; then
    REGION=$1
    aws ec2 describe-vpcs --region ${REGION} | jq ".Vpcs[].VpcId" -r
else
    echo "Incorrect Command "
fi

##$@
#aws --version
if [ $# -gt 0 ]; then
    if [ $? -eq 0]; then
        REGIONS=$@
        for REGION in ${REGIONS}; do
            echo "#########################################"
            echo "This is for ${REGION}"
            aws ec2 describe-vpcs --region ${REGION} | jq ".Vpcs[].VpcId" -r
            echo "#########################################"
        done
    else
        echo "Incorrect command"
    fi
else
    echo "Provide arguments"
fi

###$?: Returns the exit status of the last command executed.
##$@: Expands to all the positional parameters (arguments) as separate words.
###$*: Expands to all the positional parameters as a single word (all arguments combined into one string).
##$#: Returns the number of positional parameters (arguments) passed to the script.

#######################Day 03###############################################

##Output redirection
##1 is the unsuccessfull commands showing 1 > /dev/null
##$2 is the successful commands showing 2 > /dev/null

#>
##>> append lines
##tee /tmp/tee01
##for is the know the limits use for loop
##untill then goal is reach use while loop

##############################Day 04###############################################
##User automations
##cat /etc/passwd | grep -i -w ubuntu

############################Day 05 ################################################
##regex
##arrays
echo ${NAME[@]:0:3}

###########################Day 06 #######
##Functions scripts
##crontab */10**** every 10th minute
