#********************************************************************************
#*  bitesize:  Outputs the size in bytes of a copybook            
#*                                     
#*  Author:    CWOODS                   
#*
#*  09/26/95   Cynthia Ledesma    Modified directory structure
#********************************************************************************

#  Copy files to local directory
Local=0;
cp /css/devtools/common/host/data/SWBS001.pco .
cp /css/devtools/common/host/data/SWBS001.mak .

# Check if copybook parameter entered
filename=$1;
filename=${filename:?"Syntax: bitesize <copybook>"};

if [[ -a $1 ]]; then
{
    cp $1 TEMP
    Local=1 
}
elif [[ -a $HOST_APPL/source/copy/lib/$1 ]]; then
{   cp $HOST_APPL/source/copy/lib/$1 . 
    cp $1 TEMP
}
elif [[ -a  $HOST_APPL/source/copy/nongen/$1 ]]; then
{
    cp  $HOST_APPL/source/copy/nongen/$1 .
    cp $1 TEMP
}
elif [[ -a  $HOST_APPL/source/copy/cuv/$1 ]]; then
{
    cp  $HOST_APPL/source/copy/cuv/$1 .
    cp $1 TEMP
}
else
{
    print "$1 does not exist." 
    exit
}
fi

#  Compile module to display bitesize
touch SWBS001.pco;
make -f SWBS001.mak;

#  Run program
SWBS001;

#  Cleanup local directory
rm -f TEMP;
if [[ Local -ne 1 ]]; then
    rm -f $1
fi
rm SWBS001.o; 
rm SWBS001.int;
rm SWBS001.cbl;
rm SWBS001;
