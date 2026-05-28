# SCCS: %M%  %I%  %G%  %U%
##################################################################################
# ScriptName: morph.ksh
# Purpose   : converts filenames to whatever case the user specified and either do 
#             a move or copy depending on the input
#
# Date		Programmer		Action
# -------	----------		------------
###################################################################################
while getopts ":ulcf:" opt; do
	case $opt in
	  u ) Upper=1 ;;
	  l ) Lower=1 ;;
	  c ) Copy=1  ;;
	  f ) Files=$OPTARG ;;
	  \? ) print 'usage: morph [-u (to uppercase)] [-l (to lowercase)] [-c (copy not move)] -f<file pattern> '
			print '	[<match regexp> <replace regexp>]'
			return 1
	esac
done
shift $(($OPTIND - 1))

for filename in $Files ; do
	newfilename=$filename
	if [[ -n $Lower ]]; then
		newfilename=$(print $newfilename | tr [A-Z] [a-z])
	fi
	if [[ -n $Upper ]]; then
		newfilename=$(print $newfilename | tr [a-z] [A-Z])
	fi
	newfilename=$(print $newfilename | sed "s/$1/$2/1")
	print "$filename -> $newfilename"
	if [[ -n $Copy ]]; then
		cp $filename $newfilename
	else
		mv $filename $newfilename
	fi
done
