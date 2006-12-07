#####################################################
# ScriptName :  cleanup.ksh
# Purpose    :  delete copies of files
#
# Date		Programmmer		Action
# ~~~~~~~~	~~~~~~~~~~~~~~		~~~~~~~~
#
#####################################################

for comdir in cu*cw
do
	if [[ -d $comdir ]]
	then
		for file in $comdir/*
		do
			if [[ -f $file ]]
			then
				base=${file##*/}
				print "Comparing $file with $base \n"
				diff $file $base > /dev/null
				if [[ $? = 0 ]]
				then
					print "Deleting $base"
					rm -f $base
				else
					print "$file and $base are different"
					ll $file $base
				fi
			fi
		done
	fi
done
