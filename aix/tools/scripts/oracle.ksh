#!/bin/ksh

# Get oracle related variables from configuration file.
typeset -i ctr
ctr=0
CONFIG_PATH=/css/devtools/common/host/scripts

if [[ -f $CONFIG_PATH/.oracle.ini ]]; then
    cat $CONFIG_PATH/.oracle.ini | while read line > /dev/null
    do
        if [[ `echo $line |grep "#"` != "$line" ]]; then
            if [[ $ctr = 0 ]]; then
                MANAGER_PASSWORD=$line
            fi
            if [[ $ctr = 1 ]]; then
                PRISTINE_PASSWORD=$line
            fi
            if [[ $ctr = 2 ]]; then
                SHARED_PASSWORD=$line
            fi
            if [[ $ctr = 3 ]]; then
                UNIX_PASSWORD=$line
            fi
            ctr=ctr+1
        fi
    done
fi
