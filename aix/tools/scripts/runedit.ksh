#/bin/ksh
#------------------------
# Remove.ksh
#
#  This shell performs the following functions:
#
#  1)  Prompts user for the FUNC-ID of the edit checker program
#      (FUNC-ID represents bytes 6-8 of edit checker program id)
#
#  2)  Executes checker program for the FUNC-ID option selected.
#
#      Note: Option #1 will print all edits for all checker modules.
# 
#-------------------------
  /bin/tput clear
  while :
  do
    OPT=*
    echo "\n\nChoose one of the following options to execute edit"
    echo "checker module:\n"
    echo "     FUNC-ID  DESCRIPTION"
    echo "     =======  ==============================================\n"
    echo "   1)  ALL    ALL Integrity Checker Modules"
    echo "   2)  BAC    Bill Account Integrity Checker Module"
    echo "   3)  FIN    Financial Integrity Checker Module"
    echo "   4)  PRE    Premise Integrity Checker Module"
    echo "   5)  SAD    Standard Account Data Integrity Checker Module"
    echo "   6)  SVO    Service Order Integrity Checker Module"
    echo "   7)  TAR    Tariff Integrity Checker Module"
    echo "   8)  WFM    Work Flow Manager Integrity Checker Module\n"
    echo "   O)  Other"
    echo "   E)  Exit"
    echo "\n\n   Option # ==> \c"
    read OPT
    case "$OPT" in
        1)  FUNCID="ALL" break ;;
        2)  FUNCID="BAC" break ;;
        3)  FUNCID="FIN" break ;;
        4)  FUNCID="PRE" break ;;
        5)  FUNCID="SAD" break ;;
        6)  FUNCID="SVO" break ;;
        7)  FUNCID="TAR" break ;;
        8)  FUNCID="WFM" break ;;
      O|o)  FUNCID="NONE" break ;;
      E|e)  echo "\n\n"
	    exit 1;;
        *)  echo "\n\n     Invalid Option...Try Again... \07"
	    sleep 1
	    clear ;;
    esac
  done
 
  if [ $FUNCID = "NONE" ];then
    clear
    FUNCID=ABC
    echo "\n\nEnter the FUNC-ID of the checker program to generate listing [$FUNCID]: \c"
    read FUNCID
    case "$FUNCID" in
      "") FUNCID="ABC" ;;
       *) FUNCID="$FUNCID" ;;
    esac
    echo $FUNCID | tr '[a-z]' '[A-Z]' | cat | read FUNCID
  fi

  if [ $FUNCID = "ABC" ];then
    echo "\n\nYou failed to enter a FUNC-ID.  Script will be terminated."
    echo "You will have to enter a valid FUNC-ID to execute this script.\n\n"
    exit 1;
  fi

  if [ $FUNCID = "ALL" ];then
    cat *"MASTR" > tempfile
    grep -v "CUMEDNEW" tempfile > ALLMASTR
    rm tempfile
  fi
   
  if [ ! -f $FUNCID"MASTR" ];then
    echo "\n\n"
    echo "Error detected: \07"
    echo " "
    echo "Invalid FUNC-ID, "$FUNCID", "$FUNCID"MASTR file not found!!"
    echo " "
    echo "Try running script again with a valid FUNC-ID..."
    echo "\n\n"
    exit 1;
  fi
  
  clear
  echo "\n\nPerforming edits...executing CUBEDRVR (Edit Driver)..."
  cp $FUNCID"MASTR" EDMASTER
  export COBSW=-A
  rts CUBEDRVR

  if [ $FUNCID = "ALL" ];then
    rm ALLMASTR
  fi

  cp EDERROR $FUNCID"ERROR"
  echo "\n\nEdit driver completed...verifiy "$FUNCID"ERROR file for errors!!\n\n"
