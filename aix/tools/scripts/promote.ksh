#!/bin/ksh 
###########################################################################################
# ScriptName :  promote.ksh
# Description:  This is to promote codes from the Build environment to a 
#               specified environment area in as240227.
# Usage      :  promote.ksh <tvspacw> <module name> <area> <sir no>
#               options:
#                          t   -   module type (for file w/o extension)
#                          v   -   version label for ddl module 
#                          s   -   SIR number
#                          a   -   dialog or comwin (if workunit is csrmap)"
#                          p   -   dialog name or comwin name (e.g. cucl01)"
#                          f   -   NOT to migrate to client
#                          c   -   compile COBOL file in the specified
#                                  environment 
#                                  (without actual re-promotion)
#                          s   -   Call stp.ksh script to actual ftp (Emergency SIRS.)"
#                          d   -   DO NOT write to the File Transfer spreadsheet 
#                          e   -   emergency SIR (for File Transfer spreadsheet)
#                          m"memo/comment" - memo/comment description. (optional for spreadsheet)
#                          i"issue"        - issue number(s). (required for T5).
#
#
# Date       Programmer         Action
# --------------------------------------------
# 09/09/96   Cynthia Ledesma    Original code.
# 10/08/96   Cynthia Ledesma    Added call to mvsport and option to 
#                               migrate all the way up to SOCO.
# 11/18/96   Marc Danneels      Commented out the current date pass to mvsport
# 12/10/96   Scott Shepherd     Added logic to promote .pdb files for dialogs and       
#                               common windows. 
# 12/18/96   Scott Shepherd     Improved FTP error handling.
# 12/19/96   Scott Shepherd     Added copy and ftp to DDE dir for .dot .xls and .xlm files.
# 01/08/97   Scott Shepherd     Changed logic to promote .hh and .hlp files independently
#                               of their workunits.
# 01/13/97   Scott Shepherd     Added check for vcs executable befor continuing.
# 01/27/97   Scott Shepherd     Removed firewall ip address.
# 02/04/97   Scott Shepherd     Added function to append a flat file for T4. Created a function
#                               that ftp's that file to as240224.  Removed the -s option and 
#                               made SIR # mandatory. 
# 02/19/97   Scott Shepherd     Changed so that you can enter multiple sir numbers.  Also 
#                               enitire help projects are flagged itest and all *.hlp .hh files 
#                               are promoted.
# 03/10/97   Scott Shepherd     Chaned so that is no longer project specific.
# 04/03/97   Scott Shepherd     Added the type files to promote the checker flat files conta
# 04/13/97   Scott Shepherd     Fixed so that it will promote cssfunc.
# 04/15/97   Scott Shepherd     Made changes to t4 processing.
# 05/02/97   Scott Shepherd     Changed ownership and group of psc files created.
# 05/21/97   Scott Shepherd     Removed all harded coded itest references to make script more
#                               generic.  Also added a new parameter for the project.  Error    
#                               handling was added for the project. 
# 05/29/97   Scott Shepherd     Changed messages printed during processing.
# 06/10/97   Scott Shepherd     Added -o option that will make sir number optional.  Also added
#                               logic to promote the related server for a lib copybook that 
#                               ends with I or O.
# 06/28/97   Scott Shepherd     Added logic to read group and ARCH_ENV from ini files.
# 07/23/97   Gauri Gavankar     Fixed automatic promotion of sfe's.
# 08/01/97   Scott Shepherd     Changed so that CUF* front end server will be promoted when
#                               lib copy book is promoted.
# 08/18/97   Scott Shepherd     Added -n option to only ftp instead of doing an actual promotion.
#                               Added logic to put files the the SW Transfer area instead of doing
#                               a direct ftp to client site.
# 08/27/97   Scott Shepherd     Added -s option to call stp.ksh script to automatically ftp files
#                               to client site.
# 09/02/97   Khim Theng         Added logic to ftp scripts and cards to the SW Transfer Area.
# 09/08/97   Khim Theng         Added logic to print parameters to a File Transfer Checklist
#                               spreadsheet for the client.
# 09/12/97   Khim Theng         Added logic to sort unique the File Transfer Checklist spreadsheet
#                               before ftp'ing to the SW Transfer Area.
# 09/16/97   Scott Shepherd     Added a copy for xlt maps to the xlt hold area.
# 09/17/97   Khim Theng         Changed promotion spreadsheet name to PR*date.csv.
# 09/18/97   Scott Shepherd     Added functionality to copy xlt maps to hold directory.
# 10/07/97   Khim Theng         Added logic to call itself (promote.ksh) when promoting server
#                               front ends with I/O copybooks when the -n option is used.
# 10/07/97   Khim Theng         Added ability to transfer multiple files with dialogs/comwins
#                               when calling stp.ksh for emergency promotions.
# 10/09/97   Khim Theng         Changed the directory path of the .csv file to go to the 
#                               /TO/PROMOTION directory instead of the /TO/DATA/ directory.
# 10/23/97   Scott Shepherd     Added $$ onto the end of the temporary csv file.  Removed logic
#                               that checked for #-#####-# format.  
# 11/04/97   Scott Shepherd     Removed -o option. Removed project hard codes to create spread sheet
#                               prefix name.
# 12/08/97   Khim Theng         Added logic to sent the mvsported version of host copybooks and server
#                               front ends to the client site when the -n option is passed.
# 12/19/97   Khim Theng         Added logic to support a new SVT Staging environment.  If the parameter
#                               for the SVT Staging environment is set, then print to a log file and 
#                               promote to the svtstage environment.  This log file will be used by 
#                               a batch script in cron to promote from svtstage to the svt environment.
# 01/07/98   Scott Shepherd     Changed for 1-16834-1.  Modify to prevent promotions to ITest/SVT if the current
#                               version in ITest/SVT has not been pulled by client site.
# 01/09/98   Scott Shepherd     Change Production VCS to flag the version that is in ITest.
# 01/15/98   Ed Deutscher       Added code to not promote the .pdb code for cssfunc for specified projects.
# 01/16/98   Ed Deutscher       Added code to promote the .cnt files for help projects according to the client.
# 02/04/98   Khim Theng         Added logic to promote to the client sites mvsported version host code, UNIX 
#                               version host code, or both depending on the switch specified in the project's 
#                               .ini file.  Also, added CopyToSpreadsheet function to copy to the File Transfer
#                               spreadshet.
# 02/20/98   Khim Theng         Added logic to check in the project .ini file to determine if an issue number
#                               is required for promotion.
# 03/25/98   Scott Shepherd     Changed line so that TRfilename get set to $file instead of $filename.
# 04/06/98   Khim Theng         Added logic to send the .c server files to UNIX client sites.
# 04/10/98   Scott Shepherd     Uncommented code that was commented out.  Documented in code.
# 04/15/98   Khim Theng         Added logic to create the vcs.cfg file if the -cn option is used.
# 04/16/98   Khim Theng         Took out hard coded STP server name and put it in the .ini file.
# 04/21/98   Ed Deutscher       Changed check_production_flag to not prompt user whether to
#                               overwrite existing modules when promting to itest when the module
#                               did not already exist in itest.
# 04/23/98   Ed Deutscher       Changed permissions on files transferred to client sites to 777 in
#                               transfer_to_clients
# 04/29/98   Khim Theng         Added logic in the transfer_to_clients function to change the group
#                               of files placed in the STP transfer area to fcp. 
# 05/11/98   Khim Theng         Added logic to send the .sdt and .wdt files to UNIX clients when promoting
#                               server front ends.
# 05/29/98   Ed Deutscher       Added logic to promote dat files.  Added logic to write to the dat
#                               and xlt log files which will be used for the CTE Table Load process.
# 06/17/98   Khim Theng         Added logic to include: ability to pass in a list of different types
#                               of modules, a new STP area check, ability to tar up all modules and
#                               the promotion spreadsheet into one file, create a spreadsheet for each
#                               promotion, and send the tar file immediately after the promotion.
#                               (issue #7326, #7747, #10050)
# 06/22/98   Khim Theng         Added logic for promoting static data (issue #7326). 
# 07/08/98   Khim Theng         Added logic to send the recsize.txt file for all T4 and T5 clients
#                               except for PPL whenever a promotion of a static data occurs.  Also,
#                               added logic to promote cuar20b (AAR) dialog.
# 07/14/98   Khim Theng         Removed hard coded PVCS password (issue #2808).
# 08/12/98   Khim Theng         Added logic to insert new issue number, MVS, and UNIX columns on the
#                               promotion spreadsheet (issue #6285).
# 08/24/98   Khim Theng         Add logic to ftp the .psc file to the migration server if the migration
#                               server does not match the working server (to remove copies to a cross
#                               mounted server).
# 08/31/98   Ed Deutscher       Added logic to compile client objects upon promotions, contained in 
#                               the function CompileClientObjects.
# 09/02/98   Khim Theng         Added type "copyintrface" (issue #10048).
# 08/26/99   Shawn Hyde         Changed temp location to /var/tmp instead of /mass_work
# 09/06/00   Suresh Pellakur    changed logic to go all clientside modules to svt directory in transfer Drive.
# 09/11/00   Suresh Pellakur    Added logic for XLTmaps to go to host/svt/source instead of host/mfsvt/source.
# 12/11/00   Suresh Pellakur    Issue# 78782- Remove .dot files from Promotion Process. As Developers directly
#                               make changes to .dot files in PTST.
# 09/26/01  Suresh Pellakur     Work Item# :  81890 - Tools change to support Recompiles Issue
#                               Chg CreateTar procedure to allow Recompiles source go to recompile directory in
#                               Transfer G: Drive.
#################################################################################################################


#######################
# FUNCTION DEFINITION #
#######################

#----------------#
# Display usage. #
#----------------#
function prompt_usage {
    print "\nUsage:   promote.ksh [tvapfocnsdei] <workunit> <area> <project> <sir no>"
    print "         OR"
    print "         promote.ksh [tvapfocnsdei] -l<list name> <area> <project> <sir no>"
    print "\nOptions:"
    print "         <workunit> - name of dialog comwin module etc."
    print "         <area>     - environment where to promote <workunit> to (itest, svt, svtstage)"
    print "         <project>  - transfer project (T3 = base, T4 = t4_ce t4_or, T5 = t5am t5me t5nm t5ppl)" 
    print "         <sir no>   - an unlimited amount of SIR numbers."
    print "                t   - module type (for file w/o extension)"
    print "                v   - version label for ddl module "
    print "                a   - dialog or comwin (if workunit is csrmap)"
    print "                p   - dialog name or comwin name (e.g. cucl01)"
    print "                f   - NOT to migrate to client site"
    print "                c   - compile COBOL module, comwin, or dialog in the specified environment (without actual re-promotion)"
    print "                n   - Only put modules into transfer area from ITest/SVT (without actual re-promotion)"
    print "                s   - Call stp script to actual ftp (T3 Emergency SIRS.)"
    print "                d   - Do NOT write to File Transfer spreadsheet"
    print "                e   - Emergency SIR (for File Transfer spreadsheet only)"
    print "                l<list name>  - name of the master list (optional for using a master list)"
    print "                m\"memo/comment\" - memo/comment description. Put in quotes. (optional for spreadsheet)"
    print "                i\"issue\" - issue number(s). Put in quotes. (required for T5)\n"
}

#----------------------------------#
# Create Migration file for Target #
#----------------------------------#
function MigrateToTarget {
    

   if [[ $Migrate = $SET ]]; then
        TEMP_LOG=targetvlog.log
        REV_FLAG=$UNSET
        FIELD=5

        vlog -C$CURR_DIR/$CONFIG_FILE -Q -BG$VCS_LEVEL $TargetFileName > $TEMP_LOG 

        line=`grep : $TEMP_LOG` 
        if [[ $? = 0 && -s $TEMP_LOG && `grep : $TEMP_LOG |wc -w` = $FIELD ]]; then
            revision=$(print $line | cut -d" " -f$FIELD)
        else
            print "MIGRATE ERROR: Attempt to get revision number failed."
            return $ERROR
        fi

        ext=$(print $TargetFileName | cut -d'.' -f2)
        if [[ $ext = pco ]]; then
            module_Target=$TargetFileName
        else
            module_Target=$module
        fi

        if [[ -n $sir && -n $module_Target && -n $type && -n $TargetFileName && -n $revision && -n $archpath && -n $refpath && -n $create_date ]]; then
            if [[ `hostname` = $MIGRATION_SERVER ]]; then
                print "Copying $TargetFileName to ${MIGRATION_SERVER}:$MIGRATION_FILE"
                print "$sir|$module_Target|$type|$TargetFileName|$revision|$archpath/$nt_dir|$refpath/$nt_dir|$create_date" >> $MIGRATION_FILE
                rm -f $TEMP_LOG
                return $SUCCESS
            else
                ## FTP TO MIGRATION SERVER ##
                print "$sir|$module_Target|$type|$TargetFileName|$revision|$archpath/$nt_dir|$refpath/$nt_dir|$create_date" >> pscfile.tmp
                psc_file=pscfile.tmp
                transfer_psc_file
                rm -f pscfile.tmp
                rm -f $TEMP_LOG
                return $SUCCESS
            fi
        else
            print "MIGRATE ERROR: Attempt to create migration file failed."
            return $ERROR
        fi
    else
        return $SUCCESS
    fi
}

#--------------------------------#
# check_production_flag function #
#--------------------------------#
function check_production_flag
{
    DecidedAnswer=$UNSET
    ErrorProdFlag=$UNSET
    vlog -C$CURR_DIR/$CONFIG_FILE -BG$VCS_LEVEL -Q $prodfile > $LOG_FILE
    vlog -C$CURR_DIR/$CONFIG_FILE -BGProduction -Q $prodfile > $LOG_FILE2

    if [[ `grep : $LOG_FILE |wc -w` = 5 && `grep : $LOG_FILE2 |wc -w` = 5 ]]; then
        nextenv_rev=$(cat $LOG_FILE  | cut -f5 -d" ")
        prodenv_rev=$(cat $LOG_FILE2 | cut -f5 -d" ")
        rm $LOG_FILE $LOG_FILE2 2> /dev/null
        if [[ $nextenv_rev != $prodenv_rev ]]; then
            ErrorProdFlag=$SET
        else
            ErrorProdFlag=$UNSET
        fi
    elif [[ `grep : $LOG_FILE |wc -w` = 5 ]]; then
        nextenv_rev=$(cat $LOG_FILE  | cut -f5 -d" ")
        prodenv_rev="NOT FOUND"
        ErrorProdFlag=$SET
    else
        ErrorProdFlag=$UNSET
    fi

    if [[ $ErrorProdFlag = $SET ]]; then
        while [[ $DecidedAnswer != $SET ]];
        do
            echo "\nWARNING: $prodfile has revision $nextenv_rev in $AREA_DEST and $prodenv_rev in production.\n"
            if [[ $IOConfirmFlag != $SET ]]; then
                echo "Do you wish to continue? (y or n) \c"
                read response
            elif [[ $FullList_flag = $SET && ! -z $listresponse ]]; then
                echo "Do you wish to continue? (y or n) \c"
                read response
            fi

                response=`print $response | tr "[:upper:]" "[:lower:]"`
                if [[ $response = "y" || $response = "yes" ]]; then
                    DecidedAnswer=$SET
                    continue
                elif [[ $response = "n" || $response = "no" ]]; then
                    DecidedAnswer=$SET
                    ## SHOULD THIS BE PLACED HERE ??? ##
                    if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then 
                        if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                            print "\nDeleting $TAR_FILE."
                            rm -f $MASSWORK_DIR/$TAR_FILE
                        fi
                    fi
                    if [[ $Sprdsht_flag = $SET ]]; then
                        if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                            print "\nDeleting $T_PROJECT.temp.csv.$$."
                            rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                        fi
                    fi
                    Remove_temp_files
                    exit $ERROR
                else
                    print "ERROR: Cannot recognize decision -> $response"
                    DecidedAnswer=$UNSET
                    DisplayOptions
                fi
        done
    fi

    return $SUCCESS
}

#------------------#
# Tranfer function #
#------------------#
function transfer_to_clients
{
    if [[ `hostname` != $STP_SERVER ]]; then
        if [[ $transfer_file = "*.*" || $transfer_file = "*.hh" ]]; then
            put_cmd=mput
        else
            put_cmd=put 
        fi

        ftp -v -n <<EOF > xfer.log 2>xfer.err
            open $STP_SERVER
            user pvcs $PVCS_PASSWORD 
            lcd $SOURCE_DIR 
            mkdir $TRANSFER_DIR
            cd  $TRANSFER_DIR
            binary
            $put_cmd  $transfer_file
            chmod 777 $transfer_file
            bye
EOF

        FTPNO=`grep -v "bytes sent" xfer.log | grep -E "^[45][0-9][0-9]" | cut -c1-3`

        if [ ! $FTPNO -o $FTPNO -lt 400 -o $FTPNO -eq 550 ]; then
            if  [[ ! -s xfer.err ]]; then
                print "$module: Successful ftp to $T_PROJECT transfer area - $TRANSFER_DIR/$transfer_file "
#                /sw/devtools/common/host/rexec/rexec $STP_SERVER -l pvcs -p $PVCS_PASSWORD "chgrp fcp $TRANSFER_DIR/$transfer_file"
#                /sw/devtools/common/host/rexec/rexec $STP_SERVER -l pvcs -p $PVCS_PASSWORD "chmod 777 $TRANSFER_DIR/$transfer_file"
                if [[ $STP_flag = $SET && $TAR_STP_File_Flag != $SET ]]; then
                    if [[ -a list.temp ]]; then
                        rm -f list.temp
                    fi
                    ## NEW ##
                    if [[ $Emergency_STP_Exist_Flag = $SET ]]; then
                        ## CALL STP WITH THE -HF OPTIONS. LEAVE THE FILE IN THE STP AREA. ##
                        rexec $STP_SERVER -l pvcs -p $PVCS_PASSWORD "ls $TRANSFER_DIR/$transfer_file" >> list.temp
                        print "Running STP ..."
                        for file in $(<list.temp)
                        do
                            echo "  "
#                           rexec $STP_SERVER -l pvcs -p $PVCS_PASSWORD  "/sw/devtools/common/host/scripts/stp -hf $file $T_PROJECT"
                        done
                    else
                        ## CALL STP ON THE NORMAL file and remove the file from the STP area. ##
                        rexec $STP_SERVER -l pvcs -p $PVCS_PASSWORD "ls $TRANSFER_DIR/$transfer_file" >> list.temp
                        print "Running STP ..."
                        for file in $(<list.temp)
                        do
			    echo "Attempting stp"
#                           rexec $STP_SERVER -l pvcs -p $PVCS_PASSWORD  "/sw/devtools/common/host/scripts/stp -f $file $T_PROJECT"
                        done
                    fi
                fi
            else
                echo "ERROR: FTP of $transfer_file to transfer area failed!"
            fi
        else
            echo "ERROR: FTP of $transfer_file to transfer area failed!"
        fi

        rm -f xfer.log 2> /dev/null
        rm -f xfer.err 2> /dev/null
    else
        mkdir -p $TRANSFER_DIR 2>/dev/null
        cp -fp $SOURCE_DIR/$transfer_file $TRANSFER_DIR/
        if [[ $? != 0 ]]; then
            echo "ERROR: Copy of $transfer_file to transfer area failed!"
            print $module >> $CURR_DIR/unsuccessful.promote
        else
            print "$module: Successful copy to $T_PROJECT transfer area - $TRANSFER_DIR/$transfer_file "
            chmod 666 $TRANSFER_DIR/$transfer_file
            chgrp fcp $TRANSFER_DIR/$transfer_file
            if [[ $STP_flag = $SET && TAR_STP_File_Flag != $SET ]]; then
                if [[ -a list.temp ]]; then
                    rm -f list.temp
                fi
                ## NEW ##
                if [[ $Emergency_STP_Exist_Flag = $SET ]]; then
                    ## CALL STP WITH THE -HF OPTIONS. LEAVE THE FILE IN THE STP AREA. ##
                    ls $TRANSFER_DIR/$transfer_file >> list.temp
                    print "Running STP ..."
                    for file in $(<list.temp)
                    do
                     echo "  "
                     #  mmon/host/scripts/stp -hf $file $T_PROJECT
                    done
                else 
                    ## CALL STP ON THE NORMAL file and remove the file from the STP area. ##
                    ls $TRANSFER_DIR/$transfer_file >> list.temp
                    print "Running STP ..."
                    for file in $(<list.temp)
                    do
                       echo "/sw/devtools/common/host/scripts/stp -f $file $T_PROJECT"
                    done
                fi
            fi
        fi
    fi
    Emergency_STP_Exist_Flag=$UNSET
}

#-------------------------------------------------------------------------------#
# Ftp <sir>.psc file to the /sw/pvcs/psc directory on the MigTool target server #
#-------------------------------------------------------------------------------#
function transfer_psc_file
{
    ftp -v -n <<EOF > xfer.log 2>xfer.err
        open $MIGRATION_SERVER
        user pvcs $PVCS_PASSWORD
        cd  $PSC_LOC
        binary
        append $psc_file $sir.psc
        chmod 777 $psc_file
        bye
EOF

        FTPNO=`grep -v "bytes sent" xfer.log | grep -E "^[45][0-9][0-9]" | cut -c1-3`

        if [ ! $FTPNO -o $FTPNO -lt 400 -o $FTPNO -eq 550 ]; then
            if  [[ ! -s xfer.err ]]; then
                # NEED TO REMOVE? #
                print "$module: Successful ftp of $TargetFileName to ${MIGRATION_SERVER}:/sw/pvcs/psc/$sir.psc"
            else
                echo "ERROR: FTP of $TargetFileName to ${MIGRATION_SERVER}:/sw/pvcs/psc/$sir.psc failed!"
            fi
        else
            echo "ERROR: FTP of $TargetFileName to ${MIGRATION_SERVER}:/sw/pvcs/psc/$sir.psc failed!"
        fi

        rm -f xfer.log 2> /dev/null
        rm -f xfer.err 2> /dev/null
}

#--------------------------------#
# Create_Tar_File function       #
#--------------------------------#
function Create_Tar_File
{
    cd $TAR_DIR
    if [[ ! -a $MASSWORK_DIR/$TAR_FILE ]]; then
    
#The following code is modified by Suresh Pellakur on 2001-09-26 

        if   [[ !  $RECOMP = "" ]]
        then 
           cp $TAR_SOURCE_DIR/$tarfilename recompile/$tarfilename 
           chmod 777 recompile/$tarfilename
           tar cf $MASSWORK_DIR/$TAR_FILE recompile/$tarfilename > $CURR_DIR/tar.output 2>&1
           rm recompile/$tarfilename
        else 
           tar cf $MASSWORK_DIR/$TAR_FILE $TAR_SOURCE_DIR/$tarfilename > $CURR_DIR/tar.output 2>&1
         fi
# end code by Suresh Pellakur for issue 81890
 
           if [[ -s $CURR_DIR/tar.output ]]; then
            print "ERROR: Unsuccessful tar of $tarfilename to new $TAR_FILE tape."
            print -n "ERROR: "
            cat $CURR_DIR/tar.output
            print "\nDeleting $TAR_FILE."
            rm -f $MASSWORK_DIR/$TAR_FILE
            if [[ $Sprdsht_flag = $SET ]]; then
                if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then 
                    print "\nDeleting $T_PROJECT.temp.csv.$$." 
                    rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                fi
            fi
            Remove_temp_files
            exit $ERROR
        else
            print "Successful tar of $tarfilename to new $TAR_FILE tape."
        fi
    else
#The following code is modified by Suresh Pellakur on 2001-09-26
        if  [[ !  $RECOMP = "" ]]
        then 
            cp $TAR_SOURCE_DIR/$tarfilename recompile/$tarfilename 
            chmod 777 recompile/$tarfilename 
            tar rf $MASSWORK_DIR/$TAR_FILE recompile/$tarfilename > $CURR_DIR/tar.output 2>&1
            rm recompile/$tarfilename
        else
               tar rf $MASSWORK_DIR/$TAR_FILE $TAR_SOURCE_DIR/$tarfilename > $CURR_DIR/tar.output 2>&1
         fi
# end code by Suresh Pellakur for issue 81890

         if [[ -s $CURR_DIR/tar.output ]]; then
            print "ERROR: Unsuccessful tar append of $tarfilename to $TAR_FILE."
            print -n "ERROR: "
            cat $CURR_DIR/tar.output
            print "\nDeleting $TAR_FILE."
            rm -f $MASSWORK_DIR/$TAR_FILE
            if [[ $Sprdsht_flag = $SET ]]; then
                if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                    print "\nDeleting $T_PROJECT.temp.csv.$$."
                    rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                fi
            fi
            Remove_temp_files
            exit $ERROR
        else
            print "Successful tar append of $tarfilename to $TAR_FILE file."
        fi
    fi
    cd -
}

function PutOracleCode
{
    cp -f $HOST_DEST/$code_loc/$filename $MFDEST_AREA/$code_loc/$filename.sw
    if [[ $? != 0 ]]; then
	oracle_port=$UNSET
        print "ERROR: $refdest/$filename could not be copied to $MFDEST_AREA/$code_loc"
	print $filename >> $CURR_DIR/unsuccessful.promote
    else
        oracle_port=$SET
	if [[ -s $MFDEST_AREA/$code_loc/$filename ]]; then
	    cp -f $MFDEST_AREA/$code_loc/$filename $HOST_DEST/$code_loc
	    if [[ $? != 0 ]]; then
	        oracle_port=$UNSET
		cp -f $MFDEST_AREA/$code_loc/$filename.sw $refdest/$filename
	        print "ERROR: $MFDEST_AREA/$code_loc/$portname could not be copied to $refdest."
		print $filename >> $CURR_DIR/unsuccessful.promote
	    else
	        oracle_port=$SET
	    fi
	else
           oracle_port=$UNSET
	    print "ERROR:  $MFDEST_AREA/$code_loc/$filename not found!"
	    print $filename >> $CURR_DIR/unsuccessful.promote
        fi
    fi
    if [[ $oracle_port = $SET ]]; then
	TransferCode
    fi
}

function RunMVSPort
{
    if [[ $compile_flag != $SET ]]; then
	cp -f $refdest/$filename $MFDEST_AREA/$code_loc/$portname
	chmod 644 $MFDEST_AREA/$code_loc/$portname
	chgrp $GROUP $MFDEST_AREA/$code_loc/$portname
	
        mvsport $T_PROJECT $MFDEST_AREA/$code_loc/$portname
	if [[ $? = 0 ]]; then
            if [[ $OracleModeFlag = $SET ]]; then
	        print "$portname: Successfully ran oracle porting."
            else
                print "$portname: Successfully ran mvsport."
            fi
	    passed_mvs=$SET
	else
	    passed_mvs=$UNSET
            if [[ $OracleModeFlag = $SET ]]; then
	        print "ERROR: $portname did not pass oracle porting."
            else
                print "Suresh Test1...\n"
                print $MFDEST_AREA/$code_loc/$filename

                print "ERROR: $portname did not pass mvsport."
            fi
            rm -f $MFDEST_AREA/$code_loc/$filename
        fi
    else
	if [[ -a $MFDEST_AREA/$code_loc/$portname ]]; then
	    passed_mvs=$SET
        else
           passed_mvs=$UNSET
            print "ERROR: $MFDEST_AREA/$code_loc/$portname not found!"
	    print $filename >> $CURR_DIR/unsuccessful.promote
	fi
    fi
    if [[ $passed_mvs = $SET ]]; then
        chmod 444 $MFDEST_AREA/$code_loc/$portname
        chgrp $GROUP $MFDEST_AREA/$code_loc/$portname
	if [[ $CLNT_flag != $SET ]]; then
	    if [[ $Host_Unix_Flag = $SET ]]; then
		PutOracleCode
            elif [[ $Host_Mvsport_Flag = $SET ]]; then
		TransferCode
            fi
            flagfile=$file
            flag_production_group
        fi
        if [[ $Sprdsht_flag = $SET ]]; then
	    TRmain_type=$main_type
	    TRsub_type=$sub_type
	    TRfilename=$portname
	    if [[ $Host_Mvsport_Flag = $SET ]]; then
	        MVS="Y"
	        UNIX=""
	    elif [[ $Host_Unix_Flag = $SET ]]; then
	        MVS=""
	        UNIX="Y"
	    fi
            BinaryChanged=""
	    CopyToSpreadsheet
        fi
    fi
}

function TransferCode
{
    if [[ $Host_Unix_Flag = $SET ]]; then
        if [[ $TAR_STP_File_Flag = $SET ]]; then
            ## TAR COMMAND ##
	    tarfilename=$filename
	    TAR_SOURCE_DIR=host/$AREA_DEST/$code_loc
	    Create_Tar_File
        else
            ## STP CHECK ##
	    if [[ $STP_Check_Flag = $SET ]]; then
	        echo "Running Check_STP_Area for $filename ..."
		checkfilename=$filename
		LIST_TRANSFER_DIR=$UNIXHOST_TRANSFER_DIR/$code_loc
		Check_STP_Area
	    fi
	    SOURCE_DIR=$HOST_DEST/$code_loc
	    TRANSFER_DIR=$UNIXHOST_TRANSFER_DIR/$code_loc
	    transfer_file=$filename
	    transfer_to_clients
        fi
        if [[ $OracleModeFlag = $SET ]]; then
	    mv -f $MFDEST_AREA/$code_loc/$filename.sw $HOST_DEST/$code_loc/$filename
        fi   
    elif [[ $Host_Mvsport_Flag = $SET ]]; then
        if [[ $TAR_STP_File_Flag = $SET ]]; then
	    ## TAR COMMAND ##
	    tarfilename=$portname
	    TAR_SOURCE_DIR=host/mf$AREA_DEST/$code_loc
	    Create_Tar_File
	else
	    ## STP CHECK ##
	    if [[ $STP_Check_Flag = $SET ]]; then
		echo "Running Check_STP_Area for $portname ..."
		checkfilename=$portname
		LIST_TRANSFER_DIR=$MFHOST_TRANSFER_DIR/$code_loc
		Check_STP_Area
	    fi
	    SOURCE_DIR=$MFDEST_AREA/$code_loc
	    TRANSFER_DIR=$MFHOST_TRANSFER_DIR/$code_loc
	    transfer_file=$portname
	    transfer_to_clients
       fi
    fi
}

#--------------------------------#
# flag_production_group function #
#--------------------------------#
function flag_production_group
{
    if [[ $Check_Production_Flag = $SET ]]; then
        vcs -C$CURR_DIR/$CONFIG_FILE -Y -Q -GProduction -R$VCS_LEVEL $flagfile
    fi
}

#----------------------------------------#
# Copy to File Transfer Spreadsheet.     #
#----------------------------------------#
function CopyToSpreadsheet {
    for sir_num in $SIR_NUMBERS 
        do
            print "$sir_num,$EMERGENCY,$SW_USER,$codetype,$TRmain_type,$TRsub_type,$RECOMP,$TRfilename,$COMMENT,$ISSUE,$MVS,$UNIX,$BinaryChanged" >> /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
            print "Insert $sir_num,$EMERGENCY,$SW_USER,$codetype,$TRmain_type,$TRsub_type,$RECOMP,$TRfilename,$COMMENT,$ISSUE,$MVS,$UNIX,$BinaryChanged to $promotion_spreadsheet\n"
       done
}

#----------------------------------------#
# Set configuration file for host file.  #
#----------------------------------------#
function sethostconfig {
    print "ReferenceDir=$HOST_REF/source/code/$type" > $CURR_DIR/$CONFIG_FILE
    print "VCSDir=$H_ARCH/source/code/$type" >> $CURR_DIR/$CONFIG_FILE
    refpath=$HOST_REF/source/code/$type
    refdest=$HOST_DEST/source/code/$type
    code_loc=source/code/$type
    archpath=$H_ARCH/source/code/$type
}

#------------------------------------------------#
# Set configuration file for other module types. #
#------------------------------------------------#
function setconfig {
   case $type in
      scripts) print "ReferenceDir=$HOST_REF/control/jobs/scripts" > $CURR_DIR/$CONFIG_FILE
               print "VCSDir=$H_ARCH/control/jobs/scripts" >> $CURR_DIR/$CONFIG_FILE
               refpath=$HOST_REF/control/jobs/scripts
               refdest=$HOST_DEST/control/jobs/scripts
               archpath=$H_ARCH/control/jobs/scripts
               code_loc=control/jobs/scripts
               LIST_TRANSFER_DIR=$HOST_TRANSFER_DIR/$code_loc
               codetype=host
               main_type=control/jobs
               sub_type=scripts;;
        cards) print "ReferenceDir=$HOST_REF/control/jobs/cards" > $CURR_DIR/$CONFIG_FILE
               print "VCSDir=$H_ARCH/control/jobs/cards" >> $CURR_DIR/$CONFIG_FILE
               refpath=$HOST_REF/control/jobs/cards
               refdest=$HOST_DEST/control/jobs/cards
               archpath=$H_ARCH/control/jobs/cards
               code_loc=control/jobs/cards
               LIST_TRANSFER_DIR=$HOST_TRANSFER_DIR/$code_loc
               codetype=host
               main_type=control/jobs
               sub_type=cards;;
      copyio)  print "ReferenceDir=$HOST_REF/source/copy/io" > $CURR_DIR/$CONFIG_FILE
               print "VCSDir=$H_ARCH/source/copy/io" >> $CURR_DIR/$CONFIG_FILE
               refpath=$HOST_REF/source/copy/io
               refdest=$HOST_DEST/source/copy/io
               archpath=$H_ARCH/source/copy/io
               code_loc=source/copy/io
               if [[ $Host_Mvsport_Flag = $SET ]]; then
                   MFLIST_TRANSFER_DIR=$MFHOST_TRANSFER_DIR/$code_loc
               fi
               if [[ $Host_Unix_Flag = $SET ]]; then
                   UNIXLIST_TRANSFER_DIR=$UNIXHOST_TRANSFER_DIR/$code_loc
               fi
               codetype=host
               main_type=copy
               sub_type=io;;
      lib)     print "ReferenceDir=$HOST_REF/source/copy/lib" > $CURR_DIR/$CONFIG_FILE
               print "VCSDir=$H_ARCH/source/copy/lib" >> $CURR_DIR/$CONFIG_FILE
               refpath=$HOST_REF/source/copy/lib
               refdest=$HOST_DEST/source/copy/lib
               archpath=$H_ARCH/source/copy/lib
               code_loc=source/copy/lib
               if [[ $Host_Mvsport_Flag = $SET ]]; then
                   MFLIST_TRANSFER_DIR=$MFHOST_TRANSFER_DIR/$code_loc
               fi
               if [[ $Host_Unix_Flag = $SET ]]; then
                   UNIXLIST_TRANSFER_DIR=$UNIXHOST_TRANSFER_DIR/$code_loc
               fi
               codetype=host
               main_type=copy
               sub_type=lib;;
       nongen) print "ReferenceDir=$HOST_REF/source/copy/nongen" > $CURR_DIR/$CONFIG_FILE
               print "VCSDir=$H_ARCH/source/copy/nongen" >> $CURR_DIR/$CONFIG_FILE
               refpath=$HOST_REF/source/copy/nongen
               refdest=$HOST_DEST/source/copy/nongen
               archpath=$H_ARCH/source/copy/nongen
               code_loc=source/copy/nongen
               if [[ $Host_Mvsport_Flag = $SET ]]; then
                   MFLIST_TRANSFER_DIR=$MFHOST_TRANSFER_DIR/$code_loc
               fi
               if [[ $Host_Unix_Flag = $SET ]]; then
                   UNIXLIST_TRANSFER_DIR=$UNIXHOST_TRANSFER_DIR/$code_loc
               fi
               codetype=host
               main_type=copy
               sub_type=nongen;;
   copyreport) print "ReferenceDir=$HOST_REF/source/copy/report" > $CURR_DIR/$CONFIG_FILE
               print "VCSDir=$H_ARCH/source/copy/report" >> $CURR_DIR/$CONFIG_FILE
               refpath=$HOST_REF/source/copy/report
               refdest=$HOST_DEST/source/copy/report
               archpath=$H_ARCH/source/copy/report
               code_loc=source/copy/report
               if [[ $Host_Mvsport_Flag = $SET ]]; then
                   MFLIST_TRANSFER_DIR=$MFHOST_TRANSFER_DIR/$code_loc
               fi
               if [[ $Host_Unix_Flag = $SET ]]; then
                   UNIXLIST_TRANSFER_DIR=$UNIXHOST_TRANSFER_DIR/$code_loc
               fi 
               codetype=host
               main_type=copy
               sub_type=report;;
    copytable) print "ReferenceDir=$HOST_REF/source/copy/table" > $CURR_DIR/$CONFIG_FILE
               print "VCSDir=$H_ARCH/source/copy/table" >> $CURR_DIR/$CONFIG_FILE
               refpath=$HOST_REF/source/copy/table
               refdest=$HOST_DEST/source/copy/table
               archpath=$H_ARCH/source/copy/table
               code_loc=source/copy/table
               if [[ $Host_Mvsport_Flag = $SET ]]; then
                   MFLIST_TRANSFER_DIR=$MFHOST_TRANSFER_DIR/$code_loc
               fi
               if [[ $Host_Unix_Flag = $SET ]]; then
                   UNIXLIST_TRANSFER_DIR=$UNIXHOST_TRANSFER_DIR/$code_loc
               fi
               codetype=host
               main_type=copy
               sub_type=table;;
         code) print "ReferenceDir=$HOST_REF/source/copy/code" > $CURR_DIR/$CONFIG_FILE
               print "VCSDir=$H_ARCH/source/copy/code" >> $CURR_DIR/$CONFIG_FILE
               refpath=$HOST_REF/source/copy/code
               refdest=$HOST_DEST/source/copy/code
               archpath=$H_ARCH/source/copy/code
               code_loc=source/copy/code
               if [[ $Host_Mvsport_Flag = $SET ]]; then
                   MFLIST_TRANSFER_DIR=$MFHOST_TRANSFER_DIR/$code_loc
               fi
               if [[ $Host_Unix_Flag = $SET ]]; then
                   UNIXLIST_TRANSFER_DIR=$UNIXHOST_TRANSFER_DIR/$code_loc
               fi
               codetype=host
               main_type=copy
               sub_type=code;;
          cuv) print "ReferenceDir=$HOST_REF/source/copy/cuv" > $CURR_DIR/$CONFIG_FILE
               print "VCSDir=$H_ARCH/source/copy/cuv" >> $CURR_DIR/$CONFIG_FILE
               refpath=$HOST_REF/source/copy/cuv
               refdest=$HOST_DEST/source/copy/cuv
               archpath=$H_ARCH/source/copy/cuv
               code_loc=source/copy/cuv
               if [[ $Host_Mvsport_Flag = $SET ]]; then
                   MFLIST_TRANSFER_DIR=$MFHOST_TRANSFER_DIR/$code_loc
               fi
               if [[ $Host_Unix_Flag = $SET ]]; then
                   UNIXLIST_TRANSFER_DIR=$UNIXHOST_TRANSFER_DIR/$code_loc
               fi 
               codetype=host
               main_type=copy
               sub_type=cuv;;
 copyintrface) print "ReferenceDir=$HOST_REF/source/copy/intrface" > $CURR_DIR/$CONFIG_FILE
               print "VCSDir=$H_ARCH/source/copy/intrface" >> $CURR_DIR/$CONFIG_FILE
               refpath=$HOST_REF/source/copy/intrface
               refdest=$HOST_DEST/source/copy/intrface
               archpath=$H_ARCH/source/copy/intrface
               code_loc=source/copy/intrface
               if [[ $Host_Mvsport_Flag = $SET ]]; then
                   MFLIST_TRANSFER_DIR=$MFHOST_TRANSFER_DIR/$code_loc
               fi
               if [[ $Host_Unix_Flag = $SET ]]; then
                   UNIXLIST_TRANSFER_DIR=$UNIXHOST_TRANSFER_DIR/$code_loc
               fi
               codetype=host
               main_type=copy
               sub_type=intrface;;
       mvssfe) print "ReferenceDir=$HOST_REF/source/code.mvs/service" > $CURR_DIR/$CONFIG_FILE
               print "VCSDir=$H_ARCH/source/code.mvs/service" >> $CURR_DIR/$CONFIG_FILE
               refpath=$HOST_REF/source/code.mvs/service
               refdest=$HOST_DEST/source/code.mvs/service
               archpath=$H_ARCH/source/code.mvs/service
               code_loc=source/code.mvs/service
               MFLIST_TRANSFER_DIR=$MFHOST_TRANSFER_DIR/$code_loc
               codetype=host
               main_type=code.mvs
               sub_type=service;;
        files) print "ReferenceDir=$HOST_REF/files/areapvcs/checker_master" > $CURR_DIR/$CONFIG_FILE
               print "VCSDir=$H_ARCH/files/areapvcs/checker_master" >> $CURR_DIR/$CONFIG_FILE
               refpath=$HOST_REF/files/areapvcs/checker_master
               refdest=$HOST_DEST/files/areapvcs/checker_master
               archpath=$H_ARCH/files/areapvcs/checker_master
               code_loc=files/areapvcs/checker_master
               LIST_TRANSFER_DIR=$HOST_TRANSFER_DIR/$code_loc
               codetype=host
               main_type=files
               sub_type=areapvcs;;
 static|relat) ;; 
   esac
}

#----------------------------#
# GetProjectEnvVars function #
#----------------------------#
function GetProjectEnvVars
{
    typeset -i ctr
    ctr=0
    cat $PROJ_T5NM_DIR/$T_PROJECT.ini| while read line > /dev/null
    do
        if [[ `echo $line |grep "#"` != "$line" ]]; then
            if [[ $ctr = 0 ]]; then
                GROUP=$line
            fi
	    if [[ $ctr = 1 ]]; then
	       PC_MACHINE=$line
           elif [[ $ctr = 6 ]]; then
               ARCH_LEVEL=$line
           fi
           if [[ $ctr = 9 ]]; then
               HPUX_SERVER=$line
           fi
           if [[ $ctr = 10 ]]; then
               if [[ $line = "ON" ]]; then
                   Migrate=$SET
               else
                   Migrate=$UNSET
               fi
           fi
           # NEW VERSION #
           if [[ $ctr = 11 ]]; then
               if [[ $Sprdsht_flag = $SET ]]; then
                   if [[ $line != OFF ]]; then
                       spreadsheet_prefix=$line
                       date_temp=`date +"%Y%m%d%H%M%S"`
                       promotion_spreadsheet=$line$date_temp.$first_sir.csv
                       TAR_FILE=$line$date_temp.$first_sir.tar
                       if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$promotion_spreadsheet ]]; then
                           date_temp=`date +"%Y%m%d%H%M%S"`
                           promotion_spreadsheet=$line$date_temp.$first_sir.csv
                           TAR_FILE=$line$date_temp.$first_sir.tar
                           if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$promotion_spreadsheet ]]; then
                               print "/tmp_work/pvcs/promote/$T_PROJECT/$promotion_spreadsheet already exists. Please try again.\n"
                               Remove_temp_files
                               exit $ERROR
                           fi
                       fi
                   fi
               fi
           fi
           if [[ $ctr = 14 ]]; then
               if [[ $line = "ON" ]]; then
                   SVT_Staging=$SET
               else
                   SVT_Staging=$UNSET
               fi
           fi
           if [[ $ctr = 15 ]]; then
               if [[ $line = "ON" ]]; then
                   SVT_LOG=$SET
               else
                   SVT_LOG=$UNSET
               fi
           fi
           if [[ $ctr = 16 ]]; then
               if [[ $line = "ON" ]]; then
                   Check_Production_Flag=$SET
               else
                   Check_Production_Flag=$UNSET
               fi
           fi
           if [[ $ctr = 18 ]]; then
               if [[ $line = "ON" ]]; then
                   Cssfunc_Flag=$SET
               else
                   Cssfunc_Flag=$UNSET
               fi
           fi
           if [[ $ctr = 19 ]]; then
               if [[ $line = "ON" ]]; then
                   Cnt_Promote_Flag=$SET
               else
                   Cnt_Promote_Flag=$UNSET
               fi
           fi
           if [[ $ctr = 21 ]]; then
               if [[ $line = "ON" ]]; then
                   Host_Mvsport_Flag=$SET
               else
                   Host_Mvsport_Flag=$UNSET
               fi
           fi
           if [[ $ctr = 22 ]]; then
               if [[ $line = "ON" ]]; then
                   Host_Unix_Flag=$SET
               else
                   Host_Unix_Flag=$UNSET
               fi
           fi
           if [[ $ctr = 23 ]]; then
               if [[ $line = "ON" ]]; then
                   Issue_No_Flag=$SET
               else
                   Issue_No_Flag=$UNSET
               fi
           fi
           if [[ $ctr = 24 ]]; then
               STP_SERVER=$line
           fi
           if [[ $ctr = 25 ]]; then
               if [[ $line = "ON" ]]; then
                   STP_Check_Flag=$SET
               else
                   STP_Check_Flag=$UNSET
               fi
           fi
           if [[ $ctr = 26 ]]; then
               if [[ $line = "ON" ]]; then
                   STP_List_Check_Flag=$SET
               else
                   STP_List_Check_Flag=$UNSET
               fi
           fi
           if [[ $ctr = 27 ]]; then
               if [[ $line = "ON" ]]; then
                   Check_Prod_List_Flag=$SET
               else
                   Check_Prod_List_Flag=$UNSET
               fi
           fi
           if [[ $ctr = 28 ]]; then
               if [[ $line = "ON" ]]; then
                   TAR_STP_File_Flag=$SET
               else
                   TAR_STP_File_Flag=$UNSET
               fi
           fi
           if [[ $ctr = 29 ]]; then
               Xlt_Csv_Flag=$line
           fi
           if [[ $ctr = 30 ]]; then
               if [[ $line = "ON" ]]; then
                   DoNotSendCompile_Flag=$SET
               else
                   DoNotSendCompile_Flag=$UNSET
               fi
           fi
           if [[ $ctr = 31 ]]; then
               Static_Data_Prefix=$line
           fi
           if [[ $ctr = 32 ]]; then
               PVCS_PASSWORD=$line
           fi
           if [[ $ctr = 35 ]]; then
               if [[ $line = "ON" ]]; then
                   DoNotSendClientCompile_Flag=$SET
               else
                   DoNotSendClientCompile_Flag=$UNSET
               fi
           fi
           if [[ $ctr = 36 ]]; then
               if [[ $line != OFF ]]; then
                   MIGRATION_SERVER=$line
               fi
           fi
           if [[ $ctr = 37 ]]; then
               PROMOTE_COMP_SERVER=$line
           fi
           if [[ $ctr = 38 ]]; then
               if [[ $line = "ON" ]]; then
                   ClientCompile_Flag=$SET
               else
                   ClientCompile_Flag=$UNSET
               fi
           fi
           if [[ $ctr = 45 ]]; then
               if [[ $line = "ON" ]]; then
                   OracleModeFlag=$SET
               else
                   OracleModeFlag=$UNSET
               fi
           fi
           ctr=ctr+1
        fi
    done
}

#--------------------#
# Evaluate Extension #
#--------------------#
function Evaluate_Ext
{
if [[ -n $ext && ${#ext} -le $EXT_LEN ]]; then
    case $ext in
        dlg) type=dialog
             codetype=client
             main_type=dialog
             sub_type=""
             dialogname=$(print $module | cut -d'.' -f1)   
             if [[ -a $CLIENT_REF/source/dialog/$dialogname ]]; then
                 if [[ ! -a $CLIENT_DEST/source/dialog/$dialogname ]]; then
                     mkdir -m 755  $CLIENT_DEST/source/dialog/$dialogname 2> /dev/null
                     mkdir -m 755  $CLIENT_DEST/source/dialog/$dialogname/nt 2> /dev/null
                     #mkdir -m 755  $CLIENT_DEST/source/dialog/$dialogname/os216 2> /dev/null
                     #mkdir -m 755  $CLIENT_DEST/source/dialog/$dialogname/os232 2> /dev/null
                     NewDirFlag=$SET
                 fi
                 print "ReferenceDir=$CLIENT_REF/source/dialog/$dialogname/*" > $CURR_DIR/$CONFIG_FILE
                 print "VCSDir=$C_ARCH/source/dialog/$dialogname/*" >> $CURR_DIR/$CONFIG_FILE
                 refpath=$CLIENT_REF/source/dialog/$dialogname
                 refdest=$CLIENT_DEST/source/dialog/$dialogname
                 code_loc=source/dialog/$dialogname
                 archpath=$C_ARCH/source/dialog/$dialogname
             else
                 print "ERROR: $CLIENT_REF/source/dialog/$dialogname does not exist."
                 if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                     if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                         print "\nDeleting $TAR_FILE."
                         rm -f $MASSWORK_DIR/$TAR_FILE
                     fi
                 fi
                 if [[ $Sprdsht_flag = $SET ]]; then
                     if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                         print "\nDeleting $T_PROJECT.temp.csv.$$."
                         rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                     fi
                 fi
                 Remove_temp_files
                 exit $ERROR
             fi;;
   wc | css) type=comwin
             codetype=client
             main_type=comwin
             sub_type=""
             comwinname=$(print $module | cut -d'.' -f1)   
             if [[ -a $CLIENT_REF/source/comwin/$comwinname ]]; then
                 if [[ ! -a $CLIENT_DEST/source/comwin/$comwinname ]]; then
                     mkdir -m 755  $CLIENT_DEST/source/comwin/$comwinname 2> /dev/null
                     mkdir -m 755  $CLIENT_DEST/source/comwin/$comwinname/nt 2> /dev/null
                     #mkdir -m 755  $CLIENT_DEST/source/comwin/$comwinname/os216 2> /dev/null
                     #mkdir -m 755  $CLIENT_DEST/source/comwin/$comwinname/os232 2> /dev/null
                     NewDirFlag=$SET
                  fi
                  print "ReferenceDir=$CLIENT_REF/source/comwin/$comwinname/*" > $CURR_DIR/$CONFIG_FILE
                  print "VCSDir=$C_ARCH/source/comwin/$comwinname/*" >> $CURR_DIR/$CONFIG_FILE
                  refpath=$CLIENT_REF/source/comwin/$comwinname
                  refdest=$CLIENT_DEST/source/comwin/$comwinname
                  code_loc=source/comwin/$comwinname
                  archpath=$C_ARCH/source/comwin/$comwinname
              else
                  print "ERROR: $CLIENT_REF/source/comwin/$comwinname does not exist."
                  if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                      if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                          print "\nDeleting $TAR_FILE."
                          rm -f $MASSWORK_DIR/$TAR_FILE
                      fi
                  fi
                  if [[ $Sprdsht_flag = $SET ]]; then
                      if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                          print "\nDeleting $T_PROJECT.temp.csv.$$."
                          rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                      fi
                  fi
                  Remove_temp_files
                  exit $ERROR 
              fi;;
        cst) type=clst;;
         map) type=csrmap
              codetype=client
              main_type=csrmap
              sub_type=""
              if [[ -z $ancestor_type ]]; then
                  print "\nEnter type the csrmap belongs to: [dialog or comwin] \c"
                 read ancestor_type
              fi
              if [[ -z $parent ]]; then
                  print "\nEnter parent name of csrmap: [ dialog or common window name  e.g. cucl01 ] \c"
                  read parent
              fi
              print "ReferenceDir=$CLIENT_REF/source/$ancestor_type/$parent/*" > $CURR_DIR/$CONFIG_FILE
              print "VCSDir=$C_ARCH/source/$ancestor_type/$parent/*" >> $CURR_DIR/$CONFIG_FILE
              refpath=$CLIENT_REF/source/$ancestor_type/$parent
              refdest=$CLIENT_DEST/source/$ancestor_type/$parent
              archpath=$C_ARCH/source/$ancestor_type/$parent
              code_loc=source/$ancestor_type/$parent;;
         dde) type=dde
              codetype=client
              main_type=dde
              sub_type=""
              print "ReferenceDir=$CLIENT_REF/runtime/dde" > $CURR_DIR/$CONFIG_FILE
              print "VCSDir=$C_ARCH/runtime/dde" >> $CURR_DIR/$CONFIG_FILE
              refpath=$CLIENT_REF/runtime/dde
              refdest=$CLIENT_DEST/runtime/dde
              archpath=$C_ARCH/runtime/dde
              code_loc=runtime/dde;;
         bmp) type=bitmaps
              codetype=client
              main_type=bitmap
              sub_type=""
              print "ReferenceDir=$CLIENT_REF/source/bitmaps/*" > $CURR_DIR/$CONFIG_FILE
              print "VCSDir=$C_ARCH/source/bitmaps/*" >> $CURR_DIR/$CONFIG_FILE
              refpath=$CLIENT_REF/source/bitmaps/nt
              refdest=$CLIENT_DEST/source/bitmaps/nt
              archpath=$C_ARCH/source/bitmaps/nt
              code_loc=source/bitmaps/nt;;
         ico) type=icon
              codetype=client
              main_type=icon
              sub_type=""
              print "ReferenceDir=$CLIENT_REF/source/bitmaps/*" > $CURR_DIR/$CONFIG_FILE
              print "VCSDir=$C_ARCH/source/bitmaps/*" >> $CURR_DIR/$CONFIG_FILE
              refpath=$CLIENT_REF/source/bitmaps/nt
              refdest=$CLIENT_DEST/source/bitmaps/nt
              archpath=$C_ARCH/source/bitmaps/nt
              code_loc=source/bitmaps/nt;;
     h | gnb) type=include
              codetype=client
              main_type=include  
              sub_type=""
              print "ReferenceDir=$CLIENT_REF/source/include" > $CURR_DIR/$CONFIG_FILE
              print "VCSDir=$C_ARCH/source/include" >> $CURR_DIR/$CONFIG_FILE
              refpath=$CLIENT_REF/source/include
              refdest=$CLIENT_DEST/source/include
              archpath=$C_ARCH/source/include
              code_loc=source/include;;
         hlp) type=help
              codetype=client
              main_type=help
              sub_type=""
              help_type=${module%.*}
              print "ReferenceDir=$CLIENT_REF/source/help/helpsrc/$help_type" > $CURR_DIR/$CONFIG_FILE
              print "VCSDir=$C_ARCH/source/help/helpsrc/$help_type" >> $CURR_DIR/$CONFIG_FILE
              refpath=$CLIENT_REF/source/help/helpsrc/$help_type
              refdest=$CLIENT_DEST/source/help/helpinc
              archpath=$C_ARCH/source/help/helpsrc/$help_type
              code_loc=source/help;;
         dat) type=codestbl
              codetype=client
              main_type=codestbl
              sub_type=""
              print "ReferenceDir=$CLIENT_REF/source/codestbl" > $CURR_DIR/$CONFIG_FILE
              print "VCSDir=$C_ARCH/source/codestbl" >> $CURR_DIR/$CONFIG_FILE
              datlogpath=/tmp_work/pvcs/cte/dat/$AREA_DEST
              datlogfile=cte_dat.log
              refpath=$CLIENT_REF/source/codestbl
              refdest=$CLIENT_DEST/source/codestbl
              archpath=$C_ARCH/source/codestbl
              code_loc=source/codestbl;;
         sql) type=scripts
	      codetype=host
	      main_type=control/jobs
	      sub_type=scripts
	      print "ReferenceDir=$HOST_REF/control/jobs/scripts" > $CURR_DIR/$CONFIG_FILE
	      print "VCSDir=$H_ARCH/control/jobs/scripts" >> $CURR_DIR/$CONFIG_FILE
	      refpath=$HOST_REF/control/jobs/scripts
	      refdest=$HOST_DEST/control/jobs/scripts
	      archpath=$H_ARCH/control/jobs/scripts
	      code_loc=control/jobs/scripts;;
         xlt) type=xltmap
              codetype=$Xlt_Csv_Flag
              main_type=xltmap
              sub_type=""
              print "ReferenceDir=$HOST_REF/source/xltmap" > $CURR_DIR/$CONFIG_FILE
              print "VCSDir=$H_ARCH/source/xltmap" >> $CURR_DIR/$CONFIG_FILE
              xltlogpath=/tmp_work/pvcs/cte/xltmap/$AREA_DEST
              xltlogfile=cte_xlt.log
              refpath=$HOST_REF/source/xltmap
              refdest=$HOST_DEST/source/xltmap
              archpath=$H_ARCH/source/xltmap
              code_loc=source/xltmap;;
           c) type=server
              codetype=host
              main_type=code
              sub_type=service
              print "ReferenceDir=$HOST_REF/source/code/service" > $CURR_DIR/$CONFIG_FILE
              print "VCSDir=$H_ARCH/source/code/service" >> $CURR_DIR/$CONFIG_FILE
              refpath=$HOST_REF/source/code/service
              refdest=$HOST_DEST/source/code/service
              archpath=$H_ARCH/source/code/service
              code_loc=source/code/service;;
     pco|lst) if [[ -z $type && $ext = pco ]]; then
                  if [[ `find $HOST_REF/source/code -type f -name $module |wc -l` -gt 1 ]]; then
                      print "ERROR $module:  a duplicate module was found!"
                      if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                          if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                              print "\nDeleting $TAR_FILE."
                              rm -f $MASSWORK_DIR/$TAR_FILE
                          fi
                      fi
                      if [[ $Sprdsht_flag = $SET ]]; then
                          if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                              print "\nDeleting $T_PROJECT.temp.csv.$$."
                              rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                          fi
                      fi
                      Remove_temp_files
                      exit $ERROR
                  else
                      filepath=`find $HOST_REF/source/code -type f -name $module`   
                      type=$(print $filepath | cut -d\/ -f8)
                      print "ReferenceDir=$HOST_REF/source/code/$type" > $CURR_DIR/$CONFIG_FILE
                      print "VCSDir=$H_ARCH/source/code/$type" >> $CURR_DIR/$CONFIG_FILE
                      refpath=$HOST_REF/source/code/$type
                      refdest=$HOST_DEST/source/code/$type
                      code_loc=source/code/$type
                      archpath=$H_ARCH/source/code/$type
                      codetype=host
                      main_type=code
                      sub_type=$type
                  fi
              elif [[ -z $type  && $ext = lst ]]; then
                  flist_flag=$SET
                  type_flag=$UNSET
                  type=list
                  codetype=host
                  main_type=code
              else 
                  print "ReferenceDir=$HOST_REF/source/code/$type" > $CURR_DIR/$CONFIG_FILE
                  print "VCSDir=$H_ARCH/source/code/$type" >> $CURR_DIR/$CONFIG_FILE
                  refpath=$HOST_REF/source/code/$type
                  refdest=$HOST_DEST/source/code/$type
                  code_loc=source/code/$type
                  archpath=$H_ARCH/source/code/$type
                  codetype=host
                  main_type=code
                  sub_type=$type
                  if [[ $ext = lst ]]; then
                      flist_flag=$SET
                  fi
              fi;;
         ctl) type=scripts
              codetype=host
              main_type=control/jobs
              sub_type=scripts
              print "ReferenceDir=$HOST_REF/control/jobs/scripts" > $CURR_DIR/$CONFIG_FILE
              print "VCSDir=$H_ARCH/control/jobs/scripts" >> $CURR_DIR/$CONFIG_FILE
              refpath=$HOST_REF/control/jobs/scripts
              refdest=$HOST_DEST/control/jobs/scripts
              archpath=$H_ARCH/control/jobs/scripts
              code_loc=control/jobs/scripts;;
    esac
elif [[ -z $type && ${#ext} -gt $EXT_LEN ]]; then
    print "Enter module type:"
    print "[scripts|cards|copyio|lib|nongen|copyreport|copytable|copyintrface|code|cuv|mvssfe|files|static|relat] ->\c"
    read type
    setconfig
elif [[ -z $ext || ${#ext} -gt $EXT_LEN ]]; then
    setconfig
else
    prompt_usage
    print "ERROR: Check input parameters."
    if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
        if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
            print "\nDeleting $TAR_FILE."
            rm -f $MASSWORK_DIR/$TAR_FILE
        fi
    fi
    if [[ $Sprdsht_flag = $SET ]]; then
        if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
            print "\nDeleting $T_PROJECT.temp.csv.$$."
            rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
        fi
    fi 
    Remove_temp_files
    exit $ERROR 
fi
}

#---------------#
# Evaluate Type #
#---------------#
function Evaluate_Type
{
case $type in
    dialog) if [[ $Check_Production_Flag = $SET && $FTP_Only_flag != $SET && $compile_flag != $SET ]]; then
                echo "Checking version numbers for promotion validation ..."
                parentname=$(print $module | cut -d'.' -f1)
                ## CHECK .MAK FILE ##
                prodfile=$parentname.mak
                echo "Running check_production_flag for $prodfile ..."
                check_production_flag
                ## CHECK .MAP FILES ##
                for workunitfile in `find $CLIENT_REF/$code_loc -name "*.map"`
                do
                    echo "Running check_production_flag for $prodfile ..."
                    prodfile=`basename $workunitfile`
                    check_production_flag
                done
            fi

            if [[ $FTP_Only_flag != $SET && $compile_flag != $SET ]]; then
	        print "Copying source files to $AREA_DEST..."	
            fi
            if [[ $CLNT_flag != $SET ]]; then
                if [[ $STP_Check_Flag = $SET ]]; then
                    echo "Running Check_STP_Area for $module ..."
                fi
            fi
	    if [[ -a /css/c1/pvcs/workunit/$module ]]; then
		for wrkunit in $(</css/c1/pvcs/workunit/$module)
		do
                    wkunitfile=${wrkunit#@}
		    for entry in $(</css/c1/pvcs/workunit/$wkunitfile)
		    do
			entry_ext=$(print $entry | cut -d'.' -f2)
			echo $NonGenExt | grep "|$entry_ext|" > /dev/null
			if [[ $? = 0 ]]; then
			    if [[ $FTP_Only_flag != $SET && $compile_flag != $SET ]]; then
			        cp -f $refpath/$entry $refdest
			        chmod 444 $refdest/$entry
				chgrp $GROUP $refdest/$entry
                                if [[ $entry_ext = "map" ]]; then
				    print "Copying $entry to $CLIENT_DEST/runtime/nt/csrmap"
                                    bdiff $CLIENT_REF/runtime/nt/csrmap/$entry $CLIENT_DEST/runtime/nt/csrmap/$entry > $entry.out 2>&1
                                    if [[ -s $entry.out ]]; then
                                        touch $BIN_TEMP_PATH/$first_sir$entry
                                    fi
				    cp -f $CLIENT_REF/runtime/nt/csrmap/$entry $CLIENT_DEST/runtime/nt/csrmap
				    chmod 444 $CLIENT_DEST/runtime/nt/csrmap/$entry
				    chgrp $GROUP $CLIENT_DEST/runtime/nt/csrmap/$entry
                                fi
                               # Issue 78782 added on 12/11/00  
			       #	if [[ $entry_ext = "dot" || $entry_ext = "xls" || $entry_ext = "xlm" ]]; then
			       #	    print "Copying $entry to $CLIENT_DEST/runtime/dde"
                               #     bdiff $CLIENT_REF/runtime/dde/$entry $CLIENT_DEST/runtime/dde/$entry > $entry.out 2>&1
                               #     if [[ -s $entry.out ]]; then
                               #         touch $BIN_TEMP_PATH/$first_sir$entry
                               #     fi
			       #	    cp -f -p $CLIENT_REF/runtime/dde/$entry $CLIENT_DEST/runtime/dde
			       #	    chmod 444 $CLIENT_DEST/runtime/dde/$entry
			       #	    chgrp $GROUP $CLIENT_DEST/runtime/dde/$entry
                               #  fi
				vcs -C$CURR_DIR/$CONFIG_FILE -Y -Q -G$VCS_LEVEL $entry
				nt_dir=""
				TargetFileName=$entry
				for sir in $SIR_NUMBERS
				do
				    MIGRATION_FILE=$PSC_LOC/$sir.psc
				    MigrateToTarget
				done
                            fi
                            if [[ $CLNT_flag != $SET ]]; then
			        if [[ $TAR_STP_File_Flag = $SET ]]; then
				    ## TAR COMMAND ##
				    tarfilename=$entry
				    TAR_SOURCE_DIR=client/$AREA_DEST/$code_loc
				    Create_Tar_File
				    if [[ $entry_ext = "map" ]]; then
					TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/csrmap
					Create_Tar_File
                                    fi
				    # Issue 78782 Added on 12/11/00 
				    #if [[ $entry_ext = "dot" || $entry_ext = "xls" || $entry_ext = "xlm" ]]; then
				    #	TAR_SOURCE_DIR=client/$AREA_DEST/runtime/dde
				    #	Create_Tar_File
                                    #fi
                                else
                                    ## STP CHECK ##
				    if [[ $STP_Check_Flag = $SET ]]; then
				        checkfilename=$entry
				        LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
				        Check_STP_Area
					if [[ $entry_ext = "map" ]]; then
					    LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/csrmap
					    Check_STP_Area
					fi
					# Issue 78782;following lines  commented on 12/11/00
					#if [[ $entry_ext = "dot" || $entry_ext = "xls" || $entry_ext = "xlm" ]]; then
					#    LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/dde
					#    Check_STP_Area
                                        #fi
				    fi
				    SOURCE_DIR=$CLIENT_DEST/$code_loc
				    TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
				    transfer_file=$entry
				    transfer_to_clients
				    if [[ $entry_ext = "map" ]]; then
				        SOURCE_DIR=$CLIENT_DEST/runtime/nt/csrmap
				        TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/csrmap
					transfer_to_clients
                                    fi
				    #Issue 78782 added on 12/11/00 
				    #if [[ $entry_ext = "dot" || $entry_ext = "xls" || $entry_ext = "xlm" ]]; then
				    #	SOURCE_DIR=$CLIENT_DEST/runtime/dde
				    #	TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/dde
				    #    transfer_to_clients
                                    #fi
                                fi
				flagfile=$entry
				flag_production_group
                            fi
			    if [[ $Sprdsht_flag = $SET ]]; then
			        TRmain_type=$main_type
				TRsub_type=$dialogname
				TRfilename=$entry
				MVS=""
				UNIX=""
                                BinaryChanged=""
				CopyToSpreadsheet
				if [[ $entry_ext = "map" ]]; then
				    TRmain_type=csrmap
                                    if [[ -f $BIN_TEMP_PATH/$first_sir$entry ]]; then
                                        BinaryChanged="Y"
                                    else
                                        BinaryChanged=""
                                    fi
				    CopyToSpreadsheet
				fi
				# Issue 78782 Commented on 12/11/00
				# if [[ $entry_ext = "dot" || $entry_ext = "xls" || $entry_ext = "xlm" ]]; then
				#    TRmain_type=dde
                                #    if [[ -f $BIN_TEMP_PATH/$first_sir$entry ]]; then
                                #        BinaryChanged="Y"
                                #    else
                                #        BinaryChanged=""
                                #    fi
				#    CopyToSpreadsheet
                                #fi
                            fi
                        else
		            if [[ $FTP_Only_flag != $SET && $compile_flag != $SET ]]; then
			        cp -f $refpath/nt/$entry $refdest/nt
			        chmod 444 $refdest/nt/$entry
				chgrp $GROUP $refdest/nt/$entry
                                vcs -C$CURR_DIR/$CONFIG_FILE -Y -Q -G$VCS_LEVEL $entry
				nt_dir="nt/"
				TargetFileName=$entry
				for sir in $SIR_NUMBERS
				do
				    MIGRATION_FILE=$PSC_LOC/$sir.psc
				    MigrateToTarget
			        done
                            fi
			    if [[ $CLNT_flag != $SET ]]; then
                                if [[ $TAR_STP_File_Flag = $SET ]]; then
                                    ## TAR COMMAND ##
                                    tarfilename=$entry
                                    TAR_SOURCE_DIR=client/$AREA_DEST/$code_loc/nt
                                    Create_Tar_File
                                else
                                    ## STP CHECK ##
                                    if [[ $STP_Check_Flag = $SET ]]; then
                                         checkfilename=$entry
                                         LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc/nt
                                         Check_STP_Area
                                    fi
                                    SOURCE_DIR=$CLIENT_DEST/$code_loc/nt
                                    TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc/nt
                                    transfer_file=$entry
                                    transfer_to_clients
                                fi
                                flagfile=$entry
                                flag_production_group
                            fi
                            if [[ $Sprdsht_flag = $SET ]]; then
                                TRmain_type=$main_type
                                TRsub_type=$dialogname
                                TRfilename=$entry
                                MVS=""
                                UNIX=""
                                BinaryChanged=""
                                CopyToSpreadsheet
                            fi
                        fi
                    done
                done
            else
		print "ERROR: /css/c1/pvcs/workunit/$module does not exist."
		print $module >> $CURR_DIR/unsuccessful.promote
	    fi

            if [[ $dialogname != "cuar20b" ]]; then
		if [[ -a /css/c1/pvcs/workunit/$module ]]; then
                    for wrkunit in $(</css/c1/pvcs/workunit/$module)
                    do
                        extension=$(print $wrkunit | cut -d'.' -f2)
                        case $extension in
                            cl) clntname=$(print $wrkunit | cut -d'.' -f1)
                                client=${clntname#@}
                                if [[ $FTP_Only_flag != $SET ]]; then 
                                    print "Copying $client.exe to $CLIENT_DEST/runtime/nt/exe"
                                    if [[ $ClientCompile_Flag = $SET ]]; then
                                        #bdiff ./$client.exe $CLIENT_DEST/runtime/nt/exe/$client.exe  > $client.exe.out 2>&1
                                        #if [[ -s $client.exe.out ]]; then
                                        #    touch $BIN_TEMP_PATH/$first_sir$client.exe
                                        #fi
                                        cp -f ./$client.exe $CLIENT_DEST/runtime/nt/exe
                                    else
                                        #bdiff $CLIENT_REF/runtime/nt/exe/$client.exe $CLIENT_DEST/runtime/nt/exe/$client.exe  > $client.exe.out 2>&1
                                        #if [[ -s $client.exe.out ]]; then
                                        #    touch $BIN_TEMP_PATH/$first_sir$client.exe
                                        #fi
                                        cp -f $CLIENT_REF/runtime/nt/exe/$client.exe $CLIENT_DEST/runtime/nt/exe
                                    fi     
                                fi
                                chmod 555 $CLIENT_DEST/runtime/nt/exe/$client.exe
                                chgrp $GROUP $CLIENT_DEST/runtime/nt/exe/$client.exe
                                if [[ $CLNT_flag != $SET ]]; then
                                    if [[ $TAR_STP_File_Flag = $SET ]]; then
                                        ## TAR COMMAND ##
                                        tarfilename=$client.exe
                                        TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/exe
                                        Create_Tar_File
                                    else
                                        ## STP CHECK ##
                                        if [[ $STP_Check_Flag = $SET ]]; then
                                            checkfilename=$client.exe
                                            LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/exe
                                            Check_STP_Area
                                        fi
                                        SOURCE_DIR=$CLIENT_DEST/runtime/nt/exe
                                        TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/exe
                                        transfer_file=$client.exe
                                        transfer_to_clients
                                    fi
                                fi

                                if [[ $Sprdsht_flag = $SET ]]; then
                                    TRmain_type=exe
                                    TRsub_type=$dialogname
                                    TRfilename=$client.exe
                                    MVS=""
                                    UNIX=""
                                    if [[ -f $BIN_TEMP_PATH/$first_sir$client.exe ]]; then
                                        BinaryChanged="Y"
                                    else
                                        BinaryChanged=""
                                    fi
                                    CopyToSpreadsheet
                                fi
 
                                if [[ $FTP_Only_flag != $SET ]]; then
                                    print "Copying $client.obj to $CLIENT_DEST/runtime/nt/obj"
                                    if [[ $ClientCompile_Flag = $SET ]]; then
                                        cp -f ./$client.obj $CLIENT_DEST/runtime/nt/obj
                                    else
                                        cp -f $CLIENT_REF/runtime/nt/obj/$client.obj $CLIENT_DEST/runtime/nt/obj
                                    fi
                                fi
                                chmod 555 $CLIENT_DEST/runtime/nt/obj/$client.obj
                                chgrp $GROUP $CLIENT_DEST/runtime/nt/obj/$client.obj 
                                if [[ $CLNT_flag != $SET ]]; then
                                    if [[ $TAR_STP_File_Flag = $SET ]]; then
                                        ## TAR COMMAND ##
                                        tarfilename=$client.obj
                                        TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/obj
                                        Create_Tar_File
                                    else
                                        ## STP CHECK ##
                                        if [[ $STP_Check_Flag = $SET ]]; then
                                            checkfilename=$client.obj
                                            LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/obj
                                            Check_STP_Area
                                        fi
                                        SOURCE_DIR=$CLIENT_DEST/runtime/nt/obj
                                        TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/obj
                                        transfer_file=$client.obj
                                        transfer_to_clients
                                    fi    
                                fi

                                if [[ $Sprdsht_flag = $SET ]]; then
                                    TRmain_type=obj
                                    TRsub_type=$dialogname
                                    TRfilename=$client.obj
                                    MVS=""
                                    UNIX=""
                                    BinaryChanged=""
                                    CopyToSpreadsheet
                                fi

                                if [[ $FTP_Only_flag != $SET ]]; then
                                    print "Copying $client.pdb to $CLIENT_DEST/runtime/nt/debug"
                                    if [[ $ClientCompile_Flag = $SET ]]; then
                                        cp -f ./$client.pdb $CLIENT_DEST/runtime/nt/debug
                                    else
                                        cp -f $CLIENT_REF/runtime/nt/debug/$client.pdb $CLIENT_DEST/runtime/nt/debug
                                    fi
                                fi
                                chmod 555 $CLIENT_DEST/runtime/nt/debug/$client.pdb
                                chgrp $GROUP $CLIENT_DEST/runtime/nt/debug/$client.pdb
                                if [[ $CLNT_flag != $SET ]]; then
                                    if [[ $TAR_STP_File_Flag = $SET ]]; then
                                        ## TAR COMMAND ##
                                        tarfilename=$client.pdb
                                        TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/debug
                                        Create_Tar_File
                                    else
                                        ## STP CHECK ##
                                        if [[ $STP_Check_Flag = $SET ]]; then
                                            checkfilename=$client.pdb
                                            LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/debug
                                            Check_STP_Area
                                        fi
                                        SOURCE_DIR=$CLIENT_DEST/runtime/nt/debug
                                        TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/debug
                                        transfer_file=$client.pdb
                                        transfer_to_clients
                                    fi
                                fi

                                if [[ $Sprdsht_flag = $SET ]]; then
                                    TRmain_type=debug
                                    TRsub_type=$dialogname
                                    TRfilename=$client.pdb
                                    MVS=""
                                    UNIX=""
                                    BinaryChanged=""
                                    CopyToSpreadsheet
                                fi;;
                            wn) winname=$(print $wrkunit | cut -d'.' -f1)
                                window=${winname#@}
                                if [[ $FTP_Only_flag != $SET  ]]; then
                                    print "Copying $window binaries to $AREA_DEST..."
                                    if [[ $ClientCompile_Flag = $SET ]]; then
                                        cp -f ./${window}x.obj $CLIENT_DEST/runtime/nt/obj
                                    else
                                        cp -f $CLIENT_REF/runtime/nt/obj/${window}x.obj $CLIENT_DEST/runtime/nt/obj
                                    fi
                                fi
                                chmod 555 $CLIENT_DEST/runtime/nt/obj/${window}x.obj
                                chgrp $GROUP $CLIENT_DEST/runtime/nt/obj/${window}x.obj
                                if [[ $CLNT_flag != $SET ]]; then
                                    if [[ $TAR_STP_File_Flag = $SET ]]; then
                                        ## TAR COMMAND ##
                                        tarfilename=${window}x.obj
                                        TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/obj
                                        Create_Tar_File
                                    else
                                        ## STP CHECK ##
                                        if [[ $STP_Check_Flag = $SET ]]; then
                                            checkfilename=${window}x.obj
                                            LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/obj
                                            Check_STP_Area
                                        fi
                                        SOURCE_DIR=$CLIENT_DEST/runtime/nt/obj
                                        TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/obj
                                        transfer_file=${window}x.obj
                                        transfer_to_clients
                                    fi
                                fi
                                if [[ $Sprdsht_flag = $SET ]]; then
                                    TRmain_type=obj
                                    TRsub_type=$dialogname
                                    TRfilename=${window}x.obj
                                    MVS=""
                                    UNIX=""
                                    BinaryChanged=""
                                    CopyToSpreadsheet
                                fi;;
                        esac
                    done
                else
		    print "ERROR: /css/c1/pvcs/workunit/$module does not exist."
		    print $module >> $CURR_DIR/unsuccessful.promote
	        fi
            else
                ## copy aar.exe file ##
                print "Processing aar.exe for cuar20b.dlg ..."
                if [[ $FTP_Only_flag != $SET  ]]; then
                    print "Copying aar.exe to $CLIENT_DEST/runtime/nt/exe"
                    diff $CLIENT_REF/runtime/nt/exe/aar.exe $CLIENT_DEST/runtime/nt/exe/aar.exe > aar.exe.out 2>&1
                    if [[ -s aar.exe.out ]]; then
                        touch $BIN_TEMP_PATH/${first_sir}aar.exe
                    fi
                    cp -f $CLIENT_REF/runtime/nt/exe/aar.exe $CLIENT_DEST/runtime/nt/exe
                fi
                chmod 555 $CLIENT_DEST/runtime/nt/exe/aar.exe
                chgrp $GROUP $CLIENT_DEST/runtime/nt/exe/aar.exe
                if [[ $CLNT_flag != $SET ]]; then
                    if [[ $TAR_STP_File_Flag = $SET ]]; then
                        ## TAR COMMAND ##
                        tarfilename=aar.exe
                        TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/exe
                        Create_Tar_File
                    else
                        ## STP CHECK ##
                        if [[ $STP_Check_Flag = $SET ]]; then
                            checkfilename=aar.exe
                            LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/exe
                            Check_STP_Area
                        fi
                        SOURCE_DIR=$CLIENT_DEST/runtime/nt/exe
                        TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/exe
                        transfer_file=aar.exe
                        transfer_to_clients
                    fi
                fi
                if [[ $Sprdsht_flag = $SET ]]; then
                    TRmain_type=exe
                    TRsub_type=$dialogname
                    TRfilename=aar.exe
                    MVS=""
                    UNIX=""
                    if [[ -f $BIN_TEMP_PATH/${first_sir}aar.exe ]]; then
                        BinaryChanged="Y"
                    else
                        BinaryChanged=""
                    fi
                    CopyToSpreadsheet
                fi
            fi;;
    comwin) if [[ $Check_Production_Flag = $SET && $FTP_Only_flag != $SET && $compile_flag != $SET ]]; then
                echo "Checking version numbers for promotion validation ..."
		dllname=$(print $module | cut -d"." -f1)
		## CHECK .MAK FILE ##
		prodfile=$dllname.mak
		echo "Running check_production_flag for $prodfile ..."
		check_production_flag
		## CHECK .MAP FILES ##
	        for workunitfile in `find $CLIENT_REF/$code_loc -name "*.map"`
		do
		    echo "Running check_production_flag for $prodfile ..."
		    prodfile=`basename $workunitfile`
		    check_production_flag
		done
            fi
            dllname=${module%.*}
            if [[ $FTP_Only_flag != $SET && $compile_flag != $SET ]]; then
                print "Copying source files to $AREA_DEST."
            fi
            if [[ $CLNT_flag != $SET ]]; then
                if [[ $STP_Check_Flag = $SET ]]; then
                    echo "Running Check_STP_Area for $module ..."
                fi
            fi

            if [[ -a /css/c1/pvcs/workunit/$module ]]; then
                for entry in $(</css/c1/pvcs/workunit/$module)
                do
                    entry_ext=$(print $entry | cut -d'.' -f2)
                    echo $NonGenExt | grep "|$entry_ext|" > /dev/null
                    if [[ $? = 0 ]]; then
                        if [[ $FTP_Only_flag != $SET && $compile_flag != $SET ]]; then
                            cp -f $refpath/$entry $refdest 
                            chmod 444 $refdest/$entry
                            chgrp $GROUP $refdest/$entry
                            if [[ $entry_ext = "map" ]]; then
                                print "Copying $entry to $CLIENT_DEST/runtime/nt/csrmap"
                                bdiff $CLIENT_REF/runtime/nt/csrmap/$entry $CLIENT_DEST/runtime/nt/csrmap/$entry > $entry.out 2>&1
                                if [[ -s $entry.out ]]; then
                                    touch $BIN_TEMP_PATH/$first_sir$entry
                                fi
                                cp -f $CLIENT_REF/runtime/nt/csrmap/$entry $CLIENT_DEST/runtime/nt/csrmap
                                chmod 444 $CLIENT_DEST/runtime/nt/csrmap/$entry
                                chgrp $GROUP $CLIENT_DEST/runtime/nt/csrmap/$entry
                            fi
                            vcs -C$CURR_DIR/$CONFIG_FILE -Y -Q -G$VCS_LEVEL $entry
                            nt_dir=""
                            TargetFileName=$entry
                            for sir in $SIR_NUMBERS
                            do
                                MIGRATION_FILE=$PSC_LOC/$sir.psc
                                MigrateToTarget
                           done
                        fi
                        if [[ $CLNT_flag != $SET ]]; then
                            if [[ $TAR_STP_File_Flag = $SET ]]; then
                                ## TAR COMMAND ##
                                tarfilename=$entry
                                TAR_SOURCE_DIR=client/$AREA_DEST/$code_loc
                                Create_Tar_File
                                if [[ $entry_ext = "map" ]]; then
                                    TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/csrmap
                                    Create_Tar_File
                                fi
                            else
                                ## STP CHECK ##
                                if [[ $STP_Check_Flag = $SET ]]; then
                                    checkfilename=$entry
                                    LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                                    Check_STP_Area
                                    if [[ $entry_ext = "map" ]]; then 
                                        LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/csrmap
                                        Check_STP_Area
                                    fi
                                fi
                                SOURCE_DIR=$CLIENT_DEST/$code_loc
                                TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                                transfer_file=$entry
                                transfer_to_clients
                                if [[ $entry_ext = "map" ]]; then
                                    SOURCE_DIR=$CLIENT_DEST/runtime/nt/csrmap
                                    TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/csrmap
                                    transfer_file=$entry
                                    transfer_to_clients
                                fi
                            fi
                            flagfile=$entry
                            flag_production_group
                        fi    
                        if [[ $Sprdsht_flag = $SET ]]; then
                            TRmain_type=$main_type
                            TRsub_type=$comwinname
                            TRfilename=$entry
                            MVS=""
                            UNIX=""
                            BinaryChanged=""
                            CopyToSpreadsheet
                            if [[ $entry_ext = "map" ]]; then
                                TRmain_type=csrmap
                                if [[ -f $BIN_TEMP_PATH/$first_sir$entry ]]; then
                                    BinaryChanged="Y"
                                else
                                    BinaryChanged=""
                                fi
                                CopyToSpreadsheet
                            fi
                        fi
                    else
                        if [[ $FTP_Only_flag != $SET && $compile_flag != $SET ]]; then
                            cp -f $refpath/nt/$entry $refdest/nt
                            chmod 444 $refdest/nt/$entry
                            chgrp $GROUP $refdest/nt/$entry
                            vcs -C$CURR_DIR/$CONFIG_FILE -Y -Q -G$VCS_LEVEL $entry
                            nt_dir="nt/"
                            TargetFileName=$entry
                            for sir in $SIR_NUMBERS
                            do
                                MIGRATION_FILE=$PSC_LOC/$sir.psc
                                MigrateToTarget
                            done
                        fi
                        if [[ $CLNT_flag != $SET ]]; then
                            if [[ $TAR_STP_File_Flag = $SET ]]; then
                                ## TAR COMMAND ##
                                tarfilename=$entry
                                TAR_SOURCE_DIR=client/$AREA_DEST/$code_loc/nt
                                Create_Tar_File 
                            else
                                ## STP CHECK ##
                                if [[ $STP_Check_Flag = $SET ]]; then
                                    checkfilename=$entry
                                    LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc/nt
                                    Check_STP_Area
                                fi
                                SOURCE_DIR=$CLIENT_DEST/$code_loc/nt
                                TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc/nt
                                transfer_file=$entry
                                transfer_to_clients
                            fi
                            flagfile=$entry
                            flag_production_group
                        fi
                        if [[ $Sprdsht_flag = $SET ]]; then
                            TRmain_type=$main_type
                            TRsub_type=$comwinname
                            TRfilename=$entry
                            MVS=""
                            UNIX=""
                            BinaryChanged=""
                            CopyToSpreadsheet
                        fi
                    fi
                done         
            else
                print "ERROR:  /css/c1/pvcs/workunit/$module does not exist."
                print $module >> $CURR_DIR/unsuccessful.promote
            fi

            if [[ $FTP_Only_flag != $SET ]]; then
                print "Copying $dllname.dll to $CLIENT_DEST/runtime/nt/dll"
                if [[ $ClientCompile_Flag = $SET ]]; then
                  #The following code chg by Suresh Pellakur on 04/30/2002 to remove bdiff on dll  
		    #bdiff ./$dllname.dll $CLIENT_DEST/runtime/nt/dll/$dllname.dll  > $dllname.dll.out 2>&1
                    #if [[ -s $dllname.dll.out ]]; then
                    #    touch $BIN_TEMP_PATH/$first_sir$dllname.dll
                    #fi
                    cp -f ./$dllname.dll $CLIENT_DEST/runtime/nt/dll
                else
                    #bdiff $CLIENT_REF/runtime/nt/dll/$dllname.dll $CLIENT_DEST/runtime/nt/dll/$dllname.dll  > $dllname.dll.out 2>&1
                    #if [[ -s $dllname.dll.out ]]; then
                    #    touch $BIN_TEMP_PATH/$first_sir$dllname.dll
                    #fi
                    cp -f $CLIENT_REF/runtime/nt/dll/$dllname.dll $CLIENT_DEST/runtime/nt/dll
                fi
            fi
            chmod 555 $CLIENT_DEST/runtime/nt/dll/$dllname.dll
            chgrp $GROUP $CLIENT_DEST/runtime/nt/dll/$dllname.dll
            if [[ $CLNT_flag != $SET ]]; then
                if [[ $TAR_STP_File_Flag = $SET ]]; then
                    ## TAR COMMAND ##
                    tarfilename=$dllname.dll
                    TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/dll
                    Create_Tar_File
                else
                    ## STP CHECK ##
                    if [[ $STP_Check_Flag = $SET ]]; then
                        checkfilename=$dllname.dll
                        LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/dll
                        Check_STP_Area
                    fi
                    SOURCE_DIR=$CLIENT_DEST/runtime/nt/dll
                    TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/dll
                    transfer_file=$dllname.dll
                    transfer_to_clients
                fi
            fi
            if [[ $Sprdsht_flag = $SET ]]; then
                TRmain_type=dll
                TRsub_type=$comwinname
                TRfilename=$dllname.dll
                MVS=""
                UNIX=""
                if [[ -f $BIN_TEMP_PATH/$first_sir$dllname.dll ]]; then
                    BinaryChanged="Y"
                else
                    BinaryChanged=""
                fi
                CopyToSpreadsheet
            fi
            if [[ $dllname = "cssfunc" && $Cssfunc_Flag = $SET ]]; then
                if [[ $FTP_Only_flag != $SET  ]]; then
                    print "Copying $dllname.pdb to $CLIENT_DEST/runtime/nt/debug"
                    if [[ $ClientCompile_Flag = $SET ]]; then
                        cp -f ./$dllname.pdb $CLIENT_DEST/runtime/nt/debug
                    else
                        cp -f $CLIENT_REF/runtime/nt/debug/$dllname.pdb $CLIENT_DEST/runtime/nt/debug
                    fi
                fi
                chmod 555 $CLIENT_DEST/runtime/nt/debug/$dllname.pdb
                chgrp $GROUP $CLIENT_DEST/runtime/nt/debug/$dllname.pdb
                if [[ $CLNT_flag != $SET ]]; then
                    if [[ $TAR_STP_File_Flag = $SET ]]; then
                        ## TAR COMMAND ##
                        tarfilename=$dllname.pdb
                        TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/debug
                        Create_Tar_File
                    else
                        ## STP CHECK ##
                        if [[ $STP_Check_Flag = $SET ]]; then
                            checkfilename=$dllname.pdb
                            LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/debug
                            Check_STP_Area
                        fi
                        SOURCE_DIR=$CLIENT_DEST/runtime/nt/debug
                        TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/debug
                        transfer_file=$dllname.pdb
                        transfer_to_clients
                    fi
                fi
                if [[ $Sprdsht_flag = $SET ]]; then
                    TRmain_type=debug
                    TRsub_type=$comwinname
                    TRfilename=$dllname.pdb
                    MVS=""
                    UNIX=""
                    BinaryChanged=""
                    CopyToSpreadsheet
                fi
            elif [[ $dllname != "cssfunc" ]]; then
                if [[ $FTP_Only_flag != $SET  ]]; then
                    print "Copying $dllname.pdb to $CLIENT_DEST/runtime/nt/debug"
                    if [[ $ClientCompile_Flag = $SET ]]; then
                        cp -f ./$dllname.pdb $CLIENT_DEST/runtime/nt/debug
                    else
                        cp -f $CLIENT_REF/runtime/nt/debug/$dllname.pdb $CLIENT_DEST/runtime/nt/debug
                    fi
                fi
                chmod 555 $CLIENT_DEST/runtime/nt/debug/$dllname.pdb
                chgrp $GROUP $CLIENT_DEST/runtime/nt/debug/$dllname.pdb
                if [[ $CLNT_flag != $SET ]]; then
                    if [[ $TAR_STP_File_Flag = $SET ]]; then
                        ## TAR COMMAND ##
                        tarfilename=$dllname.pdb
                        TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/debug
                        Create_Tar_File
                    else
                        ## STP CHECK ##
                        if [[ $STP_Check_Flag = $SET ]]; then
                            checkfilename=$dllname.pdb
                            LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/debug
                            Check_STP_Area
                        fi
                        SOURCE_DIR=$CLIENT_DEST/runtime/nt/debug
                        TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/debug
                        transfer_file=$dllname.pdb
                        transfer_to_clients
                    fi
                fi
                if [[ $Sprdsht_flag = $SET ]]; then
                    TRmain_type=debug
                    TRsub_type=$comwinname
                    TRfilename=$dllname.pdb
                    MVS=""
                    UNIX=""
                    BinaryChanged=""
                    CopyToSpreadsheet
                fi
            fi  
            if [[ $FTP_Only_flag != $SET ]]; then
                print "Copying $dllname.lib to $CLIENT_DEST/runtime/nt/lib"
                if [[ $ClientCompile_Flag = $SET ]]; then
                    cp -f ./$dllname.lib $CLIENT_DEST/runtime/nt/lib
                else
                    cp -f $CLIENT_REF/runtime/nt/lib/$dllname.lib $CLIENT_DEST/runtime/nt/lib
                fi
            fi
            chmod 555 $CLIENT_DEST/runtime/nt/lib/$dllname.lib
            chgrp $GROUP $CLIENT_DEST/runtime/nt/lib/$dllname.lib
            if [[ $CLNT_flag != $SET ]]; then
                if [[ $TAR_STP_File_Flag = $SET ]]; then
                    ## TAR COMMAND ##
                    tarfilename=$dllname.lib
                    TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/lib
                    Create_Tar_File
                else
                    ## STP CHECK ##
                    if [[ $STP_Check_Flag = $SET ]]; then
                        checkfilename=$dllname.lib
                        LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/lib
                        Check_STP_Area
                    fi
                    SOURCE_DIR=$CLIENT_DEST/runtime/nt/lib
                    TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/lib
                    transfer_file=$dllname.lib
                    transfer_to_clients
                fi
            fi
            if [[ $Sprdsht_flag = $SET ]]; then
                TRmain_type=lib
                TRsub_type=$comwinname
                TRfilename=$dllname.lib
                MVS=""
                UNIX=""
                BinaryChanged=""
                CopyToSpreadsheet
            fi
            for entry in $(</css/c1/pvcs/workunit/$module)
            do
                entry_ext=$(print $entry | cut -d"." -f2)
                entry_name=$(print $entry | cut -d"." -f1)
                if [[ $entry_ext = "c" ]]; then
                    if [[ $FTP_Only_flag != $SET  ]]; then
                        print "Copying $entry_name.obj to $CLIENT_DEST/runtime/nt/obj"
                        if [[ $ClientCompile_Flag = $SET ]]; then
                            cp -f ./$entry_name.obj $CLIENT_DEST/runtime/nt/obj
                        else
                            cp -f $CLIENT_REF/runtime/nt/obj/$entry_name.obj $CLIENT_DEST/runtime/nt/obj
                        fi
                    fi
                    chmod 555 $CLIENT_DEST/runtime/nt/obj/$entry_name.obj
                    chgrp $GROUP $CLIENT_DEST/runtime/nt/obj/$entry_name.obj
                    if [[ $CLNT_flag != $SET ]]; then
                        if [[ $TAR_STP_File_Flag = $SET ]]; then
                            ## TAR COMMAND ##
                            tarfilename=$entry_name.obj
                            TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/obj
                            Create_Tar_File
                        else
                            ## STP CHECK ##
                            if [[ $STP_Check_Flag = $SET ]]; then
                                checkfilename=$entry_name.obj
                                LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/obj
                                Check_STP_Area
                            fi
                            SOURCE_DIR=$CLIENT_DEST/runtime/nt/obj
                            TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/obj
                            transfer_file=$entry_name.obj
                            transfer_to_clients
                        fi
                    fi
                    if [[ $Sprdsht_flag = $SET ]]; then
                        TRmain_type=obj
                        TRsub_type=$comwinname
                        TRfilename=$entry_name.obj
                        MVS=""
                        BinaryChanged=""
                        CopyToSpreadsheet
                    fi
                fi
            done;;
     help ) if [[ $FTP_Only_flag = $SET  ]]; then
                if [[ $TAR_STP_File_Flag = $SET ]]; then
                    ## TAR COMMAND ##
                    for tarfilename2 in `find $CLIENT_DEST/source/help/helpsrc/$help_type -type f -name "*.hh"`
                    do
                        tarfilename=`basename $tarfilename2` 
                        TAR_SOURCE_DIR=client/$AREA_DEST/source/help/helpinc
                        Create_Tar_File
                    done
                else
                    ## STP CHECK ##
                    if [[ $STP_Check_Flag = $SET ]]; then
                        for checkfilename2 in `find $CLIENT_DEST/source/help/helpsrc/$help_type -type f -name "*.hh"`
                        do
                            checkfilename=`basename $checkfilename2`
                            LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/source/help/helpinc
                            Check_STP_Area
                        done
                    fi
                    SOURCE_DIR=$CLIENT_DEST/source/help/helpsrc/$help_type
                    TRANSFER_DIR=$CLNT_TRANSFER_DIR/source/help/helpinc
                    transfer_file=*.hh
                    transfer_to_clients
                fi
                for subfile in $CLIENT_DEST/source/help/helpsrc/$help_type/*.hh
                do
                    singlefile=`basename $subfile`
                    if [[ $Sprdsht_flag = $SET ]]; then
                        TRmain_type=$main_type
                        TRsub_type=$help_type
                        TRfilename=$singlefile
                        MVS=""
                        UNIX=""
                        BinaryChanged=""
                        CopyToSpreadsheet
                    fi
                done
 

                ## FLAG ONLY ONE FILE ##
                flagfile=$help_type.zip
                flag_production_group

                if [[ $TAR_STP_File_Flag = $SET ]]; then
                    ## TAR COMMAND ##
                    tarfilename=$module
                    TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/help
                    Create_Tar_File
                else
                    ## STP CHECK ##
                    if [[ $STP_Check_Flag = $SET ]]; then
                        echo "Running Check_STP_Area for $module ..."
                        checkfilename=$module
                        LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/help
                        Check_STP_Area
                    fi 
                    SOURCE_DIR=$CLIENT_DEST/runtime/nt/help
                    TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/help
                    transfer_file=$module
                    transfer_to_clients
                fi
                if [[ $Sprdsht_flag = $SET ]]; then
                    TRmain_type=$main_type
                    TRsub_type=$help_type
                    TRfilename=$help_type.hlp
                    MVS=""
                    UNIX=""
                    BinaryChanged=""
                    CopyToSpreadsheet
                fi

                ## CNT FILES ##
                if [[ $Cnt_Promote_Flag = $SET ]]; then
                    if [[ $TAR_STP_File_Flag = $SET ]]; then
                        ## TAR COMMAND ##
                        tarfilename=$help_type.cnt
                        TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/help
                        Create_Tar_File
                    else
                        ## STP CHECK ##
                        if [[ $STP_Check_Flag = $SET ]]; then
                            checkfilename=$help_type.cnt
                            LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/help
                            Check_STP_Area
                        fi
                        SOURCE_DIR=$CLIENT_DEST/runtime/nt/help
                        TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/help
                        transfer_file=$help_type.cnt
                        transfer_to_clients
                    fi
                    if [[ $Sprdsht_flag = $SET ]]; then
                        TRmain_type=$main_type
                        TRsub_type=$help_type
                        TRfilename=$help_type.cnt
                        MVS=""
                        UNIX=""
                        BinaryChanged=""
                        CopyToSpreadsheet
                    fi
                    if [[ $TAR_STP_File_Flag = $SET ]]; then
                        ## TAR COMMAND ##
                        tarfilename=master.cnt
                        TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/help
                        Create_Tar_File
                    else
                        ## STP CHECK ##
                        if [[ $STP_Check_Flag = $SET ]]; then
                            checkfilename=master.cnt
                            LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/help
                            Check_STP_Area
                        fi 
                        SOURCE_DIR=$CLIENT_DEST/runtime/nt/help
                        TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/help
                        transfer_file=master.cnt
                        transfer_to_clients
                    fi
                    if [[ $Sprdsht_flag = $SET ]]; then
                        TRmain_type=$main_type
                        TRsub_type=$help_type
                        TRfilename=master.cnt
                        MVS=""
                        UNIX=""
                        BinaryChanged=""
                        CopyToSpreadsheet
                    fi
                fi
            else
                ## ACTUAL PROMOTION ##
                if [[ $Check_Production_Flag = $SET && $FTP_Only_flag != $SET ]]; then
                    echo "Checking version numbers for promotion validation ..."

                    ## CHECK ONLY ONE HELP FILE ##
                    prodfile=$help_type.zip
                    check_production_flag
                fi
                helptype=${module%.*}
                if [[ -d $refpath ]]; then
                    print "Flagging archives to $VCS_LEVEL ..."
                    vcs -C$CONFIG_FILE -G$VCS_LEVEL -Q $help_type.zip
                    print "Copying .hh files to helpsrc $AREA_DEST area ..."
                    cp -f -p $refpath/*.hh /css/c1/client/$AREA_DEST/source/help/helpsrc/$help_type
                    if [[ $? != 0 ]]; then
                        print "ERROR: Unsuccessful copy of .hh files to helpsrc $AREA_DEST area." 
                    fi
                    print "Copying .hh files to helpinc $AREA_DEST area ..."
                    cp -f -p $refpath/*.hh $refdest
                    if [[ $? = 0 ]]; then
                        chgrp $GROUP $CLIENT_DEST/runtime/nt/help/$module
                        if [[ $CLNT_flag != $SET ]]; then
                            if [[ $TAR_STP_File_Flag = $SET ]]; then
                                ## TAR COMMAND ##
                                for tarfilename2 in `find $refpath -type f -name "*.hh"`
                                do
                                    tarfilename=`basename $tarfilename2`
                                    TAR_SOURCE_DIR=client/$AREA_DEST/source/help/helpinc
                                    Create_Tar_File
                                done
                            else
                                ## STP CHECK ##
                                if [[ $STP_Check_Flag = $SET ]]; then
                                    for checkfilename2 in `find $refpath -type f -name "*.hh"`
                                    do
                                        checkfilename=`basename $checkfilename2`
                                        LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/source/help/helpinc
                                        Check_STP_Area
                                    done
                                fi
                                SOURCE_DIR=$CLIENT_DEST/source/help/helpsrc/$helptype
                                TRANSFER_DIR=$CLNT_TRANSFER_DIR/source/help/helpinc
                                transfer_file=*.hh
                                transfer_to_clients
                            fi
                            ## FLAG ONLY ONE FILE ##
                            flagfile=$helptype.zip
                            flag_production_group
                        fi
                        for subfile in $CLIENT_DEST/source/help/helpsrc/$helptype/*.hh
                        do
                            singlefile=`basename $subfile`
                            if [[ $Sprdsht_flag = $SET ]]; then
                                TRmain_type=$main_type
                                TRsub_type=$helptype
                                TRfilename=$singlefile
                                MVS=""
                                UNIX=""
                                BinaryChanged=""
                                CopyToSpreadsheet
                            fi
                        done
                    else
                        print "ERROR: Could not copy $refpath/*.hh to $refdest"
                    fi
                    print "Copying .hlp file to runtime $AREA_DEST area ..."
                    if [[ -s $CLIENT_REF/runtime/nt/help/$module ]]; then
                        cp -f $CLIENT_REF/runtime/nt/help/$module $CLIENT_DEST/runtime/nt/help
                        if [[ $? = 0 ]]; then
                            chmod 555 $CLIENT_DEST/runtime/nt/help/$module
                            chgrp $GROUP $CLIENT_DEST/runtime/nt/help/$module
                            if [[ $CLNT_flag != $SET ]]; then
                                if [[ $TAR_STP_File_Flag = $SET ]]; then
                                    ## TAR COMMAND ##
                                    tarfilename=$module
                                    TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/help
                                    Create_Tar_File
                                else
                                    ## STP CHECK ##
                                    if [[ $STP_Check_Flag = $SET ]]; then
                                        echo "Running Check_STP_Area for $module ..."
                                        checkfilename=$module
                                        LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/help
                                        Check_STP_Area
                                    fi
                                    SOURCE_DIR=$CLIENT_DEST/runtime/nt/help
                                    TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/help
                                    transfer_file=$module
                                    transfer_to_clients
                                fi
                            fi
                            if [[ $Sprdsht_flag = $SET ]]; then
                                TRmain_type=$main_type
                                TRsub_type=$helptype
                                TRfilename=$helptype.hlp
                                MVS=""
                                UNIX=""
                                BinaryChanged=""
                                CopyToSpreadsheet
                            fi
                        else
                            print "ERROR: Could not copy to $CLIENT_DEST/runtime/nt/help"
                        fi
                    else
                        print "ERROR: Could not find $CLIENT_REF/runtime/nt/help/$module" 
                    fi
                    print "Copying .cnt file to runtime $AREA_DEST area ..."
                    if [[ $Cnt_Promote_Flag = $SET ]]; then
                        if [[ -s $CLIENT_REF/runtime/nt/help/$helptype.cnt ]]; then
                            cp -f $CLIENT_REF/runtime/nt/help/$helptype.cnt $CLIENT_DEST/runtime/nt/help
                            if [[ $? = 0 ]]; then
                                chmod 555 $CLIENT_DEST/runtime/nt/help/$helptype.cnt
                                chgrp $GROUP $CLIENT_DEST/runtime/nt/help/$helptype.cnt
                                 if [[ $CLNT_flag != $SET ]]; then
                                     if [[ $TAR_STP_File_Flag = $SET ]]; then
                                         ## TAR COMMAND ##
                                         tarfilename=$helptype.cnt
                                         TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/help
                                         Create_Tar_File
                                     else
                                         ## STP CHECK ##
                                         if [[ $STP_Check_Flag = $SET ]]; then
                                             checkfilename=$helptype.cnt
                                             LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/help
                                             Check_STP_Area
                                         fi
                                         SOURCE_DIR=$CLIENT_DEST/runtime/nt/help
                                         TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/help
                                         transfer_file=$helptype.cnt
                                         transfer_to_clients
                                     fi
                                 fi
                                 if [[ $Sprdsht_flag = $SET ]]; then
                                     TRmain_type=$main_type
                                     TRsub_type=$helptype
                                     TRfilename=$helptype.cnt
                                     MVS=""
                                     UNIX=""
                                     BinaryChanged=""
                                     CopyToSpreadsheet
                                 fi
                            else
                                print "ERROR: Could not copy to $CLIENT_DEST/runtime/nt/help"
                            fi
                      else
                          print "ERROR: Could not find $CLIENT_REF/runtime/nt/help/$helptype.cnt"
                        fi
                    fi
                    print "Copying master.cnt file to runtime $AREA_DEST area ..."
                    if [[ $Cnt_Promote_Flag = $SET ]]; then
                        if [[ -s $CLIENT_REF/runtime/nt/help/master.cnt ]]; then
                            cp -f $CLIENT_REF/runtime/nt/help/master.cnt $CLIENT_DEST/runtime/nt/help
                            if [[ $? = 0 ]]; then
                                chmod 555 $CLIENT_DEST/runtime/nt/help/master.cnt
                                chgrp $GROUP $CLIENT_DEST/runtime/nt/help/master.cnt
                                 if [[ $CLNT_flag != $SET ]]; then
                                     if [[ $TAR_STP_File_Flag = $SET ]]; then
                                         ## TAR COMMAND ##
                                         tarfilename=master.cnt
                                         TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/help
                                         Create_Tar_File
                                     else
                                         ## STP CHECK ##
                                         if [[ $STP_Check_Flag = $SET ]]; then
                                             checkfilename=master.cnt
                                             LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/help
                                             Check_STP_Area
                                         fi
                                         SOURCE_DIR=$CLIENT_DEST/runtime/nt/help
                                         TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/help
                                         transfer_file=master.cnt
                                         transfer_to_clients
                                     fi
                                 fi
                                 if [[ $Sprdsht_flag = $SET ]]; then
                                     TRmain_type=$main_type
                                     TRsub_type=$helptype
                                     TRfilename=master.cnt
                                     MVS=""
                                     UNIX=""
                                     BinaryChanged=""
                                     CopyToSpreadsheet
                                 fi
                            else
                                print "ERROR: Could not copy to $CLIENT_DEST/runtime/nt/help"
                            fi
                        else
                            print "ERROR: Could not find $CLIENT_REF/runtime/nt/help/master.cnt"
                        fi
                    fi
                else
                    print "ERROR: Could not find $CLIENT_REF/$code_loc/helpsrc/$helptype" 
                fi
            fi;;
service|batch|io|table|report|common|intrface|list) rm -rf pco_compile > /dev/null 2> /dev/null
            rm -f allfiles.txt 2> /dev/null

            ## Put module in the transfer area.  Do not perform an actual promotion. ##
            if [[ $FTP_Only_flag = $SET ]]; then
                if [[ $type = list ]]; then
                    cp -f $module allfiles.txt
                else
                    print $module > allfiles.txt
                fi

                if [[ $Host_Mvsport_Flag = $SET && $type = table ]]; then
                     print "$module of type code/$type will not be put in the transfer area for $T_PROJECT."
                fi

                ## If HOST MVSPORT flag is set and type is not table, then copy mvsported file from svt to the clients. ##
                if [[ $Host_Mvsport_Flag = $SET && $type != table ]]; then
                    for file in $(<allfiles.txt)
                    do
                        filename=${file%.*}
# ipa                        filename=$file
                        if [[ $type = list ]]; then
                            if [[ `find $MFDEST_AREA/source/code -type f -name $filename | wc -l` -gt 1 ]]; then
                                print "ERROR $filename: a duplicate file was found!"
                                if [[ $TAR_STP_File_Flag = $SET ]]; then
                                    if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                        print "\nDeleting $TAR_FILE."
                                        rm -f $MASSWORK_DIR/$TAR_FILE
                                    fi
                                fi
                                if [[ $Sprdsht_flag = $SET ]]; then
                                    if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                        print "\nDeleting $T_PROJECT.temp.csv.$$."
                                        rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                                    fi
                                fi
                                Remove_temp_files
                                exit $ERROR
                            elif [[ `find $MFDEST_AREA/source/code -type f -name $filename | wc -l` = 0 ]]; then
                                print "ERROR $filename: no file was found in $MFDEST_AREA/source/code"
                                if [[ $TAR_STP_File_Flag = $SET ]]; then
                                    if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                        print "\nDeleting $TAR_FILE."
                                        rm -f $MASSWORK_DIR/$TAR_FILE
                                    fi
                                fi
                                if [[ $Sprdsht_flag = $SET ]]; then
                                    if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                        print "\nDeleting $T_PROJECT.temp.csv.$$."
                                        rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                                    fi
                                fi
                                Remove_temp_files
                                exit $ERROR
                            fi
                        fi

                        filepath=`find $MFDEST_AREA/source/code -type f -name $filename`
                        type=$(print $filepath | cut -d\/ -f8)
                        code_loc=source/code/$type
                        main_type=code
                        sub_type=$type

                        if [[ $compile_flag = $SET ]]; then
                            if [[ $DoNotSendCompile_Flag != $SET ]]; then 
                                portname=$filename
				TransferCode
                            fi
                        else
                            portname=$filename
			    TransferCode
                        fi
                        flagfile=$file
                        # Create vcs.cfg file if -cn option is passed for a list. #
                        if [[ $flist_flag = $SET ]]; then
                            sethostconfig
                        fi
                        flag_production_group
                        if [[ $Sprdsht_flag = $SET ]]; then
                            TRmain_type=$main_type
                            TRsub_type=$sub_type
                            TRfilename=$filename
                            MVS=Y
                            UNIX=""
                            BinaryChanged=""
                            CopyToSpreadsheet
                        fi
                    done
                fi

                ## If HOST UNIX flag is set, then copy UNIX version file from promoted area to the clients. ##
                if [[ $Host_Unix_Flag = $SET ]]; then
                    for file in $(<allfiles.txt)
                    do
                        if [[ $type = list ]]; then
                            if [[ `find $HOST_DEST/source/code -type f -name $file | wc -l` -gt 1 ]]; then
                                print "ERROR $file: a duplicate file was found!"
                                if [[ $TAR_STP_File_Flag = $SET ]]; then
                                    if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                        print "\nDeleting $TAR_FILE."
                                        rm -f $MASSWORK_DIR/$TAR_FILE
                                    fi
                                fi
                                if [[ $Sprdsht_flag = $SET ]]; then
                                    if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                        print "\nDeleting $T_PROJECT.temp.csv.$$."
                                        rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                                    fi
                                fi
                                Remove_temp_files
                                exit $ERROR
                            elif [[ `find $HOST_DEST/source/code -type f -name $file | wc -l` = 0 ]]; then
                                print "ERROR $file: no file was found in $HOST_DEST/source/code"
                                if [[ $TAR_STP_File_Flag = $SET ]]; then
                                    if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                        print "\nDeleting $TAR_FILE."
                                        rm -f $MASSWORK_DIR/$TAR_FILE
                                    fi
                                fi
                                if [[ $Sprdsht_flag = $SET ]]; then 
                                    if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                        print "\nDeleting $T_PROJECT.temp.csv.$$."
                                        rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                                    fi
                                fi
                                Remove_temp_files
                                exit $ERROR
                            fi
                        fi

                        filepath=`find $HOST_DEST/source/code -type f -name $file`
                        type=$(print $filepath | cut -d\/ -f8)
                        code_loc=source/code/$type
                        main_type=code
                        sub_type=$type
                        filename=$file

                        if [[ $compile_flag = $SET ]]; then
                            if [[ $DoNotSendCompile_Flag != $SET ]]; then
			        if [[ $OracleModeFlag = $SET ]]; then
                                    PutOracleCode
			        else
			            TransferCode
                                fi
                            fi
                        else
			    if [[ $OracleModeFlag = $SET ]]; then
                                PutOracleCode
			    else
			        TransferCode
                            fi
                        fi
                        flagfile=$file
                        # Create vcs.cfg file if -cn option is passed for a list. #
                        if [[ $flist_flag = $SET ]]; then
                            sethostconfig
                        fi 
                        flag_production_group
                        if [[ $Sprdsht_flag = $SET ]]; then
                            TRmain_type=$main_type
                            TRsub_type=$sub_type
                            TRfilename=$file
                            MVS=""
                            UNIX=Y
                            BinaryChanged=""
                            CopyToSpreadsheet
                        fi
                    done
                fi
            else 
                ## Perform an actual promotion. ##
                mkdir ./pco_compile
                if [[ $? = 0 ]]; then
                    cd pco_compile
                    cp -f /css/c1/arch/host/nmprod/runtime/orafix/scripts/Makefile .
                    ucompile=$UNSET
                    if [[ $flist_flag = $SET ]]; then
                        cp -f $CURR_DIR/$module allfiles.txt 
                        if [[ $? != 0 ]]; then
                            cd ..
                            rm -f Makefile
                            rm -rf pco_compile
                            print "ERROR: Failed to create host list."
                            if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                                if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                    print "\nDeleting $TAR_FILE."
                                    rm -f $MASSWORK_DIR/$TAR_FILE
                                fi
                            fi
                            if [[ $Sprdsht_flag = $SET ]]; then
                                if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                    print "\nDeleting $T_PROJECT.temp.csv.$$."
                                    rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                                fi
                            fi
                            Remove_temp_files
                            exit $ERROR
                        fi
                    else
                        print $module > allfiles.txt
                    fi

                    if [[ $Check_Production_Flag = $SET && $FTP_Only_flag != $SET && $compile_flag != $SET ]]; then
                        echo "Checking version numbers for promotion validation ..."
                        for prodfile in $(<allfiles.txt) 
                        do
                            if [[ $type = list ]]; then
                                if [[ `find $HOST_DEST/source/code -type f -name $prodfile | wc -l` -gt 1 ]]; then
                                    print "ERROR $filename: a duplicate file was found!"
                                    if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                                        if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                            print "\nDeleting $TAR_FILE."
                                            rm -f $MASSWORK_DIR/$TAR_FILE
                                        fi
                                    fi 
                                    if [[ $Sprdsht_flag = $SET ]]; then
                                        if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                            print "\nDeleting $T_PROJECT.temp.csv.$$."
                                            rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                                        fi
                                    fi
                                    Remove_temp_files
                                    exit $ERROR
                                else
                                    filepath=`find $HOST_DEST/source/code -type f -name $prodfile`
                                    type=$(print $filepath | cut -d\/ -f8)
                                    main_type=code
                                    sub_type=$type
                                    sethostconfig
                                    type=list
                                fi
                            fi
                            check_production_flag
                        done
                    fi

                    for file in $(<allfiles.txt)
                    do
                        filename=`basename $file`
                        fname=${filename%.*}
                        if [[ $compile_flag = $SET ]]; then
                            if [[ $type = list ]]; then
                                if [[ `find $HOST_DEST/source/code -type f -name $filename | wc -l` -gt 1 ]]; then   
                                    print "ERROR $filename: a duplicate file was found!"
                                    if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                                        if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                            print "\nDeleting $TAR_FILE."
                                            rm -f $MASSWORK_DIR/$TAR_FILE
                                        fi
                                    fi
                                    if [[ $Sprdsht_flag = $SET ]]; then
                                        if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                            print "\nDeleting $T_PROJECT.temp.csv.$$."
                                            rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                                        fi
                                    fi
                                    Remove_temp_files
                                    exit $ERROR
                                else
                                    filepath=`find $HOST_DEST/source/code -type f -name $filename`   
                                    main_type=code
                                    sub_type=$type
                                fi
                            else
                                filepath=$HOST_DEST/source/code/$type/$filename 
                                main_type=code
                                sub_type=$type
                            fi
                            if [[ -z $filepath ]]; then
                                print "ERROR: Cannot determine $filename path."
                                print "ERROR: $filename not found in the $AREA_DEST evironment." 
                                if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                                    if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                        print "\nDeleting $TAR_FILE."
                                        rm -f $MASSWORK_DIR/$TAR_FILE
                                    fi
                                fi
                                if [[ $Sprdsht_flag = $SET ]]; then 
                                    if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                        print "\nDeleting $T_PROJECT.temp.csv.$$."
                                        rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                                    fi
                                fi
                                Remove_temp_files
                                exit $ERROR
                            fi
                        else
                            if [[ $type = list ]]; then
                                if [[ `find $HOST_REF/source/code -type f -name $filename | wc -l` -gt 1 ]]; then
                                    print "ERROR $filename: a duplicate file was found!"
                                    if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                                        if [[ -a $MASSWORK_DIR/$TAR_FILE ]];then
                                            print "\nDeleting $TAR_FILE."
                                            rm -f $MASSWORK_DIR/$TAR_FILE
                                        fi
                                    fi
                                    if [[ $Sprdsht_flag = $SET ]]; then
                                        if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                            print "\nDeleting $T_PROJECT.temp.csv.$$."
                                            rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                                        fi
                                    fi
                                    Remove_temp_files
                                    exit $ERROR
                                else
                                    filepath=`find $HOST_REF/source/code -type f -name $filename`   
                                    main_type=code
                                    sub_type=$type
                                fi
                           else
                                filepath=$HOST_REF/source/code/$type/$filename   
                                main_type=code
                                sub_type=$type
                           fi
                           if [[ -z $filepath ]]; then
                                print "ERROR: Cannot determine $filename path."
                                print "ERROR: $filename not found in the $AREA_REF evironment."
                                if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                                    if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                        print "\nDeleting $TAR_FILE."
                                        rm -f $MASSWORK_DIR/$TAR_FILE
                                    fi
                                fi
                                if [[ $Sprdsht_flag = $SET ]]; then
                                    if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                        print "\nDeleting $T_PROJECT.temp.csv.$$."
                                        rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                                    fi
                                fi
                                Remove_temp_files
                                exit $ERROR
                            fi
                        fi
                        print "\naccessing $filepath ..."
                        cp -f $filepath . 2> /dev/null
                        if [[ $? = 0 ]]; then
                            runmake $filename
                            if [[ $? != 0 ]]; then
                                print "ERROR $filename: failed to compile." 
                                print $filename >> $CURR_DIR/compile.err.promote
                                ucompile=$SET
                                mkdir $SIR_DIR/sir$first_sir 2> /dev/null
                                cp -f $fname.err $SIR_DIR/sir$first_sir 2> /dev/null
                                if [[ $? != 0 ]]; then
                                    print "\nERROR $fname.err: copy to $SIR_DIR/sir$first_sir failed."
                                else 
                                    print "\nERROR $fname.err: copied to $SIR_DIR/sir$first_sir"
                                fi
                            fi 
                        else
                            print "ERROR: Cannot copy $filename to current directory."
                            print $module >> $CURR_DIR/unsuccessful.promote
                            if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                                if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                    print "\nDeleting $TAR_FILE."
                                    rm -f $MASSWORK_DIR/$TAR_FILE
                                fi
                            fi
                            if [[ $Sprdsht_flag = $SET ]]; then
                                if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                    print "\nDeleting $T_PROJECT.temp.csv.$$."
                                    rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                                fi
                            fi
                            Remove_temp_files
                            exit $ERROR
                        fi
                    done
                    if [[ $ucompile = $SET ]]; then
                        cd ..
                        print "\nERROR: Compilation failed! See $SIR_DIR/sir$first_sir for details."
                        rm -rf pco_compile 2> /dev/null
                        if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                            if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                print "\nDeleting $TAR_FILE."
                                rm -f $MASSWORK_DIR/$TAR_FILE
                            fi 
                        fi
                        if [[ $Sprdsht_flag = $SET ]]; then
                            if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                print "\nDeleting $T_PROJECT.temp.csv.$$."
                                rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                            fi
                        fi
                        Remove_temp_files
                        exit $ERROR
                    fi
                    for file in $(<allfiles.txt)
                    do
                        filename=`basename $file`
                        fname=${filename%.*}
                        if [[ $type_flag = $UNSET ]]; then
                            if [[ `find $HOST_REF/source/code -type f -name $filename | wc -l`  -gt 1 ]]; then  
                                print "ERROR $filename: a duplicate file was found!"
                                if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                                    if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                        print "\nDeleting $TAR_FILE."
                                        rm -f $MASSWORK_DIR/$TAR_FILE
                                    fi
                                fi
                                if [[ $Sprdsht_flag = $SET ]]; then
                                    if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                        print "\nDeleting $T_PROJECT.temp.csv.$$."
                                        rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                                    fi
                                fi
                                Remove_temp_files
                                exit $ERROR
                            else
                                filepath=`find $HOST_REF/source/code -type f -name $filename`   
                            fi
                            type=$(print $filepath | cut -d\/ -f8)
                            main_type=code
                            sub_type=$type
                            sethostconfig
                        fi
                        if [[ $compile_flag = $SET ]]; then
                            cp -f $fname.o $HOST_DEST/runtime/obj
                            if [[ $? = 0 ]]; then
                                objflag=$SET
                            else
                                objflag=$UNSET
                            fi
                            chmod 555 $HOST_DEST/runtime/obj/$fname.o
                            chgrp $GROUP $HOST_DEST/runtime/obj/$fname.o
                            cp -f $fname.idy $fname.int $fname.cbl $HOST_DEST/runtime/symbol
                            if [[ $? = 0 ]]; then
                                symflag=$SET
                            else
                                symflag=$UNSET
                            fi
                            chmod 555 $HOST_DEST/runtime/symbol/$fname.*
                            chmod 444 $HOST_DEST/runtime/symbol/$fname.cbl
                            chgrp $GROUP $HOST_DEST/runtime/symbol/$fname.*
                            if [[ $objflag = $SET && $symflag = $SET ]]; then
                                print "\n$filename: binary files in $AREA_DEST were updated"
                                if [[ $Host_Unix_Flag = $SET ]]; then
                                    if [[ $CLNT_flag != $SET ]]; then
                                        if [[ $DoNotSendCompile_Flag != $SET ]]; then
                                            if [[ $OracleModeFlag = $SET ]]; then
                                                PutOracleCode
                                            else
                                                TransferCode
                                            fi
                                        fi
                                        flagfile=$filename
                                        flag_production_group
                                    fi
                                    if [[ $Sprdsht_flag = $SET ]]; then
                                        TRmain_type=$main_type
                                        TRsub_type=$sub_type
                                        TRfilename=$filename
                                        MVS=""
                                        UNIX=Y
                                        BinaryChanged=""
                                        CopyToSpreadsheet
                                    fi 
                                fi
                            else
                                print "\n$filename: error updating binary files!"
                            fi
                        else
                            cp -f $filename $refdest
                            if [[ $? = 0 ]]; then
                                chmod 444 $refdest/$filename
                                chgrp $GROUP $refdest/$filename
                                cp -f $fname.o $HOST_DEST/runtime/obj
                                chmod 555 $HOST_DEST/runtime/obj/$fname.o
                                chgrp $GROUP $HOST_DEST/runtime/obj/$fname.o
                                cp -f $fname.idy $fname.int $HOST_DEST/runtime/symbol
                                chmod 555 $HOST_DEST/runtime/symbol/$fname.*
                                chgrp $GROUP $HOST_DEST/runtime/symbol/$fname.*
                                cp -f $fname.cbl $HOST_DEST/runtime/symbol
                                chmod 444 $HOST_DEST/runtime/symbol/$fname.cbl
                                chgrp $GROUP $HOST_DEST/runtime/symbol/$fname.cbl

                                ## HOST UNIX flag is set ##
                                if [[ $Host_Unix_Flag = $SET ]]; then
                                    if [[ $OracleModeFlag = $SET ]]; then
                                        portname=$filename
                                        RunMVSPort
                                    else
                                        if [[ $CLNT_flag != $SET ]]; then
                                            code_loc=source/code/$type
                                            main_type=code
                                            sub_type=$type
                                            TransferCode
                                            flagfile=$filename
                                            flag_production_group
                                        fi
                                        if [[ $Sprdsht_flag = $SET ]]; then
                                            TRmain_type=$main_type
                                            TRsub_type=$sub_type
                                            TRfilename=$filename
                                            MVS=""
                                            UNIX=Y
                                            BinaryChanged=""
                                            CopyToSpreadsheet
                                        fi
                                    fi
                                fi

                                print "\n"
                                
                                 vcs -C$CURR_DIR/$CONFIG_FILE -Y -Q -G$VCS_LEVEL $filename
                                print "$filename: promoted to $AREA_DEST"
                                TargetFileName=$filename
                                for sir in $SIR_NUMBERS
                                do
                                    MIGRATION_FILE=$PSC_LOC/$sir.psc
                                    MigrateToTarget
                                done
                            else
                                print $filename >> $CURR_DIR/unsuccessful.promote
                                print "\nERROR: Failed to copy $filename to $refdest."
                            fi
                        fi  
			if [[ $Host_Mvsport_Flag = $SET && $type != "table" ]]; then
			    portname=$fname
			    RunMVSPort
                        fi
                        if [[ -a $CURR_DIR/unsuccessful.promote ]]; then
                            grep "$filename" $CURR_DIR/unsuccessful.promote 2> /dev/null
                            if [[ $? != 0 ]]; then
                                if [[ $SVT_LOG = $SET && $flist_flag = $SET && $AREA_DEST = svtstage && $compile_flag = $SET ]]; then
                                    print "$filename|$sub_type||||-c|$SIR_NUMBERS" >> $SVT_STAG_DIR/$T_PROJECT.svt_staging.log
                                    if [[ $? != 0 ]]; then
                                        print "\nERROR:  Could not write to the $T_PROJECT.svt.staging.log file."
                                    fi
                                elif [[ $SVT_LOG = $SET && $flist_flag = $SET && $AREA_DEST = svtstage && $compile_flag != $SET ]]; then
                                    print "$filename|$sub_type|||||$SIR_NUMBERS" >> $SVT_STAG_DIR/$T_PROJECT.svt_staging.log
                                    if [[ $? != 0 ]]; then
                                        print "\nERROR:  Could not write to the $T_PROJECT.svt.staging.log file."
                                    fi
                                fi
                           fi
                       else
                           if [[ $SVT_LOG = $SET && $flist_flag = $SET && $AREA_DEST = svtstage && $compile_flag = $SET ]]; then
                               print "$filename|$sub_type||||-c|$SIR_NUMBERS" >> $SVT_STAG_DIR/$T_PROJECT.svt_staging.log
                               if [[ $? != 0 ]]; then
                                   print "\nERROR:  Could not write to the $T_PROJECT.svt.staging.log file."
                               fi
                           elif [[ $SVT_LOG = $SET && $flist_flag = $SET && $AREA_DEST = svtstage && $compile_flag != $SET ]]; then
                               print "$filename|$sub_type|||||$SIR_NUMBERS" >> $SVT_STAG_DIR/$T_PROJECT.svt_staging.log
                               if [[ $? != 0 ]]; then
                                   print "\nERROR:  Could not write to the $T_PROJECT.svt.staging.log file."
                               fi
                           fi
                       fi
                    done
                    cd ..
                    rm -rf pco_compile
                else
                    print "ERROR:  Cannot create temporary compile directory." 
                    print $module >> $CURR_DIR/unsuccessful.promote
                fi
            fi;;
    server) if [[ $FTP_Only_flag = $SET && $Host_Unix_Flag != $SET ]]; then
                print "\n$module will not be sent to the $T_PROJECT client site because they are not a UNIX client."
            fi

            if [[ $FTP_Only_flag = $SET && $Host_Unix_Flag = $SET ]]; then
                fname=${module%.*}
                lofname=$(print $fname | tr "[:upper:]" "[:lower:]" )
                if [[ $TAR_STP_File_Flag = $SET ]]; then
                    ## TAR COMMAND ##
                    tarfilename=$module
                    TAR_SOURCE_DIR=host/mf$AREA_DEST/$code_loc
                    Create_Tar_File
                else
                    ## STP CHECK ##
                    if [[ $STP_Check_Flag = $SET ]]; then
                        echo "Running Check_STP_Area for $module ..."
                        checkfilename=$module
                        LIST_TRANSFER_DIR=$HOST_TRANSFER_DIR/$code_loc
                        Check_STP_Area
                    fi
                    SOURCE_DIR=$HOST_DEST/$code_loc
                    TRANSFER_DIR=$HOST_TRANSFER_DIR/$code_loc
                    transfer_file=$module
                    transfer_to_clients
                fi
                flagfile=$module
                flag_production_group
                if [[ $Sprdsht_flag = $SET ]]; then
                    TRmain_type=$main_type
                    TRsub_type=$sub_type
                    TRfilename=$module
                    MVS=""
                    UNIX=Y 
                    BinaryChanged=""
                    CopyToSpreadsheet
                fi

                if [[ $TAR_STP_File_Flag = $SET ]]; then
                    ## TAR COMMAND ##
                    tarfilename=$lofname.sdt
                    TAR_SOURCE_DIR=host/mf$AREA_DEST/source/include
                    Create_Tar_File
                else
                    ## STP CHECK ##
                    if [[ $STP_Check_Flag = $SET ]]; then
                        checkfilename=$lofname.sdt
                        LIST_TRANSFER_DIR=$HOST_TRANSFER_DIR/source/include
                        Check_STP_Area
                    fi 
                    SOURCE_DIR=$HOST_DEST/source/include
                    TRANSFER_DIR=$HOST_TRANSFER_DIR/source/include
                    transfer_file=$lofname.sdt
                    transfer_to_clients
                fi
                flagfile=$lofname.sdt
                flag_production_group
                if [[ $Sprdsht_flag = $SET ]]; then
                    TRmain_type=include
                    TRsub_type=""
                    TRfilename=$lofname.sdt
                    MVS=""
                    UNIX=Y
                    BinaryChanged=""
                    CopyToSpreadsheet
                fi
                if [[ $TAR_STP_File_Flag = $SET ]]; then
                    ## TAR COMMAND ##
                    tarfilename=$lofname.wdt
                    TAR_SOURCE_DIR=host/mf$AREA_DEST/source/include
                    Create_Tar_File
                else
                    ## STP CHECK ##
                    if [[ $STP_Check_Flag = $SET ]]; then
                        checkfilename=$lofname.wdt
                        LIST_TRANSFER_DIR=$HOST_TRANSFER_DIR/source/include
                        Check_STP_Area
                    fi
                    SOURCE_DIR=$HOST_DEST/source/include
                    TRANSFER_DIR=$HOST_TRANSFER_DIR/source/include
                    transfer_file=$lofname.wdt
                    transfer_to_clients
                fi
                flagfile=$lofname.wdt
                flag_production_group
                if [[ $Sprdsht_flag = $SET ]]; then
                    TRmain_type=include
                    TRsub_type=""
                    TRfilename=$lofname.wdt
                    MVS=""
                    UNIX=Y
                    BinaryChanged=""
                    CopyToSpreadsheet
                 fi
            fi

            fname=${module%.*}
            lofname=$(print $fname | tr "[:upper:]" "[:lower:]" )

            if [[ $Check_Production_Flag = $SET && $FTP_Only_flag != $SET ]]; then
                echo "Checking version numbers for promotion validation ..."
                prodfile=$module
                check_production_flag
            fi

            if [[ $FTP_Only_flag != $SET ]]; then
#Remove .sl for Foundation Upgrade Suresh Pellakur
#            if [[ -a $refpath/$module && -a $HOST_REF/runtime/lib/lib$fname.sl && -a $HOST_REF/source/include/$lofname.wdt && -a $HOST_REF/source/include/$lofname.sdt ]]; then
             if [[ -a $refpath/$module && -a $HOST_REF/runtime/bin/$fname && -a $HOST_REF/source/include/$lofname.wdt && -a $HOST_REF/source/include/$lofname.sdt ]]; then
               cp -f $refpath/$module $refdest
                if [[ $? != 0 ]]; then
                    print $module >> $CURR_DIR/unsuccessful.promote
                    print "ERROR: Unsuccessful promote -> $module"
                else
                    chmod 444 $refdest/$module
                    chgrp $GROUP $refdest/$module
                    vcs -C$CURR_DIR/$CONFIG_FILE -Y -Q -G$VCS_LEVEL $module
                    flagfile=$module
                    flag_production_group
                    TargetFileName=$module
                    for sir in $SIR_NUMBERS
                    do
                        MIGRATION_FILE=$PSC_LOC/$sir.psc
                        MigrateToTarget
                    done
 # FCP UPGRADE Suresh Pellakur 2006-06-06
                    cp -f $HOST_REF/runtime/bin/$fname $HOST_DEST/runtime/bin
                    chmod 555 $HOST_DEST/runtime/bin/$fname
                    chgrp $GROUP $HOST_DEST/runtime/bin/$fname
                    #cp -f $HOST_REF/runtime/obj/$fname.o $HOST_DEST/runtime/obj
                    #chmod 555 $HOST_DEST/runtime/obj/$fname.o
                    #chgrp $GROUP $HOST_DEST/runtime/obj/$fname.o
                    cp -f $HOST_REF/source/include/$lofname.wdt $HOST_DEST/source/include
                    chmod 444 $HOST_DEST/source/include/$lofname.wdt
                    chgrp $GROUP $HOST_DEST/source/include/$lofname.wdt
                    print "ReferenceDir=$HOST_REF/source/include" > $CURR_DIR/$CONFIG_FILE
                    print "VCSDir=$H_ARCH/source/include" >> $CURR_DIR/$CONFIG_FILE
                    vcs -C$CURR_DIR/$CONFIG_FILE -Y -Q -G$VCS_LEVEL $lofname.wdt
                    cp -f $HOST_REF/source/include/$lofname.sdt $HOST_DEST/source/include
                    chmod 444 $HOST_DEST/source/include/$lofname.sdt
                    chgrp $GROUP $HOST_DEST/source/include/$lofname.sdt
                    archpath=$H_ARCH/source/include
                    refpath=$HOST_REF/source/include
                    TargetFileName=$lofname.wdt
                    for sir in $SIR_NUMBERS
                    do
                        MIGRATION_FILE=$PSC_LOC/$sir.psc
                        MigrateToTarget
                    done
                    print "ReferenceDir=$HOST_REF/source/include" > $CURR_DIR/$CONFIG_FILE
                    print "VCSDir=$H_ARCH/source/include" >> $CURR_DIR/$CONFIG_FILE
                    vcs -C$CURR_DIR/$CONFIG_FILE -Y -Q -G$VCS_LEVEL $lofname.sdt
                    refpath=$HOST_REF/source/include
                    archpath=$H_ARCH/source/include
                    TargetFileName=$lofname.sdt
                    for sir in $SIR_NUMBERS
                    do
                        MIGRATION_FILE=$PSC_LOC/$sir.psc 
                        MigrateToTarget
                    done
                    
                    if [[ $Host_Unix_Flag = $SET && $CLNT_flag != $SET ]]; then
                        if [[ $TAR_STP_File_Flag = $SET ]]; then
                            ## TAR COMMAND ##
                            tarfilename=$module
                            TAR_SOURCE_DIR=host/mf$AREA_DEST/$code_loc
                            Create_Tar_File
                        else
                            ## STP CHECK ##
                            if [[ $STP_Check_Flag = $SET ]]; then
                                echo "Running Check_STP_Area for $module ..."
                                checkfilename=$module
                                LIST_TRANSFER_DIR=$HOST_TRANSFER_DIR/$code_loc
                                Check_STP_Area
                            fi
                            SOURCE_DIR=$HOST_DEST/$code_loc
                            TRANSFER_DIR=$HOST_TRANSFER_DIR/$code_loc
                            transfer_file=$module
                            transfer_to_clients
                        fi
                        flagfile=$module
                        flag_production_group
                        if [[ $Sprdsht_flag = $SET ]]; then
                            TRmain_type=$main_type
                            TRsub_type=$sub_type
                            TRfilename=$module
                            MVS=""
                            UNIX=Y
                            BinaryChanged=""
                            CopyToSpreadsheet
                        fi
                        if [[ $TAR_STP_File_Flag = $SET ]]; then
                            ## TAR COMMAND ##
                            tarfilename=$lofname.sdt
                            TAR_SOURCE_DIR=host/mf$AREA_DEST/source/include
                            Create_Tar_File
                        else
                            ## STP CHECK ##
                            if [[ $STP_Check_Flag = $SET ]]; then
                                checkfilename=$lofname.sdt
                                LIST_TRANSFER_DIR=$HOST_TRANSFER_DIR/source/include
                                Check_STP_Area
                            fi
                            SOURCE_DIR=$HOST_DEST/source/include
                            TRANSFER_DIR=$HOST_TRANSFER_DIR/source/include
                            transfer_file=$lofname.sdt
                            transfer_to_clients
                        fi
                        flagfile=$lofname.sdt
                        flag_production_group
                        if [[ $Sprdsht_flag = $SET ]]; then
                            TRmain_type=include
                            TRsub_type=""
                            TRfilename=$lofname.sdt
                            MVS=""
                            UNIX=Y
                            BinaryChanged=""
                            CopyToSpreadsheet
                        fi
                        if [[ $TAR_STP_File_Flag = $SET ]]; then
                            ## TAR COMMAND ##
                            tarfilename=$lofname.wdt
                            TAR_SOURCE_DIR=host/mf$AREA_DEST/source/include
                            Create_Tar_File
                        else
                            ## STP CHECK ##
                            if [[ $STP_Check_Flag = $SET ]]; then
                                checkfilename=$lofname.wdt
                                LIST_TRANSFER_DIR=$HOST_TRANSFER_DIR/source/include
                                Check_STP_Area
                            fi
                            SOURCE_DIR=$HOST_DEST/source/include
                            TRANSFER_DIR=$HOST_TRANSFER_DIR/source/include
                            transfer_file=$lofname.wdt
                            transfer_to_clients
                        fi
                        flagfile=$lofname.wdt
                        flag_production_group
                        if [[ $Sprdsht_flag = $SET ]]; then
                            TRmain_type=include
                            TRsub_type=""
                            TRfilename=$lofname.wdt
                            MVS=""
                            UNIX=Y
                            BinaryChanged=""
                            CopyToSpreadsheet
                        fi
                    fi
                fi
            else
                print "ERROR: $refpath/$module not found."
                print $module >> $CURR_DIR/unsuccessful.promote
            fi
            fi;;
    csrmap) if [[ -a $refpath/$module ]]; then
                if [[ -a $refpath/${module%.*}.csm ]]; then
                    if [[ $FTP_Only_flag = $SET ]]; then
                        if [[ $TAR_STP_File_Flag = $SET ]]; then
                            ## TAR COMMAND ##
                            tarfilename=$module
                            TAR_SOURCE_DIR=client/$AREA_DEST/$code_loc
                            Create_Tar_File
                        else
                            ## STP CHECK ##
                            if [[ $STP_Check_Flag = $SET ]]; then
                                echo "Running Check_STP_Area for $module ..."
                                checkfilename=$module
                                LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                                Check_STP_Area
                            fi
                            SOURCE_DIR=$CLIENT_DEST/$code_loc
                            TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                            transfer_file=$module
                            transfer_to_clients
                        fi
                        if [[ $Sprdsht_flag = $SET ]]; then
                            TRmain_type=$ancestor_type
                            TRsub_type=$parent
                            TRfilename=$module
                            MVS=""
                            UNIX=""
                            BinaryChanged=""
                            CopyToSpreadsheet
                        fi
                        flagfile=$module
                        flag_production_group
                        if [[ $TAR_STP_File_Flag = $SET ]]; then
                            ## TAR COMMAND ##
                            tarfilename=${module%.*}.csm
                            TAR_SOURCE_DIR=client/$AREA_DEST/$code_loc
                            Create_Tar_File
                        else 
                            ## STP CHECK ##
                            if [[ $STP_Check_Flag = $SET ]]; then
                                checkfilename=${module%.*}.csm
                                LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                                Check_STP_Area
                            fi
                            transfer_file=${module%.*}.csm
                            transfer_to_clients
                        fi
                        if [[ $Sprdsht_flag = $SET ]]; then
                            TRmain_type=$ancestor_type
                            TRsub_type=$parent
                            TRfilename=${module%.*}.csm
                            MVS=""
                            UNIX=""
                            BinaryChanged=""
                            CopyToSpreadsheet
                        fi
                        flagfile=${module%.*}.csm
                        flag_production_group
                        if [[ $TAR_STP_File_Flag = $SET ]]; then
                            ## TAR COMMAND ##
                            tarfilename=$module
                            TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/csrmap
                            Create_Tar_File
                        else
                            ## STP CHECK ##
                            if [[ $STP_Check_Flag = $SET ]]; then
                                checkfilename=$module
                                LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/csrmap
                                Check_STP_Area
                            fi
                            SOURCE_DIR=$CLIENT_DEST/runtime/nt/csrmap
                            TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/csrmap
                            transfer_file=$module
                            transfer_to_clients
                        fi
                        if [[ $Sprdsht_flag = $SET ]]; then
                            TRmain_type=csrmap
                            TRsub_type=$parent
                            TRfilename=$module
                            MVS=""
                            UNIX=""
                            if [[ -f $BIN_TEMP_PATH/$first_sir$module ]]; then
                                BinaryChanged="Y"
                            else
                                BinaryChanged=""
                            fi
                            CopyToSpreadsheet
                        fi
                    else
                        ## Perform actual promotion ##
                        if [[ $Check_Production_Flag = $SET && $FTP_Only_flag != $SET ]]; then
                            echo "Checking version numbers for promotion validation ..."
                            for prodfile in $module ${module%.*}.csm 
                            do
                                check_production_flag
                            done
                        fi

                        cp -f $refpath/$module $refdest
                        if [[ $? != 0 ]]; then
                            print "ERROR: Could not copy $module to $redest."
                            print $module >> $CURR_DIR/unsuccessful.promote
                        else
                            if [[ $CLNT_flag != $SET ]]; then
                                if [[ $TAR_STP_File_Flag = $SET ]]; then
                                    ## TAR COMMAND ##
                                    tarfilename=$module
                                    TAR_SOURCE_DIR=client/$AREA_DEST/$code_loc
                                    Create_Tar_File
                                 else
                                     ## STP CHECK ##
                                     if [[ $STP_Check_Flag = $SET ]]; then
                                         echo "Running Check_STP_Area for $module ..."
                                         checkfilename=$module
                                         LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                                         Check_STP_Area
                                    fi
                                    SOURCE_DIR=$CLIENT_DEST/$code_loc
                                    TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                                    transfer_file=$module
                                    transfer_to_clients
                                fi
                                flagfile=$module
                                flag_production_group
                            fi
                            if [[ $Sprdsht_flag = $SET ]]; then
                                TRmain_type=$ancestor_type
                                TRsub_type=$parent
                                TRfilename=$module
                                MVS=""
                                UNIX=""
                                BinaryChanged=""
                                CopyToSpreadsheet
                            fi
                            bdiff $CLIENT_REF/runtime/nt/csrmap/$module $CLIENT_DEST/runtime/nt/csrmap/$module > $module.out 2>&1
                            if [[ -s $module.out ]]; then
                                touch $BIN_TEMP_PATH/$first_sir$module
                            fi
                            rm -f $module.out
                            cp -f $refpath/$module $CLIENT_DEST/runtime/nt/csrmap
                            chmod 444 $CLIENT_DEST/runtime/nt/csrmap/$module
                            chgrp $GROUP $CLIENT_DEST/runtime/nt/csrmap/$module
                            if [[ $CLNT_flag != $SET ]]; then
                                if [[ $TAR_STP_File_Flag = $SET ]]; then
                                    ## TAR COMMAND ##
                                    tarfilename=$module
                                    TAR_SOURCE_DIR=client/$AREA_DEST/runtime/nt/csrmap
                                    Create_Tar_File
                                else
                                    ## STP CHECK ##
                                    if [[ $STP_Check_Flag = $SET ]]; then
                                        checkfilename=$module
                                        LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/csrmap
                                        Check_STP_Area
                                    fi
                                    SOURCE_DIR=$CLIENT_DEST/runtime/nt/csrmap
                                    TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/csrmap
                                    transfer_file=$module
                                    transfer_to_clients
                                fi
                            fi
                            if [[ $Sprdsht_flag = $SET ]]; then
                                TRmain_type=csrmap
                                TRsub_type=$parent
                                TRfilename=$module
                                MVS=""
                                UNIX=""
                                if [[ -f $BIN_TEMP_PATH/$first_sir$module ]]; then
                                    BinaryChanged="Y"
                                else
                                    BinaryChanged=""
                                fi
                                CopyToSpreadsheet
                            fi 
                            cp -f $refpath/${module%.*}.csm $refdest
                            chmod 444 $refdest/$module
                            chgrp $GROUP $refdest/$module
                            chmod 444 $refdest/${module%.*}.csm
                            chgrp $GROUP $refdest/${module%.*}.csm
                            if [[ $CLNT_flag != $SET ]]; then
                                if [[ $TAR_STP_File_Flag = $SET ]]; then
                                    ## TAR COMMAND ##
                                    tarfilename=${module%.*}.csm
                                    TAR_SOURCE_DIR=client/$AREA_DEST/$code_loc
                                    Create_Tar_File
                                else
                                    ## STP CHECK ##
                                    if [[ $STP_Check_Flag = $SET ]]; then
                                        checkfilename=${module%.*}.csm
                                        LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                                        Check_STP_Area
                                    fi
                                    SOURCE_DIR=$CLIENT_DEST/$code_loc
                                    TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                                    transfer_file=${module%.*}.csm
                                    transfer_to_clients
                                fi
                                flagfile=${module%.*}.csm
                                flag_production_group
                            fi
                            if [[ $Sprdsht_flag = $SET ]]; then
                                TRmain_type=$ancestor_type
                                TRsub_type=$parent
                                TRfilename=${module%.*}.csm
                                MVS=""
                                UNIX=""
                                BinaryChanged=""
                                CopyToSpreadsheet
                            fi
                            vcs -C$CURR_DIR/$CONFIG_FILE -Y -Q -G$VCS_LEVEL $module
                            TargetFileName=$module
                            for sir in $SIR_NUMBERS
                            do
                                MIGRATION_FILE=$PSC_LOC/$sir.psc
                                MigrateToTarget
                            done
                            vcs -C$CURR_DIR/$CONFIG_FILE -Y -Q -G$VCS_LEVEL ${module%.*}.csm
                            TargetFileName=${module%.*}.csm
                            for sir in $SIR_NUMBERS
                            do
                                MIGRATION_FILE=$PSC_LOC/$sir.psc
                                MigrateToTarget
                            done
                        fi 
                    fi
                else
                    print "\nERROR: Cannot promote csrmap: $module."
                    print "\nERROR: $refpath/${module%.*}.csm does not exist."
                    print $module >> $CURR_DIR/unsuccessful.promote
                fi
            else
                print "\nERROR: $refpath/$module does not exist."
                print $module >> $CURR_DIR/unsuccessful.promote
            fi;; 
    static) Data_Flag=$SET
            prefix=$Static_Data_Prefix
            if [[ $CLNT_flag != $SET ]]; then
                if [[ $TAR_STP_File_Flag = $SET ]]; then
                    ProcessData
                else
                    if [[ -a $DATA_DIR/data/static/$module.$prefix.Z ]]; then
                        ## STP CHECK ##
                        if [[ $STP_Check_Flag = $SET ]]; then
                            checkfilename=$module.$prefix.Z
                            LIST_TRANSFER_DIR=$DATA_STP_AREA
                            Check_STP_Area
                        fi
                        SOURCE_DIR=$DATA_DIR/data/static
                        TRANSFER_DIR=$DATA_STP_AREA
                        transfer_file=$module.$prefix.Z
                        transfer_to_clients
                        if [[ $Sprdsht_flag = $SET ]]; then
                            codetype=host
                            TRmain_type=table
                            TRsub_type=$type
                            TRfilename=$module
                            MVS=""
                            UNIX=""
                            BinaryChanged=""
                            CopyToSpreadsheet
                        fi
                    else
                        print "ERROR: $DATA_DIR/data/static/$module.$prefix.Z does not exist."
                        print $module >> $CURR_DIR/unsuccessful.promote
                        if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                            if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                print "\nDeleting $TAR_FILE."
                                rm -f $MASSWORK_DIR/$TAR_FILE
                            fi
                        fi
                        if [[ $Sprdsht_flag = $SET ]]; then
                            if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                print "\nDeleting $T_PROJECT.temp.csv.$$."
                                rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                            fi
                        fi
                        Remove_temp_files 
                        exit $ERROR
                    fi
                fi
                print $module.$prefix.Z >> $CURR_DIR/staticdata.lst
            fi;;
     relat) ## JUST INSERT A LINE IN THE SPREADSHEET FOR RELAT TABLES ##
            if [[ $Sprdsht_flag = $SET ]]; then
                codetype=host
                TRmain_type=table
                TRsub_type=$type
                TRfilename=$module
                MVS=""
                UNIX=""
                BinaryChanged=""
                CopyToSpreadsheet
            fi;;
         *) if [[ -a $refpath/$module ]]; then
                if [[ $FTP_Only_flag = $SET ]]; then
                    ## HOST MVSPORT flag is set ##
                    if [[ $Host_Mvsport_Flag = $SET ]]; then
                        case $type in 
                            bitmaps | icon | include | codestbl)
                                SOURCE_DIR=$CLIENT_DEST/$code_loc
                                TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                                TAR_SOURCE_DIR=client/$AREA_DEST/$code_loc
                                MVS=""
                                UNIX=""
                                BinaryChanged="";;
                            copyio | lib | nongen | copyreport | copytable | code | cuv | copyintrface | mvssfe) 
                                SOURCE_DIR=$MFDEST_AREA/$code_loc
                                TRANSFER_DIR=$MFHOST_TRANSFER_DIR/$code_loc
                                TAR_SOURCE_DIR=host/mf$AREA_DEST/$code_loc
                                MVS=Y
                                UNIX=""
                                BinaryChanged="";;

#added by Suresh Pellakur for XLTmaps to go to host/svt/source instead of host/mfsvt/source Directory in Transfer Drive
                           xltmap | scripts )
				SOURCE_DIR=$HOST_DEST/$code_loc
				TRANSFER_DIR=$HOST_TRANSFER_DIR/$code_loc
				TAR_SOURCE_DIR=host/$AREA_DEST/$code_loc
                                MVS=""
                                UNIX=""
				BinaryChanged="";;
# code end by Suresh Pellakur on 09/08/2000

			     *)  SOURCE_DIR=$HOST_DEST/$code_loc
                                TRANSFER_DIR=$HOST_TRANSFER_DIR/$code_loc
                                TAR_SOURCE_DIR=host/mf$AREA_DEST/$code_loc
                                MVS=""
                                UNIX=""
                                BinaryChanged="";;
                        esac
			if [[ $TAR_STP_File_Flag = $SET ]]; then
			    ## TAR COMMAND ##
			    tarfilename=$module
			    Create_Tar_File
		        else
			    ## STP CHECK ##
			    if [[ $STP_Check_Flag = $SET ]]; then
			        echo "Running Check_STP_Area for $module ..."
			        checkfilename=$module
			        LIST_TRANSFER_DIR=$TRANSFER_DIR
			        Check_STP_Area
			    fi
			    transfer_file=$module
			    transfer_to_clients
			fi
                        flagfile=$module
                        flag_production_group
                        if [[ $Sprdsht_flag = $SET ]]; then
                            TRmain_type=$main_type
                            TRsub_type=$sub_type
                            TRfilename=$module
                            CopyToSpreadsheet
                        fi
                    fi
                    ## HOST UNIX flag is set ##
                    if [[ $Host_Unix_Flag = $SET && $type != mvssfe ]]; then
                        case $type in 
                            bitmaps | icon | include | codestbl)
                                SOURCE_DIR=$CLIENT_DEST/$code_loc
                                TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                                TAR_SOURCE_DIR=client/$AREA_DEST/$code_loc
                                MVS=""
                                UNIX=""
                                BinaryChanged="";;
                            copyio | lib | nongen | copyreport | copytable | code | cuv | copyintrface)
                                SOURCE_DIR=$HOST_DEST/$code_loc
                                TRANSFER_DIR=$UNIXHOST_TRANSFER_DIR/$code_loc
                                TAR_SOURCE_DIR=host/$AREA_DEST/$code_loc
                                MVS=""
                                UNIX=Y
                                BinaryChanged="";;
                            *)  SOURCE_DIR=$HOST_DEST/$code_loc
                                TRANSFER_DIR=$HOST_TRANSFER_DIR/$code_loc
                                TAR_SOURCE_DIR=host/$AREA_DEST/$code_loc
                                MVS=""
                                UNIX=""
                                BinaryChanged="";;
                        esac
                        if [[ $TAR_STP_File_Flag = $SET ]]; then
                            ## TAR COMMAND ##
                            tarfilename=$module
                            Create_Tar_File
                        else
                            ## STP CHECK ##
                            if [[ $STP_Check_Flag = $SET ]]; then
                                echo "Running Check_STP_Area for $module ..."
                                checkfilename=$module
                                LIST_TRANSFER_DIR=$TRANSFER_DIR
                                Check_STP_Area
                            fi
                            transfer_file=$module
                            transfer_to_clients
                        fi
                        flagfile=$module
                        flag_production_group
                        if [[ $Sprdsht_flag = $SET ]]; then
                            TRmain_type=$main_type
                            TRsub_type=$sub_type
                            TRfilename=$module
                            CopyToSpreadsheet
                        fi
                    fi
                    if [[ $type = lib ]]; then
                        Set_Permissions_on_pscfile
                        Svtstage_Check
                        mylen=`echo $module | awk '{len=length(); print len;}'`
                        char=$(print $module | cut -c$mylen)
                        if [[ $char = "I" || $char = "O" ]]; then
                            tempname2=`echo $module | awk '{len=length(); val=substr($0, 1, len-1); print val;}'`
                            tempname=`echo $tempname2 | awk '{len=length(); val=substr($0, 4, len-1); print val;}'`
                            mvssfename=CUF$tempname
                            servername=CUF$tempname.c
                            if [[ $IOConfirmFlag != $SET ]]; then
                                print "Promote $servername also? (Y/N) \c"
                                read response
                            elif [[ $FullList_flag = $SET && ! -z $listresponse ]]; then
                                response=$listresponse
                            else
                                response=y
                            fi
                            if [[ $response = y || $response = Y ]]; then
                                type=""
                                module=$servername
                                ext=$(print $module | cut -d'.' -f2)
                                Evaluate_Ext
                                if [[ $FTP_Only_flag = $SET ]]; then
                                    print "Transferring $type - $module - to Transfer Area..."
                                else
                                    print "Promoting $type - $module - to $AREA_DEST ..."
                                fi
                                Evaluate_Type
                                Set_Permissions_on_pscfile
                                Svtstage_Check
                            fi
                            if [[ $IOConfirmFlag != $SET ]]; then
                                print "Promote $mvssfename also? (Y/N) \c"
                                read response
                            elif [[ $FullList_flag = $SET && ! -z $listresponse ]]; then
                                response=$listresponse
                            else
                                response=y
                            fi
                            if [[ $response = y || $response = Y ]]; then
                                type=mvssfe
                                module=$mvssfename
                                ext=$(print $module | cut -d'.' -f2)
                                Evaluate_Ext
                                if [[ $FTP_Only_flag = $SET && $Host_Mvsport_Flag = $SET ]]; then
                                    print "Transferring $type - $module - to Transfer Area..."
                                elif [[ $Host_Mvsport_Flag = $SET ]]; then
                                    print "Promoting $type - $module - to $AREA_DEST ..."
                                fi
                                Evaluate_Type
                                Set_Permissions_on_pscfile
                                Svtstage_Check
                            fi
                        fi
                    fi
                else
                    if [[ $Check_Production_Flag = $SET && $FTP_Only_flag != $SET ]]; then
                        echo "Checking version numbers for promotion validation ..."
                        prodfile=$module
                        check_production_flag
                    fi

                    cp -f $refpath/$module $refdest
                    if [[ $? != 0 ]]; then
                        print "ERROR: Could not copy $refpath/$module to $refdest".
                        print $module >> $CURR_DIR/unsuccessful.promote
                    else
                        if [[ $type = scripts || $type = cards ]]; then
                            chmod 555 $refdest/$module
                            chgrp $GROUP $refdest/$module
                        else
                            chmod 444 $refdest/$module
                            chgrp $GROUP $refdest/$module
                        fi

                        if [[ $Host_Unix_Flag = $SET && $CLNT_flag != $SET ]]; then
                            case $type in
                                copyio | lib | nongen | copyreport | copytable | code | cuv | copyintrface)
                                    if [[ $TAR_STP_File_Flag = $SET ]]; then
                                        ## TAR COMMAND ##
                                        tarfilename=$module
                                        TAR_SOURCE_DIR=host/mf$AREA_DEST/$code_loc
                                        Create_Tar_File
                                     else
                                         ## STP CHECK ##
                                         if [[ $STP_Check_Flag = $SET ]]; then
                                             echo "Running Check_STP_Area for $module ..."
                                             checkfilename=$module
                                             LIST_TRANSFER_DIR=$UNIXHOST_TRANSFER_DIR/$code_loc
                                             Check_STP_Area
                                         fi
                                         SOURCE_DIR=$HOST_DEST/$code_loc
                                         TRANSFER_DIR=$UNIXHOST_TRANSFER_DIR/$code_loc
                                         transfer_file=$module
                                         transfer_to_clients
                                    fi
                                    flagfile=$module
                                    flag_production_group
                                    if [[ $Sprdsht_flag = $SET ]]; then
                                        TRmain_type=$main_type
                                        TRsub_type=$sub_type
                                        TRfilename=$module
                                        MVS=""
                                        UNIX=Y
                                        BinaryChanged=""
                                        CopyToSpreadsheet
                                    fi;;
                                *);;
                            esac
                        fi

                        vcs -C$CURR_DIR/$CONFIG_FILE -Y -Q -G$VCS_LEVEL $module
                        TargetFileName=$module
                        for sir in $SIR_NUMBERS
                        do
                            MIGRATION_FILE=$PSC_LOC/$sir.psc
                            MigrateToTarget
                        done


                        if [[ $Host_Mvsport_Flag = $SET ]]; then 
                            case $type in 
                                copyio | lib | nongen | copyreport | copytable | code | cuv | copyintrface | mvssfe)
                                    cp -f $refpath/$module $MFDEST_AREA/$code_loc
                                    if [[ $? = 0 ]]; then
                                        chmod 644 $MFDEST_AREA/$code_loc/$module
                                        chgrp $GROUP $MFDEST_AREA/$code_loc/$module
                                        current_date="`date '+%m'/'%d'/'%y'`"
                                        mvsport $T_PROJECT $MFDEST_AREA/$code_loc/$module
                                        if [[ $? = 0 ]]; then
                                            print "$module:  passed mvsport"
                                            passed_mvs=$SET
                               
                                            if [[ $CLNT_flag != $SET ]]; then
                                                if [[ $TAR_STP_File_Flag = $SET ]]; then
                                                    ## TAR COMMAND ##
                                                    tarfilename=${module%.*}
                                                    TAR_SOURCE_DIR=host/mf$AREA_DEST/$code_loc
                                                    Create_Tar_File
                                                else
                                                    ## STP CHECK ##
                                                    if [[ $STP_Check_Flag = $SET ]]; then
                                                        checkfilename=${module%.*}
                                                        echo "Running Check_STP_Area for $checkfilename ..."
                                                        LIST_TRANSFER_DIR=$MFHOST_TRANSFER_DIR/$code_loc
                                                        Check_STP_Area
                                                    fi
                                                    SOURCE_DIR=$MFDEST_AREA/$code_loc
                                                    TRANSFER_DIR=$MFHOST_TRANSFER_DIR/$code_loc
                                                    transfer_file=${module%.*}
                                                    transfer_to_clients
                                                fi
                                                flagfile=$module
                                                flag_production_group
                                                noextname=${module%.*}
                                            else
                                                noextname=${module%.*}
                                            fi

                                            if [[ $Sprdsht_flag = $SET ]]; then
                                                TRmain_type=$main_type
                                                TRsub_type=$sub_type
                                                TRfilename=$noextname
                                                MVS=Y
                                                UNIX=""
                                                BinaryChanged=""
                                                CopyToSpreadsheet
                                            fi
                                        else
                                            print "\nERROR: $module did not pass mvsport."
                                            rm -f $MFDEST_AREA/source/copy/$type/$module
                                            passed_mvs=$UNSET
                                        fi
                                    else
                                        print "\nERROR: Failed to copy ${module%.*} to $MFDEST_AREA/$code_loc."
                                        print ${module%.*} >> $CURR_DIR/unsuccessful.promote
                                        passed_mvs=$UNSET
                                    fi;;
                                *);;
                            esac
                        fi

                        if [[ $CLNT_flag != $SET ]]; then
                            case $type in 
                                bitmaps | icon | include | codestbl)
                                    if [[ $TAR_STP_File_Flag = $SET ]]; then
                                        ## TAR COMMAND ##
                                        tarfilename=$module
                                        TAR_SOURCE_DIR=client/$AREA_DEST/$code_loc
                                        Create_Tar_File
                                    else 
                                        ## STP CHECK ##
                                        if [[ $STP_Check_Flag = $SET ]]; then
                                            echo "Running Check_STP_Area for $module ..."
                                            checkfilename=$module
                                            LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                                            Check_STP_Area
                                        fi
                                        SOURCE_DIR=$CLIENT_DEST/$code_loc
                                        TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                                        transfer_file=$module
                                        transfer_to_clients
                                    fi
                                    flagfile=$module
                                    flag_production_group
                                    noextname=$module
                                    if [[ $Sprdsht_flag = $SET ]]; then
                                        TRmain_type=$main_type
                                        TRsub_type=$sub_type
                                        TRfilename=$noextname
                                        MVS=""
                                        UNIX="" 
                                        BinaryChanged=""
                                        CopyToSpreadsheet
                                    fi;;
                                xltmap | files)
                                    if [[ $TAR_STP_File_Flag = $SET ]]; then
                                        ## TAR COMMAND ##
                                        tarfilename=$module
                                        TAR_SOURCE_DIR=host/$AREA_DEST/$code_loc
                                        Create_Tar_File
                                    else
                                        ## STP CHECK ##
                                        if [[ $STP_Check_Flag = $SET ]]; then
                                            echo "Running Check_STP_Area for $module ..."
                                            checkfilename=$module
                                            LIST_TRANSFER_DIR=$HOST_TRANSFER_DIR/$code_loc
                                            Check_STP_Area
                                        fi
                                        SOURCE_DIR=$HOST_DEST/$code_loc
                                        TRANSFER_DIR=$HOST_TRANSFER_DIR/$code_loc
                                        transfer_file=$module
                                        transfer_to_clients
                                    fi
                                    flagfile=$module
                                    flag_production_group
                                    noextname=$module
                                    if [[ $Sprdsht_flag = $SET ]]; then
                                        TRmain_type=$main_type
                                        TRsub_type=$sub_type
                                        TRfilename=$noextname
                                        MVS=""
                                        UNIX="" 
                                        BinaryChanged=""
                                        CopyToSpreadsheet
                                    fi;;
                                scripts)
                                    if [[ $TAR_STP_File_Flag = $SET ]]; then
                                        ## TAR COMMAND ##
                                        tarfilename=$module
                                        TAR_SOURCE_DIR=host/$AREA_DEST/control/jobs/scripts
                                        Create_Tar_File
                                    else
                                        ## STP CHECK ##
                                        if [[ $STP_Check_Flag = $SET ]]; then
                                            echo "Running Check_STP_Area for $module ..."
                                            checkfilename=$module
                                            LIST_TRANSFER_DIR=$HOST_TRANSFER_DIR/control/jobs/scripts
                                            Check_STP_Area
                                        fi
                                        SOURCE_DIR=$HOST_DEST/control/jobs/scripts
                                        TRANSFER_DIR=$HOST_TRANSFER_DIR/control/jobs/scripts
                                        transfer_file=$module
                                        transfer_to_clients
                                    fi
                                    flagfile=$module
                                    flag_production_group
                                    noextname=$module
                                    if [[ $Sprdsht_flag = $SET ]]; then
                                        TRmain_type=$main_type
                                        TRsub_type=$sub_type
                                        TRfilename=$noextname
                                        MVS=""
                                        UNIX=""
                                        BinaryChanged=""
                                        CopyToSpreadsheet
                                    fi;;
                                cards)
                                    if [[ $TAR_STP_File_Flag = $SET ]]; then
                                        ## TAR COMMAND ##
                                        tarfilename=$module
                                        TAR_SOURCE_DIR=host/mf$AREA_DEST/control/jobs/cards
                                        Create_Tar_File
                                    else
                                        ## STP CHECK ##
                                        if [[ $STP_Check_Flag = $SET ]]; then
                                            echo "Running Check_STP_Area for $module ..."
                                            checkfilename=$module
                                            LIST_TRANSFER_DIR=$HOST_TRANSFER_DIR/control/jobs/cards
                                            Check_STP_Area
                                        fi 
                                        SOURCE_DIR=$HOST_DEST/control/jobs/cards
                                        TRANSFER_DIR=$HOST_TRANSFER_DIR/control/jobs/cards
                                        transfer_file=$module
                                        transfer_to_clients
                                    fi
                                    flagfile=$module
                                    flag_production_group
                                    noextname=$module
                                    if [[ $Sprdsht_flag = $SET ]]; then
                                        TRmain_type=$main_type
                                        TRsub_type=$sub_type
                                        TRfilename=$noextname
                                        MVS=""
                                        UNIX=""
                                        BinaryChanged=""
                                        CopyToSpreadsheet
                                    fi;;
                               *) ;;
                            esac
                        fi
                        
                        if [[ $type = "xltmap" ]]; then
                            VER_LOG=version.txt
                            vlog -BG$VCS_LEVEL -R $H_ARCH/source/xltmap/$module > $VER_LOG 2>&1
                            GetLatestRevInfo

                            if [[ $? = $ERROR ]]; then
                                print "\nERROR:  Could not write complete log information to $xltlogfile for $T_PROJECT."
                            else
                                print "$HOST_DEST/source/xltmap/$module,$promo_user promoted Rev $latest_rev on $log_promo_date" >> $xltlogpath/$xltlogfile
                                print "Successfully updated the xlt log file.\n"
                            fi
                        fi

                        if [[ $type = "codestbl" ]]; then
                            VER_LOG=version.txt
                            vlog -BG$VCS_LEVEL -R $C_ARCH/source/codestbl/$module > $VER_LOG 2>&1
                            GetLatestRevInfo

                            if [[ $? = $ERROR ]]; then
                                print "\nERROR:  Could not write complete log information to $datlogfile for $T_PROJECT."
                            else
                                print "$CLIENT_DEST/source/codestbl/$module,$promo_user promoted Rev $latest_rev on $log_promo_date" >> $datlogpath/$datlogfile
                                print "Successfully updated the dat log file.\n"
                            fi
                        fi
                    fi
                    if [[ $type = lib ]]; then
                        Set_Permissions_on_pscfile
                        Svtstage_Check
                        mylen=`echo $module | awk '{len=length(); print len;}'`
                        char=$(print $module | cut -c$mylen)
                        if [[ $char = "I" || $char = "O" ]]; then
                            tempname2=`echo $module | awk '{len=length(); val=substr($0, 1, len-1); print val;}'`
                            tempname=`echo $tempname2 | awk '{len=length(); val=substr($0, 4, len-1); print val;}'`
                            mvssfename=CUF$tempname
                            servername=CUF$tempname.c
                            if [[ $IOConfirmFlag != $SET ]]; then
                                print "Promote $servername also? (Y/N) \c"
                                read response
                            elif [[ $FullList_flag = $SET && ! -z $listresponse ]]; then
                                response=$listresponse
                            else
                                response=y
                            fi
                            if [[ $response = y || $response = Y ]]; then
                                type=""
                                module=$servername
                                ext=$(print $module | cut -d'.' -f2)
                                Evaluate_Ext
                                if [[ $FTP_Only_flag = $SET ]]; then
                                    print "Transferring $type - $module - to Transfer Area..."
                                else
                                    print "Promoting $type - $module - to $AREA_DEST ..."
                                fi
                                Evaluate_Type
                                Set_Permissions_on_pscfile
                                Svtstage_Check
                            fi
                            if [[ $IOConfirmFlag != $SET ]]; then
                                print "Promote $mvssfename also? (Y/N) \c"
                                read response
                            elif [[ $FullList_flag = $SET && ! -z $listresponse ]]; then
                                response=$listresponse
                            else
                                response=y
                            fi
                            if [[ $response = y || $response = Y ]]; then
                                type=mvssfe
                                module=$mvssfename
                                ext=$(print $module | cut -d'.' -f2)
                                Evaluate_Ext
                                if [[ $FTP_Only_flag = $SET && $Host_Mvsport_Flag = $SET ]]; then
                                    print "Transferring $type - $module - to Transfer Area..."
                                elif [[ $Host_Mvsport_Flag = $SET ]]; then
                                    print "Promoting $type - $module - to $AREA_DEST ..."
                                fi
                                Evaluate_Type
                                Set_Permissions_on_pscfile
                                Svtstage_Check
                            fi 
                        fi
                    fi
                fi
            else
		if [[ $type = include ]]; then
		   print "WARNING: The client side CUV $module does not exist." 
                else
                   print "ERROR: Could not determine location for $module of type $type."
                   print "ERROR: $refpath/$module does not exist."
                   print $module >> $CURR_DIR/unsuccessful.promote
                fi
            fi;;
esac
}

#-------------------------------#
# Write to svt_staging.log file #
#-------------------------------#
function Svtstage_Check
{
if [[ -a $CURR_DIR/unsuccessful.promote ]]; then
    grep "$module" $CURR_DIR/unsuccessful.promote 2> /dev/null
    if [[ $? != 0 ]]; then
        if [[ $SVT_LOG = $SET && $AREA_DEST = svtstage && $flist_flag != $SET ]]; then
            if [[ $type = csrmap ]]; then
                print "$module|$type|$ancestor_type|$parent|||$SIR_NUMBERS" >> $SVT_STAG_DIR/$T_PROJECT.svt_staging.log
                if [[ $? != 0 ]]; then
                    print "\nERROR:  Could not write to the $T_PROJECT.svt.staging.log file."
                fi
            elif [[ $type = ddl ]]; then
                print "$module|$type|||$ddl_ver||$SIR_NUMBERS" >> $SVT_STAG_DIR/$T_PROJECT.svt_staging.log 
                if [[ $? != 0 ]]; then
                    print "\nERROR:  Could not write to the $T_PROJECT.svt.staging.log file."
                fi
            elif [[ $compile_flag = $SET ]]; then
                print "$module|$type||||-c|$SIR_NUMBERS" >> $SVT_STAG_DIR/$T_PROJECT.svt_staging.log 
                if [[ $? != 0 ]]; then
                    print "\nERROR:  Could not write to the $T_PROJECT.svt.staging.log file."
                fi
            else
                print "$module|$type|||||$SIR_NUMBERS" >> $SVT_STAG_DIR/$T_PROJECT.svt_staging.log
                if [[ $? != 0 ]]; then
                    print "\nERROR:  Could not write to the $T_PROJECT.svt.staging.log file."
                fi
            fi
        fi
    fi
else
    if [[ $SVT_LOG = $SET && $AREA_DEST = svtstage && $flist_flag != $SET ]]; then
        if [[ $type = csrmap ]]; then
            print "$module|$type|$ancestor_type|$parent|||$SIR_NUMBERS" >> $SVT_STAG_DIR/$T_PROJECT.svt_staging.log
            if [[ $? != 0 ]]; then
                print "\nERROR:  Could not write to the $T_PROJECT.svt.staging.log file."
            fi
        elif [[ $type = ddl ]]; then
            print "$module|$type|||$ddl_ver||$SIR_NUMBERS" >> $SVT_STAG_DIR/$T_PROJECT.svt_staging.log
            if [[ $? != 0 ]]; then
                print "\nERROR:  Could not write to the $T_PROJECT.svt.staging.log file."
            fi
        elif [[ $compile_flag = $SET ]]; then
            print "$module|$type||||-c|$SIR_NUMBERS" >> $SVT_STAG_DIR/$T_PROJECT.svt_staging.log
            if [[ $? != 0 ]]; then
                print "\nERROR:  Could not write to the $T_PROJECT.svt.staging.log file."
            fi
        else
            print "$module|$type|||||$SIR_NUMBERS" >> $SVT_STAG_DIR/$T_PROJECT.svt_staging.log
            if [[ $? != 0 ]]; then
                print "\nERROR:  Could not write to the $T_PROJECT.svt.staging.log file."
            fi
        fi
    fi
fi
}

#---------------------------------#
# Write to the master spreadsheet #
#---------------------------------#
function Write_to_Master_Spreadsheet
{
    if [[ $Sprdsht_flag = $SET ]]; then
        if [[ -s /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
            if [[ ! -a /tmp_work/pvcs/promote/$T_PROJECT/$promotion_spreadsheet ]]; then
                print "SIR,Emrgcy,Promoted By,Client/Host,Main Type,Sub Type,Rcmp,Object Name,Memo/Issue,Issue,MVS,UNIX,BinaryChanged" >> /tmp_work/pvcs/promote/$T_PROJECT/$promotion_spreadsheet
            fi 
            if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                cat /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ >> /tmp_work/pvcs/promote/$T_PROJECT/$promotion_spreadsheet
                ## ONLY PUT IN STP IF TAR FLAG IS NOT SET ##
                if [[ $TAR_STP_File_Flag != $SET ]]; then
                    SOURCE_DIR=/tmp_work/pvcs/promote/$T_PROJECT
                    TRANSFER_DIR=/sw/transfer/$T_PROJECT/FROM/PROMOTION
                    transfer_file=$promotion_spreadsheet
                    transfer_to_clients
                fi
            fi
        fi
    fi
}

#-----------------------------#
# Set permissions on psc file #
#-----------------------------#
function Set_Permissions_on_pscfile
{
    for sir in $SIR_NUMBERS
    do
        MIGRATION_FILE=$PSC_LOC/$sir.psc
        if [[ -s $MIGRATION_FILE ]]; then
            chmod 777 $MIGRATION_FILE > /dev/null  2> /dev/null
            chgrp fcp $MIGRATION_FILE > /dev/null  2> /dev/null
            chown fcp $MIGRATION_FILE > /dev/null  2> /dev/null
        fi
    done
}

#-------------------#
# Remove temp files #
#-------------------#
function Remove_temp_files
{
    rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
    rm -f $CONFIG_FILE > /dev/null 2> /dev/null
    rm -f list.temp 
    rm -f allfiles.txt
    rm -f $CURR_DIR/tar.output
    rm -f $CURR_DIR/check_exist_file
    rm -f masterlist.lst
    rm -f pcolisting
    rm -f clientlisting
    rm -f $CURR_DIR/staticdata.lst
}

function Delete_client_files
{
    entry_name=$(print $object_name | cut -d'.' -f1)
    entry_ext=$(print $object_name | cut -d'.' -f2)
    if  [[ $entry_ext = "dlg" ]]; then
        rm -f $BIN_TEMP_PATH/$first_sir$entry_name.exe > /dev/null
        for wrkunit in $(</css/c1/pvcs/workunit/$object_name)
        do
            wkunitfile=${wrkunit#@}
            for entry in $(</css/c1/pvcs/workunit/$wkunitfile)
            do
                entry_ext=$(print $entry | cut -d'.' -f2)
                if [ $entry_ext = "map" ]; then
                    rm -f $BIN_TEMP_PATH/$first_sir$entry > /dev/null
                fi
            done
        done
    fi
    if [[ $entry_ext = "wc" ]]; then
        rm -f $BIN_TEMP_PATH/$first_sir$entry_name.dll > /dev/null
        for entry in $(</css/c1/pvcs/workunit/$object_name)
        do
            entry_ext=$(print $entry | cut -d'.' -f2)
            if [[ $entry_ext = "map" ]]; then   
                rm -f $BIN_TEMP_PATH/$first_sir$entry > /dev/null
            fi
        done
    fi
    if [[ $entry_ext = "map" ]]; then
        rm -f $BIN_TEMP_PATH/$first_sir$object_name
    fi
}

function Remove_temp_binary_files
{
    if [[ $FullList_flag = $SET ]]; then
        for entry in $(<$ListName)
        do
            object_name=$(print $entry | cut -d'|' -f1)
            Delete_client_files
        done
    else
        object_name=$module
        Delete_client_files
    fi
}

#------------------------------------------------#
# Check if a file already exists in the STP area #
#------------------------------------------------#
function Check_STP_Area
{
    DecidedAnswer=$UNSET
    OK_to_overwrite_flag=$UNSET
    if [[ -a $CURR_DIR/check_exist_file ]]; then
        rm -f $CURR_DIR/check_exist_file
    fi
    if [[ `hostname` != $STP_SERVER ]]; then
        rexec $STP_SERVER -l pvcs -p $PVCS_PASSWORD  "ls $LIST_TRANSFER_DIR/$checkfilename" >> $CURR_DIR/check_exist_file
    else
        ls $LIST_TRANSFER_DIR/$checkfilename >> $CURR_DIR/check_exist_file 2> /dev/null
    fi
    if [[ -a $CURR_DIR/check_exist_file ]]; then
        if [[ -s $CURR_DIR/check_exist_file ]]; then
            grep $checkfilename $CURR_DIR/check_exist_file 2> /dev/null
            if [[ $? = 0 ]]; then
                while [[ $DecidedAnswer != $SET ]];
                do
                    echo "\nWARNING: $checkfilename already exists in the STP transfer area.\n"
                    if [[ $IOConfirmFlag != $SET ]]; then ## IS THIS CORRECT???
                        echo "Do you wish to overwrite and continue? (y or n) \c"
                        read response
                        response=`print $response | tr "[:upper:]" "[:lower:]"`
                        if [[ $response = "y" || $response = "yes" ]]; then
                            DecidedAnswer=$SET
                            OK_to_overwrite_flag=$SET
                            if [[ $STP_flag = $SET && $TAR_STP_File_Flag != $SET ]]; then
                                Emergency_STP_Exist_Flag=$SET
                            fi
                            continue
                        elif [[ $response = "n" || $response = "no" ]]; then
                            DecidedAnswer=$SET
                            if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                                if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                    print "\nDeleting $TAR_FILE."
                                    rm -f $MASSWORK_DIR/$TAR_FILE
                                fi
                            fi
                            if [[ $Sprdsht_flag = $SET ]]; then
                                if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                    print "\nDeleting $T_PROJECT.temp.csv.$$."
                                    rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                                fi
                            fi
                            Remove_temp_files
                            exit $ERROR
                        else
                            print "ERROR: Cannot recognize decision -> $response"
                            DecidedAnswer=$UNSET
                            DisplaySTPOptions
                        fi
                    else
                        DecidedAnswer=$SET
                        OK_to_overwrite_flag=$SET
                        continue
                    fi
                done
            else
                return $SUCCESS
            fi
        fi
    else
        return $SUCCESS
    fi
}

#------------------------------------------------#
# Check if a file already exists in the STP area #
#------------------------------------------------#
function STP_List_Check
{
    DecidedAnswer=$UNSET
    OK_to_overwrite_flag=$UNSET
    if [[ -a $CURR_DIR/check_exist_file ]]; then
        rm -f $CURR_DIR/check_exist_file
    fi
    if [[ `hostname` != $STP_SERVER ]]; then
        rexec $STP_SERVER -l pvcs -p $PVCS_PASSWORD  "ls $LIST_TRANSFER_DIR/$checkfilename" >> $CURR_DIR/check_exist_file
    else
        ls $LIST_TRANSFER_DIR/$checkfilename >> $CURR_DIR/check_exist_file 2> /dev/null
    fi
    if [[ -a $CURR_DIR/check_exist_file ]]; then
        if [[ -s $CURR_DIR/check_exist_file ]]; then
            grep $checkfilename $CURR_DIR/check_exist_file 2> /dev/null
            if [[ $? = 0 ]]; then
                while [[ $DecidedAnswer != $SET ]];
                do
                    echo "\nWARNING: $checkfilename already exists in the STP transfer area.\n"
                    if [[ $IOConfirmFlag != $SET ]]; then ## IS THIS CORRECT???
                        echo "Do you wish to overwrite and continue? (y or n) \c"
                        read response
                    elif [[ $FullList_flag = $SET && ! -z $listresponse ]]; then
                        echo "Do you wish to continue? (y or n) \c"
                        read response
                    fi
                        response=`print $response | tr "[:upper:]" "[:lower:]"`
                        if [[ $response = "y" || $response = "yes" ]]; then
                            DecidedAnswer=$SET
                            OK_to_overwrite_flag=$SET
                            continue
                        elif [[ $response = "n" || $response = "no" ]]; then
                            DecidedAnswer=$SET
                            if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                                if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                    print "\nDeleting $TAR_FILE."
                                    rm -f $MASSWORK_DIR/$TAR_FILE
                                fi 
                            fi
                            if [[ $Sprdsht_flag = $SET ]]; then
                                if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                    print "\nDeleting $T_PROJECT.temp.csv.$$."
                                    rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                                fi 
                            fi
                            Remove_temp_files 
                            exit $ERROR
                        else
                            print "ERROR: Cannot recognize decision -> $response"
                            DecidedAnswer=$UNSET
                            DisplaySTPOptions
                        fi
                   #fi
                done
            else
                return $SUCCESS
            fi
        fi
    else
        return $SUCCESS
    fi
}

#-------------------------------#
# Create the configuration file #
#-------------------------------#
function Create_config_file
{
    if [[ -n $ext && ${#ext} -le $EXT_LEN ]]; then
        case $ext in
            dlg)
                dialogname=$(print $module | cut -d'.' -f1)
                code_loc=source/dialog/$dialogname
                LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                print "ReferenceDir=$CLIENT_REF/source/dialog/$dialogname/*" > $CURR_DIR/$CONFIG_FILE
                print "VCSDir=$C_ARCH/source/dialog/$dialogname/*" >> $CURR_DIR/$CONFIG_FILE;;
            wc | css)
                comwinname=$(print $module | cut -d'.' -f1)
                code_loc=source/comwin/$comwinname
                LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                print "ReferenceDir=$CLIENT_REF/source/comwin/$comwinname/*" > $CURR_DIR/$CONFIG_FILE
                print "VCSDir=$C_ARCH/source/comwin/$comwinname/*" >> $CURR_DIR/$CONFIG_FILE;;
            map)
                if [[ -z $ancestor_type ]]; then
                    print "\nEnter type the csrmap belongs to: [dialog or comwin] \c"
                    read ancestor_type
                fi
                if [[ -z $parent ]]; then
                    print "\nEnter parent name of csrmap: [ dialog or common window name  e.g. cucl01 ] \c"
                    read parent
                fi
                code_loc=source/$ancestor_type/$parent
                LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                print "ReferenceDir=$CLIENT_REF/source/$ancestor_type/$parent/*" > $CURR_DIR/$CONFIG_FILE
                print "VCSDir=$C_ARCH/source/$ancestor_type/$parent/*" >> $CURR_DIR/$CONFIG_FILE;;
            dde)
                code_loc=runtime/dde
                LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                print "ReferenceDir=$CLIENT_REF/runtime/dde" > $CURR_DIR/$CONFIG_FILE
                print "VCSDir=$C_ARCH/runtime/dde" >> $CURR_DIR/$CONFIG_FILE;;
            bmp)
                code_loc=source/bitmaps/nt
                LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                print "ReferenceDir=$CLIENT_REF/source/bitmaps/*" > $CURR_DIR/$CONFIG_FILE
                print "VCSDir=$C_ARCH/source/bitmaps/*" >> $CURR_DIR/$CONFIG_FILE;;
            ico)
                code_loc=source/bitmaps/nt
                LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                print "ReferenceDir=$CLIENT_REF/source/bitmaps/*" > $CURR_DIR/$CONFIG_FILE
                print "VCSDir=$C_ARCH/source/bitmaps/*" >> $CURR_DIR/$CONFIG_FILE;;
            h | gnb)
                code_loc=source/include
                LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                print "ReferenceDir=$CLIENT_REF/source/include" > $CURR_DIR/$CONFIG_FILE
                print "VCSDir=$C_ARCH/source/include" >> $CURR_DIR/$CONFIG_FILE;;
            hlp)
                help_type=${module%.*}
                code_loc=source/help/helpsrc/$help_type
                LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                help_type=$(print $module | cut -d'.' -f1)
                print "ReferenceDir=$CLIENT_REF/source/help/helpsrc/$help_type" > $CURR_DIR/$CONFIG_FILE
                print "VCSDir=$C_ARCH/source/help/helpsrc/$help_type" >> $CURR_DIR/$CONFIG_FILE;;
            sql)
		code_loc=control/jobs/scripts
		LIST_TRANSFER_DIR=$HOST_TRANSFER_DIR/$code_loc
		print "ReferenceDir=$HOST_REF/control/jobs/scripts" > $CURR_DIR/$CONFIG_FILE
		print "VCSDir=$H_ARCH/control/jobs/scripts" >> $CURR_DIR/$CONFIG_FILE;;
            xlt)
                code_loc=source/xltmap
                LIST_TRANSFER_DIR=$HOST_TRANSFER_DIR/$code_loc
                print "ReferenceDir=$HOST_REF/source/xltmap" > $CURR_DIR/$CONFIG_FILE
                print "VCSDir=$H_ARCH/source/xltmap" >> $CURR_DIR/$CONFIG_FILE;;
            c)
                code_loc=source/code/service
                UNIXLIST_TRANSFER_DIR=$UNIXHOST_TRANSFER_DIR/$code_loc
                LIST_TRANSFER_DIR=$UNIXHOST_TRANSFER_DIR/$code_loc
                print "ReferenceDir=$HOST_REF/source/code/service" > $CURR_DIR/$CONFIG_FILE
                print "VCSDir=$H_ARCH/source/code/service" >> $CURR_DIR/$CONFIG_FILE;;
            ctl)
                code_loc=control/jobs/scripts
                LIST_TRANSFER_DIR=$HOST_TRANSFER_DIR/$code_loc
                print "ReferenceDir=$HOST_REF/control/jobs/scripts" > $CURR_DIR/$CONFIG_FILE
                print "VCSDir=$H_ARCH/control/jobs/scripts" >> $CURR_DIR/$CONFIG_FILE;;
            pco)
                if [[ -z $type ]]; then
                    if [[ `find $HOST_REF/source/code -type f -name $module |wc -l` -gt 1 ]]; then
                        print "ERROR $module:  a duplicate module was found!"
                        if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                            if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                print "\nDeleting $TAR_FILE."
                                rm -f $MASSWORK_DIR/$TAR_FILE
                            fi
                        fi
                        if [[ $Sprdsht_flag = $SET ]]; then
                            if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                print "\nDeleting $T_PROJECT.temp.csv.$$."
                                rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                            fi
                        fi
                        Remove_temp_files
                        exit $ERROR
                    else
                        filepath=`find $HOST_REF/source/code -type f -name $module`
                        type=$(print $filepath | cut -d\/ -f8)
                        code_loc=source/code/$type
                        if [[ $Host_Mvsport_Flag = $SET ]]; then
                            MFLIST_TRANSFER_DIR=$MFHOST_TRANSFER_DIR/$code_loc
                        fi
                        if [[ $Host_Unix_Flag = $SET ]]; then
                            UNIXLIST_TRANSFER_DIR=$UNIXHOST_TRANSFER_DIR/$code_loc
                        fi
                        print "ReferenceDir=$HOST_REF/source/code/$type" > $CURR_DIR/$CONFIG_FILE
                        print "VCSDir=$H_ARCH/source/code/$type" >> $CURR_DIR/$CONFIG_FILE
                    fi
                else
                    code_loc=source/code/$type
                    if [[ $Host_Mvsport_Flag = $SET ]]; then
                        MFLIST_TRANSFER_DIR=$MFHOST_TRANSFER_DIR/$code_loc
                    fi
                    if [[ $Host_Unix_Flag = $SET ]]; then
                        UNIXLIST_TRANSFER_DIR=$UNIXHOST_TRANSFER_DIR/$code_loc
                    fi
                    print "ReferenceDir=$HOST_REF/source/code/$type" > $CURR_DIR/$CONFIG_FILE
                    print "VCSDir=$H_ARCH/source/code/$type" >> $CURR_DIR/$CONFIG_FILE
                fi;;
            *)
                print "ERROR:  Could not determine the type -> $type." >> $WRK_DIR/$module.out 2>&1;;
        esac
    elif [[ -z $type && ${#ext} -gt $EXT_LEN ]]; then
        print "Enter module type:"
        print "[scripts|cards|copyio|lib|nongen|copyreport|copytable|copyintrface|code|cuv|mvssfe|files] ->\c"
        read type
        setconfig
    elif [[ ! -z $type && ${#ext} -gt $EXT_LEN ]]; then
        setconfig
    elif [[ -z $ext || ${#ext} -gt $EXT_LEN ]]; then
        setconfig
    else
        prompt_usage
        print "ERROR: Check input parameters."
        if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
            if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                print "\nDeleting $TAR_FILE."
                rm -f $MASSWORK_DIR/$TAR_FILE
            fi
        fi 
        if [[ $Sprdsht_flag = $SET ]]; then
            if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                print "\nDeleting $T_PROJECT.temp.csv.$$."
                rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
            fi
        fi
        Remove_temp_files
        exit $ERROR
    fi
}

function DisplayOptions
{
    echo "\nWARNING: $prodfile has revision $nextenv_rev in $AREA_DEST and $prodenv_rev in production.\n"
    if [[ $IOConfirmFlag != $SET ]]; then
        echo "Do you wish to continue? (y or n) \c"
        read response
        response=`print $response | tr "[:upper:]" "[:lower:]"`
        if [[ $response = "y" || $response = "yes" ]]; then
            DecidedAnswer=$SET 
            continue
        elif [[ $response = "n" || $response = "no" ]]; then
            DecidedAnswer=$SET
            if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                    print "\nDeleting $TAR_FILE."
                    rm -f $MASSWORK_DIR/$TAR_FILE
                fi
            fi
            if [[ $Sprdsht_flag = $SET ]]; then
                if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                    print "\nDeleting $T_PROJECT.temp.csv.$$."
                    rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                fi
            fi
            Remove_temp_files 
            exit $ERROR
        else
            DecidedAnswer=$UNSET
        fi
    fi
}

function DisplaySTPOptions
{
    echo "\nWARNING: $checkfilename already exists in the STP transfer area.\n"
    if [[ $IOConfirmFlag != $SET ]]; then
        echo "Do you wish to overwrite and continue? (y or n) \c"
        read response
        response=`print $response | tr "[:upper:]" "[:lower:]"`
        if [[ $response = "y" || $response = "yes" ]]; then
            DecidedAnswer=$SET
            continue
        elif [[ $response = "n" || $response = "no" ]]; then
            DecidedAnswer=$SET
            if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                    print "\nDeleting $TAR_FILE."
                    rm -f $MASSWORK_DIR/$TAR_FILE
                fi
            fi
            if [[ $Sprdsht_flag = $SET ]]; then
                if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                    print "\nDeleting $T_PROJECT.temp.csv.$$."
                    rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                fi
            fi
            Remove_temp_files 
            exit $ERROR
        else
            DecidedAnswer=$UNSET
        fi
    fi
}

function GetLatestRevInfo
{
    if [[ -s $VER_LOG ]]; then
        line=`grep : $VER_LOG`
        if [[ $? = 0 && -s $VER_LOG ]]; then
            latest_rev=${line##*: }
        else
            print "ERROR: Attempt to get latest revision number in $VCS_LEVEL for $module failed."
            return $ERROR
        fi
    fi

    log_promo_date=`date '+%d %b %Y %X'`
    promo_user=$SW_USER

    rm -f $VER_LOG
    return $SUCCESS
}

function ProcessData
{
    if [[ -a $DATA_DIR/data/static/$module.$prefix.Z ]]; then
        ## TAR DATA AND INSERT A LINE IN THE SPREADSHEET FOR STATIC ##
        # /sw/data/static/$T_PROJECT/data/static
        # .../TO/PROMOTION/data/static
        tarfilename=$module.$prefix.Z
        cd $DATA_DIR
        if [[ ! -a $MASSWORK_DIR/$TAR_FILE ]]; then
            tar cf $MASSWORK_DIR/$TAR_FILE data/static/$tarfilename > $CURR_DIR/tar.output 2>&1
            if [[ -s $CURR_DIR/tar.output ]]; then
                 print "ERROR: Unsuccessful tar append of of $tarfilename to new $TAR_FILE tape."
                 print -n "ERROR: "
                 cat $CURR_DIR/tar.output
                 print "\nDeleting $TAR_FILE."
                 rm -f $MASSWORK_DIR/$TAR_FILE
                 if [[ $Sprdsht_flag = $SET ]]; then
                     if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                         print "\nDeleting $T_PROJECT.temp.csv.$$."
                         rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                     fi
                 fi
                 Remove_temp_files
                 exit $ERROR
             else
                 print "Successful tar of $tarfilename to new $TAR_FILE tape."
             fi
        else
             tar rf $MASSWORK_DIR/$TAR_FILE data/static/$tarfilename > $CURR_DIR/tar.output 2>&1
             if [[ -s $CURR_DIR/tar.output ]]; then
                 print "ERROR: Unsuccessful tar append of $tarfilename to $TAR_FILE."
                 print -n "ERROR: "
                 cat $CURR_DIR/tar.output
                 print "\nDeleting $TAR_FILE."
                 rm -f $MASSWORK_DIR/$TAR_FILE
                 if [[ $Sprdsht_flag = $SET ]]; then
                     if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                         print "\nDeleting $T_PROJECT.temp.csv.$$."
                         rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                     fi
                 fi
                 Remove_temp_files
                 exit $ERROR
             else
                 print "Successful tar append of $tarfilename to $TAR_FILE file."
             fi
        fi
        cd -
        if [[ $Sprdsht_flag = $SET ]]; then
            codetype=host
            TRmain_type=table
            TRsub_type=$type
            TRfilename=$module
            MVS=""
            UNIX=""
            BinaryChanged=""
            CopyToSpreadsheet
        fi
    else
        print "ERROR: $DATA_DIR/data/static/$module.$prefix.Z does not exist."
        print $module >> $CURR_DIR/unsuccessful.promote
        if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
            if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                print "\nDeleting $TAR_FILE."
                rm -f $MASSWORK_DIR/$TAR_FILE
            fi
        fi
        if [[ $Sprdsht_flag = $SET ]]; then
            if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                print "\nDeleting $T_PROJECT.temp.csv.$$."
                rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
            fi
        fi
        Remove_temp_files
        exit $ERROR
    fi
}

function put_client_files
{
    ftp -v -n <<EOF > xfer.log 2>xfer.err
    open $PC_MACHINE
    user pvcs $PVCS_PASSWORD
    cd ..
    cd rmake
    mkdir $clientobjname
    cd $clientobjname
    binary
    mput *
    bye
EOF

    FTPNO=`grep -v "bytes sent" xfer.log | grep -E "^[45][0-9][0-9]" | cut -c1-3`
    if [ ! $FTPNO -o $FTPNO -lt 400 -o $FTPNO -eq 550 ]; then
        if  [[ -s xfer.err ]]; then
	    return $ERROR
	fi
    else
        return $ERROR
    fi

    return $SUCCESS
}

function get_client_files
{
    ftp -v -n <<EOF > xfer.log 2>xfer.err
    open $PC_MACHINE
    user pvcs $PVCS_PASSWORD
    cd ..
    cd rmake
    cd $clientobjname
    prompt
    binary
    mget *
    bye
EOF

    if  [[ -s xfer.err ]]; then
        print "ERROR:  Could not get $clientobjname files from $PC_MACHINE.!"
        return $ERROR
    fi

    return $SUCCESS
}

function rm_tar_spread_files
{
    if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
        if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
            print "\nDeleting $TAR_FILE."
            rm -f $MASSWORK_DIR/$TAR_FILE
        fi
    fi
    if [[ $Sprdsht_flag = $SET ]]; then
        if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
            print "\nDeleting $T_PROJECT.temp.csv.$$."
            rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
        fi
    fi
    Remove_temp_files
    exit $ERROR
}


function evaluate_error
{
    case $RC in
        $COMPILE_ERROR)         print "ERROR: $clientobjname failed to compile.  See $SIR_DIR/sir$first_sir/$clientobjname.err for details."
                                print $filename >> $CURR_DIR/compile.err.promote
                                mkdir $SIR_DIR/sir$first_sir 2> /dev/null
                                if [[ -s ./$clientobjname.rpt ]]; then
                                    cp -f ./$clientobjname.rpt $clientobjname.err
                                    cp -f $clientobjname.err $SIR_DIR/sir$first_sir 2> /dev/null
                                    if [[ $? != 0 ]]; then
                                        print "\nERROR: Could not copy $clientobjname.err to $SIR_DIR/sir$first_sir."
                                    else
                                        print "\nERROR: Successfully copied $clientobjname.err to $SIR_DIR/sir$first_sir."
                                    fi
                                fi
                                cd ..
                                rm -rf clnt_compile 2> /dev/null
                                rm_tar_spread_files;;
        $SEM_ERROR)             print "ERROR: Compile was not initiated due to semaphor creation error."
                                print $filename >> $CURR_DIR/compile.err.promote
                                cd ..
                                rm -rf clnt_compile 2> /dev/null
                                rm_tar_spread_files;;
           
        $ARGS_ERROR)            print "ERROR: Incorrect arguments were passed to the compilation script."
                                print $filename >> $CURR_DIR/compile.err.promote
                                cd ..
                                rm -rf clnt_compile 2> /dev/null
                                rm_tar_spread_files;;

        $BUSY_ERROR)            print "\nNOTE: The compile could not executed because the compile servers are being utilized."
                                print "Please try promotion again in 5 minutes."
                                cd ..
                                rm -rf clnt_compile 2> /dev/null
                                rm_tar_spread_files;;

        $COMPILE_SUCCESS)       print "Successful compile of $clientobjname in $AREA_DEST.";;
                       *)       print "Unrecognized ERROR returned from compile server -> $RC."
                                print $filename >> $CURR_DIR/compile.err.promote
                                cd ..
                                rm -rf clnt_compile 2> /dev/null
                                rm_tar_spread_files;;

    esac
}


function CompileClientObjects 
{

    echo "Compiling client for promotion..."
    rm -rf clnt_compile 2> /dev/null
    mkdir ./clnt_compile
    if [[ $? = 0 ]]; then
	cd clnt_compile
	cp -f /css/devtools/common/host/data/azdi0400.c .
	filename=`basename $module`
        clientobjname=${filename%.*}
        typeset -i x
        typeset -i compile_loop
        compile_loop=2
        while [[ x -le $compile_loop ]] 
        do
            for server in $(<$SERVER_DIR/server.ini)
            do
	        /css/devtools/rexec/bin/rexec $server -l pvcs -p $PVCS_PASSWORD "dir c:\rmake\semaphor.dat" > file.temp 2>&1
                grep -i "File Not Found" file.temp > /dev/null 2>&1
                if [[ $? = 0 ]]; then
                    /css/devtools/rexec/bin/rexec $server -l pvcs -p $PVCS_PASSWORD "c:\perl\bin\perl.exe c:\rmake\compile.pl 1 $PROJECT $HPUX_SERVER $type $CURR_DIR/clnt_compile $clientobjname $PVCS_PASSWORD"
                    if [[ -a $CURR_DIR/clnt_compile/${PROJECT}${clientobjname}.rc ]]; then
                        RC=`head -1 $CURR_DIR/clnt_compile/${PROJECT}${clientobjname}.rc`
                    else
                        RC="No RC file found"
                    fi

                    evaluate_error
 
                    if [[ $RC = $COMPILE_SUCCESS ]]; then
                        Compile_Dir_Flag=$SET
                        break
                    fi
                else 
                    RC=$BUSY_ERROR
                fi
            done
            x=x+1
            if [[ $Compile_Dir_Flag = $SET ]]; then
                break
            fi
        x=x+1 
        done
        if [[ $RC = $BUSY_ERROR ]]; then
            evaluate_error
        fi 
    else
        print "ERROR: Could not make local client compile directory."
        rm_tar_spread_files
    fi
}

###################
# MAIN PROCESSING #
###################
#FCP UPGRADE SURESH PELLAKUR 2006-06-06
export LIBPATH=/opt/microfocus/cobol/lib

SET=1
UNSET=0
USER=`whoami`
nt_dir=""
EXT_LEN=3
SIR_DIR=/tmp_work/promote_err
PSC_LOC=/sw/pvcs/psc
SIR_LIST=/tmp_work/pvcs/migration/MigrationSirList.txt
CURR_DIR=`pwd`
FTP_FILE=.ftpfile
LOG_FILE=revnum1
LOG_FILE2=revnum2
PVCS_DIR=~pvcs
SERVER_DIR=/opt/pvcs/vm/aix/bin
PROJ_T5NM_DIR=/css/software/pvcs/data
CONFIG_FILE=vcs.cfg
ConfirmFlag=$UNSET
SIR_NUMBERS=""
FTP_Only_flag=$UNSET
Sprdsht_flag=$SET
ERROR=1
SUCCESS=0
Migrate=$UNSET
ErrorProdFlag=$UNSET
FullList_flag=$UNSET
compile_flag=$UNSET
Data_Flag=$UNSET
DoNotSend_flag=$UNSET
NonGenExt="|aex|bus|vld|h|txt|dde|doc|dot|exp|ini|lod|rft|hlp|hpj|wri|wcm|wct|wks|wkm|xlm|xls|xlt|xlw|prn|ptr|lnk|csm|map|dep|APS|BAK|CLW|CPP|DSP|DSW|H|MAK|OPT|PLG|RC|mdp|ncb|TXT|"

typeset -i compile_loop

COMPILE_SUCCESS=0
BUSY_ERROR=1
COMPILE_ERROR=2
SEM_ERROR=3
ARGS_ERROR=4

while getopts ":t:v:p:a:i:l:m:cfsoyqnde" option; do
    case $option in
        t)  type=$OPTARG;;
        v)  ddl_ver=$OPTARG;;
        c)  compile_flag=$SET
            RECOMP=Y;;
        f)  CLNT_flag=$SET
            option1="-f";;
        n)  FTP_Only_flag=$SET
            CLNT_flag=$UNSET
            option2="-n";;
        a)  ancestor_type=$OPTARG;;
        p)  parent=$OPTARG;;
        y)  ConfirmFlag=$SET;;
        q)  IOConfirmFlag=$SET;;
        s)  STP_flag=$SET        
            option4="-s";;
        d)  Sprdsht_flag=$UNSET
            option5="-d";;
        e)  Emergency=$SET
            EMERGENCY=Y
            option6="-e";;
        i)  ISSUE=$OPTARG        
            option7="-i";;
        l)  ListName=$OPTARG
            FullList_flag=$SET;;
        m)  COMMENT=`echo $OPTARG | sed s/'_'/' '/g`;;
        \?) prompt_usage 
            exit $ERROR;;
    esac
done

shift $(($OPTIND-1))

if [[ $FullList_flag = $SET ]]; then
    if [[ $# -ne 3 ]]; then
        prompt_usage
        exit $ERROR
    fi
    AREA_DEST=$1
    T_PROJECT=$2
    shift
    shift
    first_sir=$1
    SIR_NUMBERS=$@
else
    if [[ $# < 4 ]]; then
        prompt_usage
        exit $ERROR
    fi
    module=$1
    AREA_DEST=$2
    T_PROJECT=$3
    shift
    shift
    shift
    first_sir=$1
    SIR_NUMBERS=$@
fi

BIN_TEMP_PATH=/tmp_work/pvcs/promote/$T_PROJECT/client/$AREA_DEST
HOST_TRANSFER_DIR=/sw/transfer/$T_PROJECT/FROM/PROMOTION/host/$AREA_DEST
CLNT_TRANSFER_DIR=/sw/transfer/$T_PROJECT/FROM/PROMOTION/client/$AREA_DEST
SVT_STAG_DIR=/tmp_work/pvcs/svt_staging/$T_PROJECT
TAR_STP_DIR=/sw/transfer/$T_PROJECT/FROM/PROMOTION
MASSWORK_DIR=/tmp_work/pvcs/mass_work
DATA_STP_AREA=/sw/transfer/$T_PROJECT/FROM/PROMOTION/data/static

#if [[ ! -a $PVCS_DIR/vcs ]]; then
#    print "\nERROR: The VCS command has been deleted.  Please Restore before continuing."
#    exit $ERROR
#fi

GetProjectEnvVars

if [[ $Host_Mvsport_Flag = $SET ]]; then
    MFHOST_TRANSFER_DIR=/sw/transfer/$T_PROJECT/FROM/PROMOTION/host/mf$AREA_DEST
fi
if [[ $Host_Unix_Flag = $SET ]]; then
    UNIXHOST_TRANSFER_DIR=/sw/transfer/$T_PROJECT/FROM/PROMOTION/host/$AREA_DEST
fi
if [[ $Host_Mvsport_Flag != $SET && $Host_Unix_Flag != $SET ]]; then
    print "ERROR: The host flag type is not set in $T_PROJECT.ini! Do not know which host version to promote."
    if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
        if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
            print "\nDeleting $TAR_FILE."
            rm -f $MASSWORK_DIR/$TAR_FILE
        fi
    fi
    if [[ $Sprdsht_flag = $SET ]]; then
        if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
            print "\nDeleting $T_PROJECT.temp.csv.$$."
            rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
        fi
    fi
    Remove_temp_files 
    exit $ERROR
fi

if [[ $APPL_ENV != $AREA_DEST || $ARCH_ENV != $ARCH_LEVEL ]]; then
    print "ERROR:  Promotion environment not properly set."
    print "APPL_ENV is set to: $APPL_ENV"
    print "APPL_ENV should be: $AREA_DEST"
    print "ARCH_ENV is set to: $ARCH_ENV"
    print "ARCH_ENV should be: $ARCH_LEVEL"
    exit $ERROR 
fi

if [[ $PROJECT = $T_PROJECT && -n $T_PROJECT ]]; then
    if [[ -d /css/c1 ]]; then
        if [[ `hostname` != $HPUX_SERVER ]]; then
	    print "this is the host_name   `hostname`"
            print "ERROR Invalid server.  You must be on the $HPUX_SERVER"
            exit $ERROR
        fi
    else
        print "ERROR: Invalid project -> $T_PROJECT"
        exit $ERROR
    fi
else
    print "ERROR: Promotion environment not properly set."
    print "shell project    : $PROJECT"
    print "specified project: $T_PROJECT"
    exit $ERROR
fi

if [[ $Issue_No_Flag = $SET ]]; then
    if [[ -z $ISSUE ]]; then
        print "\nAn issue number is required for this promotion."
        print "\nEnter the issue number: \c"
        read ISSUE 
        option7="-i"
    fi
fi 

checksirnumber=$first_sir
echo $checksirnumber |grep -i [A-Z] > /dev/null
if [[ $? = 0 ]]; then
    print "\nERROR: Invalid SIR number -> $checksirnumber\n"
    exit $ERROR
fi

if [[ $AREA_DEST = itest ]]; then
    VCS_LEVEL=ITest
    AREA_REF=build
elif [[ $AREA_DEST = svtstage ]]; then
    VCS_LEVEL=SVTStage
    AREA_REF=build
elif [[ $AREA_DEST = svt && $SVT_Staging = $SET ]]; then 
    VCS_LEVEL=SVT
    AREA_REF=svtstage
else
    VCS_LEVEL=SVT
    AREA_REF=build
fi

CLIENT_REF=/css/c1/client/$AREA_REF
HOST_REF=/css/c1/host/$AREA_REF
C_ARCH=/css/c1/pvcs/client
H_ARCH=/css/c1/pvcs/host
MFDEST_AREA=/css/c1/host/mf$AREA_DEST
#MFDEST_AREA=/css/c1/host/$AREA_DEST
HOST_DEST=/css/c1/host/$AREA_DEST
CLIENT_DEST=/css/c1/client/$AREA_DEST
HOST_DEST=/css/c1/host/$AREA_DEST
TAR_DIR=/css/c1
DATA_DIR=/css/data/static

if [[ $TAR_STP_File_Flag != $SET ]]; then
    ## promotion spreadsheet ##
    date_temp=`date +"%Y%m%d"`
    promotion_spreadsheet=$spreadsheet_prefix$date_temp.csv
    TAR_FILE="" 
fi

if [[ $STP_flag = $SET && $TAR_STP_File_Flag = $SET ]]; then
    print "\nERROR: The -s option should not be used for $T_PROJECT promotions.\n"
    exit $ERROR
fi

if [[ $Migrate = $SET ]]; then
    print "\n"
    for sir in $SIR_NUMBERS
    do
        VALID_SIR=`grep $sir $SIR_LIST |wc -l` 
        if [[ $VALID_SIR != 0 ]]; then
            SIR_INFO=`grep $sir $SIR_LIST`
            sir_no=$(print $SIR_INFO | cut -f1 -d\|)
            descr=$(print $SIR_INFO | cut -f2 -d\|)
            create_date=$(print $SIR_INFO | cut -f3 -d\|)
            if [[ $ConfirmFlag != $SET ]]; then
                print "SIR: $sir_no   DESCRIPTION: $descr"
            fi
        elif [[ $VALID_SIR = 0 ]]; then
            print "ERROR: No valid sir found with that id - $sir."
            print "Make sure the sir has a migration assignment.\n"
            if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                    print "\nDeleting $TAR_FILE."
                    rm -f $MASSWORK_DIR/$TAR_FILE
                fi
            fi
            if [[ $Sprdsht_flag = $SET ]]; then
                if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                    print "\nDeleting $T_PROJECT.temp.csv.$$."
                    rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                fi
            fi 
            Remove_temp_files
            exit $ERROR
        fi    
    done

    if [[ $ConfirmFlag != $SET ]]; then
        print "\nIs the above information correct? (Y/N) \c"
        read response
    else
        response=y
    fi

    if [[ $response != Y && $response != y ]]; then
        print "ERROR: Please execute the script again."
        if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
            if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                print "\nDeleting $TAR_FILE."
                rm -f $MASSWORK_DIR/$TAR_FILE
            fi
        fi 
        if [[ $Sprdsht_flag = $SET ]]; then
            if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                print "\nDeleting $T_PROJECT.temp.csv.$$."
                rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
            fi
        fi
        Remove_temp_files 
        exit $ERROR
    fi
fi

if [[ -a $CURR_DIR/unsuccessful.promote ]]; then
    rm -f $CURR_DIR/unsuccessful.promote
    if [[ $? != 0 ]]; then
        print "ERROR: Cannot remove $CURR_DIR/unsuccessful.promote"
    fi
fi 

NewDirFlag=$UNSET
aar_dialog_flag=$UNSET
ext=$(print $module | cut -d'.' -f2)
obj_name=$(print $module | cut -d'.' -f1)

## IF CHECK FOR LIST/STP/PROD FLAG IS SET, THEN DO THIS ##

if [[ $FullList_flag = $SET ]]; then
    if [[ ! -a $CURR_DIR/$ListName ]]; then
        print "\nERROR: $ListName does not exist.\n"
        exit $ERROR
    fi
    cp -f $ListName masterlist.lst
    for file in $(<masterlist.lst)
    do
        ## RESET EVERYTHING TO NOTHING ##
        module=""
        type=""
        compile_flag=$UNSET
        entryfield=`print $file |cut -d"|" -f1`
        module=$entryfield
        entryfield_ext=$(print $entryfield | cut -d'.' -f2)
        ext=$entryfield_ext
        if [[ ${#entryfield_ext} -gt $EXT_LEN ]]; then
            print $file |grep "|" 2> /dev/null
            if [[ $? = 0 ]]; then
                secondfield=`print $file |cut -d"|" -f2`
                type=$secondfield

                if [[ $type = lib ]]; then
                    libmodule=$module
                    libtype=$type
                    listresponse=""
                    IOConfirmFlag=$UNSET  ## DO WE NEED THIS HERE ??? ##
                    mylen=`echo $module | awk '{len=length(); print len;}'`
                    char=$(print $module | cut -c$mylen)
                    if [[ $char = "I" || $char = "O" ]]; then
                        thirdfield=`print $file |cut -d"|" -f3`
                        if [[ $thirdfield = "y" ]]; then
                            IOConfirmFlag=$SET
                            listresponse=y
                        elif [[ $thirdfield = "n" ]]; then
                            IOConfirmFlag=$SET
                            listresponse=n
                        fi
                        if [[ $IOConfirmFlag = $SET && $listresponse = y ]]; then
                            tempname2=`echo $module | awk '{len=length(); val=substr($0, 1, len-1); print val;}'`
                            tempname=`echo $tempname2 | awk '{len=length(); val=substr($0, 4, len-1); print val;}'`
                            mvssfename=CUF$tempname
                            servername=CUF$tempname.c
                            module=$mvssfename
                            type=mvssfe
                            ext=""
                            Create_config_file
                            if [[ $Check_Prod_List_Flag = $SET && $FTP_Only_flag != $SET ]]; then
                                prodfile=$mvssfename
                                echo "Running check_production_flag for $prodfile ..."
                                check_production_flag
                            fi
                            if [[ $STP_List_Check_Flag = $SET && $CLNT_flag != $SET && $Host_Mvsport_Flag = $SET ]]; then
                                checkfilename=$mvssfename
                                echo "Running STP_List_Check for $checkfilename ..."
                                LIST_TRANSFER_DIR=$MFLIST_TRANSFER_DIR
                                STP_List_Check
                            fi
                            ## SERVER ##
                            module=$servername
                            type=server
                            server_ext=$(print $servername | cut -d'.' -f2)
                            ext=$server_ext 
                            Create_config_file
                            if [[ $Check_Prod_List_Flag = $SET && $FTP_Only_flag != $SET ]]; then
                                prodfile=$servername
                                echo "Running check_production_flag for $prodfile ..."
                                check_production_flag
                            fi
                            if [[ $STP_List_Check_Flag = $SET && $CLNT_flag != $SET && $Host_Unix_Flag = $SET ]]; then
                                checkfilename=$servername
                                echo "Running STP_List_Check for $checkfilename ..."
                                LIST_TRANSFER_DIR=$UNIXLIST_TRANSFER_DIR
                                STP_List_Check
                            fi
                     fi
                     ## RESET LIB VARIABLES ##
                     module=$libmodule
                     type=$libtype
                     ext=$(print $libmodule | cut -d'.' -f2)
                fi
            fi
                ## LIB AND OTHERS ##
                if [[ $type != "static" && $type != "relat" ]]; then
                    Create_config_file
                    if [[ $Check_Prod_List_Flag = $SET && $FTP_Only_flag != $SET ]]; then
                        prodfile=$module
                        echo "Running check_production_flag for $prodfile ..."
                        check_production_flag
                    fi
                    if [[ $STP_List_Check_Flag = $SET && $CLNT_flag != $SET ]]; then
                        checkfilename=$module
                        if [[ $type = "copyio" || $type = "lib" || $type = "nongen" || $type = "copyreport" || $type = "copytable" || $type = "code" || $type = "cuv" || $type = "copyintrface" || $type = "mvssfe" ]]; then
                            if [[ $Host_Mvsport_Flag = $SET ]]; then
                                echo "Running STP_List_Check for $checkfilename ..."
                                LIST_TRANSFER_DIR=$MFLIST_TRANSFER_DIR
                                STP_List_Check
                            fi
                        fi
                        if [[ $type = "copyio" || $type = "lib" || $type = "nongen" || $type = "copyreport" || $type = "copytable" || $type = "code" || $type = "cuv" || $type = "copyintrface" ]]; then
                            if [[ $Host_Unix_Flag = $SET ]]; then
                                LIST_TRANSFER_DIR=$UNIXLIST_TRANSFER_DIR
                                echo "Running STP_List_Check for $checkfilename ..."
                                STP_List_Check
                            fi
                        fi
                        if [[ $type = "scripts" || $type = "cards" || $type = "files" ]]; then
                            echo "Running STP_List_Check for $checkfilename ..."
                            STP_List_Check
                        fi
                    fi
                fi
            else
                print "ERROR: Cannot determine type for $module.\n"
                print "ERROR: Check master list -> $ListName \n"
                if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                   if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                       print "\nDeleting $TAR_FILE."
                       rm -f $MASSWORK_DIR/$TAR_FILE
                   fi
                fi
                Remove_temp_files
                exit $ERROR
            fi 

        ## .MAP FILES ##
        elif [[ $entryfield_ext = "map" ]]; then
            ancestor_type=""
            parent=""
            print $file |grep "|" 2> /dev/null
            if [[ $? = 0 ]]; then
                ancestor_type=`print $file |cut -d"|" -f2`
                parent=`print $file |cut -d"|" -f3`
            else
                print "ERROR: Cannot determine the type for $module.\n"
                print "ERROR: Check master list -> $ListName \n"
                Remove_temp_files
                exit $ERROR 
            fi
            Create_config_file
            if [[ $Check_Prod_List_Flag = $SET && $FTP_Only_flag != $SET ]]; then
                prodfile=$module
                echo "Running check_production_flag for $prodfile ..."
                check_production_flag
            fi
            if [[ $STP_List_Check_Flag = $SET && $CLNT_flag != $SET ]]; then
                checkfilename=$module
                echo "Running STP_List_Check for $checkfilename ..."
                STP_List_Check
            fi
        ## DIALOGS AND COMWINS ##
        elif [[ $entryfield_ext = "dlg" || $entryfield_ext = "wc" ]]; then
            ancestor_type=""
            parent=""
            print $file | grep "|" 2> /dev/null
            if [[ $? = 0 ]]; then
                secondfield=`print $file | cut -d"|" -f2`
                compileoption=$secondfield
                if [[ $compileoption = "c" ]]; then
                    if [[ $ClientCompile_Flag = $SET ]]; then
                        compile_flag=$SET
                        RECOMP=Y
                        if [[ $DoNotSendClientCompile_Flag = $SET && $CLNT_flag != $SET ]]; then
                            CLNT_flag=$SET
                            DoNotSend_flag=$SET
                        fi
                    else
                        print "\nERROR: The -c option should not be used for $T_PROJECT client side modules.\n"
                        if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                            if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                print "\nDeleting $TAR_FILE."
                                rm -f $MASSWORK_DIR/$TAR_FILE
                            fi
                        fi
                        if [[ $Sprdsht_flag = $SET ]]; then
                            if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                print "\nDeleting $T_PROJECT.temp.csv.$$."
                                rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                            fi
                        fi
                        Remove_temp_files
                        exit $ERROR
                    fi
                fi
            fi
            Create_config_file
            DecidedAnswer=$UNSET
            OK_to_overwrite_flag=$UNSET
            parentname=$(print $module | cut -d'.' -f1)
            if [[ $Check_Prod_List_Flag = $SET && $FTP_Only_flag != $SET && $compile_flag != $SET ]]; then
                ## CHECK .MAK FILE ##
                prodfile=$parentname.mak
                echo "Running check_production_flag for $prodfile ..."
                check_production_flag
                ## CHECK .MAP FILES ##
                for workunitfile in `find $CLIENT_REF/$code_loc -name "*.map"`
                do
                    prodfile=`basename $workunitfile`
                    echo "Running check_production_flag for $prodfile ..."
                    check_production_flag
                done
            fi

            if [[ $STP_List_Check_Flag = $SET && $CLNT_flag != $SET ]]; then
                ## CHECK .MAK FILE ##
                checkfilename=$parentname.mak
                echo "Running STP_List_Check for $module ..."
                LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc/nt
                STP_List_Check
                ## CHECK .MAP FILES ##
                for workunitfile in `find $CLIENT_REF/$code_loc -name "*.map"`
                do
                    checkfilename=`basename $workunitfile`
                    LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc 
                    STP_List_Check
                done
            fi
        ## CLIENT LIST ##
        elif [[ $entryfield_ext = "cst" ]]; then
            ancestor_type=""
            parent=""
            compile_flag=$UNSET
            RECOMP=""
            print $file | grep "|" 2> /dev/null
            if [[ $? = 0 ]]; then
                secondfield=`print $file | cut -d"|" -f2`
                compileoption=$secondfield
                if [[ $compileoption = "c" ]]; then
                    if [[ $ClientCompile_Flag = $SET ]]; then
                        compile_flag=$SET
                        RECOMP=Y
                        if [[ $DoNotSendClientCompile_Flag = $SET && $CLNT_flag != $SET ]]; then
                            CLNT_flag=$SET
                            DoNotSend_flag=$SET
                        fi
                    else
                        print "\nERROR: The -c option should not be used for $T_PROJECT client side modules.\n"
                        if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                            if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                                print "\nDeleting $TAR_FILE."
                                rm -f $MASSWORK_DIR/$TAR_FILE
                            fi
                        fi
                        if [[ $Sprdsht_flag = $SET ]]; then
                            if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                                print "\nDeleting $T_PROJECT.temp.csv.$$."
                                rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                            fi
                        fi
                        Remove_temp_files
                        exit $ERROR
                    fi
                fi
            fi
            cp -f $module clientlisting
            for clientname in $(<clientlisting)
            do
                parent=""      
                ancestor_type=""
                module=$clientname
                clientextension=$(print $module | cut -d'.' -f2)
                ext=$clientextension
                Create_config_file
                DecidedAnswer=$UNSET
                OK_to_overwrite_flag=$UNSET
                parentname=$(print $module | cut -d'.' -f1)
                if [[ $Check_Prod_List_Flag = $SET && $FTP_Only_flag != $SET && $compile_flag != $SET ]]; then
                    ## CHECK .MAK FILE ##
                    prodfile=$parentname.mak
                    echo "Running check_production_flag for $prodfile ..."
                    check_production_flag
                    ## CHECK .MAP FILES ##
                    for workunitfile in `find $CLIENT_REF/$code_loc -name "*.map"`
                    do
                        prodfile=`basename $workunitfile`
                        echo "Running check_production_flag for $prodfile ..."
                        check_production_flag
                    done
                fi
                if [[ $STP_List_Check_Flag = $SET && $CLNT_flag != $SET ]]; then
                    ## CHECK .MAK FILE ##
                    checkfilename=$parentname.mak
                    echo "Running STP_List_Check for $module ..."
                    LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc/nt
                    STP_List_Check
                    ## CHECK .MAP FILES ##
                    for workunitfile in `find $CLIENT_REF/$code_loc -name "*.map"`
                    do
                        checkfilename=`basename $workunitfile`
                        LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/$code_loc
                        STP_List_Check
                    done
                fi
            done   
               
        ## HELP ##
        ## ONLY CHECK ONE ARCHIVE FILE ##
        elif [[ $entryfield_ext = "hlp" ]]; then
            Create_config_file
            if [[ $Check_Prod_List_Flag = $SET && $FTP_Only_flag != $SET ]]; then
                prodfile=$help_type.zip
                echo "Running check_production_flag for $prodfile ..."
                check_production_flag
            fi
            ## ONLY CHECK THE .HLP FILE ##
            if [[ $STP_List_Check_Flag = $SET && $CLNT_flag != $SET ]]; then
                checkfilename=$help_type.hlp
                echo "Running STP_List_Check for $checkfilename ..."
                LIST_TRANSFER_DIR=$CLNT_TRANSFER_DIR/runtime/nt/help
                STP_List_Check
            fi

        ## .LST FILES ##
        elif [[ $entryfield_ext = "lst" ]]; then
            compile_flag=$UNSET
            type=""
            RECOMP=""
            print $file |grep "|" 2> /dev/null
            if [[ $? = 0 ]]; then
                secondfield=`print $file |cut -d"|" -f2`
                compileoption=$secondfield
                if [[ $compileoption = "c" ]]; then
                    compile_flag=$SET
                    RECOMP=Y
                fi
            fi
            cp -f $module pcolisting
            for pconame in $(<pcolisting)
            do
                type=""
                module=$pconame
                pcoextension=$(print $pconame | cut -d'.' -f2)
                ext=$pcoextension
                Create_config_file
                DecidedAnswer=$UNSET
                OK_to_overwrite_flag=$UNSET
                if [[ $Check_Prod_List_Flag = $SET && $FTP_Only_flag != $SET && $compile_flag != $SET ]]; then
                    prodfile=$module
                    echo "Running check_production_flag for $prodfile ..."
                    check_production_flag
                fi
                if [[ $STP_List_Check_Flag = $SET && $CLNT_flag != $SET && $Host_Mvsport_Flag = $SET ]]; then
                    mvssfename=$(print $pconame | cut -d'.' -f1)
                    checkfilename=$mvssfename
                    echo "Running STP_List_Check for $checkfilename ..."
                    LIST_TRANSFER_DIR=$MFLIST_TRANSFER_DIR
                    STP_List_Check
                fi 
                if [[ $STP_List_Check_Flag = $SET && $CLNT_flag != $SET && $Host_Unix_Flag = $SET ]]; then
                    checkfilename=$pconame
                    echo "Running STP_List_Check for $checkfilename ..."
                    LIST_TRANSFER_DIR=$UNIXLIST_TRANSFER_DIR
                    STP_List_Check
                fi
            done
        ## .pco FILES ##
        elif [[ $entryfield_ext = "pco" ]]; then
            type=""
            print $file |grep "|" 2> /dev/null
            if [[ $? = 0 ]]; then
                secondfield=`print $file |cut -d"|" -f2`
                compileoption=$secondfield
                if [[ $compileoption = "c" ]]; then
                    compile_flag=$SET
                    RECOMP=Y
                fi
            fi
            Create_config_file
            DecidedAnswer=$UNSET
            OK_to_overwrite_flag=$UNSET
            if [[  $Check_Prod_List_Flag = $SET && $FTP_Only_flag != $SET && $compile_flag != $SET ]]; then
                prodfile=$module
                echo "Running check_production_flag for $prodfile ..."
                check_production_flag
            fi
            if [[ $STP_List_Check_Flag = $SET && $CLNT_flag != $SET && $Host_Mvsport_Flag = $SET && $type != "table" ]]; then
                mvssfename=$(print $module | cut -d'.' -f1)
                checkfilename=$mvssfename
                echo "Running STP_List_Check for $checkfilename ..."
                LIST_TRANSFER_DIR=$MFLIST_TRANSFER_DIR
                STP_List_Check
            fi
            if [[ $STP_List_Check_Flag = $SET && $CLNT_flag != $SET && $Host_Unix_Flag = $SET ]]; then
                checkfilename=$module
                echo "Running STP_List_Check for $checkfilename ..."
                LIST_TRANSFER_DIR=$UNIXLIST_TRANSFER_DIR
                STP_List_Check
            fi
        ## SERVER FILES ##
        elif [[ $entryfield_ext = "c" ]]; then
            type=""
            Create_config_file
            if [[  $Check_Prod_List_Flag = $SET && $FTP_Only_flag != $SET ]]; then
                prodfile=$module
                echo "Running check_production_flag for $prodfile ..."
                check_production_flag
            fi
            if [[ $STP_List_Check_Flag = $SET && $CLNT_flag != $SET && $Host_Unix_Flag = $SET ]]; then
                checkfilename=$module
                echo "Running STP_List_Check for $checkfilename ..."
                LIST_TRANSFER_DIR=$UNIXLIST_TRANSFER_DIR
                STP_List_Check
            fi
        ## CODESTABLE ##
        elif [[ $entryfield_ext = "dat" ]]; then
            type=""
            print "$module is a codestable.  No STP checks will be performed on it.\n"
        else
            ## ALL OTHERS ##
            Create_config_file
            if [[ $Check_Prod_List_Flag = $SET && $FTP_Only_flag != $SET ]]; then
                prodfile=$module
                echo "Running check_production_flag for $prodfile ..."
                check_production_flag
            fi
            if [[ $STP_List_Check_Flag = $SET && $CLNT_flag != $SET ]]; then
                checkfilename=$module
                echo "Running STP_List_Check for $checkfilename ..."
                STP_List_Check
            fi 
        fi
    done
    if [[ $Check_Prod_List_Flag = $SET && $FTP_Only_flag != $SET ]]; then
        print "\n** PRODUCTION FLAG CHECK on $ListName is complete. **" 
    fi
    if [[ $STP_List_Check_Flag = $SET && $CLNT_flag != $SET ]]; then
        print "\n** STP AREA CHECK on $ListName is complete. **\n"
    fi
fi

## PERFORM ACTUAL PROMOTION ##
print "\n**----------------------------**"
print "** PROMOTIONS WILL BEGIN NOW. **"
print "**----------------------------**\n"
if [[ $FullList_flag = $SET ]]; then
    if [[ ! -a $CURR_DIR/$ListName ]]; then
        print "\nERROR: $ListName does not exist.\n"
        if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
            if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                    print "\nDeleting $TAR_FILE."
                    rm -f $MASSWORK_DIR/$TAR_FILE
                fi
            fi
            if [[ $Sprdsht_flag = $SET ]]; then
               if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                   print "\nDeleting $T_PROJECT.temp.csv.$$."
                   rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
               fi 
            fi
        fi
        Remove_temp_files 
        exit $ERROR
    fi
    cp -f $ListName masterlist.lst
    for file in $(<masterlist.lst)
    do
        obj_name=$(print $file | cut -d'.' -f1)
        ## RESET EVERYTHING TO NOTHING ##
        module=""
        type=""
        RECOMP=""
        compile_flag=$UNSET
        entryfield=`print $file |cut -d"|" -f1`
        module=$entryfield
        entryfield_ext=$(print $entryfield | cut -d'.' -f2)
        if [[ ${#entryfield_ext} -gt $EXT_LEN ]]; then
            ext=$entryfield_ext
            print $file |grep "|" 2> /dev/null
            if [[ $? = 0 ]]; then
                secondfield=`print $file |cut -d"|" -f2`
                type=$secondfield

                if [[ $type = lib ]]; then
                    libmodule=$module
                    libtype=$type
                    listresponse=""
                    IOConfirmFlag=$UNSET  ## DO WE NEED THIS HERE ??? ##
                    mylen=`echo $module | awk '{len=length(); print len;}'`
                    char=$(print $module | cut -c$mylen)
                    if [[ $char = "I" || $char = "O" ]]; then
                        thirdfield=`print $file |cut -d"|" -f3`
                        if [[ $thirdfield = "y" ]]; then
                            IOConfirmFlag=$SET
                            listresponse=y
                        elif [[ $thirdfield = "n" ]]; then
                            IOConfirmFlag=$SET
                            listresponse=n
                        fi
                    fi
                fi
                if [[ $type != "static" && $type != "relat" ]]; then
                    Evaluate_Ext
                    if [[ $FTP_Only_flag = $SET ]]; then
                        print "Transferring $type - $module - to Transfer Area..."
                    else
                        print "Promoting $type - $module - to $AREA_DEST ..."
                    fi

                    Evaluate_Type
                    Set_Permissions_on_pscfile
                    Svtstage_Check
                elif [[ $type = "relat" ]]; then
                    ## JUST INSERT A LINE IN THE SPREADSHEET FOR RELAT TABLES ##
                    Evaluate_Type
                else
                    ## INSERT A LINE IN THE SPREADSHEET FOR STATIC AND SEND DATA ##
                    # /sw/data/static/$T_PROJECT/data/static
                    # .../TO/PROMOTION/data/static
                    Evaluate_Type
                fi
            else
                print "ERROR: Cannot determine type for $module.\n"
                print "ERROR: Check master list -> $ListName \n"
                exist $ERROR
           fi

        ## DIALOGS AND COMWINS ##
        elif [[ $entryfield_ext = "dlg" || $entryfield_ext = "wc" ]]; then
            ext=$entryfield_ext
            compile_flag=$UNSET
            RECOMP=""
            type=""
	    aar_dialog_flag=$UNSET
            print $file | grep "|" 2> /dev/null
            if [[ $? = 0 ]]; then
                secondfield=`print $file | cut -d"|" -f2`
                compileoption=$secondfield
                if [[ $compileoption = "c" ]]; then
                    compile_flag=$SET
                    RECOMP=Y
                    if [[ $DoNotSendClientCompile_Flag = $SET && $CLNT_flag != $SET ]]; then
                        CLNT_flag=$SET
                        DoNotSend_flag=$SET
                    fi
                fi
            fi
            Evaluate_Ext
	    if [[ $compile_flag = $SET && $FTP_Only_flag != $SET ]]; then
	        print "Compiling $type - $module - in $AREA_DEST ..."
                if [[ $module != "cuar20b.dlg" ]]; then
                    CompileClientObjects
                else
                    print "Dialog cuar20b.dlg cannot be processed as a recompile."
                    aar_dialog_flag=$SET
                fi
            elif [[ $FTP_Only_flag = $SET ]]; then
                print "Transferring $type - $module - to Transfer Area..."
            else
	        print "Promoting $type - $module - to $AREA_DEST ..."
		if [[ $module != "cuar20b.dlg" && $ClientCompile_Flag = $SET ]]; then    
		    CompileClientObjects
                elif [[ $module = "cuar20b.dlg" ]]; then
	            print "Dialog cuar20b.dlg will not be compiled before it is promoted."		
		fi 
            fi    
	    if [[ $aar_dialog_flag != $SET ]]; then
                Evaluate_Type
                if [[ $Compile_Dir_Flag = $SET ]]; then
                    cd ..
	            rm -rf clnt_compile 2> /dev/null
                fi
                Set_Permissions_on_pscfile
                Svtstage_Check
                if [[ $compile_flag = $SET && $DoNotSendClientCompile_Flag = $SET && $DoNotSend_flag = $SET ]]; then
                    CLNT_flag=$UNSET
                fi
            fi
        ## CLIENT LIST ##
        elif [[ $entryfield_ext = "cst" ]]; then
            compile_flag=$UNSET
            RECOMP=""
            type=""
            print $file |grep "|" 2> /dev/null
            if [[ $? = 0 ]]; then
                secondfield=`print $file |cut -d"|" -f2`
                compileoption=$secondfield
                if [[ $compileoption = "c" ]]; then
                    compile_flag=$SET
                    RECOMP=Y
                    if [[ $DoNotSendClientCompile_Flag = $SET && $CLNT_flag != $SET ]]; then
                        CLNT_flag=$SET
                        DoNotSend_flag=$SET
                    fi
                fi
            fi
            clientlist=$module
            rm -f allfiles.txt 2> /dev/null
            cp -f $module allfiles.txt
            for clientobj in $(<allfiles.txt)
            do
                module=$clientobj
                ext=`print $module | cut -d"." -f2`
                Evaluate_Ext
		if [[ $compile_flag = $SET && $FTP_Only_flag != $SET ]]; then
		    print "Compiling $type - $module - in $AREA_DEST ..."
                    if [[ $module != "cuar20b.dlg" ]]; then
                        CompileClientObjects
                    else
                        print "Dialog cuar20b.dlg cannot be processed as a recompile."
                        continue
                    fi
                elif [[ $FTP_Only_flag = $SET ]]; then
                    print "Transferring $type - $module - to Transfer Area..."
		else
	            print "Promoting $type - $module - to $AREA_DEST ..."
                    if [[ $module != "cuar20b.dlg" && $ClientCompile_Flag = $SET ]]; then
                        CompileClientObjects
                    elif [[ $module = "cuar20b.dlg" ]]; then
                        print "Dialog cuar20b.dlg will not be compiled before it is promoted."
                    fi
		fi
	        Evaluate_Type
                if [[ $Compile_Dir_Flag = $SET ]]; then
                    cd ..
	            rm -rf clnt_compile 2> /dev/null
                fi
	        Set_Permissions_on_pscfile
	        Svtstage_Check
            done
            if [[ $compile_flag = $SET && $DoNotSendClientCompile_Flag = $SET && $DoNotSend_flag = $SET ]]; then
                CLNT_flag=$UNSET
            fi
            module=$clientlist

        ## .pco FILES ##
        elif [[ $entryfield_ext = "pco" ]]; then
            ext=$entryfield_ext
            compile_flag=$UNSET
            RECOMP=""
            type=""
            print $file |grep "|" 2> /dev/null
            if [[ $? = 0 ]]; then
                secondfield=`print $file |cut -d"|" -f2`
                compileoption=$secondfield
                if [[ $compileoption = "c" ]]; then
                    compile_flag=$SET
                    RECOMP=Y
                    if [[ $DoNotSendCompile_Flag = $SET && $CLNT_flag != $SET ]]; then
                        CLNT_flag=$SET
                        DoNotSend_flag=$SET
                    fi
                fi
            fi
            Evaluate_Ext
            if [[ $compile_flag = $SET && $FTP_Only_flag != $SET ]]; then
                print "Compiling $type - $module - in $AREA_DEST ..."
            elif [[ $FTP_Only_flag = $SET ]]; then
                print "Transferring $type - $module - to Transfer Area..."
            else
                print "Promoting $type - $module - to $AREA_DEST ..."
            fi
            Evaluate_Type
            Set_Permissions_on_pscfile
            Svtstage_Check
            if [[ $compile_flag = $SET && $DoNotSendCompile_Flag = $SET && $DoNotSend_flag = $SET ]]; then
                CLNT_flag=$UNSET
            fi
        ## .LST FILES ##
        elif [[ $entryfield_ext = "lst" ]]; then
            ext=$entryfield_ext
            compile_flag=$UNSET
            RECOMP=""
            type=""
            print $file |grep "|" 2> /dev/null
            if [[ $? = 0 ]]; then
                secondfield=`print $file |cut -d"|" -f2`
                compileoption=$secondfield
                if [[ $compileoption = "c" ]]; then
                    compile_flag=$SET
                    RECOMP=Y
                    if [[ $DoNotSendCompile_Flag = $SET && $CLNT_flag != $SET ]]; then
                        CLNT_flag=$SET
                        DoNotSend_flag=$SET
                    fi
                fi
            fi
            Evaluate_Ext
            if [[ $compile_flag = $SET && $FTP_Only_flag != $SET ]]; then
                print "Compiling $type - $module - in $AREA_DEST ..."
            elif [[ $FTP_Only_flag = $SET ]]; then
                print "Transferring $type - $module - to Transfer Area..."
            else
                print "Promoting $type - $module - to $AREA_DEST ..."
            fi
            Evaluate_Type
            Set_Permissions_on_pscfile
            Svtstage_Check
            if [[ $compile_flag = $SET && $DoNotSendCompile_Flag = $SET && $DoNotSend_flag = $SET ]]; then
                CLNT_flag=$UNSET
            fi
        ## .MAP FILES ##
        elif [[ $entryfield_ext = "map" ]]; then
            ext=$entryfield_ext
            ancestor_type=""
            parent=""
            print $file |grep "|" 2> /dev/null
            if [[ $? = 0 ]]; then
                ancestor_type=`print $file |cut -d"|" -f2`
                parent=`print $file |cut -d"|" -f3`
            else
                print "ERROR: Cannot determine the parent name for $module.\n"
                print "ERROR: Check master list -> $ListName \n"
                if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                    if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                        print "\nDeleting $TAR_FILE."
                        rm -f $MASSWORK_DIR/$TAR_FILE
                    fi
                fi 
                if [[ $Sprdsht_flag = $SET ]]; then
                    if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                        print "\nDeleting $T_PROJECT.temp.csv.$$."
                        rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                    fi
                fi 
                Remove_temp_files
                exit $ERROR
            fi
            Evaluate_Ext
            if [[ $FTP_Only_flag = $SET ]]; then
                print "Transferring $type - $module - to Transfer Area..."
            else
                print "Promoting $type - $module - to $AREA_DEST ..."
            fi
            Evaluate_Type
            Set_Permissions_on_pscfile
            Svtstage_Check
        ## ALL OTHERS ##
        else
            ext=$entryfield_ext
            Evaluate_Ext
            if [[ $FTP_Only_flag = $SET ]]; then
                print "Transferring $type - $module - to Transfer Area..."
            else
                print "Promoting $type - $module - to $AREA_DEST ..."
            fi
            Evaluate_Type
            Set_Permissions_on_pscfile
            Svtstage_Check
        fi
        ## CHECK UNSUCCESSFUL.PROMOTE FILE FOR MODULE NAME ##
        grep "$module" $CURR_DIR/unsuccessful.promote 2> /dev/null
        if [[ $? = 0 ]]; then
            print "\nERROR: An error occurred while promoting $module from a master list of files for SIR $sir"
            print "\nDo you wish to continue processing $ListName? (y or n) \c"
            read answer
            answer=`print $answer | tr "[:upper:]" "[:lower:]"`
            if [[ $answer = y || $answer = "yes" ]]; then
                continue
            elif [[ $answer = n || $answer = "no" ]]; then
                ## DELETE TEMP SPREADSHEET & TAR FILE AND EXIT ##
                if [[ $Sprdsht_flag = $SET ]]; then
                    if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                        print "\nDeleting $T_PROJECT.temp.csv.$$."
                        rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                    fi
                fi
                if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                    if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                        print "\nDeleting $TAR_FILE."
                        rm -f $MASSWORK_DIR/$TAR_FILE
                    fi
                fi
                Remove_temp_files
                exit $ERROR
            else
                print "\nERROR: Unrecognized response -> $answer"
                print "Please enter y or n: \c"
                read decisionagain
                decisionagain=`print $decisionagain | tr "[:upper:]" "[:lower:]"`
                if [[ $decisionagain = y || $decisionagain = "yes" ]]; then
                    continue
                elif [[ $decisionagain = n || $decisionagain = "no" ]]; then
                    if [[ $Sprdsht_flag = $SET ]]; then
                        if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                            print "\nDeleting $T_PROJECT.temp.csv.$$."
                            rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                        fi
                    fi
                    if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                        if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                            print "\nDeleting $TAR_FILE."
                            rm -f $MASSWORK_DIR/$TAR_FILE
                        fi
                    fi
                    Remove_temp_files
                    exit $ERROR
                else
                    print "\nERROR: Unrecognized response the 2nd time -> $decisionagain"
                    print "\nERROR: Processing of $ListName has stopped."
                    if [[ $Sprdsht_flag = $SET ]]; then
                        if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                            print "\nDeleting $T_PROJECT.temp.csv.$$."
                            rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                        fi
                    fi
                    if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                        if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                            print "\nDeleting $TAR_FILE."
                            rm -f $MASSWORK_DIR/$TAR_FILE
                        fi
                    fi
                    Remove_temp_files
                    exit $ERROR
                fi
            fi
        fi
        ## PROMPTS USER IF HE WISHES TO CONTINUE ##
        if [[ $FTP_Only_flag = $SET ]]; then
            if [[ $TAR_STP_File_Flag = $SET ]]; then 
                print "\nTarring of $module to $TAR_FILE is complete."
            else
                print "\nTransferred $module to STP transfer area is complete."
            fi
        else
            print "\nPromotion of $module to $AREA_DEST is complete."
         fi

        print "\nDo you wish to continue processing $ListName? (y or n) \c"
        read answer
        answer=`print $answer | tr "[:upper:]" "[:lower:]"`
        if [[ $answer = y || $answer = "yes" ]]; then
            continue
        elif [[ $answer = n || $answer = "no" ]]; then
            ## DELETE TEMP SPREADSHEET AND EXIT ##
            if [[ $Sprdsht_flag = $SET ]]; then
                if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                    print "\nDeleting $T_PROJECT.temp.csv.$$."
                    rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                fi
            fi
            if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                    print "\nDeleting $TAR_FILE."
                    rm -f $MASSWORK_DIR/$TAR_FILE
                fi
            fi
            Remove_temp_files
            exit $ERROR
        else
            print "\nERROR: Unrecognized response -> $answer"
            print "Please enter y or n: \c"
            read decisionagain
            decisionagain=`print $decisionagain | tr "[:upper:]" "[:lower:]"`
            if [[ $decisionagain = y || $decisionagain = "yes" ]]; then
                continue
            elif [[ $decisionagain = n || $decisionagain = "no" ]]; then
                if [[ $Sprdsht_flag = $SET ]]; then
                    if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                        print "\nDeleting $T_PROJECT.temp.csv.$$."
                        rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                    fi
                fi
                if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                    if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                        print "\nDeleting $TAR_FILE."
                        rm -f $MASSWORK_DIR/$TAR_FILE
                    fi
                fi
                Remove_temp_files
                exit $ERROR
            else
                print "\nERROR: Unrecognized response the 2nd time -> $decisionagain"
                print "\nERROR: Processing of $ListName has stopped."
                if [[ $Sprdsht_flag = $SET ]]; then
                    if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                        print "\nDeleting $T_PROJECT.temp.csv.$$."
                        rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                    fi
                fi
                if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
                    if [[ -a $MASSWORK_DIR/$TAR_FILE ]]; then
                        print "\nDeleting $TAR_FILE."
                        rm -f $MASSWORK_DIR/$TAR_FILE
                    fi
                fi
                Remove_temp_files
                exit $ERROR
            fi
        fi 
    done
#   FullListEnd_flag=$SET ## DO NOT NEED ##
    ## PROCESS RECSIZE.TXT ##
    if [[ $Data_Flag = $SET && $CLNT_flag != $SET ]]; then
        if [[ $Static_Data_Prefix = "EBC" ]]; then
            if [[ -s $DATA_DIR/data/static/recsize.txt ]]; then
                cd $DATA_DIR
                ## tar append recsize.txt file ##
                tar rf $MASSWORK_DIR/$TAR_FILE data/static/recsize.txt > $CURR_DIR/tar.output 2>&1
                if [[ -s $CURR_DIR/tar.output ]]; then
                    print "ERROR: Unsuccessful tar append of recsize.txt to $TAR_FILE."
                    print -n "ERROR: "
                    cat $CURR_DIR/tar.output
                    print "\nDeleting $TAR_FILE."
                    rm -f $MASSWORK_DIR/$TAR_FILE
                    if [[ $Sprdsht_flag = $SET ]]; then
                        if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                            print "\nDeleting $T_PROJECT.temp.csv.$$."
                            rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                        fi
                    fi
                    Remove_temp_files
                    exit $ERROR
                else
                    print "Successful tar append of recsize.txt to $TAR_FILE file."
                    ## HOLD THE FOLLOWING UNTIL THE 1-TO-1 IS ROLLED OUT ##
                    if [[ $Sprdsht_flag = $SET ]]; then
                        codetype=host
                        TRmain_type=table
                        TRsub_type=recsize
                        TRfilename=recsize.txt
                        CopyToSpreadsheet
                    fi
                fi
                cd -
            else
                print "ERROR: $DATA_DIR/data/static/recsize.txt file not found."
                print "ERROR: A recsize.txt file is required for promoting static data to $T_PROJECT."
                print "\nDeleting $TAR_FILE."
                rm -f $MASSWORK_DIR/$TAR_FILE
                if [[ $Sprdsht_flag = $SET ]]; then
                    if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                        print "\nDeleting $T_PROJECT.temp.csv.$$."
                        rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                    fi
                fi
                Remove_temp_files
                exit $ERROR
            fi
        fi
    fi
    Write_to_Master_Spreadsheet  ## THIS WILL CALL STP.KSH IF TAR FLAG IS NOT SET ##
    ## NEED TO SEND SPRDSHT LAST ##
    if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
        if [[ $Sprdsht_flag = $SET ]]; then
            ## TAR COMMAND TO ADD CSV FILE TO THE TAR FILE ##
            tarfilename=$promotion_spreadsheet
            cd /tmp_work/pvcs/promote/$T_PROJECT 
            if [[ ! -a $MASSWORK_DIR/$TAR_FILE ]]; then
                tar cf $MASSWORK_DIR/$TAR_FILE $tarfilename > $CURR_DIR/tar.output 2>&1
                if [[ -s $CURR_DIR/tar.output ]]; then
                    print "ERROR: Unsuccessful tar of $tarfilename to new $TAR_FILE file."
                    print -n "ERROR: "
                    cat $CURR_DIR/tar.output
                    print "\nDeleting $TAR_FILE."
                    rm -f $MASSWORK_DIR/$TAR_FILE
                    print "\nDeleting $T_PROJECT.temp.csv.$$."
                    rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                    Remove_temp_files
                    exit $ERROR
                else
                    print "Successful tar of $tarfilename to new $TAR_FILE file."
                fi
            else
                tar rf $MASSWORK_DIR/$TAR_FILE $tarfilename > $CURR_DIR/tar.output 2>&1
                if [[ -s $CURR_DIR/tar.output ]]; then
                    print "ERROR: Unsuccessful tar append of $tarfilename to $TAR_FILE."
                    print -n "ERROR: "
                    cat $CURR_DIR/tar.output
                    print "\nDeleting $TAR_FILE."
                    rm -f $MASSWORK_DIR/$TAR_FILE
                    print "\nDeleting $T_PROJECT.temp.csv.$$."
                    rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                    Remove_temp_files
                    exit $ERROR
                else
                    print "Successful tar append of $tarfilename to $TAR_FILE file."
                fi
            fi
            cd -
        fi
        ## GUNZIP TAR FILE ##
        gzip $MASSWORK_DIR/$TAR_FILE
        if [[ $? != 0 ]]; then
            print "ERROR: An error occurred while attempting to gzip $MASSWORK_DIR/$TAR_FILE."
            print "\nDeleting $TAR_FILE."
            rm -f $MASSWORK_DIR/$TAR_FILE
            print "\nDeleting $T_PROJECT.temp.csv.$$."
            rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
            Remove_temp_files
            exit $ERROR
        fi
        ## FTP TAR FILE TO STP AREA ##
        if [[ `hostname` != $STP_SERVER ]]; then
            cp $MASSWORK_DIR/$TAR_FILE.gz $TAR_STP_DIR 
            if [[ $? != 0 ]]; then
                print "\nERROR: Copy of $TAR_FILE.gz to $STP_SERVER:$TAR_STP_DIR STP directory failed.\n"
            else
                print "\nSuccessful copy of $TAR_FILE.gz to $STP_SERVER:$TAR_STP_DIR STP directory.\n"
            fi
        else
            cp -f $MASSWORK_DIR/$TAR_FILE.gz $TAR_STP_DIR
            if [[ $? != 0 ]]; then
                print "\nERROR: Copy of $TAR_FILE.gz to $TAR_STP_DIR STP directory failed.\n"
            else
                print "\nSuccessful copy of $TAR_FILE.gz to $TAR_STP_DIR STP directory.\n"
            fi
        fi 
        ## CALL STP ON TAR FILE IN STP AREA ##
         if [[ `hostname` != $STP_SERVER ]]; then
           print "Running STP on $TAR_FILE.gz ..."
           #/sw/devtools/common/host/rexec/rexec $STP_SERVER -l pvcs -p $PVCS_PASSWORD "/sw/devtools/common/host/scripts/stp -f $TAR_STP_DIR/$TAR_FILE.gz $T_PROJECT"
        else
           print "Running STP on $TAR_FILE.gz ..."
         #  /sw/devtools/common/host/scripts/stp -f $TAR_STP_DIR/$TAR_FILE.gz $T_PROJECT
        fi
    fi

    ## NOTES:  FOR T3, call stp with the -h option to leave module in the STP area if tar flag is not set ##
    ## and it is an emergency.  Emergency_STP_Exist_Flag is set.                                          ##
else
    if [[ $ext = "pco" || $ext = "lst" ]]; then
        if [[ $DoNotSendCompile_Flag = $SET && $CLNT_flag != $SET && $compile_flag = $SET ]]; then
            CLNT_flag=$SET
            DoNotSend_flag=$SET
        fi
    fi
    Evaluate_Ext
    if [[ $type = "dialog" || $type = "comwin" || $type = "clst" ]]; then
        if [[ $DoNotSendClientCompile_Flag = $SET && $CLNT_flag != $SET && $compile_flag = $SET ]]; then
            CLNT_flag=$SET
            DoNotSend_flag=$SET
        fi
        if [[ $compile_flag = $SET && $ClientCompile_Flag != $SET ]]; then
            print "\nERROR: The -c option should not be used for $T_PROJECT client object promotions.\n"
            Remove_temp_files
            exit $ERROR
        fi
    fi
    if [[ $type != "static" && $type != "relat" && $type != "clst" ]]; then
        if [[ $compile_flag = $SET && $FTP_Only_flag != $SET ]]; then
            print "Compiling $type - $module - in $AREA_DEST ..."
            if [[ $type = "dialog" || $type = "comwin" ]]; then
	        if [[ $module != "cuar20b.dlg" ]]; then
	            CompileClientObjects
                else
		    print "Dialog cuar20b.dlg cannot be processed as a recompile."
	            aar_dialog_flag=$SET
                fi
            fi 
        elif [[ $FTP_Only_flag = $SET ]]; then
            print "Transferring $type - $module - to Transfer Area..."
        else
	    print "Promoting $type - $module - to $AREA_DEST ..."
            if [[ $type = "dialog" || $type = "comwin" ]]; then 
	        if [[ $module != "cuar20b.dlg" && $ClientCompile_Flag = $SET ]]; then
		    CompileClientObjects
                elif [[ $module = "cuar20b.dlg" ]]; then
		    print "Dialog cuar20b.dlg will not be compiled before it is promoted."
                fi
            fi
        fi
	if [[ $aar_dialog_flag != $SET ]]; then
            Evaluate_Type
            if [[ $Compile_Dir_Flag = $SET ]]; then
                if [[ $type = "dialog" || $type = "comwin" ]]; then
                    cd ..
	            rm -rf clnt_compile 2> /dev/null
                fi
            fi
            Set_Permissions_on_pscfile
            Svtstage_Check
            if [[ $type = "dialog" || $type = "comwin" || $ext = "pco" || $ext = "lst" ]]; then
                if [[ $DoNotSend_flag = $SET ]]; then
                    CLNT_flag=$UNSET
                fi
            fi
        fi
    elif [[ $type = "clst" ]]; then
        rm -f allfiles.txt 2> /dev/null
        cp -f $module allfiles.txt
	for clientobj in $(<allfiles.txt)
        do
	    module=$clientobj
            ext=`print $module | cut -d"." -f2`
	    Evaluate_Ext
	    if [[ $compile_flag = $SET && $FTP_Only_flag != $SET ]]; then
	        print "Compiling $type - $module - in $AREA_DEST ..."
                if [[ $module != "cuar20b.dlg" ]]; then
                    CompileClientObjects
                else
                    print "Dialog cuar20b.dlg cannot be processed as a recompile."
                    continue
                fi
            elif [[ $FTP_Only_flag = $SET ]]; then
                print "Transferring $type - $module - to Transfer Area..."
	    else
	        print "Promoting $type - $module - to $AREA_DEST ..."
	        if [[ $module != "cuar20b.dlg" && $ClientCompile_Flag = $SET ]]; then
		    CompileClientObjects
                elif [[ $module = "cuar20b.dlg" ]]; then
		    print "Dialog cuar20b.dlg will not be compiled before it is promoted."
		fi
	    fi
	    Evaluate_Type
            if [[ $Compile_Dir_Flag = $SET ]]; then
                cd ..
	        rm -rf clnt_compile 2> /dev/null
            fi
	    Set_Permissions_on_pscfile
	    Svtstage_Check
        done
        if [[ $compile_flag = $SET && $DoNotSendClientCompile_Flag = $SET && $DoNotSend_flag = $SET ]]; then
            CLNT_flag=$UNSET
        fi
    else
        Evaluate_Type
    fi 
    ## PROCESS RECSIZE.TXT ##
    if [[ $Data_Flag = $SET && $CLNT_flag != $SET ]]; then
        if [[ $Static_Data_Prefix = "EBC" ]]; then
            if [[ -s $DATA_DIR/data/static/recsize.txt ]]; then
                cd $DATA_DIR
                ## tar append recsize.txt file ##
                tar rf $MASSWORK_DIR/$TAR_FILE data/static/recsize.txt > $CURR_DIR/tar.output 2>&1
                if [[ -s $CURR_DIR/tar.output ]]; then
                    print "ERROR: Unsuccessful tar append of recsize.txt to $TAR_FILE."
                    print -n "ERROR: "
                    cat $CURR_DIR/tar.output
                    print "\nDeleting $TAR_FILE."
                    rm -f $MASSWORK_DIR/$TAR_FILE
                    if [[ $Sprdsht_flag = $SET ]]; then
                        if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                            print "\nDeleting $T_PROJECT.temp.csv.$$."
                            rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                        fi
                    fi
                    Remove_temp_files
                    exit $ERROR
                else
                    print "Successful tar append of recsize.txt to $TAR_FILE file."
                    ## HOLD THE FOLLOWING UNTIL THE 1-TO-1 IS ROLLED OUT ##
                    if [[ $Sprdsht_flag = $SET ]]; then
                        codetype=host
                        TRmain_type=table
                        TRsub_type=recsize
                        TRfilename=recsize.txt
                        CopyToSpreadsheet
                    fi
                fi
                cd -
            else
                print "ERROR: $DATA_DIR/data/static/recsize.txt file not found."
                print "ERROR: A recsize.txt file is required for promoting static data to $T_PROJECT."
                print "\nDeleting $TAR_FILE."
                rm -f $MASSWORK_DIR/$TAR_FILE
                if [[ $Sprdsht_flag = $SET ]]; then
                    if [[ -a /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$ ]]; then
                        print "\nDeleting $T_PROJECT.temp.csv.$$."
                        rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                    fi
                fi
                Remove_temp_files
                exit $ERROR
            fi
        fi
    fi
    Write_to_Master_Spreadsheet ## THIS WILL CALL STP.KSH IF TAR FLAG IS NOT SET ##
    ## NEED TO SEND SPRDSHT LAST ##
    if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
        if [[ $Sprdsht_flag = $SET ]]; then
            ## TAR COMMAND TO ADD CSV FILE TO THE TAR FILE ##
            tarfilename=$promotion_spreadsheet
            cd /tmp_work/pvcs/promote/$T_PROJECT
            if [[ ! -a $MASSWORK_DIR/$TAR_FILE ]]; then
                tar cf $MASSWORK_DIR/$TAR_FILE $tarfilename > $CURR_DIR/tar.output 2>&1
                if [[ -s $CURR_DIR/tar.output ]]; then
                    print "ERROR: Unsuccessful tar of $tarfilename to new $TAR_FILE."
                    print -n "ERROR: "
                    cat $CURR_DIR/tar.output
                    print "\nDeleting $TAR_FILE."
                    rm -f $MASSWORK_DIR/$TAR_FILE
                    print "\nDeleting $T_PROJECT.temp.csv.$$."
                    rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                    Remove_temp_files
                    exit $ERROR
                else
                    print "Successful tar of $tarfilename to new $TAR_FILE file."
                fi
            else
                tar rf $MASSWORK_DIR/$TAR_FILE $tarfilename > $CURR_DIR/tar.output 2>&1
                if [[ -s $CURR_DIR/tar.output ]]; then
                    print "ERROR: Unsuccessful tar append of $tarfilename to $TAR_FILE."
                    print -n "ERROR: "
                    cat $CURR_DIR/tar.output
                    print "\nDeleting $TAR_FILE."
                    rm -f $MASSWORK_DIR/$TAR_FILE
                    print "\nDeleting $T_PROJECT.temp.csv.$$."
                    rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
                    Remove_temp_files
                    exit $ERROR
                else
                    print "Successful tar append of $tarfilename to $TAR_FILE file."
                fi
            fi
            cd -
        fi 
        ## GUNZIP TAR FILE ##
        gzip $MASSWORK_DIR/$TAR_FILE
        if [[ $? != 0 ]]; then
            print "ERROR: An error occurred while attempting to gzip $MASSWORK_DIR/$TAR_FILE."
            print "\nDeleting $TAR_FILE."
            rm -f $MASSWORK_DIR/$TAR_FILE
            print "\nDeleting $T_PROJECT.temp.csv.$$."
            rm -f /tmp_work/pvcs/promote/$T_PROJECT/$T_PROJECT.temp.csv.$$
            Remove_temp_files
            exit $ERROR
        fi

        ## FTP TAR FILE TO STP AREA ##
        if [[ `hostname` != $STP_SERVER ]]; then
            cp $MASSWORK_DIR/$TAR_FILE.gz $TAR_STP_DIR
            if [[ $? != 0 ]]; then
                print "\nERROR: Copy of $TAR_FILE.gz to $STP_SERVER:$TAR_STP_DIR STP directory failed.\n"
            else
                print "\nSuccessful copy of $TAR_FILE.gz to $STP_SERVER:$TAR_STP_DIR STP directory.\n"
            fi
        else
            cp -f $MASSWORK_DIR/$TAR_FILE.gz $TAR_STP_DIR
            if [[ $? != 0 ]]; then
                print "\nERROR: Copy of $TAR_FILE.gz to $TAR_STP_DIR STP directory failed.\n"
            else
                print "\nSuccessful copy of $TAR_FILE.gz to $TAR_STP_DIR STP directory.\n"
            fi
        fi
        ## CALL STP ON TAR FILE IN STP AREA ##
        if [[ `hostname` != $STP_SERVER ]]; then
           print "Running STP on $TAR_FILE.gz ..."
#           /sw/devtools/common/host/rexec/rexec $STP_SERVER -l pvcs -p $PVCS_PASSWORD "/sw/devtools/common/host/scripts/stp -f $TAR_STP_DIR/$TAR_FILE.gz $T_PROJECT"
        else
           print "Running STP on $TAR_FILE.gz ..."
#           /sw/devtools/common/host/scripts/stp -f $TAR_STP_DIR/$TAR_FILE.gz $T_PROJECT
        fi
    fi
fi

grep "$module" $CURR_DIR/unsuccessful.promote 2> /dev/null
if [[ $? = 0 ]]; then
    print "\n** AN ERROR OCCURRED WHILE PROCESSING SIR# $first_sir. **\n"
    Remove_temp_files
else
    ## REMOVE THE TAR FILE FROM THE MASS_WORK AREA ##
    if [[ $TAR_STP_File_Flag = $SET && $CLNT_flag != $SET ]]; then
        if [[ -a $MASSWORK_DIR/$TAR_FILE.gz ]]; then
            rm -f $MASSWORK_DIR/$TAR_FILE.gz
        fi
    fi
    if [[ $Data_Flag = $SET && $CLNT_flag != $SET ]]; then
        if [[ -s $CURR_DIR/staticdata.lst ]]; then 
            for file in $(<$CURR_DIR/staticdata.lst)
            do
                rm -f $DATA_DIR/data/static/$file
            done
            rm -f $CURR_DIR/staticdata.lst
        fi
    fi
    Remove_temp_files
    if [[ $CLNT_flag != $SET ]]; then
        Remove_temp_binary_files
    fi
    print "\n** SIR# $first_sir IS COMPLETE **\n"
fi

return $SUCCESS
