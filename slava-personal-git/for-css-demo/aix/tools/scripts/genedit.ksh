#!/bin/ksh
#------------------------
# Remove.ksh
#
#  This shell performs the following functions:
#
#  1)   Generates a new EDMASTER file for the FUNC-ID passed in
#       (a FUNC-ID represents the last 3 bytes of a checker  
#        program id);  copies NEWMASTER file to [FUNC-ID]MASTER,
#        and replaces all occurances of CUMED with CUMED[FUNC-ID]
# 
#  2)   Generates a new checker program for the FUNC-ID passed in;
#       copies CUMEDSHL (shell checker program) into CUMED[FUNC-ID]
#       and replaces all occurances of CUMEDSHLL with CUMED[FUNC-ID]
#
#-------------------------
  /bin/tput clear
  PORT1=ABC
  echo "\n\nEnter the FUNC-ID of the checker module to generate [$PORT1]: \c"
  read SW_PORT1
  case "$SW_PORT1" in
         "")     SW_PORT1="$PORT1" ;;
          *)     SW_PORT1="$SW_PORT1" ;;
  esac
  echo $SW_PORT1 | tr '[a-z]' '[A-Z]' | cat | read SW_PORT1
  if [ -f "CUMED"$SW_PORT1".pco" ];then
    echo "\n\nError detected: \07"
    echo "\nInvalid FUNC-ID, CUMED"$SW_PORT1".pco already exists!!\n\n"
    exit 1;
  fi
  echo "\n\nGenerating checker module CUMED"$SW_PORT1".pco ...\n"
  sed "s/CUMEDNEW/CUMED"$SW_PORT1"/" CUMEDNEW.pco > "CUMED"$SW_PORT1".pco"
  echo "Generating EDMASTER file ("$SW_PORT1"MASTR) for CUMED"$SW_PORT1".pco ..." 
  sed "s/CUMEDNEW/CUMED"$SW_PORT1"/" NEWMASTR > $SW_PORT1"MASTR"
  echo "\nCUMED"$SW_PORT1".pco and "$SW_PORT1"MASTR file generated !!\n\n"
