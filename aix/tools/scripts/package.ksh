#!/bin/ksh 
function prompt_usage
{
    print "Usage package.ksh <ini file> <list file> "
    return
}

function copy_to_dir
{
    mkdir -p $to_dir
    cp -fR $from_dir_path $to_dir_path
    if [[ $? != 0 ]]; then
        print "Could not copy $from_dir_path $to_dir_path" >> $long_error_file
        print $line >> $short_error_file
    fi
}

ERROR=1
SUCCESS=0
SET=1
UNSET=0
long_error_file=ErrorOutput.txt
short_error_file=error.log

INI_FILE=$1
LST_FILE=$2

rm -f $long_error_file $short_error_file

if [[ $# != 2 ]]; then
    prompt_usage
    exit $ERROR
fi

if [[ ! -s $INI_FILE ]]; then
    print "Invalid ini file $INI_FILE "
    exit $ERROR
fi

if [[ ! -s $LST_FILE ]]; then
    print "Invalid list file $LST_FILE"
    exit $ERROR
fi

typeset -i ctr
ctr=1
cat $INI_FILE| while read line > /dev/null
do
    if [[ `echo $line |grep "#"` != "$line" ]]; then
        if [[ $ctr = 1 ]]; then
            CLIENT_SRC=$line
        fi
        if [[ $ctr = 2 ]]; then
            CLIENT_TARGET=$line
	fi
        if [[ $ctr = 3 ]]; then
            HOST_SRC=$line
	fi
        if [[ $ctr = 4 ]]; then
            HOST_TARGET=$line
	fi
        if [[ $ctr = 5 ]]; then
            MFHOST_SRC=$line
	fi
        if [[ $ctr = 6 ]]; then
            MFHOST_TARGET=$line
	fi
        ctr=ctr+1
    fi
done

if [[ ! -d $CLIENT_SRC ]]; then
    print "Invalid directory $CLIENT_SRC" 
    exit $ERROR
fi
if [[ ! -d $CLIENT_TARGET ]]; then
    print "Invalid directory $CLIENT_TARGET"
    exit $ERROR
fi
if [[ ! -d $HOST_SRC ]]; then
    print "Invalid directory $HOST_SRC"
    exit $ERROR
fi
if [[ ! -d $HOST_TARGET ]]; then
    print "Invalid directory $HOST_TARGET"
    exit $ERROR
fi
if [[ ! -d $MFHOST_SRC ]]; then
    print "Invalid directory $MFHOST_SRC"
    exit $ERROR
fi
if [[ ! -d $MFHOST_TARGET ]]; then
    print "Invalid directory $MFHOST_TARGET"
    exit $ERROR
fi

src_dir=$CLIENT_SRC
target_dir=$CLIENT_TARGET
TOOL_FLAG=$UNSET

cat $LST_FILE | while read line > /dev/null
do
    if [[ `echo $line |grep "#"| wc -l` = 0 ]]; then
        case $line in
 	    CLIENT) TYPE_LINE=$SET; src_dir=$CLIENT_SRC; target_dir=$CLIENT_TARGET; TOOL_FLAG=$UNSET;;
            MVS)    TYPE_LINE=$SET; src_dir=$MFHOST_SRC; target_dir=$MFHOST_TARGET; TOOL_FLAG=$UNSET;; 
            UNIX)   TYPE_LINE=$SET; src_dir=$HOST_SRC;   target_dir=$HOST_TARGET;   TOOL_FLAG=$UNSET;;
	    MISC)   TYPE_LINE=$SET; target_dir=$HOST_TARGET;                        TOOL_FLAG=$SET;;
        esac

        if [[ $TYPE_LINE != $SET ]]; then
            if [[ `echo $line |grep " R"` = $line ]]; then
                if [[ $TOOL_FLAG = $UNSET ]]; then
                    tempdirpath=$(echo $line | cut -d" " -f1)
                    tempdirpath2=${tempdirpath%/*}
                    from_dir_path=$src_dir/$tempdirpath
                    to_dir_path=$target_dir/$tempdirpath2
                    to_dir=$target_dir/$tempdirpath
                    copy_to_dir
                else
                    from_dir_path=$(echo $line | cut -d" " -f1)
                    tempdirpath=$(echo $line | cut -d" " -f2)
                    to_dir_path=$target_dir/$tempdirpath 
                    to_dir=$target_dir/$tempdirpath
                    copy_to_dir
                fi
            else
                if [[ $TOOL_FLAG = $UNSET ]]; then
                    to_dir_path=$target_dir/$line
                    from_dir_path=$src_dir/$line
                    to_dir=${to_dir_path%/*}
                    copy_to_dir
                else
                    from_dir_path=$(echo $line | cut -d" " -f1)
                    tempdirpath=$(echo $line | cut -d" " -f2)
                    to_dir_path=$target_dir/$tempdirpath
                    to_dir=${to_dir_path%/*}
                    copy_to_dir
                fi
            fi
        fi
    fi
    TYPE_LINE=$UNSET
done
