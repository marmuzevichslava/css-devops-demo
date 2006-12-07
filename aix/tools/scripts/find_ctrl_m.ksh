#!/bin/ksh -x
#******************************************************************************
# (c) COPYRIGHT 1996 ANDERSEN CONSULTING - ALL RIGHTS RESERVED.
# THIS WORK IS PROTECTED BY COPYRIGHT LAW AS AN UNPUBLISHED WORK.
#
# ScriptName: find_ctrl_m.ksh 
#
# Arguments:  None.
#
# This script finds all the files within the current directory which contain an 
# occurrence of the control M (^M) character and pipes the output to a list.
# For an unknown reason, running the command below at the command line does not
# produce intelligible results.
#
# Andersen Consulting - SolutionWorks
#
# Coder           Date      Action
# -----           ----      ------ 
# Gauri Gavankar  11/17/97  Original code.
#******************************************************************************

grep -l "" * > ctrlm.list
